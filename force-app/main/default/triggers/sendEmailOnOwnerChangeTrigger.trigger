/*
Created By : Jay Gupta
Created Date : 4/11/23
Created For : Trigger Send Email to Task Owner.
*/

trigger sendEmailOnOwnerChangeTrigger on Task (after insert , after update) {
    list<Task> triggerlist = Trigger.New;
    if(Trigger.isInsert){
        selectUsers(triggerlist);
    }
    if(Trigger.isUpdate){
        list<Task> tasklist = new list<Task>();
        for(Integer i = 0 ; i < trigger.new.size() ; i++){
            if(trigger.new[i].Ownerid != trigger.old[i].Ownerid){
                tasklist.add(trigger.new[i]);
            }
        }
        selectUsers(tasklist);
    }
    
    
    public void selectUsers(list<Task> triggerlist){
        Set<Id> profileset = new Set<Id>();
        Set<Id> accountSet = new Set<Id>();
        List<Task> tasklist = new List<Task>();
        Map<Id,User> usermap = new Map<Id,User>();
        for(User user : [SELECT Id,Name,Email,Manager.Email FROM user WHERE Profile.Name = 'Monster - Tele Caller Support and Sales' OR Profile.Name = 'Monster - Sales' OR Profile.Name = 'Monster - Service/CR']){
            profileset.add(user.Id);
            usermap.put(user.Id,user);
        }
        list<Task> tasklistloop = triggerlist;
        for(Task task : tasklistloop){
            if(task.OwnerId != Userinfo.getUserId() && profileset.Contains(task.OwnerId) && task.WhatId.getSObjectType().getDescribe().getName() == 'Account'){
                accountSet.add(task.WhatId);
                tasklist.add(task);
            }
        }
        Map<Id, Account> accountMap = new Map<Id, Account>([Select Name,AccountId__c,SalesChannel__c,Top_1000__c,Account_Expiration_Date__c From Account Where Id IN : accountSet]);
        
        try{
            User currentUser = [Select Manager.Email,Email,Name From User Where id =: UserInfo.getUserId()];
            sendEmalOnOwnerChange sendemail = new sendEmalOnOwnerChange(accountMap,tasklist,usermap,currentUser);
        }
        catch(Exception e){}
        
    }
}