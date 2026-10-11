/*
Last update by : Abdul Aziz
Last Update Date : 15-05-2023
*/

trigger UpdateCompetitor on competitivelandscape__c (after insert) {
    /* Account a = new Account();
for(competitivelandscape__c cl : Trigger.new){ 
if(cl.Account__c!=null){
a = [select id,name from Account where id=:cl.Account__c];
System.debug('Account Record to be updated by creation of Account');
a.Competitor__c = cl.Competitor__c;
System.debug('Competitors value in Competitor----->'+cl.Competitor__c);
System.debug('Competitors value in Account----->'+a.Competitor__c);
}
}     
update a;*/
    
    /*Update last created date of Competitor in related account*/
    Set<id> setofAccid=new  Set<id>();
    Set<id> setofCmpid=new  Set<id>();
    if(Trigger.isAfter && Trigger.isInsert) {
        /*Send Notification to account owner*/
        UpdateCompetitorHelper.SendNotification(Trigger.new);
        /****************************/
        
        for(competitivelandscape__c cl : Trigger.new){
            
            setofAccid.add(cl.Account__c);
            setofCmpid.add(cl.Id);
        }   
    }
    List<Account> listofAcc=[select id,Competitor__c,Last_Competitor_Created_Date__c,Last_Activity_Created_Date__c from Account where id in:setofAccid];
    List<competitivelandscape__c> listofCmp=[select id,Account__c,Competitor__c,CreatedDate from competitivelandscape__c where id in:setofCmpid];
    for(competitivelandscape__c cmp : listofCmp){
        for(Account acc : listofAcc){
            if(cmp.Account__c==acc.Id)
            {
                acc.Last_Competitor_Created_Date__c  =cmp.CreatedDate.date();
                acc.Last_Activity_Created_Date__c=null;
                acc.Competitor__c=cmp.Competitor__c;
            }
            
        }  
    }
    
    try{
        //update listofAcc;
        Database.update(listofAcc,false);
    }
    catch(Exception e){
        System.debug(' e.getMessage() is '+e.getMessage());
    }
}