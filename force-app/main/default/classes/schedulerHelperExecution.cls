public class schedulerHelperExecution {
    
    public Set<Id> evtIds;
    public List<Event> evtList;
    Public Account acc;
    
    public schedulerHelperExecution(String evtId){
        system.debug('Another Scheduler Helper:');
        evtList = new List<Event>();
        evtIds = new Set<Id>();
        evtIds.add(evtId);
        acc = new Account();
        String managerMail;
        User utt = new User();
         
        evtList = [Select Id,OwnerId,Feedback__c,Feedback_By_Sales__c,Subject,Level_for_Escalation__c,Manager__c,CC_Mail__c,WhatId,CreatedDate,WhoId from Event where Id=:evtIds Limit 1];
        system.debug('evtList new helper: '+evtList);
        
        User usrManager = new User();
        if(evtList[0].Manager__c!=null){
            usrManager = [Select Id,Name,Email,ManagerId from User where Id=:evtList[0].Manager__c];
            managerMail = usrManager.Email;
        }
        else if(evtList[0].Manager__c==null){
            usrManager = [Select Id,Name,Email,ManagerId from User where Id=:evtList[0].OwnerId];
            utt = [Select Id,Name,Email from user where Id=:usrManager.ManagerId];
            managerMail = utt.Email;
        }
        acc = [Select Id,Name,AccountID__c,OwnerId,CreatedDate from Account Where Id=:evtList[0].WhatId];
        if(evtList[0].Feedback__c==null&&evtList[0].Feedback_By_Sales__c==null){
            updateSendMail(acc,evtList[0],usrManager,managerMail);
        }
        
    }
    
    public void updateSendMail(Account act, Event evt,User managUsr,String managerMailId){
        system.debug('act : '+act);
        system.debug('evt : '+evt);
        system.debug('managUsr : '+managUsr);
        
        User u = [Select id,Name from User where Id=:evt.OwnerId];
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'inboundleads@monsterindia.com'];

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        if ( owea.size() > 0 ) {
  				  mail.setOrgWideEmailAddressId(owea.get(0).Id);
			}
        system.debug('managerMailId : '+managerMailId);
        string [] toaddress= New string[]{managerMailId};  // Remove this and put managerMailId
            string [] ccmail;
            if(evt.CC_Mail__c.contains(',')){
                ccmail = evt.CC_Mail__c.split(',');
            }
        else{
            ccmail = new String[]{evt.CC_Mail__c};
        } 
        
        mail.setToAddresses(toaddress);
        mail.setCcAddresses(ccmail);
        Integer cDay = evt.CreatedDate.DAY();
        Integer cMonth = evt.CreatedDate.MONTH();
        Integer cYear = evt.CreatedDate.YEAR();
        
        Integer cHour  = evt.CreatedDate.HOUR();
        Integer cMinute = evt.CreatedDate.MINUTE();
        Integer cSecond = evt.CreatedDate.SECOND();
        
        String sub ='Inbound/RP';
        if(evt.Subject.startsWithIgnoreCase('Recruiter Profile')){
            sub = 'RP';
        }
        else{
            sub = 'Inbound';
        }
        
        mail.setSubject('NO FEEDBACK UPDATED – '+sub+' '+act.Name+' - '+act.AccountID__c+' - '+u.Name+' - '+cDay+'/'+cMonth+'/'+cYear+'-'+cHour+':'+cMinute+':'+cSecond);
        
        string msgBody = 'The event assigned to '+u.Name+' is not Completed!!!\n';
        mail.setPlainTextBody(msgBody);
        
           
     
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        
        List<Email__c> emailListOld = [Select Id,Name,Event_Id__c,Latest__c,Level_for_Escalation__c from Email__c where Event_Id__c=:evt.Id];
        if(emailListOld.size()>0){
            
            for(Email__c ee : emailListOld){
                if(ee.Level_for_Escalation__c!='Level 4'){
                    ee.Latest__c=false;
                }
            }
           update emailListOld; 
        }
        
        triggerHandlerEscalation.isUpdateTrigger=true;
        Event eet = new Event();
        eet.Id=evt.Id;
        eet.Manager__c=managUsr.ManagerId;
        eet.CC_Mail__c=evt.CC_Mail__c+','+managerMailId;
        
        If(evt.Level_for_Escalation__c==null){
            if(managUsr.ManagerId!=null){
             user uu = [select Id,Name,Email from user where Id=:managUsr.ManagerId];
             eet.Schedule_Job_Id__c=uu.Name;
            }
            eet.Level_for_Escalation__c='Level 1'; 
        }
        If(evt.Level_for_Escalation__c=='Level 1'){
            if(managUsr.ManagerId!=null){
            user uu = [select Id,Name,Email from user where Id=:managUsr.ManagerId];
            eet.Schedule_Job_Id__c=uu.Name;
            }
            eet.Level_for_Escalation__c='Level 2';
            
        }
        If(evt.Level_for_Escalation__c=='Level 2'){
            if(managUsr.ManagerId!=null){
            user uu = [select Id,Name,Email from user where Id=:managUsr.ManagerId];
            eet.Schedule_Job_Id__c=uu.Name;
            }
            eet.Level_for_Escalation__c='Level 3';
        }
        If(evt.Level_for_Escalation__c=='Level 3'){
            eet.Level_for_Escalation__c='Level 4';
        } 
        update eet;
        system.debug('eet.OwnerId : '+eet.OwnerId);
        Email__c emailRecord = new Email__c();
        emailRecord.Escalation_Mail__c = true;
        emailRecord.Latest__c = true;
        emailRecord.Event_Id__c=evt.Id;
        emailRecord.Subject__c = 'NO FEEDBACK UPDATED – '+sub+' '+act.Name+' - '+act.AccountID__c+' - '+u.Name+' - '+cDay+'/'+cMonth+'/'+cYear+'-'+cHour+':'+cMinute+':'+cSecond;
        emailRecord.Body__c='The event assigned to '+u.Name+' is not Completed!!!';
        emailRecord.Account__c=acc.Id;
        emailRecord.Level_for_Escalation__c=eet.Level_for_Escalation__c;
        emailRecord.Event__c=evt.Subject;
        emailRecord.Email_Address__c=managerMailId;
        //emailRecord.OwnerId=eet.OwnerId;
        insert emailRecord;
        
        /*List<CronTrigger> JOBIDLIST = new List<CronTrigger>();
        JOBIDLIST = [select id,NextFireTime from CronTrigger where NextFireTime=NULL];
        system.debug('size : '+JOBIDLIST.size());
        If(JOBIDLIST.size()>0){
        for(CronTrigger job:JOBIDLIST)
         {
          System.abortJob(job.id);
         }
     }*/
  }
    

}