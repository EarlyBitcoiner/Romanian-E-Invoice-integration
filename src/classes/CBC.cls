/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 25.6.2024 г..
 *
 * @description Apex Class representing the elements in "CommonBasicComponents" also known as C.B.C from "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
 */
public class CBC {
	private static final String CBC_NAMESPACE = 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

	public class BaseAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public BaseAmount(){}

		public void populateXmlNode(Dom.XmlNode outerNode){ }
	}

	public class CityName implements XmlNodeCustom {
		public UDT.NameType value;

		public CityName(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CompanyID implements XmlNodeCustom {
		public UDT.IdentifierType value;

		public CompanyID(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CompanyLegalForm implements XmlNodeCustom {
		public UDT.TextType value;

		public CompanyLegalForm(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CountrySubentity implements XmlNodeCustom {
		public UDT.TextType value;

		public CountrySubentity(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class CustomizationID implements XmlNodeCustom {
		public UDT.IdentifierType value;

		public CustomizationID(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class DocumentCurrencyCode implements XmlNodeCustom {
		public UDT.CodeType value;

		public DocumentCurrencyCode(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class DueDate implements XmlNodeCustom {
		public UDT.DateType value;

		public DueDate(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class ElectronicMail implements XmlNodeCustom {
		public UDT.TextType value;

		public ElectronicMail(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class EndDate implements XmlNodeCustom {
		public UDT.DateType value;

		public EndDate(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class IdentificationCode implements XmlNodeCustom {
		public UDT.CodeType value;

		public IdentificationCode(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class ID implements XmlNodeCustom {
		public UDT.IdentifierType value;

		public ID(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class InvoiceTypeCode implements XmlNodeCustom {
		public UDT.CodeType value;

		public InvoiceTypeCode(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class InvoicedQuantity implements XmlNodeCustom {
		public UDT.QuantityType value;

		public InvoicedQuantity(){}

		public void populateXMLNode(Dom.XmlNode outerNode){}
	}

	public class IssueDate implements XmlNodeCustom {
		public UDT.DateType value;

		public IssueDate(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class Name implements XmlNodeCustom {

		public UDT.NameType value;

		public Name(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class Note implements XmlNodeCustom {
		public UDT.TextType value;

		public Note(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class Percent implements XmlNodeCustom {
		public UDT.PercentType value;

		public Percent(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class PostalZone implements XmlNodeCustom {
		public UDT.TextType value;

		public PostalZone(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class PayableAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public PayableAmount(){}

		public void populateXmlNode(Dom.XmlNode outerNode){}
	}

	public class PaymentMeansCode implements XmlNodeCustom {
		public UDT.CodeType value;

		public PaymentMeansCode(){}

		public void populateXmlNode(Dom.XmlNode outerNode){}
	}

	public class PriceAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public PriceAmount(){}

		public void populateXmlNode(Dom.XmlNode outerNode){}
	}

	public class RegistrationName implements XmlNodeCustom {
		public UDT.NameType value;

		public RegistrationName(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class StreetName implements XmlNodeCustom {
		public UDT.NameType value;

		public StreetName(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class TaxableAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public TaxableAmount(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class TaxAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public TaxAmount(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}

	public class TaxCurrencyCode implements XmlNodeCustom {
		public UDT.CodeType value;

		public TaxCurrencyCode(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class TaxExclusiveAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public TaxExclusiveAmount(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class TaxInclusiveAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public TaxInclusiveAmount(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class LineExtensionAmount implements XmlNodeCustom {
		public UDT.AmountType value;

		public LineExtensionAmount(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){

		}
	}

	public class UBLVersionID implements XmlNodeCustom {
		public UDT.IdentifierType value;

		public UBLVersionID(){
		}

		public void populateXmlNode(Dom.XmlNode outerNode){
		}
	}
}