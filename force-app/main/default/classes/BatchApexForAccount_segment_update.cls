global class BatchApexForAccount_segment_update implements Database.Batchable<sObject>, Database.Stateful{
   
    
   global Database.QueryLocator start(Database.BatchableContext BC){

      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id,name,Segment__c from Account where Segment__c=\'Corporate\' OR Segment__c=\'Staffing\' OR Segment__c=\'New Market\'  Order by CreatedDate ASC';
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
      
      
        LIst <Account> a1= new List<Account>();
         
  
       
        for(Account c:scope){
           
         
          c.Segment__c='Small & Medium Business';
           
        }
       
      update scope;
      
   
   }

global void finish(Database.BatchableContext BC){
 
   }
}