global class deletePersonAccountBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator Start(Database.BatchableContext context){
        if(Test.isRunningTest()){
            return Database.getQueryLocator('SELECT Id From Account WHERE Id NOT IN (SELECT Account__c FROM Seeker_Order__c) AND Id NOT IN (SELECT Account__c FROM OpportunityN__c) AND Person_Account__c = true AND CreatedDate < 2023-11-01T00:00:00Z LIMIT 1');
        }else{
            return Database.getQueryLocator('SELECT Id FROM Account WHERE Person_Account__c = true AND Id NOT IN (SELECT Account__c FROM Seeker_Order__c) AND Id NOT IN (SELECT Account__c FROM OpportunityN__c) AND CreatedDate < 2023-10-01T00:00:00Z AND (Expirence_In_Numbers__c < 8 OR Expirence_In_Numbers__c = null) AND (Last_Activity_Created_Date__c < 2024-11-01 OR Last_Activity_Created_Date__c = null)');
        }
    }
    
    global void execute(Database.BatchableContext context, List<Account> personAccounts) {
        List<Account> failedToDeleteRecords = new List<Account>();
       
        Database.DeleteResult[] deleteResults = Database.delete(personAccounts, false);
        
        for (Integer i = 0; i < deleteResults.size(); i++) {
            if (!deleteResults[i].isSuccess()) {
                failedToDeleteRecords.add(personAccounts[i]);
                System.debug('Failed to delete record Id: ' + personAccounts[i].Id + 
                             ' - Error: ' + deleteResults[i].getErrors()[0].getMessage());
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