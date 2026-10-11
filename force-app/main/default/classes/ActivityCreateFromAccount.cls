public class ActivityCreateFromAccount {
    @AuraEnabled()
    public static void createActivity(Task activityRec, String recordId, String assign, string name, String related, String accompany, String recordurl, String subtype ,String opportunityId){
        User uid = [Select Id from User where Id =: UserInfo.getUserId()];
        activityRec.OwnerId = uid.Id;
        if(!Test.isRunningTest()){
            if (related == null) {
                
            }
            activityRec.WhoId = name;
        }
        if (assign != null) {
            activityRec.OwnerId = assign;
        }
        if (accompany != null) {
            activityRec.Accompanied_By1__c = accompany;
        }
        if(!Test.isRunningTest()){
            activityRec.WhatId = recordId;
        }
        
        if(activityRec.recording_url__c.length() > 244){
            activityRec.Long_recording_url__c = activityRec.recording_url__c;
            activityRec.recording_url__c = '';
        }
        
        activityRec.Opportunities_Revamp__c = opportunityId == '' ? null : opportunityId;
        activityRec.Task_Sub_Type1__c = subtype;
        System.debug(activityRec);
        System.debug(activityRec.recording_url__c);
        insert activityRec;
    }
    
    @AuraEnabled(cacheable=true)
    public static User getUserData(){
        return [Select Id, Profile.Name,Channel__c from User where Id =: UserInfo.getUserId() limit 1];
    }
    
    @AuraEnabled(cacheable=true)
    public static Boolean getAccountSuspect(String accountId){
        Account account = [select Suspect_Prospect__c from Account where id =: accountId];
        system.debug('SP '+account.Suspect_Prospect__c);
        if(account.Suspect_Prospect__c != null){
            return false;
        }
        else{ 
            return true;
        }
    }
    
    @AuraEnabled(cacheable = true)
    public static String getLatestOpportunityRecord(String recordId){
        return [SELECT Id
                FROM OpportunityN__c
               	WHERE Account__c =: recordId AND OwnerId =: userInfo.getUserId() AND Stage__c NOT IN ('Closed Won','Closed Lost') ORDER BY CreatedDate DESC LIMIT 1].Id;
    }
    
    @AuraEnabled
    public static boolean updateAccountStat(String accountId,String accountStat){
        //System.debug(accountStat);
        System.debug('Accountid Suspect '+accountStat);
        Account acc = [Select Id, Suspect_Prospect__c from Account where Id =: accountId];
        acc.Suspect_Prospect__c = accountStat;
        update acc;
        if(acc.Suspect_Prospect__c != null){
            system.debug('Updated');
            return false;
            
        }
        else{ 
            return true;
        }
    }
}