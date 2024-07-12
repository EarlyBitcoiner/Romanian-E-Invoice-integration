/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 5.7.2024 г.
 * 
 * @description Trigger handler used in BEFORE_INSERT and BEFORE_UPDATE on c2g__codaInvoice__c , c2g__codaInvoiceLineItem__c , c2g__codaTaxCode__c , Account and 	c2g__codaCompany__c
 */
public class XMLInvoiceHandler {

	@TestVisible
	private static XMLInvoiceSelector selector = new XMLInvoiceSelector();

	public static final String ACCOUNT_NAME = 'Account';
	public static final String INVOICE_NAME = 'c2g__codaInvoice__c';
	public static final String INVOICE_LINE_ITEM_NAME = 'c2g__codaInvoiceLineItem__c';
	public static final String TAX_CODE_NAME = 'c2g__codaTaxCode__c';
	public static final String COMPANY_NAME = 'c2g__codaCompany__c';

	public static final Set<String> requiredFields = new Set<String>{ 'c2g__invoiceDate__c', 'c2g__DueDate__c', 'c2g__NetTotal__c', 'c2g__Tax1Total__c', 'c2g__Tax2Total__c', 'c2g__Tax3Total__c', 'c2g__InvoiceTotal__c', 'c2g__InvoiceCurrency__c', 'c2g__OwnerCompany__c', 'c2g__Account__c' };

	private static Boolean skipDocumentHandler = false;

	public static Boolean handlerTrigger( List<SObject> newRecords, List<SObject> oldRecords, System.TriggerOperation triggerEvent ) {
		System.debug( 'XMLInvoiceHandler' );
		//if( SettingsProvider.getInstance().disableAllTriggers ) {
		//	return skipDocumentHandler;
		//}

		String objectType = newRecords[ 0 ].getSObjectType().getDescribe().getName();

		switch on triggerEvent {
			when BEFORE_INSERT {
				doBeforeCreate( newRecords, objectType );
			}
			when BEFORE_UPDATE {
				doBeforeUpdate( newRecords, oldRecords, objectType );
			}
		}

		return skipDocumentHandler;
	}

	private static void doBeforeCreate( List<SObject> newRecords, String objectType ) {

		switch on objectType {
			when 'c2g__codaInvoiceLineItem__c' {
				System.debug('c2g__codaInvoiceLineItem__c switch case');
				Set<Id> invoiceIds = new Set<Id>();

				List<c2g__codaInvoiceLineItem__c> lines = newRecords;
				for( c2g__codaInvoiceLineItem__c line : lines ) {
					if(line.c2g__Invoice__c != null) {
						invoiceIds.add( line.c2g__Invoice__c );
					}
				}

				List<c2g__codaInvoice__c> invoices = selector.getCodaInvoiceByIds( invoiceIds );
				for( c2g__codaInvoice__c invoice : invoices ) {
					invoice.Validated__c = false;
				}
				update invoices;
			}
		}

	}

	private static void doBeforeUpdate( List<SObject> newRecords, List<SObject> oldRecords, String objectType ) {

		switch on objectType {
			when 'Account' {
				Set<Id> ids = new Set<Id>();

				List<Account> accs = oldRecords;
				for( Account acc : accs ) {
					ids.add( acc.Id );
				}

				List<c2g__codaInvoice__c> invoices = selector.getCodaInvoiceByAccountIds( ids );
				for( c2g__codaInvoice__c invoice : invoices ) {
					invoice.Validated__c = false;
				}

				update invoices;
			}
			when 'c2g__codaInvoice__c' {
				Boolean requiredFieldChanged = false;
				List<c2g__codaInvoice__c> newInvoices = newRecords;
				List<c2g__codaInvoice__c> oldInvoices = oldRecords;

				for( Integer i = 0; i < newInvoices.size(); i++ ) {
					for( String requiredField : requiredFields ) {
						if( newInvoices[ i ].get( requiredField ) != oldInvoices[ i ].get( requiredField ) ) {
							requiredFieldChanged = true;
						}
					}
				}

				for( Integer i = 0; i < newInvoices.size(); i++ ) {
					if( oldInvoices[ i ].Validated__c && newInvoices[ i ].Validated__c == false && newInvoices[ i ].Posted__c == false && newInvoices.size() > 1 ) {
						skipDocumentHandler = true; // have to stop DocumentHandler from starting
					} else if( requiredFieldChanged && oldInvoices[ i ].Validated__c == true && newInvoices[ i ].Validated__c == true && newInvoices[ i ].Posted__c == false ) {
						//System.debug( 'Old Validated__c = ' + oldInvoices[ i ].Validated__c );
						//System.debug( 'New Validated__c = ' + newInvoices[ i ].Validated__c );
						//System.debug( 'Validated__c set to FALSE' );
						newInvoices[ i ].Validated__c = false; // have to update newInvoices[i] to false
					}
				}
			}
			when 'c2g__codaInvoiceLineItem__c' {
				System.debug('c2g__codaInvoiceLineItem__c switch case');
				Set<Id> ids = new Set<Id>();

				List<c2g__codaInvoiceLineItem__c> lines = oldRecords;
				for( c2g__codaInvoiceLineItem__c line : lines ) {
					if(line.c2g__Invoice__c != null) {
						ids.add( line.c2g__Invoice__c );
					}
				}

				List<c2g__codaInvoice__c> invoices = selector.getCodaInvoiceByIds( ids );
				for( c2g__codaInvoice__c invoice : invoices ) {
					invoice.Validated__c = false;
				}
				update invoices;
			}
			when 'c2g__codaTaxCode__c' {
				System.debug('c2g__codaTaxCode__c switch case');
				Set<Id> taxCodeIds = new Set<Id>();
				Set<Id> invoiceIds = new Set<Id>();

				List<c2g__codaTaxCode__c> taxCodes = oldRecords;
				for( c2g__codaTaxCode__c taxCode : taxCodes ) {
					taxCodeIds.add( taxCode.Id );
				}

				List<c2g__codaInvoiceLineItem__c> lines = selector.getCodaInvoiceLineItemByTaxCodeId( taxCodeIds );
				for( c2g__codaInvoiceLineItem__c line : lines ) {
					invoiceIds.add(line.c2g__Invoice__c);
				}

				List<c2g__codaInvoice__c> invoices = selector.getCodaInvoiceByIds( invoiceIds );
				for( c2g__codaInvoice__c invoice : invoices ) {
					invoice.Validated__c = false;
				}
				update invoices;
			}
			when 'c2g__codaCompany__c' {
				System.debug('c2g__codaCompany__c switch case');
				Set<Id> ids = new Set<Id>();

				List<c2g__codaCompany__c> companies = oldRecords;
				for( c2g__codaCompany__c company : companies ) {
					ids.add( company.Id );
				}

				List<c2g__codaInvoice__c> invoices = selector.getCodaInvoiceByCompanyIds( ids );
				for( c2g__codaInvoice__c invoice : invoices ) {
					invoice.Validated__c = false;
				}

				update invoices;
			}
		}
	}
}