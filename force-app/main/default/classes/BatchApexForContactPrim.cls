public class BatchApexForContactPrim{

    public void met(){
        
        
    }
    
/*
global class BatchApexForContactPrim implements Database.Batchable<sObject>, Database.Stateful{
   
 public  string last_record;
  global  map<id,account> accmap = new map<id,account>();
     
    global Database.QueryLocator start(Database.BatchableContext BC){
      
      
        String query = 'SELECT id,name,Accountid__c,(SELECT id,Lastname,PrimarySalesContact__c FROM Contacts order by createddate Asc limit 100 ) FROM Account where Accountid__c> =:last_record AND Person_Account__c= False order by accountid__c asc limit 100000';
       
    
     
        return Database.getQueryLocator(query);
        
    }
    
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        List<Contact> Con = new List<Contact>();
        for(Account ac : scope){
           last_record= ac.AccountID__c;
          
              
            
               if(ac.contacts.size() == 1) {
               ac.contacts[0].PrimarySalesContact__c=true;
               
               Con.add(ac.contacts[0]);
            } 
            
             else if(ac.contacts.size() > 1){
             
                integer j=0;
                for(contact gg:ac.contacts){
                
                    if(gg.PrimarySalesContact__c== true){
                        j++;
                    }
                
                }
                
                if(j==0){
                 ac.contacts[0].PrimarySalesContact__c=true;
                Con.add(ac.contacts[0]);
                }
            
            
            }              
         }
        
       Database.Update(con) ; 
    }
    
    
    global void finish(Database.BatchableContext BC)
        {
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<string> {'support@cloudexpertsindia.com','crm@cloudexpertsindia.com'};
            String subject ='Contact Primary last record';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody(' Contact Primary last record '+last_record);
   
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }


}*/


}