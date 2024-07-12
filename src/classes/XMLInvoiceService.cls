/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 18.6.2024 г.
 *
 * @description creates E-Invoice in XML format
 */
public class XMLInvoiceService {

	public Dom.Document invoice;
	public List<XMLInvoiceNode> invoiceNodes;

	private final static String UBL_CIUS_RULES_REFERENCE = 'urn:cen.eu:en16931:2017#compliant#urn:efactura.mfinante.ro:CIUS-RO:1.0.1';
	private final static String UBL_VERSION = '2.1';
	private final static String INVOICE_TYPE_CODE = '380';

	@TestVisible
	private XMLInvoiceSelector selector = new XMLInvoiceSelector();

	public XMLInvoiceService() {
		invoice = new Dom.Document();
		invoiceNodes = new List<XMLInvoiceNode>();
		Dom.XmlNode root = invoice.createRootElement( 'Invoice', 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2', '' );
		root.setNamespace( 'cbc', 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2' );
		root.setNamespace( 'cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2' );

		Dom.XmlNode UBLVersionId = root.addChildElement( 'cbc:UBLVersionID', null, null );
		UBLVersionId.addTextNode( UBL_VERSION );

		Dom.XmlNode CustomizationID = root.addChildElement( 'cbc:CustomizationID', null, null );
		CustomizationID.addTextNode( UBL_CIUS_RULES_REFERENCE );
	}

	/**
	 * @param codaInvoiceId The ID of the c2g__codaInvoice__c for which we are constructing an E-Invoice
	 *
	 * @description SOQL's the c2g__codaInvoice__c and all her related c2g__codaInvoiceLineItem__c , after this uses them to create apex class instances of the classes representing the required XML nodes and pushes them into "invoiceNodes".
	 */
	public void constructXmlInvoiceNodes( Id codaInvoiceId ) {
		c2g__codaInvoice__c codaInvoice = selector.getCodaInvoiceById( codaInvoiceId )[ 0 ];
		List<c2g__codaInvoiceLineItem__c> lineItems = selector.getCodaInvoiceLineItemByInvoiceId( codaInvoiceId );
		Map<String, List<c2g__codaInvoiceLineItem__c>> lineItemsByTaxCategoryAndPercentMap = mapLineItemsByTaxCategoryAndPercent( lineItems );

		// the order in which the invoice nodes are added to the list is very important. It defines the order in which they will appear in the XML document.
		CBC.ID invoiceID = new CBC.ID( codaInvoice.Document_Number_RO__c );
		this.invoiceNodes.add( invoiceID );
		CBC.IssueDate invoiceIssueDate = new CBC.IssueDate( codaInvoice.c2g__InvoiceDate__c );
		this.invoiceNodes.add( invoiceIssueDate );
		CBC.DueDate invoiceDueDate = new CBC.DueDate( codaInvoice.c2g__DueDate__c );
		this.invoiceNodes.add( invoiceDueDate );
		CBC.InvoiceTypeCode invoiceTypeCode = new CBC.InvoiceTypeCode( INVOICE_TYPE_CODE );
		this.invoiceNodes.add( invoiceTypeCode );
		CBC.DocumentCurrencyCode documentCurrencyCode = new CBC.DocumentCurrencyCode( codaInvoice.c2g__InvoiceCurrency__r.Name );
		this.invoiceNodes.add( documentCurrencyCode );
		CAC.AccountingSupplierParty accountingSupplierParty = new CAC.AccountingSupplierParty( codaInvoice );
		this.invoiceNodes.add( accountingSupplierParty );
		CAC.AccountingCustomerParty accountingCustomerParty = new CAC.AccountingCustomerParty( codaInvoice );
		this.invoiceNodes.add( accountingCustomerParty );
		CAC.TaxTotal taxTotal = new CAC.TaxTotal( codaInvoice, lineItemsByTaxCategoryAndPercentMap );
		this.invoiceNodes.add( taxTotal );
		CAC.LegalMonetaryTotal legalMonetaryTotal = new CAC.LegalMonetaryTotal( codaInvoice );
		this.invoiceNodes.add( legalMonetaryTotal );

		Integer index = 1;
		List<CAC.InvoiceLine> invoiceLines = new List<CAC.InvoiceLine>();
		for( c2g__codaInvoiceLineItem__c lineItem : lineItems ) {
			invoiceLines.add( new CAC.InvoiceLine( lineItem, codaInvoice.c2g__InvoiceCurrency__r.Name, index ) );
			index++;
		}
		for( CAC.InvoiceLine invoiceLine : invoiceLines ) {
			this.invoiceNodes.add( invoiceLine );
		}
	}

	/**
	 * @description Iterates every element in "invoiceNodes" (XMLInvoiceNode instances) and calls its populateXmlNode method which populates "invoice" (Dom.Document instance)
	 */
	public void populateXmlInvoiceDocument() {
		Dom.XmlNode root = this.invoice.getRootElement();

		for( XMLInvoiceNode invoiceNode : this.invoiceNodes ) {
			invoiceNode.populateXmlNode( root );
		}
	}

	/**
	 * @param lineItems The List<c2g__codaInvoiceLineItem__c> which need mapping
	 *
	 * @description concatenates the c2g__codaInvoiceLineItem__c tax category and tax percent (*EXAMPLE* tax category = "S" + tax percent = "9" = "S9") puts the concatenated string as a map key("S9") and the c2g__codaInvoiceLineItem__c adds to its values.
	 *
	 * @return Map<String, List<c2g__codaInvoiceLineItem__c>>
	 */
	private Map<String, List<c2g__codaInvoiceLineItem__c>> mapLineItemsByTaxCategoryAndPercent( List<c2g__codaInvoiceLineItem__c> lineItems ) {
		Map<String, List<c2g__codaInvoiceLineItem__c>> result = new Map<String, List<c2g__codaInvoiceLineItem__c>>();
		for( c2g__codaInvoiceLineItem__c lineItem : lineItems ) {
			String TaxCategoryAndPercent = lineItem.c2g__TaxCode1__r.Tax_Category__c + lineItem.c2g__TaxRate1__c;
			if( result.containsKey( TaxCategoryAndPercent ) ) {
				result.get( TaxCategoryAndPercent ).add( lineItem );
			} else {
				result.put( TaxCategoryAndPercent, new List<c2g__codaInvoiceLineItem__c> { lineItem } );
			}
		}
		/*
		* Example -> If line item has tax category "S" and tax percent "9" then the map key will be "S9"
		* so the map will look like : { "S9" , List<c2g__codaInvoiceLineItem__c> }
		*/
		return result;
	}

	/**
	 * @param invoiceId c2g__codaInvoice__c ID
	 *
	 * @description Sets the Invoice as validated
	 */
	@AuraEnabled
	public static void setInvoiceAsValidated( Id invoiceId ){
		XMLInvoiceSelector selector = new XMLInvoiceSelector();
		c2g__codaInvoice__c invoice = selector.getCodaInvoiceById( invoiceId)[0];
		invoice.Validated__c = true;
		update invoice;
	}
}