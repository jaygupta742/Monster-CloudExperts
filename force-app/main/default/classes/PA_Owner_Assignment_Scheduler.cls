global class PA_Owner_Assignment_Scheduler implements Schedulable{
    global void execute(SchedulableContext SC) {
        List<PA_Owner_Assignment__c> PAOA = new List<PA_Owner_Assignment__c>();
        PAOA = [select id,Count__c from PA_Owner_Assignment__c];
        for(PA_Owner_Assignment__c SPA : PAOA){
            SPA.Count__c = 0;
        }
        Update PAOA;
   }
}