global class DeleteOldEmailsBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        if(!Test.isRunningTest()){
            return Database.getQueryLocator([
                SELECT Id
                FROM EmailMessage
                WHERE CreatedDate < 2024-04-01T00:00:00Z
                AND CreatedBy.Profile.Name NOT IN ('Monster - Finance', 'Monster - Collections')
            ]);
        }else{
            return Database.getQueryLocator([
                SELECT Id
                FROM EmailMessage
                WHERE CreatedDate < 2024-04-01T00:00:00Z
                AND CreatedBy.Profile.Name NOT IN ('Monster - Finance', 'Monster - Collections') LIMIT 200
            ]);
        }
    }
    
    global void execute(Database.BatchableContext bc, List<EmailMessage> scope) {
        if (!scope.isEmpty()) {
            try {
                delete scope;
            } catch (DmlException e) {
                // Optionally log or handle individual failures
                System.debug('Delete failed: ' + e.getMessage());
            }
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        // Optional: send notification or log
        System.debug('DeleteOldEmailsBatch finished.');
    }
}