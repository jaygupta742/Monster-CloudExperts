global class BatchApexDeletePersonAccount implements Database.Batchable<sObject>, Database.Stateful{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        String AccList = 'select id,createddate from Account WHERE Person_Account__c = TRUE AND CALENDAR_YEAR(CreatedDate) < 2015';
     // String AccList = 'select id,createddate from Account';
      
         return Database.getQueryLocator(AccList);
        
    }
    
    global void execute(Database.BatchableContext BC, List<Account> acc){
        
        delete acc;
    }
    
    global void finish(Database.BatchableContext BC){
        
        
    }
    
    

}