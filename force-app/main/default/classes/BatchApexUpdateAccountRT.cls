global class BatchApexUpdateAccountRT implements Database.Batchable<sObject>, Database.Stateful {
    
      Id ActiveRT = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Monster Active Account').getRecordTypeId();
      
    Id InActiveRT = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Monster In-Active Account').getRecordTypeId();
      
     global Database.QueryLocator start(Database.BatchableContext BC){
        
        String AccList = 'select id,SalesChannel__c,Segment__c,Posting_City_Address__c,ShippingCity,createddate,AccountStatus__c,RecordTypeId,Lead_Account_Status__c from Account';
      
         return Database.getQueryLocator(AccList);
        
    }
    
    global void execute(Database.BatchableContext BC, List<Account> acc){
        LIst <account> a1= new List<account>();
       
        for(account a : acc){
            a.Posting_City_Address__c = a.ShippingCity;
            
            if(a.Lead_Account_Status__c == NULL || a.AccountStatus__c == 'Candidate' || a.AccountStatus__c == 'Customer' || a.AccountStatus__c == 'Fraud' || a.AccountStatus__c == 'Lapsed Customer')
            { a.Lead_Account_Status__c = 'Active';}
            
            
            /*if(a.Lead_Account_Status__c == 'Active' && a.AccountStatus__c == NULL){
                a.AccountStatus__c = 'Candidate';
            }*/
            if(a.Lead_Account_Status__c == 'Inactive' || a.Lead_Account_Status__c == 'Rejected'){
                a.AccountStatus__c = 'Lead';
            }
            
            if(a.SalesChannel__c == 'Telesales') {a.Segment__c = 'Blank';}
            
            if(a.Lead_Account_Status__c == 'Active'){a.RecordTypeId = ActiveRT;}
            if(a.Lead_Account_Status__c == 'Inactive'){a.RecordTypeId = InActiveRT;}
            //if(a.RecordTypeId == NULL){a.RecordTypeId = ActiveRT;}
           
            a1.add(a);
            
        }
        
        update a1;
      
        
    }
    
    global void finish(Database.BatchableContext BC){
        
        
    }
    

}