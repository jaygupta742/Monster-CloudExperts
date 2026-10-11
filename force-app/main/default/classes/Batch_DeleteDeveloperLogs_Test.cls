@isTest public class Batch_DeleteDeveloperLogs_Test {
    @isTest public static void TestMethod01() {
        Developer_Helper__c logs = new Developer_Helper__c();
        logs.Error_Message__c = null;
        logs.Account__c = null;
        logs.Is_Success__c = true;
        logs.Logs__c = 'Delete Log Test Successfully';
        logs.Operation__c = 'Delete Log Test';
        logs.Starting_Time__c = Datetime.now();
        logs.Type__c = 'Shared';

        insert logs;

        Test.setCreatedDate(logs.Id, Date.today().addMonths(-2));

        Test.startTest();
        Batch_DeleteDeveloperLogs.scheduleWeekly();
        Batch_DeleteDeveloperLogs.scheduleMonthly();
        Database.executeBatch(new Batch_DeleteDeveloperLogs(), 2000);   
        Test.stopTest();
    }
}