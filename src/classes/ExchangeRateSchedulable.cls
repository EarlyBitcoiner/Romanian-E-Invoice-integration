global without sharing class ExchangeRateSchedulable implements Schedulable {

    global void execute(SchedulableContext sc) {
        System.enqueueJob(
                new ExchangeRateQueueable(
                        new ExchangeRateServiceImpl()
                )
        );
    }
}