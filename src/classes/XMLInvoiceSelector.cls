/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 28.6.2024 г..
 * 
 * @description Used by XMLInvoiceService
 */
public class XMLInvoiceSelector {

	/**
	 * @param codaInvoiceId The Id of the c2g__codaInvoice__c to query
	 *
	 * @return c2g__codaInvoice__c[]
	 */
	public c2g__codaInvoice__c[] getCodaInvoiceById( Id codaInvoiceId ) {
		return [
				SELECT Id,
						Name,
						Posted__c,
						Validated__c,
						c2g__TaxTotal__c,
						c2g__InvoiceCurrency__c,
						c2g__InvoiceCurrency__r.Name,
						c2g__DueDate__c,
						c2g__NetTotal__c,
						c2g__InvoiceTotal__c,
						Document_Number_RO__c,
						c2g__InvoiceDate__c,
						c2g__InvoiceDescription__c,
						c2g__OwnerCompany__r.Name,
						c2g__OwnerCompany__r.c2g__ZipPostCode__c,
						c2g__OwnerCompany__r.Sector__c,
						c2g__OwnerCompany__r.c2g__Street__c,
						c2g__OwnerCompany__r.c2g__ECCountryCode__c,
						c2g__OwnerCompany__r.CountrySubentity__c,
						c2g__OwnerCompany__r.c2g__VATRegistrationNumber__c,
						c2g__OwnerCompany__r.PartyLegalEntity__c,
						c2g__Account__r.Name,
						c2g__Account__r.BillingPostalCode,
						c2g__Account__r.Sector__c,
						c2g__Account__r.BillingStreet,
						c2g__Account__r.c2g__CODAECCountryCode__c,
						c2g__Account__r.CountrySubentity__c,
						c2g__Account__r.c2g__CODAVATRegistrationNumber__c,
						c2g__Account__r.PartyLegalEntity__c
				FROM c2g__codaInvoice__c
				WHERE Id = :codaInvoiceId
		];
	}

	/**
	 * @param codaInvoiceIds Set<Id> with the c2g__codaInvoice__c to query
	 *
	 * @return c2g__codaInvoice__c[]
	 */
	public c2g__codaInvoice__c[] getCodaInvoiceByIds( Set<Id> codaInvoiceIds ) {
		return [
				SELECT Id,
						Name,
						Posted__c,
						Validated__c,
						c2g__TaxTotal__c,
						c2g__InvoiceCurrency__c,
						c2g__InvoiceCurrency__r.Name,
						c2g__DueDate__c,
						c2g__NetTotal__c,
						c2g__InvoiceTotal__c,
						Document_Number_RO__c,
						c2g__InvoiceDate__c,
						c2g__InvoiceDescription__c,
						c2g__OwnerCompany__r.Name,
						c2g__OwnerCompany__r.c2g__ZipPostCode__c,
						c2g__OwnerCompany__r.Sector__c,
						c2g__OwnerCompany__r.c2g__Street__c,
						c2g__OwnerCompany__r.c2g__ECCountryCode__c,
						c2g__OwnerCompany__r.CountrySubentity__c,
						c2g__OwnerCompany__r.c2g__VATRegistrationNumber__c,
						c2g__OwnerCompany__r.PartyLegalEntity__c,
						c2g__Account__r.Name,
						c2g__Account__r.BillingPostalCode,
						c2g__Account__r.Sector__c,
						c2g__Account__r.BillingStreet,
						c2g__Account__r.c2g__CODAECCountryCode__c,
						c2g__Account__r.CountrySubentity__c,
						c2g__Account__r.c2g__CODAVATRegistrationNumber__c,
						c2g__Account__r.PartyLegalEntity__c
				FROM c2g__codaInvoice__c
				WHERE Id IN :codaInvoiceIds
		];
	}

	/**
	 * @param codaInvoiceId The Id of the c2g__codaInvoice__c to which the c2g__codaInvoiceLineItem__c records are related
	 *
	 * @return c2g__codaInvoiceLineItem__c[]
	 */
	public c2g__codaInvoiceLineItem__c[] getCodaInvoiceLineItemByInvoiceId( Id codaInvoiceId ) {
		return [
				SELECT Id,
						c2g__TaxCode1__r.TaxExemptionReasonCode__c,
						c2g__NetValue__c,
						c2g__TaxCode1__r.Tax_Category__c,
						c2g__TaxRate1__c,
						c2g__Quantity__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Item__r.SCMC__Stocking_UOM__r.Name_Other_Language__c,
						SCMFFA__Item_Name__r.Intrastat_Number_2__c,
						SCMFFA__Item_Name__r.Barcode__c,
						c2g__Product__c,
						c2g__Product__r.Name,
						c2g__Product__r.Barcode__c,
						c2g__Invoice__r.c2g__InvoiceDate__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Sales_Order_Line_Item__r.SCMC__Customer_Commitment_Date__c,
						c2g__UnitPrice__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Sales_Order_Line_Item__r.SCMC__Sales_Order__r.SCMC__Actual_Ship_To_Address__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Sales_Order_Line_Item__r.SCMC__Sales_Order__r.SCMC__Customer_Account__r.Country_Codes__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Sales_Order_Line_Item__r.SCMC__Sales_Order__r.SCMC__Actual_Ship_To_Address__r.Country_Codes__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Sales_Order_Line_Item__r.SCMC__Sales_Order__r.SCMC__Customer_Account__r.CountrySubentity__c,
						SCMFFA__SCM_Invoice_Line__r.SCMC__Sales_Order_Line_Item__r.SCMC__Sales_Order__r.SCMC__Actual_Ship_To_Address__r.CountrySubentity__c
				FROM c2g__codaInvoiceLineItem__c
				WHERE c2g__Invoice__c = :codaInvoiceId
		];
	}

	/**
	 * @param taxCodeIds Set<Id> Ids of c2g__codaTaxCode__c
	 *
	 * @description Retrieves all c2g__codaInvoiceLineItem__c which are related with the passed c2g__codaTaxCode__c records
	 *
	 * @return c2g__codaInvoiceLineItem__c[]
	 */
	public c2g__codaInvoiceLineItem__c[] getCodaInvoiceLineItemByTaxCodeId( Set<Id> taxCodeIds) {
		return [SELECT Id,
						c2g__Invoice__c
				FROM c2g__codaInvoiceLineItem__c
				WHERE c2g__TaxCode1__c IN :taxCodeIds];
	}

	/**
	 * @param accountIds Set<Id> with Ids of Account records
	 *
	 * @description Returns c2g__codaInvoice__c[] which are related to the passed accounts
	 *
	 * @return c2g__codaInvoice__c[]
	 */
	public c2g__codaInvoice__c[] getCodaInvoiceByAccountIds( Set<Id> accountIds ) {
		return [
				SELECT Id,
						Validated__c,
						Posted__c
				FROM c2g__codaInvoice__c
				WHERE c2g__Account__c IN :accountIds AND Posted__c = FALSE AND Validated__c = TRUE
		];
	}

	/**
	 * @param companyIds Set<Id> with Ids of c2g__codaCompany__c
	 *
	 * @description Returns c2g__codaInvoice__c[] which are related to the passed companyIds
	 *
	 * @return c2g__codaInvoice__c[]
	 */
	public c2g__codaInvoice__c[] getCodaInvoiceByCompanyIds( Set<Id> companyIds ) {
		return [
				SELECT Id,
						Validated__c,
						Posted__c
				FROM c2g__codaInvoice__c
				WHERE c2g__OwnerCompany__c IN :companyIds AND Posted__c = FALSE AND Validated__c = TRUE
		];
	}
}