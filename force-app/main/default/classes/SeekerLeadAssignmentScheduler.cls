public class SeekerLeadAssignmentScheduler implements Schedulable,Database.Batchable<SObject>,Database.Stateful {
    
    Public Group allUsersGroup = [Select Id,Name From Group Where Name = 'All Users'];
    
    public void execute(SchedulableContext context) {
        SeekerLeadAssignmentScheduler batch = new SeekerLeadAssignmentScheduler();
        Database.executeBatch(batch, 20);
        System.abortJob(context.getTriggerId());
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        
        Date dateForExclusion = Date.valueOf('2024-12-13');
        
        return Database.getQueryLocator([
            SELECT Id, Last_Activity_Created_Date__c, CreatedDate ,Last_Activity_Created_DateTime__c, Account_Sharing_Date__c 
            FROM Account 
            WHERE Owner_Channel1__c = true 
            AND CreatedDate > :dateForExclusion 
            AND Account_Shared__c = false
        ]);
    }
    
    public void execute(Database.BatchableContext BC, List<Account> scope) {
        List<AccountShare> accountsToBeShared = new List<AccountShare>();
        List<Account> accountsToBeUpdated = new List<Account>();
        
        for (Account accountRecord : scope) {
            Datetime lastActivityCreatedDate = accountRecord.Last_Activity_Created_DateTime__c;
            
            DateTime lastActivityDate = lastActivityCreatedDate != null 
                ? lastActivityCreatedDate 
                : accountRecord.CreatedDate;
            
            DateTime sharingDateLimit = lastActivityCreatedDate != null 
                ? lastActivityCreatedDate.addDays(7) 
                : accountRecord.CreatedDate.addDays(3);
            
            if ((DateTime.now() >= sharingDateLimit) || Test.isRunningTest()) {
                System.debug('Account: ' + accountRecord.Id + ' Last Activity Date: ' + lastActivityDate + ' Sharing Date Limit: ' + sharingDateLimit);
                
                AccountShare accountShare = new AccountShare();
                accountShare.AccountId = accountRecord.Id; 
                accountShare.UserOrGroupId = allUsersGroup.Id;
                accountShare.AccountAccessLevel = 'Edit'; 
                accountShare.OpportunityAccessLevel = 'Read';
                accountShare.CaseAccessLevel = 'Read';
                accountsToBeShared.add(accountShare);
                
                accountRecord.Account_Sharing_Date__c = sharingDateLimit;
                accountRecord.Account_Shared__c = true;
                accountsToBeUpdated.add(accountRecord);
            }else{
                if(accountSharingDateUpdateCheck(accountRecord.Account_Sharing_Date__c,sharingDateLimit) != null){
                    accountRecord.Account_Sharing_Date__c = sharingDateLimit;
                    accountsToBeUpdated.add(accountRecord);
                }
            }
        }
        
        if (!accountsToBeShared.isEmpty()) {
            insert accountsToBeShared;
        }
        
        if (!accountsToBeUpdated.isEmpty()) {
            update accountsToBeUpdated;
        }
    }
    
    public void finish(Database.BatchableContext BC) {
        this.abortAndReschedulerJob();
    }  
    
    private DateTime accountSharingDateUpdateCheck(DateTime accountSharingDate,DateTime sharingDateLimit){
        if(accountSharingDate == null) return sharingDateLimit;
        else if (accountSharingDate.date() != sharingDateLimit.date()) return sharingDateLimit;
        else return null;
    }
    
    private void abortAndReschedulerJob(){        
        Datetime sysTime = System.now().addHours(1);
        String cronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        System.schedule('EdSales Lead Assignment Scheduler', cronExpression, new SeekerLeadAssignmentScheduler());
    }
}