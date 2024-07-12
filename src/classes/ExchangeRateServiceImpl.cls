/**
 * Created By: Ilin Argirov on 22.3.2022 г.
 * Refactored By: petar.danadzhiev@next-consult.com - Junior Developer on 12.7.2024 г.
 */
global with sharing class ExchangeRateServiceImpl implements ExchangeRateService {

	@TestVisible
	private ExchangeRateHttpCalloutService calloutService = new ExchangeRateHttpCalloutService();
	@TestVisible
	private ExchangeRateSelector selector = new ExchangeRateSelector();
	@TestVisible
	private UnitOfWork workUnit = new UnitOfWork();

	global static final String CLASS_NAME = ExchangeRateServiceImpl.class.getName();
	global static final String ISO_CODE_BGN = 'BGN';
	global static final String ISO_CODE_RON = 'RON';
	global static final String ISO_CODE_EUR = 'EUR';
	global static final String ISO_CODE_USD = 'USD';
	global static final String ISO_CODE_GOLD = 'XAU';

	private static final String XML_ROW = 'ROW';
	private static final String XML_TITLE = 'TITLE';
	private static final String XML_CODE = 'CODE';
	private static final String XML_REVERSE_RATE = 'REVERSERATE';
	private static final String XML_CURR_DATE = 'CURR_DATE';
	global static final String JSON_DATE = 'date';
	global static final String JSON_RATES = 'rates';

	private String corporateCurrencyIsoCode;

	@TestVisible
	private String datedConversionRateJsonPayload;

	@TestVisible
	private fferpcore__ExchangeRateEntry__c[] entriesToInsert;

	@TestVisible
	Map<String, List<fferpcore__ExchangeRateGroup__c>> exchangeRateGroupsByDefaultCurrency = new Map<String, List<fferpcore__ExchangeRateGroup__c>>();

	@TestVisible
	private Map<String , CurrencyInformation> currencyInformationByCurrencyCode = new Map<String , CurrencyInformation>();

	global ExchangeRateServiceImpl() {
	}

	public void updateCurrenciesExchangeRates() {
		this.mapGroupsByCurrency( ISO_CODE_RON );
		this.mapGroupsByCurrency( ISO_CODE_BGN );

		this.getExchangeRatesFromBNB( this.calloutService.requestBNBExchangeRates() );
		this.getExchangeRatesFromBNR( this.calloutService.requestBNRExchangeRates() );

		if( this.currencyInformationByCurrencyCode.isEmpty() ) {
			return;
		}

		this.insertFFExchangeRateRecords();

		this.updateCorporateCurrencyExchangeRates();
	}

	/**
	 * @description Updates the corporate currency's exchange rates. Supports BGN and RON as corporate currencies.
	 */
	public virtual void updateCorporateCurrencyExchangeRates() {
		this.corporateCurrencyIsoCode = this.selector.getCorporateCurrency().IsoCode;

		if( this.currencyInformationByCurrencyCode.isEmpty() || !this.currencyInformationByCurrencyCode.containsKey(this.corporateCurrencyIsoCode) ) {
			return;
		}

		this.insertSFExchangeRateRecords();
	}

	private void mapGroupsByCurrency( String currencyCode ) {
		List<fferpcore__ExchangeRateGroup__c> groups = new List<fferpcore__ExchangeRateGroup__c>();
		groups = this.selector.getExchangeRateGroupsByDefaultCurrency( currencyCode );
		if( !groups.isEmpty() ) {
			this.exchangeRateGroupsByDefaultCurrency.put( currencyCode, groups );
		}
	}

	/**
	 * @description Inserts SF exchange rate records for the corporate currency.
	 */
	private void insertSFExchangeRateRecords() {
		CurrencyInformation currencyInformation = currencyInformationByCurrencyCode.get(this.corporateCurrencyIsoCode);
		Integer conversionRatesCount = selector.getDatedConversionRatesCountForDate(
				currencyInformation.getExchangeRate( ISO_CODE_USD ).effectiveDate
		);
		if( conversionRatesCount > 0 ) {
			return;
		}

		CurrencyType[] currencyTypes = selector.getActiveCurrencies();
		Record[] records = new List<Record>();
		for( CurrencyType currencyType : currencyTypes ) {
			if( currencyInformation.containsKey( currencyType.IsoCode ) ) {
				ExchangeRate exchangeRate = currencyInformation.getExchangeRate( currencyType.IsoCode );
				records.add(
						makeDatedConversionRateRecord(
								currencyType.IsoCode,
								exchangeRate.reverseRate,
								exchangeRate.effectiveDate
						)
				);
			}
		}
		datedConversionRateJsonPayload = serializePayloadIntoJson( records );
		calloutService.sendRecordsToSalesforce(
				datedConversionRateJsonPayload
		);
	}

	/**
	 * @description Produces a DatedConversionRate Record.
	 *
	 * @param isoCode currency ISO code
	 * @param rate exchange rate value
	 * @param startDate effective date
	 *
	 * @return hydrated Record object
	 */
	private static Record makeDatedConversionRateRecord( String isoCode, Decimal rate, Date startDate ) {
		Attributes attributes = new Attributes();
		attributes.type = 'DatedConversionRate';
		attributes.referenceId = isoCode;

		Record record = new Record();
		record.attributes = attributes;
		record.IsoCode = isoCode;
		record.ConversionRate = String.valueOf( rate );
		record.StartDate = formatDateToString( startDate );

		return record;
	}

	/**
	 * @description Makes DatedExchangeRate payload.
	 *
	 * @param records Record objects to send to Salesforce.
	 *
	 * @return json payload
	 */
	private static String serializePayloadIntoJson( Record[] records ) {
		Payload payload = new Payload();
		payload.records = records;

		return JSON.serializePretty( payload, true );
	}

	/**
	 * @description Inserts FF exchange rate entries for the corporate currency.
	 */
	private void insertFFExchangeRateRecords() {

		entriesToInsert = new List<fferpcore__ExchangeRateEntry__c>();
		for( String groupDefaultCurrency : exchangeRateGroupsByDefaultCurrency.keySet() ) {
			CurrencyInformation currencyInformation = currencyInformationByCurrencyCode.get(groupDefaultCurrency);
			for( fferpcore__ExchangeRateGroup__c rateGroup : exchangeRateGroupsByDefaultCurrency.get( groupDefaultCurrency ) ) {

				String[] usedCurrencies = rateGroup.fferpcore__SelectedCurrencies__c.split( ';' );
				Set<String> usedCurrenciesIsoCodes = new Set<String>();

				for( String currencyString : usedCurrencies ) {
					if( currencyString.contains( ISO_CODE_EUR ) == false ) {
						usedCurrenciesIsoCodes.add( currencyString.substring( 0, 3 ) ); // get ISO Code from currency string
					}
				}

				fferpcore__ExchangeRateEntry__c rate = new fferpcore__ExchangeRateEntry__c();
				rate.fferpcore__ExchangeRateGroup__c = rateGroup.Id;
				rate.fferpcore__ExchangeRateType__c = 'Commercial';

				for( String isoCode : usedCurrenciesIsoCodes ) {
					if( currencyInformation.containsKey( isoCode ) ) {
						fferpcore__ExchangeRateEntry__c individualEntry = rate.clone();
						individualEntry.put(
								String.format( 'Rate_{0}__c', new Object[] {
										isoCode
								} ),
								currencyInformation.getExchangeRate(isoCode).reverseRate
						);
						individualEntry.fferpcore__StartDate__c = currencyInformation.getExchangeRate( isoCode ).effectiveDate;

						entriesToInsert.add( individualEntry );
					}
				}
			}
		}

		if( entriesToInsert.isEmpty() ) {
			return;
		}

		workUnit.insertRecords( entriesToInsert );
	}

	/**
	 * @description Retrieves exchange rates from BNB.
	 *
	 * @param xmlResponse HttpResponse with xml data in the body
	 */
	private void getExchangeRatesFromBNB( HttpResponse xmlResponse ) {
		if( xmlResponse.getBody().length() < 1 ) {
			return;
		}

		try {
			Dom.Document exchangeRatesXml = new Dom.Document();
			exchangeRatesXml.load( xmlResponse.getBody() );
			Dom.XmlNode rowSet = exchangeRatesXml.getRootElement();
			CurrencyInformation currencyInformation = currencyInformationByCurrencyCode.get(ISO_CODE_BGN);
			for( Dom.XmlNode row : rowSet.getChildElements() ) {
				if( row.getName() == XML_ROW && row.getChildElement( XML_TITLE, null ) == null ) {
					String currencyIsoCode = row.getChildElement( XML_CODE, null ).getText();
					if( currencyIsoCode == ISO_CODE_EUR
							|| currencyIsoCode == ISO_CODE_GOLD ) {
						continue;
					}
					Dom.XmlNode reverseRateNode = row.getChildElement( XML_REVERSE_RATE, null );
					if( reverseRateNode == null ) {
						continue;
					}
					Decimal reverseRate = Decimal.valueOf( reverseRateNode.getText() );
					Date effectiveDate = parseDate( row.getChildElement( XML_CURR_DATE, null ).getText() );

					currencyInformation.addExchangeRate( currencyIsoCode, reverseRate, effectiveDate );

				}
			}
		} catch( Exception e ) {
			ncerpUtil.Logger.setSubject( String.format( Constant.EXCEPTION_OCCURRED, new Object[] { CLASS_NAME } ) );
			ncerpUtil.Logger.log( e );
			ncerpUtil.Logger.emit();
			throw e;
		}
	}

	/**
	 * @description Retrieves exchange rates from BNR.
	 */
	private void getExchangeRatesFromBNR( HttpResponse jsonResponse ) {
		if( jsonResponse.getBody().length() < 1 ) {
			return;
		}

		try {
			String exchangeRatesJson = jsonResponse.getBody();
			Map<String, Object> deserializedResponse = (Map<String, Object>) JSON.deserializeUntyped( exchangeRatesJson );
			String dateStr = (String) deserializedResponse.get( JSON_DATE );
			String[] dateElements = dateStr.split( '-' );
			Date effectiveDate = Date.newInstance( Integer.valueOf( dateElements[ 0 ] ), Integer.valueOf( dateElements[ 1 ] ), Integer.valueOf( dateElements[ 2 ] ) );
			Map<String, Object> deserializedRawRates = (Map<String, Object>) deserializedResponse.get( JSON_RATES );
			CurrencyInformation currencyInformation = this.currencyInformationByCurrencyCode.get(ISO_CODE_RON);
			for( String key : deserializedRawRates.keySet() ) {
				if( key == ISO_CODE_EUR ) {
					continue;
				}
				Decimal reverseRate = 1 / Decimal.valueOf( (String) deserializedRawRates.get( key ) );
				currencyInformation.addExchangeRate( key, reverseRate, effectiveDate );
			}
		} catch( Exception e ) {
			ncerpUtil.Logger.setSubject( String.format( Constant.EXCEPTION_OCCURRED, new Object[] { CLASS_NAME } ) );
			ncerpUtil.Logger.log( e );
			ncerpUtil.Logger.emit();
			throw e;
		}
	}

	/**
	 * @description Formats a date to YYYY-MM-DD.
	 *
	 * @param dateToFormat Date
	 *
	 * @return formatted date as string.
	 */
	private static String formatDateToString( Date dateToFormat ) {
		return String.format(
				'{0}-{1}-{2}',
				new Object[] {
						dateToFormat.year(),
						dateToFormat.month(),
						dateToFormat.day()
				}
		);
	}

	/**
	 * @description Produces a date object, sourced from a date string. To be used in BNB xml parsing.
	 *
	 * @param dateString date string in the format dd.mm.yyyy
	 *
	 * @return Date object from the parsed string.
	 */
	private static Date parseDate( String dateString ) {
		String[] dateElements = dateString.split( '\\.' );
		return Date.newInstance(
				Integer.valueOf( dateElements[ 2 ] ),
				Integer.valueOf( dateElements[ 1 ] ),
				Integer.valueOf( dateElements[ 0 ] )
		);
	}

	// START PAYLOAD DEFINITION
	public class Payload {
		public List<Record> records;
	}

	public class Record {
		public Attributes attributes;
		public String IsoCode;
		public String ConversionRate;
		public String StartDate;
	}

	public class Attributes {
		public String type;
		public String referenceId;
	}
	// END PAYLOAD DEFINITION
}