/**
 * Created By: Ilin Argirov on 22.3.2022 г.
 */
global without sharing class ExchangeRateSchedulable implements Schedulable {

    global void execute(SchedulableContext sc) {
        System.enqueueJob(
                new ExchangeRateQueueable(
                        new ExchangeRateServiceImpl()
                )
        );
    }
}