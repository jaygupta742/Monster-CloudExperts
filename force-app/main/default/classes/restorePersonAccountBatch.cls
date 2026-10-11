global class restorePersonAccountBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator Start(Database.BatchableContext context){
        if(Test.isRunningTest()){
            return Database.getQueryLocator('SELECT Id FROM Account Where IsDeleted = true AND LastModifiedDate = YESTERDAY LIMIT 1 ALL ROWS');
        }else{
            return Database.getQueryLocator('SELECT Id FROM Account Where IsDeleted = true AND LastModifiedDate = YESTERDAY ALL ROWS');
        }
    }
    
    global void execute(Database.BatchableContext context, List<Account> personAccounts) {
        List<Account> failedToDeleteRecords = new List<Account>();
       
        Database.UndeleteResult[] undeleteResults = Database.undelete(personAccounts, false);
        
        for (Integer i = 0; i < undeleteResults.size(); i++) {
            if (!undeleteResults[i].isSuccess()) {
                failedToDeleteRecords.add(personAccounts[i]);
                System.debug('Failed to delete record Id: ' + personAccounts[i].Id + 
                             ' - Error: ' + undeleteResults[i].getErrors()[0].getMessage());
            }
        }
        
        if (!failedToDeleteRecords.isEmpty()) {
            System.debug('Number of records that failed to delete: ' + failedToDeleteRecords.size());
        }
    }
    
    global void Finish(Database.BatchableContext context){
        System.debug('Batch processing to delete Account Team Members is complete.');
    }
}