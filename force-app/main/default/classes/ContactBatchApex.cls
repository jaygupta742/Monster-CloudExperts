global class ContactBatchApex implements Database.Batchable<sObject>, Database.stateful {
global final string Query;
global final String Field;
global final boolean Value;
global final string Que;

public Integer totalAmtOfRecords = 0; 
global Database.QueryLocator start(Database.BatchableContext BC) {
   
    string query = 'SELECT MobilePhone,Mobile_Customer_Requested_Do__c,WorkPhone_Customer_Requested_Do_Not_Call__c,WorkPhoneExtension__c,Phone,MobilePhone_Mobile_Do_Not_Call__c,Phone_Mobile_Do_Not_Call__c,MobilePhone_Mobile_Do_Not_Call_Registry__c,Phone_National_Do_Not_Call_Registry__c from Contact ';
    

return Database.getQueryLocator(query);
}

global void execute(Database.BatchableContext BC, List<Contact> scope) {
     totalAmtOfRecords += scope.size();
    map<String,TestObject1__c> too = new map<String,TestObject1__c>();
    
    for(TestObject1__c t:[Select id,name,Mobile__c,phone__c from TestObject1__c LIMIT 50000])
    {
        too.put(t.Mobile__c,t);
    }
    
    for(Contact b : scope){
    
    if(too.containskey(b.MobilePhone))
    {
       b.Mobile_Customer_Requested_Do__c = true;
        b.MobilePhone_Mobile_Do_Not_Call_Registry__c =true;
        //b.WorkPhone_Customer_Requested_Do_Not_Call__c = true;
    }
        else If(too.containskey(b.Phone)) {
            //b.WorkPhone_Customer_Requested_Do_Not_Call__c = true;
            b.Phone_Mobile_Do_Not_Call__c=true;
            b.MobilePhone_National_Do_Not_Call_Registr__c=true;
        }
        else if(too.containskey(b.WorkPhoneExtension__c)) {
             b.WorkPhone_Customer_Requested_Do_Not_Call__c = true;
            b.Phone_National_Do_Not_Call_Registry__c=true;	
        }
        else{
           b.Mobile_Customer_Requested_Do__c = false;
            b.WorkPhone_Customer_Requested_Do_Not_Call__c = false;
             b.Phone_National_Do_Not_Call_Registry__c=false;
            b.MobilePhone_National_Do_Not_Call_Registr__c=false;
             b.MobilePhone_Mobile_Do_Not_Call__c =false;
        }

}

update scope;
}
global void finish(Database.BatchableContext BC) {
      system.debug('Total amount of records processed :' + totalAmtOfRecords);
}


}