global class DeleteAllEmailRecordsBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        if(!Test.isRunningTest()){
            return Database.getQueryLocator('SELECT Id FROM Email__c');
        }else{
            return Database.getQueryLocator('SELECT Id FROM Email__c LIMIT 10');
        }
    }

    global void execute(Database.BatchableContext bc, List<Email__c> scope) {
        try {
            delete scope;
        } catch (DmlException e) {
            System.debug('Error deleting records: ' + e.getMessage());
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Finished deleting all Email__c records.');
    }
}