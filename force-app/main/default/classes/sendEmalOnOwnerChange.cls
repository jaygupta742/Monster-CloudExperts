/*
	Created By : Jay Gupta
	Created Date : 4/11/23
	Created For : For Sending Email to Task Owner.
*/

public class sendEmalOnOwnerChange {
    public sendEmalOnOwnerChange(Map<Id, Account> accMap,list<Task> taskList,Map<Id,User> userMap,User currentUser){
		List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(Task t : taskList){
            emails.add(createEmail(accMap.get(t.WhatId),t,userMap.get(t.OwnerId),currentUser));
        }
        system.debug(emails);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        for (Messaging.SendEmailResult result : results) {
            if (result.isSuccess()) {
                System.debug('Email sent successfully');
            } else {
                System.debug('Email send failed: ' + result.getErrors()[0].getMessage());
            }
        }
    }
    
    public Messaging.SingleEmailMessage createEmail(Account acc,Task task,User user,User currentUser){
        system.debug('This is create email');
        String body = '';
        String [] subtypes = task.Task_Sub_Type1__c.split(';');
        system.debug(task.Owner.Name);
        body += '<span>Hi '+ user.Name +'</span><br>';
        body += '<span>An '+ task.Task_Type__c +' activity has been assigned to you for acccount '+ acc.AccountId__c + ' ' +acc.Name +'</span><br>';
        body += '<span>Bellow are the account details</span><br>';
        body += '<ul><li> Sales Channel : '+ acc.SalesChannel__c +'</li> <li> Top 1K : '+ acc.Top_1000__c +'</li> <li> Account Expiration Date : '+ acc.Account_Expiration_Date__c +'</li></ul>';
       	body += '<span> '+ currentUser.Name +' has raised the following issues on the account : </span><br>';
        body += '<ul>';
        for(String sus : subtypes){
            body += '<li>'+ sus +'</li>';
        }
        body += '</ul><br>';
		body += '<span>Regards</span><br><span>'+ currentUser.Name +'</span>'; 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {user.Email});
        mail.setCcAddresses(new String[] {user.Manager.Email,currentUser.Email,currentUser.Manager.Email});
        //mail.setToAddresses(new String[] {'jaysgupta742@gmail.com'});
        mail.setSubject(task.Subject);
        mail.setHtmlBody(body);
		return mail;
    }
    
    
    // current user manager , assignto manager , cuurent user
    // assigned to
    
    
}