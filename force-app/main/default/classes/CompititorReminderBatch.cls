/*Created By : Abdul Aziz
Created Date : 15/05/2023
*/

global class CompititorReminderBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date fivedaysback =Date.today().addDays(-7);
        //   Date fivedaysback =Date.today();
        System.debug('todaydate'+fivedaysback);
        String query = 'select id,Name,Last_Competitor_Created_Date__c,Last_Activity_Created_Date__c ,Owner.email, owner.firstname,owner.lastname,(select id,Name,Account__c,Competitor__c,TotalJobs__c from Competitive_Landscapes__r order by createddate desc limit 1) from account where Last_Competitor_Created_Date__c!=null and Last_Activity_Created_Date__c=null and Last_Competitor_Created_Date__c=:fivedaysback';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> listofAccount) {
        System.debug('listofAccount size is ***'+listofAccount.size());
        System.debug('listofAccount is ***'+listofAccount);
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Account acc : listofAccount) {        
            for(competitivelandscape__c cmp : acc.Competitive_Landscapes__r){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List<String> sendTo = new List<String>();
                sendTo.add(acc.Owner.email);
                // sendTo.add('azizabdul7383@gmail.com');
                mail.setToAddresses(sendTo);
                mail.setSenderDisplayName('Foundit/Monster');
                // List<String> ccTo = new List<String>();
                // ccTo.add('business@bankofnigeria.com');
                // mail.setCcAddresses(ccTo);
                mail.setReplyTo('no-reply@foundit.com');
                mail.setWhatId(acc.id);
                mail.setSubject('Reminder -  No Activity Done for '+acc.Name);
                String body = 'Dear ' + acc.owner.firstname +' ' +acc.owner.lastname+', <br/> <br/>';
                body += 'Greetings of the day!!!  <br/><br/> ';
                body += 'This is to inform you that Competition - '+cmp.Competitor__c + ', Total jobs-'+cmp.TotalJobs__c+ ' is added .<br/> <br/>';
                body += 'Since last 5 days no activity done for '+acc.Name+'.'+'<br/> <br/>';
                body += 'Kindly start activities now!!!  <br/> <br/>';
                body += 'Thank You. <br/> <br/>';
                mail.setHtmlBody(body);
                mails.add(mail);
                //  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        } 
        try{
            Messaging.sendEmail(mails);
        }
        catch(Exception e){
            System.debug('inside exception code Apex class name : CompititorReminderBatch');
        }
    }   
    global void finish(Database.BatchableContext BC) {
        System.debug('CompititorReminderBatch Executed Succesfully!!!');
    }
}