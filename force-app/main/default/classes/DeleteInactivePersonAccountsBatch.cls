global class DeleteInactivePersonAccountsBatch implements Database.Batchable<SObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM Account WHERE Person_Account__c = true AND CreatedDate < LAST_N_MONTHS:6';

        if (Test.isRunningTest()) {
            query += ' LIMIT 100';
        }

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> accountsToDelete = (List<Account>) scope;
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