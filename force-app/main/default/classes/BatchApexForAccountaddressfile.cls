global class BatchApexForAccountaddressfile implements Database.Batchable<sObject>, Database.Stateful{
  
    string header='Record ID'+'\n';
    string finalbody=header;
    
    
   global Database.QueryLocator start(Database.BatchableContext BC){

      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account Order by CreatedDate ASC';
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Account> scope){
      
    
  
       
        for(Account c:scope){
           integer i=0;
           
            if(c.ShippingAddress!=null){
                
               i++;
            }
            if(c.BillingAddress!=null){
               i++;
               
            }
            
            if(i!=0)
            {
            
             finalbody=finalbody+c.id+'\n';
            
            }
            
           
        }
       
      
    //
      /* for(Database.SaveResult j:srlist){
           if(j.isSuccess())
           {
               finalbody=finalbody+j.getId()+','+j.success+'\n';
               
               
           }
           
       }*/
       
       
      
   }

global void finish(Database.BatchableContext BC){
   Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
    blob csvBlob = Blob.valueOf(finalbody);
    string csvname= 'Account_update.csv';
    csvAttc.setFileName(csvname);
    csvAttc.setBody(csvBlob);
    
  
    
    Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
    String[] toAddresses = new list<string> {'crm@cloudexpertsindia.com'};
    String subject ='Account_address  CSV';
    email.setSubject(subject);
    email.setToAddresses( toAddresses );
    email.setPlainTextBody('Account CSV ');
    email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
   }
}