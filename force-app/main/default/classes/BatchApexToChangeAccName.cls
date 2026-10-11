global class BatchApexToChangeAccName implements Database.Batchable<sObject>, Database.Stateful{
   
 public  string last_record;
  global  map<id,account> accmap = new map<id,account>();
     
    global Database.QueryLocator start(Database.BatchableContext BC){
      String query ;
       if(!Test.isRunningTest())
         query = 'Select id,AccountID__c,(SELECT CreatedDate,NewValue,OldValue,Field FROM Histories  WHERE CreatedDate >2018-09-22T00:00:00Z  Order by CreatedDate ASC limit 100) from Account where Accountid__c> =\'A-09097198\' AND Accountid__c< =\'A-11743811\' AND Person_Account__c= False and LastModifiedDate > 2018-09-22T00:00:00Z AND LastModifiedDate != Today order by Accountid__c asc  limit 100000';
        else 
         query = 'Select id,AccountID__c,(SELECT CreatedDate,NewValue,OldValue,Field FROM Histories  WHERE CreatedDate >2018-09-22T00:00:00Z  Order by CreatedDate ASC limit 100) from Account where Person_Account__c= False and LastModifiedDate > 2018-09-22T00:00:00Z order by Accountid__c asc  limit 100000';    
       
    
     
        return Database.getQueryLocator(query);
        
    }
    
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        List<Account> Accc = new List<Account>();
        for(Account ac : scope){
            Boolean AccName = true;
            Boolean Accphone = true;
           last_record= ac.AccountID__c;
            for(AccountHistory ah : ac.histories){
                if(ah.field == 'TextName' && AccName){
                    System.debug('Old Value Name: '+ah.OldValue);
                    ac.Name = String.valueof(ah.OldValue);
                    System.debug('Old Value Name string: '+String.valueof(ah.OldValue));
                    AccName =false;
                }
                if(ah.field == 'Phone' && Accphone){
                    System.debug('Old Value Phone: '+ah.OldValue);
                    ac.Phone = String.valueof(ah.OldValue);
                    System.debug('Old Value Phone string: '+String.valueof(ah.OldValue));
                    Accphone =false;
                }
            }
            Accc.add(ac);
         }
        
       Database.Update(Accc) ; 
    }
    
    
    global void finish(Database.BatchableContext BC)
        {
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<string> {'support@cloudexpertsindia.com','crm@cloudexpertsindia.com'};
            String subject ='Account Name last record';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody(' Account Name last record '+last_record);
   
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }


}