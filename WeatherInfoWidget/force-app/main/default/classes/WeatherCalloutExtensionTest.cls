/*************************************************************************************
 * @Name         : WeatherCalloutExtensionTest.apxc
 * @Description  : Test class for the WeatherCalloutExtension class
 * @Created By   : Berke Bakkaloğlu
 * @Created Date : Sep 02, 2021
 *************************************************************************************/
@isTest
private class WeatherCalloutExtensionTest {
    private static Account testAccount;
    
    private static void initData(String methodName) {
        switch on methodName {
            when 'testGetCalloutSuccess' {
                testAccount = new Account();
                
                testAccount.Name = 'Test Account';
                testAccount.BillingCity = 'London';
                
                insert testAccount;
            }
            when 'testGetCalloutFailure' {
                testAccount = new Account();
                
                testAccount.Name = 'Test Account';
                
                insert testAccount;
            }
        }
    }
    
    @isTest
    private static void testGetCalloutSuccess() {
        initData('testGetCalloutSuccess');
        
        Test.setMock(HttpCalloutMock.class, new WeatherMockout());
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('id', testAccount.Id);
        ApexPages.StandardController stdController = new ApexPages.StandardController(testAccount);
        WeatherCalloutExtension ext = new WeatherCalloutExtension(stdController);
        
        Test.stopTest();
        
        WeatherWrapper result = ext.weatherData;
        
        System.assertEquals('London', result.name);
        System.assertEquals('light intensity drizzle', result.weather[0].description);
        System.assertEquals(280.32, result.main.temp);
        System.assertEquals('09d', result.weather[0].icon);
    }
    
    @isTest
    private static void testGetCalloutFailure() {
        initData('testGetCalloutFailure');

        Test.setMock(HttpCalloutMock.class, new WeatherMockout());
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('id', testAccount.Id);
        ApexPages.StandardController stdController = new ApexPages.StandardController(testAccount);
        WeatherCalloutExtension ext = new WeatherCalloutExtension(stdController);
        
        Test.stopTest();
        
        WeatherWrapper result = ext.weatherData;
        
        System.assertEquals(result, null);
    }
}