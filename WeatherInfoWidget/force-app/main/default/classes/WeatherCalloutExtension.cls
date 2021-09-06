/*************************************************************************************
 * @Name         : WeatherCalloutExtension.apxc
 * @Description  : Standard Controller Extension to send an HTTP callout and set the results to a wrapper class
 * @Created By   : Berke Bakkaloğlu
 * @Created Date : Sep 01, 2021
 *************************************************************************************/
public class WeatherCalloutExtension {
    public WeatherWrapper weatherData {get; set;}
    private final String API_KEY = '0dd7ab53306406da32958d6fd85f889f';
    private final Account account;
    
    public WeatherCalloutExtension(ApexPages.StandardController stdController) {
        if (!Test.isRunningTest()) {
            stdController.addFields(new List<String> {'BillingCity'});
        }
        this.account = (Account) stdController.getRecord();
        this.weatherData = doWeatherCallout();
    }
    
    /*************************************************************************************
    * @Name         : doWeatherCallout
    * @Description  : Sends an HTTP callout and deserializes the JSON response into a wrapper class
    * @Created By   : Berke Bakkaloğlu
    * @Created Date : Sep 01, 2021
    * @Return	WeatherWrapper	Deserialized version of the callout response
    *************************************************************************************/
    private WeatherWrapper doWeatherCallout() {
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        
        request.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q=' + account.BillingCity + '&appid=' + API_KEY);
        request.setMethod('GET');
        
        try {
        	response = http.send(request);
        } catch (CalloutException e) {
            System.debug(e);
        }
        
        if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
            weatherData = (WeatherWrapper) JSON.deserialize(response.getBody(), WeatherWrapper.class);
            
            return weatherData;
        } else if (response.getStatusCode() >= 400 && response.getStatusCode() < 600) {
            Integer statusCode = response.getStatusCode();
            ApexPages.Message statusMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error ' + statusCode + ': ' + response.getStatus());
            ApexPages.addMessage(statusMessage);
            
            return null;
        } else {
            return null;
        }
    }
}