global class BapexForPersonAccountRTUpdt implements Database.Batchable<sObject>{
   global String paAcc;
    global Database.QueryLocator start(Database.BatchableContext bc){
        paAcc='select id,name,Person_Account__c,RecordTypeid from Account where Person_Account__c=true AND Integration__c=false';
         return Database.getQueryLocator(paAcc);
  
    } 
    global void execute( Database.BatchableContext bc , List<Account>cc){
        id rtid=Schema.SObjectType.Account.getRecordTYpeInfosByName().get('Person Account').getRecordTYpeid();
        List<Account> ac= new List<Account>();
        for(Account pa:cc){
            pa.RecordTypeId=rtid;
           ac.add(pa); 
        }
        update ac;
    }
    
    global void finish (Database.BatchableContext bc){
        
    }
}