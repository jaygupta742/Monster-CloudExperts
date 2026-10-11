@IsTest
private class B2CIntegration_LoggingTest {

    private static void enableDebugLogging() {
        IntegrationLogger.settingOverride = new Integration_Log_Setting__mdt(
            Enabled__c = true,
            Log_Level__c = IntegrationLogger.LEVEL_DEBUG,
            Log_Request_Body__c = true,
            Log_Response_Body__c = true,
            Mask_Sensitive_Data__c = true
        );
    }

    private static void setRequest(String body) {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/B2Cintegration/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(body);
        RestContext.request = req;
    }

    private static Integration_Log__c onlyLog() {
        List<Integration_Log__c> logs = [
            SELECT Status__c, Records_Received__c, Error_Message__c, Stack_Trace__c, Request_Body__c, Response_Body__c, Debug_Log__c
            FROM Integration_Log__c
            WHERE Integration_Name__c = 'B2CIntegration'
        ];
        System.assertEquals(1, logs.size(), 'Exactly one Integration_Log__c should be written per call');
        return logs[0];
    }

    @IsTest
    static void malformedRequestIsLoggedAndStillThrows() {
        enableDebugLogging();
        setRequest('{not valid json');

        Test.startTest();
        Boolean thrown = false;
        try {
            B2CIntegration.doPost();
        } catch (Exception e) {
            thrown = true;
        }
        Test.stopTest();

        System.assert(thrown, 'The caller must still receive the error');
        Integration_Log__c log = onlyLog();
        System.assertEquals(IntegrationLogger.STATUS_FAILED, log.Status__c);
        System.assertNotEquals(null, log.Error_Message__c);
        System.assertNotEquals(null, log.Stack_Trace__c);
        System.assertEquals('{not valid json', log.Request_Body__c);
    }

    @IsTest
    static void completedCallIsLoggedWithResponse() {
        enableDebugLogging();
        // Country outside the supported list: the class returns 'Invalid Country' without any DML,
        // so this runs the same on every org regardless of assignment data.
        setRequest('{"seekerid":"LOGTEST","fname":"Log","lname":"Test","Email":"b2c.logtest@example.com",'
            + '"mobile":"9876543210","Country":"Atlantis","Experience":"2 Years"}');

        Test.startTest();
        String result = B2CIntegration.doPost();
        Test.stopTest();

        Integration_Log__c log = onlyLog();
        System.assertEquals(result, log.Response_Body__c);
        System.assertEquals(1, log.Records_Received__c);
        System.assertNotEquals(IntegrationLogger.STATUS_FAILED, log.Status__c);
        System.assert(!log.Request_Body__c.contains('b2c.logtest@example.com'), 'Email must be masked');
        System.assert(log.Debug_Log__c.contains('SearchCountry=Atlantis'), log.Debug_Log__c);
    }
}