public class sendMailtoExecutives {
    
    public sendMailtoExecutives(String evtId, String previousOwnerId){
        Event eventSalesRep = [Select Id,OwnerId,Subject,EndDateTime,StartDateTime,Feedback__c,Level_for_Escalation__c,Manager__c,WhatId,
                               CreatedDate,Created_Date__c,Created_Time__c,WhoId from Event where Id=:evtId Limit 1];
        User salesUser = new User();
        User previousUser = new User();
        User managerUser = new user();
        Account acc = new Account();
        acc = [Select Id,Name,AccountID__c,OwnerId,CreatedDate from Account Where Id=:eventSalesRep.WhatId];
        String mailHtmlBody;
        Integer cDay = eventSalesRep.CreatedDate.DAY();
        Integer cMonth = eventSalesRep.CreatedDate.MONTH();
        Integer cYear = eventSalesRep.CreatedDate.YEAR();
        Integer cHour  = eventSalesRep.CreatedDate.HOUR();
        Integer cMinute = eventSalesRep.CreatedDate.MINUTE();
        Integer cSecond = eventSalesRep.CreatedDate.SECOND();
        salesUser = [Select Id,Name,Email,ManagerId from User where Id=:eventSalesRep.OwnerId];
        previousUser = [Select Id,Name,Email from User where Id=:previousOwnerId];
        managerUser = [Select Id,Name from User where Id=:salesUser.ManagerId];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        system.debug('salesUser.Email : '+salesUser.Email);
        string [] toaddress= New string[]{salesUser.Email};
        mail.setToAddresses(toaddress);
        mail.setSubject('Event : '+eventSalesRep.Subject+' has been assigned to you by '+previousUser.Name+' for Account '+acc.Name+' ('+acc.AccountID__c+')');
        mailHtmlBody = '<b>Hi  </b> &nbsp;'+'<b>'+ salesUser.Name +'</b>,<br/><br/>'
            +'The details for the event is given below <br/><br/>'
            +'An event has been assigned to you for Account '+acc.Name+' ('+acc.AccountID__c+')<br/>'
            +'<b>Event : </b>'+eventSalesRep.Subject+'<br/>'
            +'<b>Related To : </b>'+acc.Name+' ('+acc.AccountID__c+')<br/>'
            +'<b>Created Date : </b>'+cDay+'/'+cMonth+'/'+cYear+'-'+cHour+':'+cMinute+':'+cSecond+'<br/>';
        mail.setHtmlBody(mailHtmlBody);
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'inboundleads@monsterindia.com'];
        if (owea.size()>0){
  				  mail.setOrgWideEmailAddressId(owea.get(0).Id);
			}
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        eventSalesRep.Schedule_Job_Id__c=managerUser.Name;
        eventSalesRep.Manager__c=managerUser.Id;
        eventSalesRep.CC_Mail__c=salesUser.Email;
        update eventSalesRep;
    }
    

}