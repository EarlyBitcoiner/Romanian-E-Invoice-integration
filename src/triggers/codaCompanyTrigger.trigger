/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 8.7.2024 г..
 * 
 * @description 
 */
trigger codaCompanyTrigger on c2g__codaCompany__c ( before update ) {
	XMLInvoiceHandler.handlerTrigger(Trigger.new, Trigger.old, Trigger.operationType);
}