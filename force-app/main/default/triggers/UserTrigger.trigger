//Created By : Abdul Aziz , Created Date : 15/04/2023 , Description : Update Last Deactived Date , Whenever we deactivate the user
trigger UserTrigger on User (before update) {
    for(User u : Trigger.new){
        User oldUser = Trigger.oldMap.get(u.Id);
        if(!u.IsActive && oldUser.IsActive){
            u.Last_Disabled_Date__c = Date.today();
        }
    }
}