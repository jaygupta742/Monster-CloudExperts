global class BatchApexForAccount_autonumber_update implements Database.Batchable<sObject>, Database.Stateful{
   
    public integer start_number;
   global Database.QueryLocator start(Database.BatchableContext BC){

      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id,name from Account where  createddate=this_month  Order by CreatedDate ASC';
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
      
      
        LIst <Account> a1= new List<Account>();
         
  
       
    /*    for(Account c:scope){
           
         start_number++;
          c.AccountID__c='A-'+start_number;
           
        }*/
       
      update scope;
      
   
   }

global void finish(Database.BatchableContext BC){
 
   }
}