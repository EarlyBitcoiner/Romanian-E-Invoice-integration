/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 25.6.2024 г..
 *
 * @description Apex Class representing the elements in "CommonAggregateComponents" also known as C.A.C from "urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
 */
public class CAC {

	public class AccountingSupplierParty implements XMLInvoiceNode {

		public CAC.Party partyValue;

		public AccountingSupplierParty() {
		}

		public AccountingSupplierParty( c2g__codaInvoice__c codaInvoice ) {
			this.partyValue = new CAC.Party( codaInvoice, 'Supplier' );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode accountingSupplierPartyNode = outerNode.addChildElement( 'cac:AccountingSupplierParty', null, null );
			this.partyValue.populateXmlNode( accountingSupplierPartyNode );
		}
	}

	public class AccountingCustomerParty implements XMLInvoiceNode {

		public CAC.Party partyValue;

		public AccountingCustomerParty() {
		}

		public AccountingCustomerParty( c2g__codaInvoice__c codaInvoice ) {
			this.partyValue = new CAC.Party( codaInvoice, 'Customer' );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode accountingCustomerPartyNode = outerNode.addChildElement( 'cac:AccountingCustomerParty', null, null );
			this.partyValue.populateXmlNode( accountingCustomerPartyNode );
		}
	}

	public class Country implements XMLInvoiceNode {

		public CBC.IdentificationCode identificationCodeValue;

		public Country() {
		}

		public Country( String identificationCodeValue ) {
			this.identificationCodeValue = new CBC.IdentificationCode( identificationCodeValue );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode countryNode = outerNode.addChildElement( 'cac:Country', null, null );
			this.identificationCodeValue.populateXmlNode( countryNode );
		}
	}

	public class ClassifiedTaxCategory implements XMLInvoiceNode {

		public CBC.ID taxCategoryCode;
		public CBC.Percent taxPercent;
		public CAC.TaxScheme taxScheme;

		public ClassifiedTaxCategory() {
		}

		public ClassifiedTaxCategory( c2g__codaInvoiceLineItem__c lineItem ) {
			this.taxCategoryCode = new CBC.ID( lineItem.c2g__TaxCode1__r.Tax_Category__c );
			this.taxPercent = new CBC.Percent( ( lineItem.c2g__TaxRate1__c ).setScale( 2, RoundingMode.HALF_UP ) );
			this.taxScheme = new CAC.TaxScheme( 'VAT' );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode classifiedTaxCategoryNode = outerNode.addChildElement( 'cac:ClassifiedTaxCategory', null, null );
			this.taxCategoryCode.populateXmlNode( classifiedTaxCategoryNode );
			this.taxPercent.populateXmlNode( classifiedTaxCategoryNode );
			this.taxScheme.populateXmlNode( classifiedTaxCategoryNode );

		}
	}

	public class CommodityClassification implements XMLInvoiceNode {

		public CommodityClassification() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {

		}
	}

	public class LegalMonetaryTotal implements XMLInvoiceNode {

		public CBC.LineExtensionAmount lineExtensionAmount;
		public CBC.TaxExclusiveAmount taxExclusiveAmount;
		public CBC.TaxInclusiveAmount taxInclusiveAmount;
		public CBC.PayableAmount payableAmount;

		public LegalMonetaryTotal() {
		}

		public LegalMonetaryTotal( c2g__codaInvoice__c codaInvoice ) {
			String currencyId = codaInvoice.c2g__InvoiceCurrency__r.Name;
			this.lineExtensionAmount = new CBC.LineExtensionAmount( codaInvoice.c2g__NetTotal__c, currencyId );
			this.taxExclusiveAmount = new CBC.TaxExclusiveAmount( codaInvoice.c2g__NetTotal__c, currencyId );
			this.taxInclusiveAmount = new CBC.TaxInclusiveAmount( codaInvoice.c2g__InvoiceTotal__c, currencyId );
			this.payableAmount = new CBC.PayableAmount( codaInvoice.c2g__InvoiceTotal__c, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode legalMonetaryTotalNode = outerNode.addChildElement( 'cac:LegalMonetaryTotal', null, null );
			this.lineExtensionAmount.populateXmlNode( legalMonetaryTotalNode );
			this.taxExclusiveAmount.populateXmlNode( legalMonetaryTotalNode );
			this.taxInclusiveAmount.populateXmlNode( legalMonetaryTotalNode );
			this.payableAmount.populateXmlNode( legalMonetaryTotalNode );
		}
	}

	public class InvoiceLine implements XMLInvoiceNode {

		public CBC.ID lineIndex;
		public CBC.InvoicedQuantity invoicedQuantity;
		public CBC.LineExtensionAmount lineExtensionAmount;
		public CAC.Item item;
		public CAC.Price price;

		public InvoiceLine() {
		}

		public InvoiceLine( c2g__codaInvoiceLineItem__c lineItem, String currencyId, Integer index ) {
			this.lineIndex = new CBC.ID( index.toString() );
			this.invoicedQuantity = new CBC.InvoicedQuantity( ( lineItem.c2g__Quantity__c ).setScale( 2, RoundingMode.HALF_UP ), lineItem.SCMFFA__SCM_Invoice_Line__r.SCMC__Item__r.SCMC__Stocking_UOM__r.Name_Other_Language__c );
			this.lineExtensionAmount = new CBC.LineExtensionAmount( lineItem.c2g__NetValue__c, currencyId );
			this.price = new CAC.Price( lineItem, currencyId );
			this.item = new CAC.Item( lineItem );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode invoiceLineNode = outerNode.addChildElement( 'cac:InvoiceLine', null, null );
			this.lineIndex.populateXmlNode( invoiceLineNode );
			this.invoicedQuantity.populateXmlNode( invoiceLineNode );
			this.lineExtensionAmount.populateXmlNode( invoiceLineNode );
			this.item.populateXmlNode( invoiceLineNode );
			this.price.populateXmlNode( invoiceLineNode );
		}
	}

	public class Item implements XMLInvoiceNode {

		public CBC.Name name;
		public CAC.ClassifiedTaxCategory classifiedTaxCategory;
		//public CAC.CommodityClassification commodityClassification;
		//public CAC.StandardItemIdentification standardItemIdentification;

		public Item() {
		}

		public Item( c2g__codaInvoiceLineItem__c lineItem ) {
			this.name = new CBC.Name( lineItem.c2g__Product__r.Name );
			this.classifiedTaxCategory = new CAC.ClassifiedTaxCategory( lineItem );
			//this.commodityClassification = new CAC.CommodityClassification();
			//this.standardItemIdentification = new CAC.StandardItemIdentification( lineItem );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode itemNode = outerNode.addChildElement( 'cac:Item', null, null );
			this.name.populateXmlNode( itemNode );
			this.classifiedTaxCategory.populateXmlNode( itemNode );
			//this.standardItemIdentification.populateXmlNode( itemNode );
		}
	}

	public class Price implements XMLInvoiceNode {

		public CBC.PriceAmount priceAmount;
		//public CBC.BaseQuantity baseQuantity;

		public Price() {
		}

		public Price( c2g__codaInvoiceLineItem__c lineItem, String currencyId ) {
			this.priceAmount = new CBC.PriceAmount( ( lineItem.c2g__UnitPrice__c ).setScale( 2, RoundingMode.HALF_UP ), currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode priceNode = outerNode.addChildElement( 'cac:Price', null, null );
			this.priceAmount.populateXmlNode( priceNode );
		}
	}

	public class Party implements XMLInvoiceNode {

		public CAC.PartyName partyNameValue;
		public CAC.PostalAddress postalAddressValue;
		public CAC.PartyTaxScheme partyTaxSchemeValue;
		public CAC.PartyLegalEntity partyLegalEntityValue;

		public Party() {
		}

		public Party( c2g__codaInvoice__c codaInvoice, String accountingParty ) {
			String partyName;
			String vatRegistrationNumber;
			String zip;
			String street;
			String countryCode;
			String countrySubentity;
			String registrationName;
			String companyId;

			if( accountingParty == 'Supplier' ) {
				partyName = codaInvoice.c2g__OwnerCompany__r.Name;
				vatRegistrationNumber = codaInvoice.c2g__OwnerCompany__r.c2g__VATRegistrationNumber__c;
				zip = codaInvoice.c2g__OwnerCompany__r.c2g__ZipPostCode__c;
				countryCode = codaInvoice.c2g__OwnerCompany__r.c2g__ECCountryCode__c;
				countrySubentity = codaInvoice.c2g__OwnerCompany__r.CountrySubentity__c;
				street = codaInvoice.c2g__OwnerCompany__r.c2g__Street__c;
				registrationName = codaInvoice.c2g__OwnerCompany__r.Name;
				companyId = codaInvoice.c2g__OwnerCompany__r.PartyLegalEntity__c;
			} else if( accountingParty == 'Customer' ) {
				partyName = codaInvoice.c2g__Account__r.Name;
				vatRegistrationNumber = codaInvoice.c2g__OwnerCompany__r.c2g__VATRegistrationNumber__c;
				zip = codaInvoice.c2g__Account__r.BillingPostalCode;
				countryCode = codaInvoice.c2g__Account__r.c2g__CODAECCountryCode__c;
				countrySubentity = codaInvoice.c2g__Account__r.CountrySubentity__c;
				street = codaInvoice.c2g__Account__r.BillingStreet;
				registrationName = codaInvoice.c2g__Account__r.Name;
				companyId = codaInvoice.c2g__Account__r.c2g__CODAVATRegistrationNumber__c;
			}

			this.partyNameValue = new CAC.PartyName( partyName );
			this.postalAddressValue = new CAC.PostalAddress( zip, street, countryCode, countrySubentity );
			this.partyTaxSchemeValue = new CAC.PartyTaxScheme( vatRegistrationNumber );
			this.partyLegalEntityValue = new CAC.PartyLegalEntity( registrationName, companyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode partyNode = outerNode.addChildElement( 'cac:Party', null, null );
			this.partyNameValue.populateXmlNode( partyNode );
			this.postalAddressValue.populateXmlNode( partyNode );
			this.partyTaxSchemeValue.populateXmlNode( partyNode );
			this.partyLegalEntityValue.populateXmlNode( partyNode );
		}
	}

	public class PartyTaxScheme implements XMLInvoiceNode {

		public CBC.CompanyID companyIDValue;
		public CAC.TaxScheme taxSchemeValue;

		public PartyTaxScheme() {
		}

		public PartyTaxScheme( String value ) {
			this.companyIDValue = new CBC.CompanyID( value );
			this.taxSchemeValue = new CAC.TaxScheme( 'VAT' );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode partyTaxSchemeNode = outerNode.addChildElement( 'cac:PartyTaxScheme', null, null );
			this.companyIDValue.populateXmlNode( partyTaxSchemeNode );
			this.taxSchemeValue.populateXmlNode( partyTaxSchemeNode );
		}
	}

	public class PostalAddress implements XMLInvoiceNode {

		public CBC.StreetName streetNameValue;
		public CBC.CityName cityNameValue;
		public CBC.PostalZone postalZoneValue;
		public CBC.CountrySubentity countrySubentityValue;
		public CAC.Country countryValue;

		public PostalAddress() {
		}

		public PostalAddress( String zip, String street, String countryCode, String countrySubentity ) {
			this.postalZoneValue = new CBC.PostalZone( zip );
			this.streetNameValue = new CBC.StreetName( street );
			this.countryValue = new CAC.Country( countryCode );

			if( countryCode == 'RO' ) {
				this.countrySubentityValue = new CBC.CountrySubentity( countrySubentity );
				if( countrySubentity == 'RO-B' ) {
					this.cityNameValue = new CBC.CityName( 'SECTOR1' );
				} else {
					this.cityNameValue = new CBC.CityName( 'City name for supplier and customer needs to be mapped' );
				}
			}
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode postalAddressNode = outerNode.addChildElement( 'cac:PostalAddress', null, null );
			this.streetNameValue.populateXmlNode( postalAddressNode );
			this.cityNameValue.populateXmlNode( postalAddressNode );
			this.postalZoneValue.populateXmlNode( postalAddressNode );
			if( this.countryValue.identificationCodeValue.code.value == 'RO' ) {
				this.countrySubentityValue.populateXmlNode( postalAddressNode );
				this.countryValue.populateXmlNode( postalAddressNode );
			} else {
				this.countryValue.populateXmlNode( postalAddressNode );
			}
		}
	}

	public class PartyName implements XMLInvoiceNode {

		public CBC.Name nameValue;

		public PartyName() {
		}

		public PartyName( String nameValue ) {
			this.nameValue = new CBC.Name( nameValue );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode partyNameNode = outerNode.addChildElement( 'cac:PartyName', null, null );
			this.nameValue.populateXmlNode( partyNameNode );
		}
	}

	public class PartyLegalEntity implements XMLInvoiceNode {

		public CBC.RegistrationName registrationNameValue;
		public CBC.CompanyLegalForm companyIDValue;

		public PartyLegalEntity() {
		}

		public PartyLegalEntity( String registrationName, String companyId ) {
			this.registrationNameValue = new CBC.RegistrationName( registrationName );
			this.companyIDValue = new CBC.CompanyLegalForm( companyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode partyLegalEntityNode = outerNode.addChildElement( 'cac:PartyLegalEntity', null, null );
			this.registrationNameValue.populateXmlNode( partyLegalEntityNode );
			//this.companyIDValue.populateXmlNode( partyLegalEntityNode );
		}
	}

	public class PaymentMeans implements XMLInvoiceNode {

		public PaymentMeans() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {

		}
	}

	public class StandardItemIdentification implements XMLInvoiceNode {

		public CBC.ID itemIdentificationId;

		public StandardItemIdentification() {
		}

		public StandardItemIdentification( c2g__codaInvoiceLineItem__c lineItem ) {
			this.itemIdentificationId = new CBC.ID( lineItem.c2g__Product__r.Barcode__c, 'GTIN' );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode standardItemIdentificationNode = outerNode.addChildElement( 'cac:StandardItemIdentification', null, null );
			this.itemIdentificationId.populateXmlNode( standardItemIdentificationNode );
		}
	}

	public class TaxTotal implements XMLInvoiceNode {

		public CBC.TaxAmount taxAmount;
		public List<CAC.TaxSubtotal> taxSubtotals;

		public TaxTotal() {
		}

		public TaxTotal( c2g__codaInvoice__c codaInvoice, Map<String, List<c2g__codaInvoiceLineItem__c>> lineItemsByTaxCategoryAndPercentMap ) {
			this.taxAmount = new CBC.TaxAmount( codaInvoice.c2g__TaxTotal__c, codaInvoice.c2g__InvoiceCurrency__r.Name );

			List<CAC.TaxSubtotal> taxSubtotals = new List<CAC.TaxSubtotal>();

			for( String key : lineItemsByTaxCategoryAndPercentMap.keySet() ) {
				String taxCategory = lineItemsByTaxCategoryAndPercentMap.get( key )[ 0 ].c2g__TaxCode1__r.Tax_Category__c;
				String currencyId = codaInvoice.c2g__InvoiceCurrency__r.Name;
				Decimal taxPercent = ( lineItemsByTaxCategoryAndPercentMap.get( key )[ 0 ].c2g__TaxRate1__c ).setScale( 2, RoundingMode.HALF_UP );
				Decimal taxableAmount = 0;
				Decimal taxAmount = 0;
				for( c2g__codaInvoiceLineItem__c lineItem : lineItemsByTaxCategoryAndPercentMap.get( key ) ) {
					taxableAmount += ( lineItem.c2g__NetValue__c ).setScale( 2, RoundingMode.HALF_UP );
				}
				taxAmount = ( taxableAmount * ( taxPercent / 100 ) ).setScale( 2, RoundingMode.HALF_UP );
				taxSubtotals.add( new CAC.TaxSubtotal( taxCategory, currencyId, taxPercent, taxableAmount, taxAmount ) );
			}

			this.taxSubtotals = taxSubtotals;
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxTotalNode = outerNode.addChildElement( 'cac:TaxTotal', null, null );
			this.taxAmount.populateXmlNode( taxTotalNode );
			for( CAC.TaxSubtotal taxSubtotal : this.taxSubtotals ) {
				taxSubtotal.populateXmlNode( taxTotalNode );
			}
		}
	}

	public class TaxSubtotal implements XMLInvoiceNode {

		public CBC.TaxableAmount taxableAmount;
		public CBC.TaxAmount taxAmount;
		public CAC.TaxCategory taxCategory;

		public TaxSubtotal() {
		}

		public TaxSubtotal( String taxCategory, String currencyId, Decimal taxPercent, Decimal taxableAmount, Decimal taxAmount ) {
			this.taxableAmount = new CBC.TaxableAmount( taxableAmount, currencyId );
			this.taxAmount = new CBC.TaxAmount( taxAmount, currencyId );
			this.taxCategory = new CAC.TaxCategory( taxCategory, taxPercent );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxSubtotalNode = outerNode.addChildElement( 'cac:TaxSubtotal', null, null );
			this.taxableAmount.populateXmlNode( taxSubtotalNode );
			this.taxAmount.populateXmlNode( taxSubtotalNode );
			this.taxCategory.populateXmlNode( taxSubtotalNode );
		}
	}

	public class TaxCategory implements XMLInvoiceNode {

		public CBC.ID taxCategoryCode;
		public CBC.Percent taxPercent;
		public CAC.TaxScheme taxScheme;

		public TaxCategory() {
		}

		public TaxCategory( String taxCategory, Decimal taxPercent ) {
			this.taxCategoryCode = new CBC.ID( taxCategory );
			this.taxPercent = new CBC.Percent( taxPercent );
			this.taxScheme = new CAC.TaxScheme( 'VAT' );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxCategoryNode = outerNode.addChildElement( 'cac:TaxCategory', null, null );
			this.taxCategoryCode.populateXmlNode( taxCategoryNode );
			this.taxPercent.populateXmlNode( taxCategoryNode );
			this.taxScheme.populateXmlNode( taxCategoryNode );
		}
	}

	public class TaxScheme implements XMLInvoiceNode {

		public CBC.ID idValue;

		public TaxScheme() {
		}

		public TaxScheme( String idValue ) {
			this.idValue = new CBC.ID( idValue );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxSchemeNode = outerNode.addChildElement( 'cac:TaxScheme', null, null );
			this.idValue.populateXmlNode( taxSchemeNode );
		}
	}
}