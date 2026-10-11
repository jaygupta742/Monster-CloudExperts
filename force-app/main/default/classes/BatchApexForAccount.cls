global class BatchApexForAccount implements Database.Batchable<sObject>, Database.Stateful{

    Id rt = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Monster Active Account').getRecordTypeId();
  public  string last_record;
     string header1='Record ID'+','+'error'+'\n';
    string finalbody1=header1;
    
     global list<Database.SaveResult> srlist1;
    
   global Database.QueryLocator start(Database.BatchableContext BC){

      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id,Posting_City_Address__c,RecordTypeId,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where Person_Account__c = true';
        /*Accountid__c, write in query  where Accountid__C> =:last_record order by Accountid__C asc */ 
       
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
      
        //List<Address1__c> sa=new List<Address1__c>();
        LIst <Account> a1= new List<Account>();
         
  
       
        for(Account c:scope){
        //  last_record=c.Accountid__c;
           /*if(c.Addresses1__r.size()==0)
           {*/
           /* if(c.ShippingCity!=null||c.ShippingState!=null||c.ShippingStreet!=null||c.ShippingPostalCode!=null||c.ShippingCountry!=null){
                Address1__c ad= new Address1__c();
                ad.Account__c=c.id;
                if(c.ShippingCity!=null)
                        {ad.City__c=c.ShippingCity;}
                if(c.ShippingState!=null)
                         {ad.State__c=c.ShippingState;}
               if(c.ShippingStreet!=null)
                         {ad.Address1__c=c.ShippingStreet;}
                if(c.ShippingPostalCode!=null)
                          {ad.PinCode__c=c.ShippingPostalCode;}
                
                ad.Type__c='Posting Address';
                
                if(c.ShippingCountry!=null)
                           {ad.Country__c=c.ShippingCountry;}
                           
                           
                ad.OwnerId=c.OwnerId;
                ad.CreatedById=c.CreatedById;
                ad.LastModifiedById=c.LastModifiedById;
                ad.CreatedDate=c.CreatedDate;
                sa.add(ad);
            }*/
           /* if(c.BillingCity!=null||c.BillingState!=null||c.BillingStreet!=null||c.BillingPostalCode!=null||c.BillingCountry!=null){
                Address1__c ad1= new Address1__c();
                ad1.Account__c=c.id;
                if(c.BillingCity!=null)
                        {ad1.City__c=c.BillingCity;}
                if(c.BillingState!=null)
                        {ad1.State__c=c.BillingState;}
                if(c.BillingStreet!=null)
                        {ad1.Address1__c=c.BillingStreet;}
                if(c.BillingPostalCode!=null)
                        {ad1.PinCode__c=c.BillingPostalCode;}
                        
                ad1.Type__c='Billing';
                
                if(c.BillingCountry!=null)
                        {ad1.Country__c=c.BillingCountry;}
                        
                        
                ad1.OwnerId=c.OwnerId;
                ad1.CreatedById=c.CreatedById;
                ad1.LastModifiedById=c.LastModifiedById;
                ad1.CreatedDate=c.CreatedDate;
                sa.add(ad1);
            }*/
           //}
           // c.Posting_City_Address__c=c.ShippingCity;
            /*if(c.Lead_Account_Status__c=='Active'&& c.RecordTypeId!=rt)
            {   
                c.RecordTypeId=rt;
               
            }*/
            //a1.add(c);
           
      //  }
       
      
      //update a1;
     // srlist1=database.insert(sa,false);
      //insert sa;
    
   }
   }
  global void finish(Database.BatchableContext BC){
    
    Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
    String[] toAddresses = new list<string> {'support@cloudexpertsindia.com'};
    String subject ='Account_auto_create_address  CSV';
    email.setSubject(subject);
    email.setToAddresses( toAddresses );
    email.setPlainTextBody('Account CSV '+last_record);
   
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
   } 
}