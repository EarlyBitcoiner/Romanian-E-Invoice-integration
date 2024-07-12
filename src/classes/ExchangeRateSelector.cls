public with sharing class ExchangeRateSelector {

    public fferpcore__ExchangeRateGroup__c[] getExchangeRateGroups(String defaultCurrencyIsoCode) {
        String isoCodeFilter = defaultCurrencyIsoCode + '%';
        return [
                SELECT
                        fferpcore__SelectedCurrencies__c
                FROM fferpcore__ExchangeRateGroup__c
                WHERE fferpcore__DefaultCurrency__c LIKE :isoCodeFilter
        ];
    }

    public CurrencyType getCorporateCurrency() {
        return [
                SELECT IsoCode
                FROM CurrencyType
                WHERE IsActive = TRUE
                AND IsCorporate = TRUE
                LIMIT 1
        ];
    }

    public CurrencyType[] getActiveCurrencies() {
        return [
                SELECT IsoCode
                FROM CurrencyType
                WHERE IsActive = TRUE
                AND IsCorporate = FALSE
                AND IsoCode != 'EUR'
        ];
    }

    public Integer getDatedConversionRatesCountForDate(Date startDate) {
        return [
                SELECT
                        COUNT()
                FROM DatedConversionRate
                WHERE StartDate = :startDate
        ];
    }
}