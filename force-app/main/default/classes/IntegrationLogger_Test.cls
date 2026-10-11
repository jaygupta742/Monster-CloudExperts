@IsTest
private class IntegrationLogger_Test {

    private class TestException extends Exception {}

    private static final String NAME = 'LoggerTestIntegration';
    private static final String BODY =
        '[{"seekerid":"1","Email":"jane.doe@example.com","mobile":9876543210,"state":"Karnataka"}]';

    private static void configure(String level, Boolean enabled) {
        IntegrationLogger.settingOverride = new Integration_Log_Setting__mdt(
            Enabled__c = enabled,
            Log_Level__c = level,
            Log_Request_Body__c = true,
            Log_Response_Body__c = true,
            Mask_Sensitive_Data__c = true,
            Sensitive_Fields__c = 'Email, mobile'
        );
    }

    private static IntegrationLogger newLogger() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/LoggerTest/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(BODY);
        IntegrationLogger logger = new IntegrationLogger(NAME);
        logger.logRequest(req);
        return logger;
    }

    private static List<Integration_Log__c> logs() {
        return [
            SELECT Integration_Name__c, Status__c, Log_Level__c, Request_URI__c, HTTP_Method__c, Request_Body__c,
                   Response_Body__c, Records_Received__c, Records_Inserted__c, Records_Updated__c, Records_Failed__c,
                   Error_Message__c, Stack_Trace__c, Record_Results__c, Debug_Log__c, Limits_Summary__c, Request_Id__c
            FROM Integration_Log__c
            WHERE Integration_Name__c = :NAME
        ];
    }

    @IsTest
    static void infoLevelLogsSuccessfulCallWithMaskedBody() {
        configure(IntegrationLogger.LEVEL_INFO, true);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(2);
        logger.debug('not kept at INFO');
        logger.recordResult('jane.doe@example.com', IntegrationLogger.ACTION_INSERT, true, null);
        logger.recordResult('john@example.com', IntegrationLogger.ACTION_UPDATE, true, null);
        logger.finish('Success');
        Test.stopTest();

        List<Integration_Log__c> result = logs();
        System.assertEquals(1, result.size());
        Integration_Log__c log = result[0];
        System.assertEquals(IntegrationLogger.STATUS_SUCCESS, log.Status__c);
        System.assertEquals('INFO', log.Log_Level__c);
        System.assertEquals('POST', log.HTTP_Method__c);
        System.assertEquals('/services/apexrest/LoggerTest/', log.Request_URI__c);
        System.assertEquals(2, log.Records_Received__c);
        System.assertEquals(1, log.Records_Inserted__c);
        System.assertEquals(1, log.Records_Updated__c);
        System.assertEquals(0, log.Records_Failed__c);
        System.assertEquals('Success', log.Response_Body__c);
        System.assertNotEquals(null, log.Request_Id__c);
        System.assertNotEquals(null, log.Limits_Summary__c);
        System.assert(!log.Request_Body__c.contains('jane.doe@example.com'), 'Email must be masked');
        System.assert(log.Request_Body__c.contains('"Email":"ja****@example.com"'), log.Request_Body__c);
        System.assert(!log.Request_Body__c.contains('9876543210'), 'Numeric phone must be masked');
        System.assert(log.Request_Body__c.contains('"state":"Karnataka"'), 'Non-sensitive fields are kept');
        System.assertEquals(null, log.Record_Results__c, 'Successful records are only listed at DEBUG');
        System.assertEquals(null, log.Debug_Log__c, 'Debug lines are only kept at DEBUG');
    }

    @IsTest
    static void errorLevelSkipsSuccessfulCall() {
        configure(IntegrationLogger.LEVEL_ERROR, true);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(1);
        logger.recordResult('a@example.com', IntegrationLogger.ACTION_INSERT, true, null);
        logger.finish('Success');
        Test.stopTest();

        System.assertEquals(0, logs().size());
    }

    @IsTest
    static void errorLevelLogsPartialFailure() {
        configure(IntegrationLogger.LEVEL_ERROR, true);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(2);
        logger.recordResult('ok@example.com', IntegrationLogger.ACTION_INSERT, true, null);
        logger.recordResult('bad@example.com', IntegrationLogger.ACTION_UPDATE, false, 'FIELD_CUSTOM_VALIDATION_EXCEPTION: nope');
        logger.finish('Success');
        Test.stopTest();

        Integration_Log__c log = logs()[0];
        System.assertEquals(IntegrationLogger.STATUS_PARTIAL, log.Status__c);
        System.assertEquals(1, log.Records_Failed__c);
        System.assert(log.Error_Message__c.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), log.Error_Message__c);
        System.assert(log.Record_Results__c.contains('ba****@example.com'), log.Record_Results__c);
        System.assert(!log.Record_Results__c.contains('ok@'), 'Only failures are listed below DEBUG');
    }

    @IsTest
    static void allRecordsFailingIsFailed() {
        configure(IntegrationLogger.LEVEL_ERROR, true);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(1);
        logger.recordResult('bad@example.com', IntegrationLogger.ACTION_INSERT, false, 'REQUIRED_FIELD_MISSING');
        logger.finish('Success');
        Test.stopTest();

        System.assertEquals(IntegrationLogger.STATUS_FAILED, logs()[0].Status__c);
    }

    @IsTest
    static void exceptionIsLoggedWithStackTrace() {
        configure(IntegrationLogger.LEVEL_ERROR, true);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.fail(new TestException('Boom'));
        logger.finish('ignored - already completed');
        Test.stopTest();

        List<Integration_Log__c> result = logs();
        System.assertEquals(1, result.size(), 'Only the first completion is published');
        System.assertEquals(IntegrationLogger.STATUS_FAILED, result[0].Status__c);
        System.assert(result[0].Error_Message__c.contains('Boom'), result[0].Error_Message__c);
        System.assertNotEquals(null, result[0].Stack_Trace__c);
    }

    @IsTest
    static void debugLevelKeepsDebugLinesAndAllRecords() {
        configure(IntegrationLogger.LEVEL_DEBUG, true);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(1);
        logger.debug('step one');
        logger.recordResult('a@example.com', IntegrationLogger.ACTION_INSERT, true, null);
        logger.finish('Success');
        Test.stopTest();

        Integration_Log__c log = logs()[0];
        System.assert(log.Debug_Log__c.contains('step one'), log.Debug_Log__c);
        System.assert(log.Record_Results__c.contains('a****@example.com'), log.Record_Results__c);
        System.assert(log.Record_Results__c.contains('Insert'), 'Successful records are listed at DEBUG');
    }

    @IsTest
    static void emptyRequestIsNoData() {
        configure(IntegrationLogger.LEVEL_INFO, true);

        Test.startTest();
        newLogger().finish('No Data');
        Test.stopTest();

        System.assertEquals(IntegrationLogger.STATUS_NO_DATA, logs()[0].Status__c);
    }

    @IsTest
    static void disabledLogsNothing() {
        configure(IntegrationLogger.LEVEL_DEBUG, false);

        Test.startTest();
        IntegrationLogger logger = newLogger();
        System.assertEquals(false, logger.isEnabled());
        logger.fail(new TestException('Boom'));
        Test.stopTest();

        System.assertEquals(0, logs().size());
    }

    @IsTest
    static void saveResultOverloadCapturesErrors() {
        configure(IntegrationLogger.LEVEL_DEBUG, true);
        List<Database.SaveResult> results = Database.insert(
            new List<SObject>{ new Integration_Log__c(Integration_Name__c = 'other'), new Account() }, false);
        System.assert(results[0].isSuccess());
        System.assert(!results[1].isSuccess());

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(2);
        logger.recordResult('ok@example.com', IntegrationLogger.ACTION_INSERT, results[0]);
        logger.recordResult('bad@example.com', IntegrationLogger.ACTION_INSERT, results[1]);
        logger.finish('Success');
        Test.stopTest();

        Integration_Log__c log = logs()[0];
        System.assertEquals(IntegrationLogger.STATUS_PARTIAL, log.Status__c);
        System.assertEquals(1, log.Records_Inserted__c);
        System.assertEquals(1, log.Records_Failed__c);
        System.assertNotEquals(null, log.Error_Message__c);
    }

    @IsTest
    static void unmaskedWhenMaskingOff() {
        configure(IntegrationLogger.LEVEL_INFO, true);
        IntegrationLogger.settingOverride.Mask_Sensitive_Data__c = false;

        Test.startTest();
        IntegrationLogger logger = newLogger();
        logger.setRecordsReceived(1);
        logger.finish('Success');
        Test.stopTest();

        System.assert(logs()[0].Request_Body__c.contains('jane.doe@example.com'));
    }

    @IsTest
    static void maskValueAndTruncate() {
        System.assertEquals('ja****@example.com', IntegrationLogger.maskValue('jane@example.com'));
        System.assertEquals('98****10', IntegrationLogger.maskValue('9876543210'));
        System.assertEquals('****', IntegrationLogger.maskValue('abc'));
        System.assertEquals(null, IntegrationLogger.maskValue(null));

        String longText = 'x'.repeat(IntegrationLogger.MAX_LONG_TEXT + 10);
        String cut = IntegrationLogger.truncate(longText, IntegrationLogger.MAX_LONG_TEXT);
        System.assertEquals(IntegrationLogger.MAX_LONG_TEXT, cut.length());
        System.assert(cut.endsWith('[truncated]'));
        System.assertEquals('short', IntegrationLogger.truncate('short', 10));
    }

    @IsTest
    static void usesDeployedSettingsWhenNoOverride() {
        // Falls back to the Default record (or the built-in ERROR config) for an unknown integration.
        IntegrationLogger logger = new IntegrationLogger('NoSuchIntegration');
        System.assertNotEquals(null, logger.isEnabled());
    }

    @IsTest
    static void purgeDeletesOldLogs() {
        Integration_Log__c oldLog = new Integration_Log__c(Integration_Name__c = NAME);
        Integration_Log__c newLog = new Integration_Log__c(Integration_Name__c = NAME);
        insert new List<Integration_Log__c>{ oldLog, newLog };
        Test.setCreatedDate(oldLog.Id, System.now().addDays(-(IntegrationLogPurgeBatch.retentionDays() + 1)));

        Test.startTest();
        Database.executeBatch(new IntegrationLogPurgeBatch());
        System.schedule('Integration Log Purge Test', '0 0 2 * * ?', new IntegrationLogPurgeBatch());
        Test.stopTest();

        List<Integration_Log__c> remaining = [SELECT Id FROM Integration_Log__c WHERE Integration_Name__c = :NAME];
        System.assertEquals(1, remaining.size());
        System.assertEquals(newLog.Id, remaining[0].Id);
    }
}