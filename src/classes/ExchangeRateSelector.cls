/**
 * Created By: Ilin Argirov on 22.3.2022 г.
 * Refactored By: petar.danadzhiev@next-consult.com - Junior Developer on 12.7.2024 г.
 */
public with sharing class ExchangeRateSelector {

    public fferpcore__ExchangeRateGroup__c[] getExchangeRateGroupsByDefaultCurrency(String defaultCurrencyIsoCode) {
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