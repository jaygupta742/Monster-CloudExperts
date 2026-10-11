trigger Cannot_Delete_Acc_Team_Member on Account_Team_Member__c (before insert,before update,after insert,before delete,after update,after undelete) {
   /* for(Account_Team_Member__c atm : trigger.old){
            if(atm.UserId__c == atm.AccountOwnerID__c)
                atm.addError('You cannot delete this Team Member');
		} */
  	AccountTeamMemberTriggerHandler atm = new AccountTeamMemberTriggerHandler();
    /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        atm.OnBeforeInsert(Trigger.new);
    }
    /* After Insert */
    else if(Trigger.isInsert && Trigger.isAfter){
     atm.OnAfterInsert(trigger.new);

}
    
    /* Before Update */
    else if(Trigger.isUpdate && Trigger.isBefore){
        atm.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    /* After Update */
    else if(Trigger.isUpdate && Trigger.isAfter){
        atm.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    /* Before Delete */
    if(Trigger.isDelete && Trigger.isBefore){
           atm.onBeforeDelete(Trigger.old);  
            }
    /* After Delete */
  /*  else if(Trigger.isDelete && Trigger.isAfter){
        atm.OnAfterDelete(Trigger.old);
    }*/

    /* After Undelete */
    else if(Trigger.isUnDelete){
       // atm.OnUndelete(Trigger.new);
    }
    
}