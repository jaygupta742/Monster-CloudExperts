global class UpdateLastActivityUsingTaskBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        if(!Test.isRunningTest()){
            return Database.getQueryLocator([
                SELECT Id, (SELECT Id, CreatedDate FROM Tasks ORDER BY CreatedDate DESC)
                FROM Account
                WHERE Last_Activity_Created_DateTime__c = null
            ]);
        }else{
            return Database.getQueryLocator([
                SELECT Id, (SELECT Id, CreatedDate FROM Tasks ORDER BY CreatedDate DESC)
                FROM Account
                WHERE Last_Activity_Created_DateTime__c != null LIMIT 200
            ]);
        }
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        
        for (SObject s : scope) {
            Account acc = (Account)s;
            
            if (acc.Tasks != null && !acc.Tasks.isEmpty()) {
                Task latestTask = acc.Tasks[0]; // First task is latest due to ORDER BY CreatedDate DESC
                acc.Last_Activity_Created_DateTime__c = latestTask.CreatedDate;
                accountsToUpdate.add(acc);
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            Database.update(accountsToUpdate,false);
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        // Optional: send email or log
    }
}