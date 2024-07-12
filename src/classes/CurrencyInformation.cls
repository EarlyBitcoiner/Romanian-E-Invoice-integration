/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 12.7.2024 г.
 * 
 * @description Used in ExchangeRateServiceImpl to hold information about currencies
 */
public with sharing class CurrencyInformation {

	public String currencyCode;
	private Map<String, ExchangeRate> exchangeRates = new Map<String, ExchangeRate>();

	public CurrencyInformation(String currencyCode){
		this.currencyCode = currencyCode;
	}

	public ExchangeRate getExchangeRate(String currencyCode){
		return this.exchangeRates.get(currencyCode);
	}

	public void addExchangeRate(String currencyCode , Decimal rate, Date effectiveDate) {
		this.exchangeRates.put(currencyCode, new ExchangeRate(rate, effectiveDate));
	}

	public Boolean containsKey(String currencyCode){
		return this.exchangeRates.containsKey(currencyCode);
	}
}