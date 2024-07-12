global virtual without sharing class ExchangeRateHttpCalloutService {

    public static final String CLASS_NAME = ExchangeRateHttpCalloutService.class.getName();
    public static final String BNB_EXCHANGE_RATE_NAMED_CREDENTIAL = 'callout:BNB_Exchange_Rates';
    public static final String DATED_CONVERSION_RATE_ENDPOINT = Url.getSalesforceBaseUrl().toExternalForm() + '/services/data/v52.0/composite/tree/DatedConversionRate';

    /**
     * @description Executes BNB Exchange Rate request.
     *
     * @return body as xml with rates
     */
    public HttpResponse requestBNBExchangeRates() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BNB_EXCHANGE_RATE_NAMED_CREDENTIAL);
        req.setMethod('GET');
        req.setTimeout(12000);

        return sendHttpRequest(req);
    }

    /**
     * @description Creates DatedConversionRate records in Salesforce via the API.
     *
     * @param jsonPayload datedConversionRateJsonPayload
     */
    public void sendRecordsToSalesforce(String jsonPayload) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(DATED_CONVERSION_RATE_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(12000);
        req.setBody(jsonPayload);

        sendHttpRequest(req);
    }

    /**
     * @description Send a provided Http Request.
     *
     * @param req Http Request
     *
     * @return Http Response
     */
    protected HttpResponse sendHttpRequest(HttpRequest req) {
        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);
        } catch (CalloutException e) {
            ncerpUtil.Logger.setSubject(String.format(Constant.EXCEPTION_OCCURRED, new Object[]{CLASS_NAME}));
            ncerpUtil.Logger.log(e);
            ncerpUtil.Logger.emit();
        }

        if (res.getStatusCode() > 299) {
            String errorMessage = SimpleLogger.constructError(
                    'Request failed: {0} : {1}',
                    new Object[]{
                            res.getStatusCode(),
                            res.getBody()
                    }
            );
            ncerpUtil.Logger.setSubject(String.format(Constant.EXCEPTION_OCCURRED, new Object[]{CLASS_NAME}));
            ncerpUtil.Logger.log(errorMessage);
            ncerpUtil.Logger.emit();
        }

        return res;
    }
}