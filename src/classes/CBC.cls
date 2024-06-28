/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 25.6.2024 г..
 *
 * @description Apex Class representing the elements in "CommonBasicComponents" also known as C.B.C from "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
 */
public class CBC {
	private static final String CBC_NAMESPACE = 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

	public class BaseAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public BaseAmount(){}

		public void populateXmlNode(Dom.XmlNode outerNode){ }
	}

	public class BaseQuantity implements XMLInvoiceNode {
		public UDT.AmountType value;

		public BaseQuantity(){}

		public void populateXmlNode(Dom.XmlNode outerNode){ }
	}

	public class CityName implements XMLInvoiceNode {
		public UDT.NameType value;

		public CityName(){
		}

		public CityName(String value){
			this.value = new UDT.NameType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CompanyID implements XMLInvoiceNode {
		public UDT.IdentifierType value;

		public CompanyID(){
		}

		public CompanyID(String value){
			this.value = new UDT.IdentifierType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CompanyLegalForm implements XMLInvoiceNode {
		public UDT.TextType value;

		public CompanyLegalForm(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CountrySubentity implements XMLInvoiceNode {
		public UDT.TextType value;

		public CountrySubentity(){
		}

		public CountrySubentity(String value){
			this.value = new UDT.TextType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CustomizationID implements XMLInvoiceNode {
		public UDT.IdentifierType value;

		public CustomizationID(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class DocumentCurrencyCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public DocumentCurrencyCode(){
		}

		public DocumentCurrencyCode(String code){
			this.value = new UDT.CodeType(code);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class DueDate implements XMLInvoiceNode {
		public UDT.DateType value;

		public DueDate(){
		}

		public DueDate(Date value){
			this.value = new UDT.DateType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class ElectronicMail implements XMLInvoiceNode {
		public UDT.TextType value;

		public ElectronicMail(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class EndDate implements XMLInvoiceNode {
		public UDT.DateType value;

		public EndDate(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class IdentificationCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public IdentificationCode(){
		}

		public IdentificationCode(String value){
			this.value = new UDT.CodeType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class ID implements XMLInvoiceNode {
		public UDT.IdentifierType value;

		public ID(){
		}

		public ID(String documentId){
			this.value = new UDT.IdentifierType(documentId);
		}

		public ID(String documentId, String schemaId){
			this.value = new UDT.IdentifierType(documentId , schemaId);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class InvoiceTypeCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public InvoiceTypeCode(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class InvoicedQuantity implements XMLInvoiceNode {
		public UDT.QuantityType value;

		public InvoicedQuantity(){}

		public InvoicedQuantity( Decimal invoicedQuantity , String unitCode ) {
			this.value = new UDT.QuantityType( invoicedQuantity , unitCode );
		}

		public void populateXMLNode(Dom.XmlNode outerNode){}
	}

	public class IssueDate implements XMLInvoiceNode {
		public UDT.DateType value;

		public IssueDate(){
		}

		public IssueDate(Date value){
			this.value = new UDT.DateType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class Name implements XMLInvoiceNode {

		public UDT.NameType value;

		public Name(){
		}

		public Name(String value){
			this.value = new UDT.NameType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class Note implements XMLInvoiceNode {
		public UDT.TextType value;

		public Note(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class Percent implements XMLInvoiceNode {
		public UDT.PercentType value;

		public Percent(){
		}

		public Percent( Decimal taxPercent ) {
			this.value = new UDT.PercentType(taxPercent);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class PostalZone implements XMLInvoiceNode {
		public UDT.TextType value;

		public PostalZone(){
		}

		public PostalZone(String value){
			this.value = new UDT.TextType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class PayableAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public PayableAmount(){}

		public PayableAmount( Decimal payableAmount , String currencyId ) {
			this.value = new UDT.AmountType( payableAmount , currencyId );
		}

		public void populateXmlNode(Dom.XmlNode outerNode){}
	}

	public class PaymentMeansCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public PaymentMeansCode(){}

		public void populateXmlNode(Dom.XmlNode outerNode){}
	}

	public class PriceAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public PriceAmount(){}

		public PriceAmount(Decimal priceAmount , String currencyId ) {
			this.value = new UDT.AmountType(priceAmount,currencyId);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){}
	}

	public class RegistrationName implements XMLInvoiceNode {
		public UDT.NameType value;

		public RegistrationName(){
		}

		public RegistrationName(String value){
			this.value = new UDT.NameType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class StreetName implements XMLInvoiceNode {
		public UDT.NameType value;

		public StreetName(){
		}

		public StreetName(String value){
			this.value = new UDT.NameType(value);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class TaxableAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public TaxableAmount(){
		}

		public TaxableAmount( Decimal taxableAmount , String currencyId ) {
			this.value = new UDT.AmountType(taxableAmount , currencyId);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class TaxAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public TaxAmount(){
		}

		public TaxAmount(Decimal value, String currencyId){
			this.value = new UDT.AmountType(value, currencyId);
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class TaxCurrencyCode implements XMLInvoiceNode {
		public UDT.CodeType value;

		public TaxCurrencyCode(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class TaxExclusiveAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public TaxExclusiveAmount(){
		}

		public TaxExclusiveAmount(Decimal taxExtensionAmount , String currencyId ) {
			this.value = new UDT.AmountType( taxExtensionAmount , currencyId );
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class TaxInclusiveAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public TaxInclusiveAmount(){
		}

		public TaxInclusiveAmount(Decimal taxInclusiveAmount , String currencyId ) {
			this.value = new UDT.AmountType( taxInclusiveAmount , currencyId );
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class LineExtensionAmount implements XMLInvoiceNode {
		public UDT.AmountType value;

		public LineExtensionAmount(){
		}

		public LineExtensionAmount(Decimal lineExtensionAmount , String currencyId ) {
			this.value = new UDT.AmountType( lineExtensionAmount , currencyId );
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class UBLVersionID implements XMLInvoiceNode {
		public UDT.IdentifierType value;

		public UBLVersionID(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}
}