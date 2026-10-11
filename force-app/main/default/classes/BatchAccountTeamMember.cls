/*Created By : Abdul Aziz 
Created Date : 6-apr-2023
Description : Batch Class to update Account Team Member's Status to Inactive if user is deactivated
Dependency : BatchAccountTeamMemberScheduler
Test Class Name : BatchAccountTeamMemberTest
*/

global class BatchAccountTeamMember implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Status__c,UserId__c,UserId__r.IsActive FROM Account_Team_Member__c where UserId__r.IsActive=false';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Account_Team_Member__c> accTeamMember) {
        for(Account_Team_Member__c acc : accTeamMember) {        
            acc.Status__c ='Inactive';
        }
        try {
            update accTeamMember;
            
        } catch(Exception e) {
            System.debug(e);
        }  
    }   
    global void finish(Database.BatchableContext BC) {
        System.debug('BatchApexAccountTeamMember Executed Successfully!!!');
    }
}