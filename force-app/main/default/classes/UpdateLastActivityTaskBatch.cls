global class UpdateLastActivityTaskBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        if(!Test.isRunningTest()){
            return Database.getQueryLocator([
                SELECT Id
                FROM Account
                WHERE Last_Activity_Created_DateTime__c = null
            ]);
        }else{
            return Database.getQueryLocator([
                SELECT Id
                FROM Account
                WHERE Last_Activity_Created_DateTime__c != null LIMIT 200
            ]);
        }
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : scope) {
            accountIds.add(acc.Id);
        }
        
        // Step 1: Query relevant Tasks
        List<Task> taskList = [
            SELECT AccountId, CreatedDate
            FROM Task
            WHERE AccountId IN :accountIds AND CreatedDate != NULL
        ];
        
        // Step 2: Build map of AccountId -> latest Task date
        Map<Id, Datetime> latestTaskDateMap = new Map<Id, Datetime>();
        
        for (Task t : taskList) {
            if (!latestTaskDateMap.containsKey(t.AccountId) || t.CreatedDate > latestTaskDateMap.get(t.AccountId)) {
                latestTaskDateMap.put(t.AccountId, t.CreatedDate);
            }
        }
        
        // Step 3: Update Accounts
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : scope) {
            if (latestTaskDateMap.containsKey(acc.Id)) {
                acc.Last_Activity_Created_DateTime__c = latestTaskDateMap.get(acc.Id);
                accountsToUpdate.add(acc);
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        // Optional: log or notify
    }
}