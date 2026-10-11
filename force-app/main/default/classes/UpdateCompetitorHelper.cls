/*
Created By : Abdul Aziz
Created Date : 16/05/2023
Used in trigger : UpdateCompetitor
*/

public class UpdateCompetitorHelper {
    public static void SendNotification(List<competitivelandscape__c> OppList){ 
        set<id> setofcmpid=new  set<id>();
        for(competitivelandscape__c cmp: OppList){
            setofcmpid.add(cmp.id);
        }
        
        List<competitivelandscape__c> listofCmp=[select id,name,Account__c,Competitor__c,TotalJobs__c,
                                                 Account__r.name,Account__r.ownerid,Account__r.owner.firstname,
                                                 Account__r.owner.lastname,Account__r.owner.IsActive
                                                 from competitivelandscape__c where id in:setofcmpid and Account__r.owner.IsActive=true];
        
        CustomNotificationType CompititorNotification = [SELECT Id, DeveloperName  FROM CustomNotificationType    
                                                         WHERE DeveloperName='CompititorNotification'  LIMIT 1]; 
        
        for(competitivelandscape__c opp : listofCmp){ 
            String body = 'Hi ' +opp.Account__r.owner.firstname+' '+opp.Account__r.owner.lastname; 
            body+=', Competitor- '+opp.Competitor__c+' Total job -'+' '+opp.TotalJobs__c;
            body+=' is added on account '+opp.Account__r.name;
            //  body+=' Thank you.';
            Messaging.CustomNotification Notification = new Messaging.CustomNotification(); 
            Notification.setNotificationTypeId(CompititorNotification.id); 
            Notification.setSenderId(Userinfo.getUserId()); 
            Notification.setBody(body); 
            Notification.setTitle('New Competitor Added !!!'); 
            Notification.setTargetId(opp.Id); 
            Notification.send(new Set<String> {opp.Account__r.ownerid}); 
        } 
    } 
    
}