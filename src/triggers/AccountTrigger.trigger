/**
 * Created by Ilin Argirov on 2022-03-28.
 */

trigger AccountTrigger on Account (after insert, before update) {
    AccountTriggerHandler.handleTrigger(Trigger.new, Trigger.old, Trigger.operationType);
    XMLInvoiceHandler.handlerTrigger(Trigger.new, Trigger.old, Trigger.operationType);
}