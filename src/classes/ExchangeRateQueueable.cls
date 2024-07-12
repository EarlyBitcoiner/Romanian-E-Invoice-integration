/**
 * Created By: Ilin Argirov on 22.3.2022 г.
 * Refactored By: petar.danadzhiev@next-consult.com - Junior Developer on 12.7.2024 г.
 */
public with sharing class ExchangeRateQueueable implements Queueable, Database.AllowsCallouts {

    @TestVisible
    private ExchangeRateService service;

    public ExchangeRateQueueable(ExchangeRateService service) {
        this.service = service;
    }

    public void execute(QueueableContext qc) {
        service.updateCurrenciesExchangeRates();
    }
}