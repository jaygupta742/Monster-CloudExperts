/**
 * Deletes Integration_Log__c records older than Retention_Days__c on the "Default"
 * Integration_Log_Setting__mdt record (30 days if not set).
 *
 * Schedule once, e.g. daily at 2 AM:
 *     System.schedule('Integration Log Purge', '0 0 2 * * ?', new IntegrationLogPurgeBatch());
 */
public without sharing class IntegrationLogPurgeBatch implements Database.Batchable<SObject>, Schedulable {

    private static final Integer DEFAULT_RETENTION_DAYS = 30;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Datetime cutoff = System.now().addDays(-retentionDays());
        return Database.getQueryLocator([SELECT Id FROM Integration_Log__c WHERE CreatedDate < :cutoff]);
    }

    public void execute(Database.BatchableContext bc, List<Integration_Log__c> scope) {
        Database.delete(scope, false);
    }

    public void finish(Database.BatchableContext bc) {
    }

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new IntegrationLogPurgeBatch(), 2000);
    }

    @TestVisible
    private static Integer retentionDays() {
        Integration_Log_Setting__mdt s = Integration_Log_Setting__mdt.getInstance('Default');
        if (s == null || s.Retention_Days__c == null || s.Retention_Days__c < 1) {
            return DEFAULT_RETENTION_DAYS;
        }
        return s.Retention_Days__c.intValue();
    }
}