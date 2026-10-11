global with sharing class Batch_DeleteDeveloperLogs implements Database.Batchable<sObject>, Schedulable {
    global void execute(SchedulableContext sc) {
        // Execute the batch job
        Database.executeBatch(this, 2000);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date today = Date.today();
        Date LastMonth = today.toStartOfMonth();
        LastMonth = LastMonth.addMonths(-1);
        // Define the query to select developer logs created before the last week
        String query = 'SELECT Id FROM Developer_Helper__c WHERE CreatedDate <=: LastMonth';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        // Delete the selected developer logs
        delete scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        // Perform any post-processing logic here
    }
    
    // Method to schedule the batch class to run weekly
    public static void scheduleWeekly() {
        String jobName = 'Delete Weekly Developer Logs Job';
        String cronExp = '0 0 0 ? * SUN'; // Every Sunday at midnight
        System.schedule(jobName, cronExp, new Batch_DeleteDeveloperLogs());
    }

    // Method to schedule the batch class to run monthly
    public static void scheduleMonthly() {
        String jobName = 'Delete Monthly Developer Logs Job';
        String cronExp = '0 0 0 1 * ?'; // At midnight on the 1st day of every month
        System.schedule(jobName, cronExp, new Batch_DeleteDeveloperLogs());
    }
}