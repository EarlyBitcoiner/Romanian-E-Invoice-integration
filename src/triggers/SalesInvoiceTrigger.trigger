trigger SalesInvoiceTrigger on c2g__codaInvoice__c (before insert, before update) {
    Boolean skipDocumentHandler = XMLInvoiceHandler.handlerTrigger(Trigger.new, Trigger.old, Trigger.operationType);
    if(skipDocumentHandler) {
        return;
    }
    DocumentHandler.handleTrigger( Trigger.new, Trigger.old, Trigger.operationType );
}