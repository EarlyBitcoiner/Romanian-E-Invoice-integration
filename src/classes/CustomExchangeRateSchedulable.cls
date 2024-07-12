/**
 * Created by Ilin Argirov on 2022-03-22.
 */

public with sharing class CustomExchangeRateSchedulable implements Schedulable {

    public void execute(SchedulableContext sc) {
        System.enqueueJob(
                new ExchangeRateQueueable(
                        new CustomExchangeRateServiceImpl()
                )
        );
    }

    /**
     * @description Schedules the class to run Mon-Fri at 18:05
     */
    public static void schedule() {
        System.schedule('Exchange Rate Update','0 5 18 ? * MON-FRI', new CustomExchangeRateSchedulable());
    }
}