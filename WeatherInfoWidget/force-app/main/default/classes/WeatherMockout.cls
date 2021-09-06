/*************************************************************************************
 * @Name         : WeatherMockout.apxc
 * @Description  : Test class to send a fake response to the HTTP callout
 * @Created By   : Berke Bakkaloğlu
 * @Created Date : Sep 02, 2021
 *************************************************************************************/
@isTest
global class WeatherMockout implements HttpCalloutMock {
    
    public static final String RESPONSE_HEADER_PARAM_NAME = 'Content-Type';
    public static final String RESPONSE_HEADER_CONTENT_TYPE = 'application/json';
    private static final String RESPONSE_BODY = '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":300,"main":"Drizzle","description":"light intensity drizzle","icon":"09d"}],"base":"stations","main":{"temp":280.32,"pressure":1012,"humidity":81,"temp_min":279.15,"temp_max":281.15},"visibility":10000,"wind":{"speed":4.1,"deg":80},"clouds":{"all":90},"dt":1485789600,"sys":{"type":1,"id":5091,"message":0.0103,"country":"GB","sunrise":1485762037,"sunset":1485794875},"id":2643743,"name":"London","cod":200}';
	private static final String API_CALL = 'https://api.openweathermap.org/data/2.5/weather?q=London&appid=0dd7ab53306406da32958d6fd85f889f';
    
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        
        response.setHeader(RESPONSE_HEADER_PARAM_NAME, RESPONSE_HEADER_CONTENT_TYPE);
        response.setBody(RESPONSE_BODY);
        if (request.getEndpoint() == API_CALL) {
        	response.setStatusCode(200);
            response.setStatus('SUCCESS');
        } else {
            response.setStatusCode(404);
            response.setStatus('Not found');
        }
        
        return response;
    }
}