global class BatchApexForQuote_owner implements Database.Batchable<sObject>, Database.Stateful{
    map<id,id> standarduser=new map<id,id>();
    map<id,string> customuser=new map<id,string>();
    
   global Database.QueryLocator start(Database.BatchableContext BC){
    
    for(user u:[select id,N_ExternalID__c from user])
    {
    
        standarduser.put(u.N_ExternalID__c ,u.id);
        
    
    }
    
    for(User__c uu:[select id,First_Name__c,Name,N_ExternalID__c from User__c ])
    {
    string s=uu.First_Name__c+''+uu.name;
    customuser.put(uu.N_ExternalID__c ,uu.id);
    
    }
    
      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id,ownerid,Old_Owner__c,N_external_ownerid__c from apttus_proposal_proposal__c';
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<apttus_proposal_proposal__c> scope){
      
  list<apttus_proposal_proposal__c> tt=new list<apttus_proposal_proposal__c>();
       
     
                   for(apttus_proposal_proposal__c e:scope )
                   {
                   
                      if(standarduser.get(e.N_external_ownerid__c) !=null)
                      {
                      
                      
                      
                      e.Ownerid=standarduser.get(e.N_external_ownerid__c);
                      
                      }
                      else
                      {
                      
                      e.Old_Owner__c=customuser.get(e.N_external_ownerid__c);
                      
                      }
                                    
                   
                   
                   
                   tt.add(e);
                   }
     
           
           
          database.update(tt,false);
   }

global void finish(Database.BatchableContext BC){
  
  
}

}