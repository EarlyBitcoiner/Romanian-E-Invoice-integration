/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 8.7.2024 г.
 * 
 * @description 
 */
trigger codaInvoiceLineItemTrigger on c2g__codaInvoiceLineItem__c ( before insert, before update ) {
	XMLInvoiceHandler.handlerTrigger(Trigger.new, Trigger.old, Trigger.operationType);
}