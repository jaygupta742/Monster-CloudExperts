global class heapcheck implements Database.Batchable<sObject>, Database.Stateful{
  
    
   global Database.QueryLocator start(Database.BatchableContext BC){

      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
                  map<id,string> mm=new map<id,string>();
            for(account a:[select id ,name from account limit 1000000])
            {
            
            mm.put(a.id,a.name);
            }
            
            system.debug('heap size used'+limits.getheapsize());      
        system.debug('heap size total'+limits.getlimitheapsize());      
      
      
      
      
      
      
       String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account Order by CreatedDate ASC limit 1';
      // list<account> acc=database.getquerylocator(query);
       
       
       
       
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
      
     
   }

global void finish(Database.BatchableContext BC){
   
}
}