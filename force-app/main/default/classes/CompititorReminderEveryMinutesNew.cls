/*
Created by : Abdul Aziz
Created Date : 27/05/2023
*/
global class CompititorReminderEveryMinutesNew  Implements Schedulable{
    private final String JOB_NAME = 'IM CompititorReminderEveryMinutesNew';
    private final Integer FIVE_MINUTE = 1;
    
    private void rescheduleJob() {
        Datetime sysTime = System.now().addMinutes(FIVE_MINUTE);
        String cronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        System.schedule(JOB_NAME, cronExpression, new CompititorReminderEveryMinutesNew());
    }
    private void findAndAbortJob(SchedulableContext cont) {
        if (cont == null) {
            return;
        }
        
        //Need to query CronJobDetail to find our currently active scheduled job
        List<CronJobDetail> cronDetail = [SELECT Id FROM CronJobDetail WHERE Name =: JOB_NAME LIMIT 1];
        
        if (cronDetail.isEmpty()) {
            return;
        }
        
        //Need to find the corresponding cron trigger to be able to abort the scheduled job
        List<CronTrigger> cronTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetailId = :cronDetail[0].Id];
        
        if(cronTriggers.isEmpty()) {
            return;
        }
        
        try {
            //Aborts the job current setup for this scheduled class
            System.abortJob(cronTriggers[0].Id);
            rescheduleJob();
        }
        catch (Exception e) {
            System.debug('This was the error ::: ' + e.getMessage());
        }
    }
    
    
    global void execute(SchedulableContext sc) {
        CompititorReminderEveryMinutesNew.sendMailFunction();  
        findAndAbortJob(sc);
    }
    
    public static void  sendMailFunction() {
       Date fivedaysback =Date.today().addDays(-5);
     System.debug('todaydate'+fivedaysback);
        //  List<Account> listofAccount=[select id,Name,Last_Competitor_Created_Date__c,Last_Activity_Created_Date__c ,Owner.email, owner.firstname,owner.lastname,(select id,Name,Account__c,Competitor__c,TotalJobs__c from Competitive_Landscapes__r order by createddate desc limit 1) from account where Last_Competitor_Created_Date__c!=null and Last_Activity_Created_Date__c=null and Last_Competitor_Created_Date__c=:fivedaysback order by name limit 2];
        List<competitivelandscape__c> compititorlist=[select id,Name,Account__c,Competitor__c,TotalJobs__c,Account__r.id,Account__r.name,Competitor_Email_Sent__c,Created_Date_Formula__c,
                                                      Account__r.Last_Competitor_Created_Date__c,Account__r.Last_Activity_Created_Date__c,Account__r.Owner.email,Account__r.Owner.firstname,Account__r.Owner.lastname
                                                      from competitivelandscape__c
                                                      where Competitor_Email_Sent__c=false and Account__r.Last_Activity_Created_Date__c=null  and Created_Date_Formula__c=:fivedaysback order by name limit 2];                                
      
        System.debug('compititorlist count is **'+compititorlist.size());
        set<id> setofcompid=new  set<id>();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(competitivelandscape__c cmp : compititorlist){
              string TotalJobs =cmp.TotalJobs__c==null  ? '' : +String.valueOf(cmp.TotalJobs__c);
            cmp.Competitor_Email_Sent__c=true;
            // count=count+1;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
             sendTo.add(cmp.Account__r.Owner.email);
          //  sendTo.add('azizabdul7383@gmail.com');
            mail.setToAddresses(sendTo);
            mail.setSenderDisplayName('Foundit/Monster');
            mail.setReplyTo('no-reply@foundit.com');
            mail.setWhatId(cmp.id);
            mail.setSubject('Reminder -  No Activity Done for '+cmp.Account__r.name);
            String accOwnerFistName =cmp.Account__r.owner.firstname==null || cmp.Account__r.owner.firstname=='' ? '' : +cmp.Account__r.owner.firstname;
            String body = 'Dear ' + accOwnerFistName +' ' +cmp.Account__r.owner.lastname+', <br/> <br/>';
            body += 'Greetings of the day!!!  <br/><br/> ';
            body += 'This is to inform you that Competition - '+cmp.Competitor__c + ', Total jobs-'+TotalJobs+ ' is added .<br/> <br/>';
            body += 'Since last 5 days no activity done for '+cmp.Account__r.name+'.'+'<br/> <br/>';
            body += 'Kindly start activities now!!!  <br/> <br/>';
            body += 'Thank You. <br/> <br/>';
            mail.setHtmlBody(body);
            try{
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
            catch(Exception e){
                System.debug('Error Account Name    : '+cmp.Account__r.name);
                System.debug('Error Account id  : '+cmp.Account__r.id);
                System.debug('Inside Exception -CompititorReminderEveryMinutesNew');
                System.debug(' e.getCause() is : '+e.getCause());
                System.debug(' e.getLineNumber() is : '+ e.getLineNumber());
                System.debug(' e.getMessage() is : '+e.getMessage());
            }
        }
        try{
            update compititorlist;
        }
        catch(exception e){
            
        }   
    }     
}