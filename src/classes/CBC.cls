/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 25.6.2024 г.
 *
 * @description Apex Class representing the elements in "CommonBasicComponents" also known as C.B.C from "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
 */
public class CBC {

	public class BaseAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public BaseAmount() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
		}
	}

	public class BaseQuantity implements XMLInvoiceNode {
		public UDT.AmountType value;

		public BaseQuantity() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
		}
	}

	public class CityName implements XMLInvoiceNode {
		public UDT.NameType name;

		public CityName() {
		}

		public CityName( String value ) {
			if(value.length() > 50) {
				value = value.substring(0,50);
			}
			this.name = new UDT.NameType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode cityNameNode = outerNode.addChildElement( 'cbc:CityName', null, null );
			cityNameNode.addTextNode( this.name.value );
		}
	}

	public class CompanyID implements XMLInvoiceNode {
		public UDT.IdentifierType identifier;

		public CompanyID() {
		}

		public CompanyID( String value ) {
			this.identifier = new UDT.IdentifierType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode companyIDNode = outerNode.addChildElement( 'cbc:CompanyID', null, null );
			companyIDNode.addTextNode( this.identifier.value );
		}
	}

	public class CompanyLegalForm implements XMLInvoiceNode {
		public UDT.TextType legalForm;

		public CompanyLegalForm() {
		}

		public CompanyLegalForm( String legalForm ) {
			this.legalForm = new UDT.TextType( legalForm );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode companyLegalFormNode = outerNode.addChildElement( 'cbc:CompanyLegalForm', null, null );
			companyLegalFormNode.addTextNode( this.legalForm.value );
		}
	}

	public class CountrySubentity implements XMLInvoiceNode {
		public UDT.TextType subEntity;

		public CountrySubentity() {
		}

		public CountrySubentity( String value ) {
			this.subEntity = new UDT.TextType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode countrySubentityNode = outerNode.addChildElement( 'cbc:CountrySubentity', null, null );
			countrySubentityNode.addTextNode( this.subEntity.value );
		}
	}

	public class CustomizationID implements XMLInvoiceNode {
		public UDT.IdentifierType value;

		public CustomizationID() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {

		}
	}

	public class DocumentCurrencyCode implements XMLInvoiceNode {
		public UDT.CodeType code;

		public DocumentCurrencyCode() {
		}

		public DocumentCurrencyCode( String code ) {
			this.code = new UDT.CodeType( code );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode documentCurrencyCodeNode = outerNode.addChildElement( 'cbc:DocumentCurrencyCode', null, null );
			documentCurrencyCodeNode.addTextNode( this.code.value );
		}
	}

	public class DueDate implements XMLInvoiceNode {
		public UDT.DateType dateInstance;

		public DueDate() {
		}

		public DueDate( Date value ) {
			this.dateInstance = new UDT.DateType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode dueDateNode = outerNode.addChildElement( 'cbc:DueDate', null, null );
			dueDateNode.addTextNode( this.dateInstance.toString() );
		}
	}

	public class ElectronicMail implements XMLInvoiceNode {
		public UDT.TextType value;

		public ElectronicMail() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {

		}
	}

	public class EndDate implements XMLInvoiceNode {
		public UDT.DateType value;

		public EndDate() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {

		}
	}

	public class IdentificationCode implements XMLInvoiceNode {
		public UDT.CodeType code;

		public IdentificationCode() {
		}

		public IdentificationCode( String value ) {
			this.code = new UDT.CodeType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode identificationCodeNode = outerNode.addChildElement( 'cbc:IdentificationCode', null, null );
			identificationCodeNode.addTextNode( this.code.value );
		}
	}

	public class ID implements XMLInvoiceNode {
		public UDT.IdentifierType identifierType;

		public ID() {
		}

		public ID( String documentId ) {
			this.identifierType = new UDT.IdentifierType( documentId );
		}

		public ID( String documentId, String schemaId ) {
			this.identifierType = new UDT.IdentifierType( documentId, schemaId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode idNode = outerNode.addChildElement( 'cbc:ID', null, null );
			idNode.addTextNode( this.identifierType.value );
			if( identifierType.schemeID != null ) {
				idNode.setAttribute( 'schemeID', identifierType.schemeID );
			}
		}
	}

	public class InvoiceTypeCode implements XMLInvoiceNode {
		public UDT.CodeType code;

		public InvoiceTypeCode() {
		}

		public InvoiceTypeCode(String code){
			this.code = new UDT.CodeType(code);
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode invoiceTypeCodeNode = outerNode.addChildElement('cbc:InvoiceTypeCode',null,null);
			invoiceTypeCodeNode.addTextNode(this.code.value);
		}
	}

	public class InvoicedQuantity implements XMLInvoiceNode {
		public UDT.QuantityType quantity;

		public InvoicedQuantity() {
		}

		public InvoicedQuantity( Decimal invoicedQuantity, String unitCode ) {
			this.quantity = new UDT.QuantityType( (invoicedQuantity).setScale(2, RoundingMode.HALF_UP), unitCode );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode invoicedQuantityNode = outerNode.addChildElement( 'cbc:InvoicedQuantity', null, null );
			invoicedQuantityNode.addTextNode( '' + this.quantity.value );
			invoicedQuantityNode.setAttribute( 'unitCode', this.quantity.unitCode );
		}
	}

	public class IssueDate implements XMLInvoiceNode {
		public UDT.DateType dateInstance;

		public IssueDate() {
		}

		public IssueDate( Date value ) {
			this.dateInstance = new UDT.DateType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode issueDateNode = outerNode.addChildElement( 'cbc:IssueDate', null, null );
			issueDateNode.addTextNode( this.dateInstance.toString() );
		}
	}

	public class Name implements XMLInvoiceNode {

		public UDT.NameType name;

		public Name() {
		}

		public Name( String value ) {
			this.name = new UDT.NameType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode nameNode = outerNode.addChildElement( 'cbc:Name', null, null );
			nameNode.addTextNode( this.name.value );
		}
	}

	public class Note implements XMLInvoiceNode {
		public UDT.TextType value;

		public Note() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
		}
	}

	public class Percent implements XMLInvoiceNode {
		public UDT.PercentType percent;

		public Percent() {
		}

		public Percent( Decimal taxPercent ) {
			this.percent = new UDT.PercentType( taxPercent );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode percentNode = outerNode.addChildElement( 'cbc:Percent', null, null );
			percentNode.addTextNode( '' + this.percent.value );
		}
	}

	public class PostalZone implements XMLInvoiceNode {
		public UDT.TextType zone;

		public PostalZone() {
		}

		public PostalZone( String value ) {
			this.zone = new UDT.TextType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode postalZoneNode = outerNode.addChildElement( 'cbc:PostalZone', null, null );
			postalZoneNode.addTextNode( this.zone.value );
		}
	}

	public class PayableAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public PayableAmount() {
		}

		public PayableAmount( Decimal payableAmount, String currencyId ) {
			this.amount = new UDT.AmountType( payableAmount, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode payableAmountNode = outerNode.addChildElement( 'cbc:PayableAmount', null, null );
			payableAmountNode.addTextNode('' + this.amount.value);
			payableAmountNode.setAttribute('currencyID', this.amount.currencyID);
		}
	}

	public class PaymentMeansCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public PaymentMeansCode() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
		}
	}

	public class PriceAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public PriceAmount() {
		}

		public PriceAmount( Decimal priceAmount, String currencyId ) {
			this.amount = new UDT.AmountType( priceAmount, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode priceAmountNode = outerNode.addChildElement( 'cbc:PriceAmount', null, null );
			priceAmountNode.addTextNode('' + this.amount.value);
			priceAmountNode.setAttribute('currencyID', this.amount.currencyID);
		}
	}

	public class RegistrationName implements XMLInvoiceNode {
		public UDT.NameType name;

		public RegistrationName() {
		}

		public RegistrationName( String value ) {
			this.name = new UDT.NameType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode registrationNameNode = outerNode.addChildElement( 'cbc:RegistrationName', null, null );
			registrationNameNode.addTextNode( this.name.value );
		}
	}

	public class StreetName implements XMLInvoiceNode {
		public UDT.NameType name;

		public StreetName() {
		}

		public StreetName( String value ) {
			this.name = new UDT.NameType( value );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode streetNameNode = outerNode.addChildElement( 'cbc:StreetName', null, null );
			streetNameNode.addTextNode( this.name.value );
		}
	}

	public class TaxableAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public TaxableAmount() {
		}

		public TaxableAmount( Decimal taxableAmount, String currencyId ) {
			this.amount = new UDT.AmountType( taxableAmount, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxableAmountNode = outerNode.addChildElement( 'cbc:TaxableAmount', null, null );
			taxableAmountNode.addTextNode( '' + this.amount.value );
			taxableAmountNode.setAttribute( 'currencyID', this.amount.currencyID );
		}
	}

	public class TaxAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public TaxAmount() {
		}

		public TaxAmount( Decimal value, String currencyId ) {
			this.amount = new UDT.AmountType( value, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxAmountNode = outerNode.addChildElement( 'cbc:TaxAmount', null, null );
			taxAmountNode.addTextNode( '' + this.amount.value );
			taxAmountNode.setAttribute( 'currencyID', this.amount.currencyID );
		}
	}

	public class TaxCurrencyCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public TaxCurrencyCode() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {

		}
	}

	public class TaxExclusiveAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public TaxExclusiveAmount() {
		}

		public TaxExclusiveAmount( Decimal taxExtensionAmount, String currencyId ) {
			this.amount = new UDT.AmountType( taxExtensionAmount, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxExclusiveAmountNode = outerNode.addChildElement( 'cbc:TaxExclusiveAmount', null, null );
			taxExclusiveAmountNode.addTextNode('' + this.amount.value);
			taxExclusiveAmountNode.setAttribute('currencyID', this.amount.currencyID);
		}
	}

	public class TaxInclusiveAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public TaxInclusiveAmount() {
		}

		public TaxInclusiveAmount( Decimal taxInclusiveAmount, String currencyId ) {
			this.amount = new UDT.AmountType( taxInclusiveAmount, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode taxInclusiveAmountNode = outerNode.addChildElement( 'cbc:TaxInclusiveAmount', null, null );
			taxInclusiveAmountNode.addTextNode('' + this.amount.value);
			taxInclusiveAmountNode.setAttribute('currencyID', this.amount.currencyID);
		}
	}

	public class LineExtensionAmount implements XMLInvoiceNode {
		public UDT.AmountType amount;

		public LineExtensionAmount() {
		}

		public LineExtensionAmount( Decimal lineExtensionAmount, String currencyId ) {
			this.amount = new UDT.AmountType( lineExtensionAmount, currencyId );
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
			Dom.XmlNode lineExtensionAmountNode = outerNode.addChildElement( 'cbc:LineExtensionAmount', null, null );
			lineExtensionAmountNode.addTextNode( '' + this.amount.value );
			lineExtensionAmountNode.setAttribute('currencyID', this.amount.currencyID);
		}
	}

	public class UBLVersionID implements XMLInvoiceNode {
		public UDT.IdentifierType value;

		public UBLVersionID() {
		}

		public void populateXmlNode( Dom.XmlNode outerNode ) {
		}
	}
}