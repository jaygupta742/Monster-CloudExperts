/*Created By : Abdul Aziz
Created Date : 15/05/2023
Description : Task trigger to rollup created date of task for an account 
*/
trigger TaskTrigger on Task (after insert) {
    Set<id> setofAccid=new  Set<id>();
    Set<id> setofActivityid=new  Set<id>();
    String AccountPrefix = Account.SObjectType.getDescribe().getKeyPrefix();
    if(Trigger.isAfter && Trigger.isInsert) {
        for(Task t : Trigger.new)
        {
            if(t.whatId != null && string.valueOf(t.whatId).startsWith(AccountPrefix) ){
                setofAccid.add(t.WhatId);
                setofActivityid.add(t.Id);
            }
        } 
    }
    List<Account> listofAcc=[select id,Last_Activity_Created_Date__c from Account where id in:setofAccid];
    List<Task> tasklist=[select id,whatId,CreatedDate from task where id in:setofActivityid];
    for(Task t : tasklist){
        for(Account acc : listofAcc){
            if(acc.Id==t.WhatId){
                acc.Last_Activity_Created_Date__c=t.CreatedDate.date();
                acc.Last_Activity_Created_DateTime__c = t.CreatedDate;
            }
        }
    }
    try{
        // update listofAcc;
        Database.update(listofAcc,false);
    }
    catch(Exception e){
        System.debug(' e.getMessage() is '+e.getMessage());
    }
    
}