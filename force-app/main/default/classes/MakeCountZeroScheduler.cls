/*This scheduler Class will make count equal to zero for each record of custom setting PA Owner Assignment 
EveryDay at 08:00 AM Morinig*/
global class MakeCountZeroScheduler Implements Schedulable {
    global void execute(SchedulableContext sc) {
        makeCountZero();
    }
    
    public void makeCountZero() {
        List<PA_Owner_Assignment__c> pa=[select id,name,Count__c from PA_Owner_Assignment__c];
        for(PA_Owner_Assignment__c o:pa){
            o.Count__c=0;
        }
        update pa;  
    }
}