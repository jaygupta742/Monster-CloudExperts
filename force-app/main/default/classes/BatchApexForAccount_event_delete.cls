global class BatchApexForAccount_event_delete implements Database.Batchable<sObject>, Database.Stateful{
   
   global Database.QueryLocator start(Database.BatchableContext BC){
    
  
    
      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id from Events__c';
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Events__c> scope){
      
      delete scope;
   }

global void finish(Database.BatchableContext BC){
  
  
}

}