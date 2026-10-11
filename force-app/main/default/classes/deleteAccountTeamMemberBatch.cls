global class deleteAccountTeamMemberBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator Start(Database.BatchableContext context){
        if(Test.isRunningTest()){
            return Database.getQueryLocator('Select Id From Account_Team_Member__c Where (AccountId__r.Person_Account__c = true AND CreatedDate < THIS_YEAR) OR UserId__r.isActive = false LIMIT 1');
        }else{
            return Database.getQueryLocator('Select Id From Account_Team_Member__c Where (AccountId__r.Person_Account__c = true AND CreatedDate < THIS_YEAR) OR UserId__r.isActive = false');
        }
    }
    
    global void execute(Database.BatchableContext context, List<Account_Team_Member__c> accountTeamMembers) {
        List<Account_Team_Member__c> failedToDeleteRecords = new List<Account_Team_Member__c>();
       
        Database.DeleteResult[] deleteResults = Database.delete(accountTeamMembers, false);
        
        for (Integer i = 0; i < deleteResults.size(); i++) {
            if (!deleteResults[i].isSuccess()) {
                failedToDeleteRecords.add(accountTeamMembers[i]);
                System.debug('Failed to delete record Id: ' + accountTeamMembers[i].Id + 
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