// test class is UpdateTaskCount_test
trigger UpdateTaskCount on Task (after delete, after insert, after undelete, after update) {
    Set<ID> AccountIds = new Set<ID>();
    Set<ID> ContactIds = new Set<ID>();

    String AccountPrefix = Account.SObjectType.getDescribe().getKeyPrefix();
    String ContactPrefix = Contact.SObjectType.getDescribe().getKeyPrefix();


    if (Trigger.new != null) 
    {
        for (Task tn : Trigger.new) 
        {
             if (tn.whatId != null && string.valueOf(tn.whatId).startsWith(AccountPrefix) ) 
             {
                if(!AccountIds.contains(tn.WhatId))AccountIds.add(tn.whatId);
             }
             if (tn.whoId != null && string.valueOf(tn.whoId).startsWith(ContactPrefix) ) 
             {
                if(!ContactIds.contains(tn.whoId))ContactIds.add(tn.whoId);
             }
      }
   }

if (Trigger.old != null) {
    for (Task to : Trigger.old) {
     if (to.WhatId != null && String.valueOf(to.whatId).startsWith(AccountPrefix) )
            {
            if(!AccountIds.contains(to.WhatId))AccountIds.add(to.whatId);
            }
        if (to.whoId != null && string.valueOf(to.whoId).startsWith(ContactPrefix) ) 
             {
                if(!ContactIds.contains(to.whoId))ContactIds.add(to.whoId);
             }
      }
   }
  
     if (AccountIds.size() > 0){



List<Account> AccountWithTasks = [select id,Total_No_Of_Activities__c,(select id,Status from Tasks ) from Account where Id = :AccountIds];

List<Account> AccountUpdatable = new List<Account>();
System.debug('777777777777777777777'+AccountWithTasks);
if(AccountWithTasks[0].Tasks.size() >= 0)
{
    for(Account A : AccountWithTasks)
    {
       
     //   A.Total_No_Of_Activities__c = A.Tasks.size();
        
        integer count = 0;
        for(Task t : A.Tasks){
            if(t.Status != 'Completed')
            {count++;}
        }
        A.Total_No_Of_Activities__c = count;
     //  A.Total_Number_of_Closed_Activities__c = count;
        AccountUpdatable.add(A); 
    }
}
if(AccountUpdatable.size()>0)
{

    update AccountUpdatable;
    
}
}
    if (ContactIds.size() > 0){



List<Contact> ContactWithTasks = [select id,Total_No_Of_Activities__c,(select id,Status from Tasks ) from Contact where Id = :ContactIds];

List<Contact> ContactUpdatable = new List<Contact>();
System.debug('777777777777777777777'+ContactWithTasks);
if(ContactWithTasks[0].Tasks.size() >= 0)
{
    for(Contact C : ContactWithTasks)
    {
       
      //  C.Total_No_Of_Activities__c = C.Tasks.size();
        
        integer count = 0;
        for(Task t : C.Tasks){
            if(t.Status != 'Completed')
            {count++;}
        }
        
        C.Total_No_Of_Activities__c =count;
       // C.Total_Number_of_Closed_Activities__c = count; 
        ContactUpdatable.add(C);
    }
}
if(ContactUpdatable.size()>0)
{

    update ContactUpdatable;
 
}
}
}