global class UserAccountCountScheduler implements Schedulable{
    global void execute(SchedulableContext SC) {
        List<User> uu = new List<User>();
        uu = [select id,name,Account_Count__c,Profile_Name__c from User where Profile_Name__c='Monster - B2C'];
        for(User u : uu){
            u.Account_Count__c = 0;
        }
        Update uu;
   }
}