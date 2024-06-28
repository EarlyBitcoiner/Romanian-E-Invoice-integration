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

	@TestVisible
	private XMLInvoiceSelector selector = new XMLInvoiceSelector();

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
		c2g__codaInvoice__c codaInvoice = selector.getCodaInvoiceById(codaInvoiceId)[0];
		List<c2g__codaInvoiceLineItem__c> lineItems = codaInvoice.c2g__InvoiceLineItems__r;
		Map<String, List<c2g__codaInvoiceLineItem__c>> lineItemsByTaxCategoryAndPercentMap = mapLineItemsByTaxCategoryAndPercent(lineItems);

		List<CAC.InvoiceLine> invoiceLines = new List<CAC.InvoiceLine>();
		Integer index = 1;
		for(c2g__codaInvoiceLineItem__c lineItem : lineItems){
			invoiceLines.add(new CAC.InvoiceLine(lineItem , codaInvoice.c2g__InvoiceCurrency__r.Name , index ));
			index++;
		}
		CBC.ID invoiceID = new CBC.ID(codaInvoice.Document_Number_RO__c);
		CBC.IssueDate invoiceIssueDate = new CBC.IssueDate(codaInvoice.c2g__InvoiceDate__c);
		CBC.DueDate invoiceDueDate =  new CBC.DueDate(codaInvoice.c2g__DueDate__c);
		CBC.DocumentCurrencyCode documentCurrencyCode = new CBC.DocumentCurrencyCode(codaInvoice.c2g__InvoiceCurrency__r.Name);
		CAC.AccountingSupplierParty accountingSupplierParty = new CAC.AccountingSupplierParty(codaInvoice);
		CAC.AccountingCustomerParty accountingCustomerParty = new CAC.AccountingCustomerParty(codaInvoice);
		CAC.TaxTotal taxTotal = new CAC.TaxTotal(codaInvoice, lineItemsByTaxCategoryAndPercentMap);
		CAC.LegalMonetaryTotal legalMonetaryTotal = new CAC.LegalMonetaryTotal(codaInvoice);

		Dom.XmlNode root = this.invoice.getRootElement();
	}

	private Map<String, List<c2g__codaInvoiceLineItem__c>> mapLineItemsByTaxCategoryAndPercent(List<c2g__codaInvoiceLineItem__c> lineItems){
		Map<String, List<c2g__codaInvoiceLineItem__c>> result = new Map<String, List<c2g__codaInvoiceLineItem__c>>();
		for( c2g__codaInvoiceLineItem__c lineItem : lineItems ){
			String TaxCategoryAndPercent = lineItem.c2g__TaxCode1__r.Tax_Category__c + lineItem.c2g__TaxRate1__c;
			if( result.containsKey( TaxCategoryAndPercent ) ) {
				result.get( TaxCategoryAndPercent ).add( lineItem );
			} else {
				result.put( TaxCategoryAndPercent , new List<c2g__codaInvoiceLineItem__c>{ lineItem } );
			}
		}
		/*
		* Example -> If line item has tax category "S" and tax percent "5" then the map key will be "S5"
		* so the map will look like : { "S5" , List<c2g__codaInvoiceLineItem__c> }
		*/
		return result;
	}
}