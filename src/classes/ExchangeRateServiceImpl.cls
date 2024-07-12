global virtual with sharing class ExchangeRateServiceImpl implements ExchangeRateService {

    @TestVisible
    protected ExchangeRateHttpCalloutService calloutService = new ExchangeRateHttpCalloutService();
    @TestVisible
    protected ExchangeRateSelector selector = new ExchangeRateSelector();
    @TestVisible
    protected UnitOfWork workUnit = new UnitOfWork();

    global static final String CLASS_NAME = ExchangeRateServiceImpl.class.getName();
    global static final String ISO_CODE_BGN = 'BGN';
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

    global ExchangeRateServiceImpl() {
    }

    protected Map<String, ExchangeRateDTO> exchangeRateDTOs = new Map<String, ExchangeRateDTO>{
    };
    protected String corporateCurrencyIsoCode;
    @TestVisible
    protected String datedConversionRateJsonPayload;
    @TestVisible
    protected fferpcore__ExchangeRateEntry__c[] entriesToInsert;

    /**
     * @description Updates the corporate currency's exchange rates. Supports BGN and RON as corporate currencies.
     */
    public virtual void updateCorporateCurrencyExchangeRates() {
        corporateCurrencyIsoCode = selector.getCorporateCurrency().IsoCode;

        if (corporateCurrencyIsoCode == ISO_CODE_BGN) {
            HttpResponse xmlResponse = calloutService.requestBNBExchangeRates();
            getExchangeRatesFromBNB(xmlResponse);
        } else {
            return;
        }

        if (exchangeRateDTOs.isEmpty()) {
            return;
        }

        insertSFExchangeRateRecords();
        insertFFExchangeRateRecords();
    }

    /**
     * @description Inserts SF exchange rate records for the corporate currency.
     */
    protected void insertSFExchangeRateRecords() {
        Integer conversionRatesCount = selector.getDatedConversionRatesCountForDate(
                exchangeRateDTOs.get(ISO_CODE_USD).effectiveDate
        );
        if (conversionRatesCount > 0) {
            return;
        }

        CurrencyType[] currencyTypes = selector.getActiveCurrencies();
        Record[] records = new List<Record>();
        for (CurrencyType currencyType : currencyTypes) {
            if (!exchangeRateDTOs.containsKey(currencyType.IsoCode)) {
                continue;
            }
            ExchangeRateDTO exchangeRateDTO = exchangeRateDTOs.get(currencyType.IsoCode);
            records.add(
                    makeDatedConversionRateRecord(
                            exchangeRateDTO.currencyIsoCode,
                            exchangeRateDTO.reverseRate,
                            exchangeRateDTO.effectiveDate
                    )
            );
        }
        datedConversionRateJsonPayload = serializePayloadIntoJson(records);
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
    private static Record makeDatedConversionRateRecord(String isoCode, Decimal rate, Date startDate) {
        Attributes attributes = new Attributes();
        attributes.type = 'DatedConversionRate';
        attributes.referenceId = isoCode;

        Record record = new Record();
        record.attributes = attributes;
        record.IsoCode = isoCode;
        record.ConversionRate = String.valueOf(rate);
        record.StartDate = formatDateToString(startDate);

        return record;
    }

    /**
     * @description Makes DatedExchangeRate payload.
     *
     * @param records Record objects to send to Salesforce.
     *
     * @return json payload
     */
    private static String serializePayloadIntoJson(Record[] records) {
        Payload payload = new Payload();
        payload.records = records;

        return JSON.serializePretty(payload, true);
    }

    /**
     * @description Inserts FF exchange rate entries for the corporate currency.
     */
    protected void insertFFExchangeRateRecords() {
        fferpcore__ExchangeRateGroup__c[] groups = selector.getExchangeRateGroups(corporateCurrencyIsoCode);

        entriesToInsert = new List<fferpcore__ExchangeRateEntry__c>();
        for (fferpcore__ExchangeRateGroup__c grp : groups) {
            String[] currencyStringList = grp.fferpcore__SelectedCurrencies__c.split(';');
            Set<String> sanitizedCurrencyIsoCodeSet = new Set<String>();
            for (String currencyString : currencyStringList) {
                if (currencyString.contains(corporateCurrencyIsoCode) || currencyString.contains(ISO_CODE_EUR)) {
                    continue;
                }
                sanitizedCurrencyIsoCodeSet.add(currencyString.substring(0,3)); // get ISO Code from currency string
            }

            fferpcore__ExchangeRateEntry__c entry = new fferpcore__ExchangeRateEntry__c();
            entry.fferpcore__ExchangeRateGroup__c = grp.Id;
            entry.fferpcore__ExchangeRateType__c = 'Commercial';

            for (String currencyIsoCode : sanitizedCurrencyIsoCodeSet) {
                if (!exchangeRateDTOs.containsKey(currencyIsoCode)) {
                    continue;
                }

                fferpcore__ExchangeRateEntry__c individualEntry = entry.clone();
                individualEntry.put(
                        String.format('Rate_{0}__c', new Object[]{
                                currencyIsoCode
                        }),
                        exchangeRateDTOs.get(currencyIsoCode).reverseRate
                );
                individualEntry.fferpcore__StartDate__c = exchangeRateDTOs.get(currencyIsoCode).effectiveDate;

                entriesToInsert.add(individualEntry);
            }
        }

        if (entriesToInsert.isEmpty()) {
            return;
        }

        workUnit.insertRecords(entriesToInsert);
    }

    /**
     * @description Retrieves exchange rates from BNB.
     *
     * @param xmlResponse HttpResponse with xml data in the body
     */
    protected void getExchangeRatesFromBNB(HttpResponse xmlResponse) {
        if (xmlResponse.getBody().length() < 1) {
            return;
        }

        try {
            Dom.Document exchangeRatesXml = new Dom.Document();
            exchangeRatesXml.load(xmlResponse.getBody());
            Dom.XmlNode rowSet = exchangeRatesXml.getRootElement();
            for (Dom.XmlNode row : rowSet.getChildElements()) {
                if (row.getName() == XML_ROW && row.getChildElement(XML_TITLE, null) == null) {
                    String currencyIsoCode = row.getChildElement(XML_CODE, null).getText();
                    if (currencyIsoCode == ISO_CODE_EUR
                            || currencyIsoCode == ISO_CODE_GOLD) {
                        continue;
                    }
                    Dom.XmlNode reverseRateNode = row.getChildElement(XML_REVERSE_RATE, null);
                    if (reverseRateNode == null) {
                        continue;
                    }
                    Decimal reverseRate = Decimal.valueOf(reverseRateNode.getText());
                    Date effectiveDate = parseDate(row.getChildElement(XML_CURR_DATE, null).getText());

                    exchangeRateDTOs.put(
                            currencyIsoCode,
                            new ExchangeRateDTO(currencyIsoCode, reverseRate, effectiveDate)
                    );
                }
            }
        } catch (Exception e) {
            ncerpUtil.Logger.setSubject(String.format(Constant.EXCEPTION_OCCURRED, new Object[]{CLASS_NAME}));
            ncerpUtil.Logger.log(e);
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
    private static String formatDateToString(Date dateToFormat) {
        return String.format(
                '{0}-{1}-{2}',
                new Object[]{
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
    private static Date parseDate(String dateString) {
        String[] dateElements = dateString.split('\\.');
        return Date.newInstance(
                Integer.valueOf(dateElements[2]),
                Integer.valueOf(dateElements[1]),
                Integer.valueOf(dateElements[0])
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