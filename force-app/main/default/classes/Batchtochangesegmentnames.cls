global class Batchtochangesegmentnames implements Database.Batchable<sObject>, Database.Stateful{

     
    global Database.QueryLocator start(Database.BatchableContext BC){
      
      
        String query = 'SELECT id,Accountid__c,ownerid,Segment__c FROM Account where Person_Account__c= False AND (Segment__c = \'SMB Business\' or Segment__c = \'Enterprise Business\') order by accountid__c asc';
       
        return Database.getQueryLocator(query);
        
    }
    
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        List<Account> lacc = new List<Account>();
        for(Account a : scope){
            if(a.Segment__c == 'SMB Business'){
                a.Segment__c = 'Small & Medium Business';
                lacc.add(a);
            }
            else if(a.Segment__c == 'Enterprise Business'){
                a.Segment__c = 'Enterprise';
                lacc.add(a);
            }
            
        }
        Database.update(lacc,false);
    }
        
    global void finish(Database.BatchableContext BC)
        {
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<string> {'support@cloudexpertsindia.com','crm@cloudexpertsindia.com'};
            String subject ='completed';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody(' completed ');
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
}