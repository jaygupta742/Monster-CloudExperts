global class BatchApexForAddress_delete implements Database.Batchable<sObject>, Database.Stateful{
  
    
   global Database.QueryLocator start(Database.BatchableContext BC){
   

       String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       //String query = 'select id,name,Account__c from Account where Account__c=null'; //To change Address from Object to Standard Address in Account
      return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
      
      /*  List<Account> sa=new List<Account>();
      
  
       
        for(Account c:scope){
            sa.add(c);
           }
           
           delete sa;
         */
           
   }

global void finish(Database.BatchableContext BC){
  
 
   }
}