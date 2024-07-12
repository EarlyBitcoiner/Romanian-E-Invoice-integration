public with sharing class ExchangeRateQueueable implements Queueable, Database.AllowsCallouts {

    @TestVisible
    private ExchangeRateService service;

    public ExchangeRateQueueable(ExchangeRateService service) {
        this.service = service;
    }

    public void execute(QueueableContext qc) {
        service.updateCorporateCurrencyExchangeRates();
    }
}