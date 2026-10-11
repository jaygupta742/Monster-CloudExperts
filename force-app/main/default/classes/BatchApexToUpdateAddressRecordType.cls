global class BatchApexToUpdateAddressRecordType implements Database.Batchable<sObject>, Database.Stateful {
    
      Id ActiveRT = '0127F000000mhAV';// Schema.SObjectType.Address1__c.getRecordTypeInfosByName().get('Address Layout - Active Account').getRecordTypeId();
      
    Id InActiveRT = '0127F000000mhAT';// Schema.SObjectType.Address1__c.getRecordTypeInfosByName().get('Address Layout- In Active Account').getRecordTypeId();
      
     global Database.QueryLocator start(Database.BatchableContext BC){
        
        String AccList = 'select RecordTypeId from Account';
      
         return Database.getQueryLocator(AccList);
        
    }
    
    global void execute(Database.BatchableContext BC, List<Account> acc){
        LIst <Account> a1= new List<Account>();
       
        for(Account a : acc){
           
            if(a.RecordTypeId == '0127F000000mhAV'){a.RecordTypeId = ActiveRT;}
            if(a.RecordTypeId == '0127F000000mhAT'){a.RecordTypeId = InActiveRT;}
            a1.add(a);
            
        }
        
        update a1;
      
        
    }
    
    global void finish(Database.BatchableContext BC){
        
        
    }
    

}