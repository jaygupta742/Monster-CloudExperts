/*Created By : Abdul Aziz
Created Date : 15/05/2023
*/
global class CompititorReminder Implements Schedulable {
    global void execute(SchedulableContext sc) {
        sendMailFunction();
        System.debug('CompititorReminder - SchedulerClass is Successfully Executed !!!');
        // updateAccountStatus();
        // CompititorReminderBatch b = new CompititorReminderBatch(); 
        // Database.executeBatch(b,5);
    }
    
    public void sendMailFunction() {
        Date fivedaysback =Date.today().addDays(-8);
        // Date fivedaysback =Date.today();
        System.debug('todaydate'+fivedaysback);
        List<Account> listofAccount=[select id,Name,Last_Competitor_Created_Date__c,Last_Activity_Created_Date__c ,Owner.email, owner.firstname,owner.lastname,(select id,Name,Account__c,Competitor__c,TotalJobs__c from Competitive_Landscapes__r order by createddate desc limit 1) from account where Last_Competitor_Created_Date__c!=null and Last_Activity_Created_Date__c=null and Last_Competitor_Created_Date__c=:fivedaysback order by name limit 1000];
        
        System.debug('listofAccount size is ***'+listofAccount.size());
        System.debug('listofAccount is ***'+listofAccount);
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        for(Account acc : listofAccount) { 
            if(acc.Competitive_Landscapes__r.size()>0){
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
                    
                    try
                    {
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                    catch(Exception e){
                        System.debug('inside exception code Apex class name : CompititorReminder');
                        System.debug(' e.getLineNumber() is : '+ e.getLineNumber());
                        System.debug(' e.getMessage() is : '+ e.getMessage());
                        System.debug(' e.getTypeName() is : '+ e.getTypeName());
                    }   
                }
            }
        } 
    } 
}











































/*  public void updateAccountStatus() {
Date fivedaysback =Date.today().addDays(-5);
System.debug('todaydate'+fivedaysback);
List<Account> listofAccount=[select id,Name,Last_Competitor_Created_Date__c,Last_Activity_Created_Date__c ,Owner.email,
owner.firstname,owner.lastname,
(select id,Name,Account__c,Competitor__c,TotalJobs__c from Competitive_Landscapes__r order by createddate desc limit 1)
from account where Last_Competitor_Created_Date__c!=null and Last_Activity_Created_Date__c=null and Last_Competitor_Created_Date__c=:fivedaysback ];
System.debug('listofAccount size is ***'+listofAccount.size());
System.debug('listofAccount is ***'+listofAccount);
List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
for(Account acc : listofAccount){
for(competitivelandscape__c cmp : acc.Competitive_Landscapes__r)
{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
List<String> sendTo = new List<String>();
sendTo.add(acc.Owner.email);
//  sendTo.add('azizabdul7383@gmail.com');
mail.setToAddresses(sendTo);
mail.setSenderDisplayName('Foundit/Monster');
// List<String> ccTo = new List<String>();
// ccTo.add('business@bankofnigeria.com');
// mail.setCcAddresses(ccTo);
mail.setReplyTo('no-reply@foundit.com');
mail.setSubject('Reminder -  No Activity Done for '+acc.Name);
String body = 'Dear ' + acc.owner.firstname +' ' +acc.owner.lastname+', <br/> <br/>';
body += 'Greetings of the day!!!  <br/><br/> ';
body += 'This is to inform you that Competition - '+cmp.Competitor__c + ', Total jobs-'+cmp.TotalJobs__c+ ' is added .<br/> <br/>';
body += 'Since last 5 days no activity done for '+acc.Name+'.'+'<br/> <br/>';
body += 'Kindly start activities now!!!  <br/> <br/>';
body += 'Thank You  <br/> <br/>';
mail.setHtmlBody(body);
mails.add(mail);
}
}
Messaging.SendEmailResult[] rr=Messaging.sendEmail(mails); 
System.debug('rr is '+rr);
} */