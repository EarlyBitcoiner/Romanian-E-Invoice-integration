/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 18.6.2024 г..
 *
 * @description creates E-Invoice in XML format
 */
public class XMLInvoiceService {

	public Dom.Document invoice;
	private final static String UBL_CIUS_RULES = 'urn:cen.eu:en16931:2017#compliant#urn:efactura.mfinante.ro:CIUS-RO:1.0.1';
	private final static String UBL_VERSION = '2.1';
	private final static String INVOICE_TYPE_CODE = '380';

	public XMLInvoiceService(){
		invoice = new Dom.Document();
		Dom.XmlNode root = invoice.createRootElement('Invoice','urn:oasis:names:specification:ubl:schema:xsd:Invoice-2','');
		root.setNamespace('cbc','urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2');
		root.setNamespace('cac','urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2');

		Dom.XmlNode UBLVersionId = root.addChildElement('cbc:UBLVersionId',null,null);
		UBLVersionId.addTextNode(UBL_VERSION);

		Dom.XmlNode CustomizationID = root.addChildElement('cbc:CustomizationID',null,null);
		CustomizationID.addTextNode(UBL_CIUS_RULES);

		Dom.XmlNode InvoiceTypeCode = root.addChildElement('cbc:InvoiceTypeCode',null,null);
		InvoiceTypeCode.addTextNode(INVOICE_TYPE_CODE);
	}

	public void constructInvoice(Id codaInvoiceId){
		//List<c2g__codaInvoiceLineItem__c> lineItems = new List<c2g__codaInvoiceLineItem__c>();

		CBC.ID invoiceID = new CBC.ID();
		CBC.IssueDate invoiceIssueDate = new CBC.IssueDate();
		CBC.DueDate invoiceDueDate =  new CBC.DueDate();
		CBC.DocumentCurrencyCode documentCurrencyCode = new CBC.DocumentCurrencyCode();

		CAC.AccountingSupplierParty accountingSupplierParty = new CAC.AccountingSupplierParty();
		CAC.AccountingCustomerParty accountingCustomerParty = new CAC.AccountingCustomerParty();

		CAC.TaxTotal taxTotal = new CAC.TaxTotal();

		CAC.LegalMonetaryTotal legalMonetaryTotal = new CAC.LegalMonetaryTotal();

		List<CAC.InvoiceLine> invoiceLines = new List<CAC.InvoiceLine>();
		//for(c2g__codaInvoiceLineItem__c lineItem : lineItems){

		//}

		Dom.XmlNode root = this.invoice.getRootElement();
	}
}