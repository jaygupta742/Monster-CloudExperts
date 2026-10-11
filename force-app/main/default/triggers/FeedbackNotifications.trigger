trigger FeedbackNotifications on Event (after update,after insert){
    
   if(trigger.isAfter&&trigger.isInsert){
        
        List<Event> listEvent = new List<Event>();
        List<User> salesOpsUsers = new List<User>();
        Set<Id> salesOpsIds = new Set<Id>();
        String profileId = [Select Id,Name from profile where Name='Monster - Sales Ops/LM' limit 1].Id;
        system.debug('profileId : '+profileId);
        for(User uu : [Select Id,Name,Email,ProfileId,IsActive from User where ProfileId=:profileId AND IsActive=true]){
           salesOpsIds.add(uu.Id);
        }
        for(Event et : trigger.new){
        String sub = et.Subject;
        system.debug('sub : '+sub);
        if((salesOpsIds.contains(UserInfo.getUserId()))&&(et.Feedback__c==null)&&(et.Level_for_Escalation__c==null)&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            datetime dt = et.CreatedDate.addMinutes(30);
            system.debug('String.valueOf(et.Id) : '+String.valueOf(et.Id));
            system.debug('UserInfo.getUserId() : '+UserInfo.getUserId());
            sendMailtoExecutives sme = new sendMailtoExecutives(String.valueOf(et.Id),UserInfo.getUserId());
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 1 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);  
        }
        
        /*
          from line no 29 to 60 this was already blocked as not required
           if((et.Feedback__c==null)&&(et.Level_for_Escalation__c=='Level 1')&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            //datetime dt = et.CreatedDate.addHours(1);
            datetime dt = et.CreatedDate.addMinutes(10);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 2 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);
        }
        if((et.Feedback__c==null)&&(et.Level_for_Escalation__c=='Level 2')&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            //datetime dt = et.CreatedDate.addHours(3);
            datetime dt = et.CreatedDate.addMinutes(15);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 3 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);
        }
        if((et.Feedback__c==null)&&(et.Level_for_Escalation__c=='Level 3')&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            //datetime dt = et.CreatedDate.addHours(6);
            datetime dt = et.CreatedDate.addMinutes(20);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 4 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);
        }*/
    }
    }
  
     If(trigger.isAfter&&trigger.isUpdate){
    List<Event> listEvent = new List<Event>();
    List<User> salesOpsUsers = new List<User>();
    Set<Id> salesOpsIds = new Set<Id>();
    String profileId = [Select Id,Name from profile where Name='Monster - Sales Ops/LM' limit 1].Id;
    system.debug('profileId : '+profileId);
    for(User uu : [Select Id,Name,Email,ProfileId,IsActive from User where ProfileId=:profileId AND IsActive=true]){
        salesOpsIds.add(uu.Id);
    }
    system.debug('salesOpsUsers : '+salesOpsUsers);
    system.debug('salesOpsUsers.size() : '+salesOpsUsers.size());
    
    system.debug('Old Map : '+trigger.oldmap);
    system.debug('Old Map keys : '+trigger.oldmap.Keyset());
    system.debug('New Map : '+trigger.newmap);
    system.debug('New Map keys : '+trigger.newmap.Keyset());
    
    for(Event et : trigger.new){
        String sub = et.Subject;
        system.debug('sub : '+sub);
        if((trigger.oldmap.get(et.id).OwnerId!=et.OwnerId)&&(salesOpsIds.contains(trigger.oldmap.get(et.id).OwnerId))&&(et.Feedback__c==null)&&(et.Level_for_Escalation__c==null)&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            datetime dt = et.CreatedDate.addMinutes(30);
            sendMailtoExecutives sme = new sendMailtoExecutives(String.valueOf(et.Id),trigger.oldmap.get(et.id).OwnerId);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 1 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);  
        }
        
        if((et.Feedback__c==null)&&(et.Level_for_Escalation__c=='Level 1')&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            datetime dt = et.CreatedDate.addHours(2);
       //     datetime dt = et.CreatedDate.addMinutes(10);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 2 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);
        }
        if((et.Feedback__c==null)&&(et.Level_for_Escalation__c=='Level 2')&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            datetime dt = et.CreatedDate.addHours(5);
         //   datetime dt = et.CreatedDate.addMinutes(15);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 3 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);
        }
        if((et.Feedback__c==null)&&(et.Level_for_Escalation__c=='Level 3')&&(sub.startsWithIgnoreCase('Recruiter Profile')||sub.startsWithIgnoreCase('Inbound'))){
            datetime dt = et.CreatedDate.addHours(11);
         //   datetime dt = et.CreatedDate.addMinutes(20);
            string cron_exp = '' + dt.second() + ' ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            system.debug('cron_exp level 4 : '+cron_exp);
            scheduleEscalation scheduledJob = new scheduleEscalation(String.valueOf(et.Id));
            Id jobId = System.schedule('ScheduledJob ' + dt.getTime(),cron_exp,scheduledJob);
            //et.Schedule_Job_Id__c = jobId;
            system.debug('jobId : '+jobId);
        }
    }
    }
}