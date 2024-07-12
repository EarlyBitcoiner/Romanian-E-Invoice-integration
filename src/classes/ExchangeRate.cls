/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 12.7.2024 г.
 * 
 * @description Used in CurrencyInformation class to store exchange rates
 */
public with sharing class ExchangeRate {

	public Decimal reverseRate;
	public Date effectiveDate;

	public ExchangeRate(Decimal rate, Date effectiveDate) {
		this.reverseRate = rate;
		this.effectiveDate = effectiveDate;
	}
}