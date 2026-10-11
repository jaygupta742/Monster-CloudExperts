global class DeleteInactiveTargetJnBatch implements Database.Batchable<SObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM Target_JN_Task__c';

        if (Test.isRunningTest()) {
            // Apply LIMIT in test context to avoid hitting governor limits
            query += ' LIMIT 100';
        }

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Target_JN_Task__c> accountsToDelete = (List<Target_JN_Task__c>) scope;
        try {
            Database.delete(accountsToDelete, false); // false = allow partial success
        } catch (Exception ex) {
            System.debug('Error deleting accounts: ' + ex.getMessage());
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Batch job finished.');
    }
}