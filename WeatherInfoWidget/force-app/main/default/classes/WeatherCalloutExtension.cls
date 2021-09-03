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
        
        response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            weatherData = (WeatherWrapper) JSON.deserialize(response.getBody(), WeatherWrapper.class);
            
            return weatherData;
        } else {
            return null;
        }
        
    }
}