/*Create By : Abdul Aziz , Created Date : 17/06/2023 , Helper Class for ActivationTrigger*/
public class ActivationTriggerHelper {
    public static void sendEmail(List<Activation__c> act)
    {
        set<id> setofid=new  set<id>();
        for(Activation__c ac : act)
        {
            setofid.add(ac.Id);
        }
        List<Activation__c> listofActivation=[select id,name,User__r.name,Xcode_Name__c,Account__r.name,Account_Id__c,
                                              Order_For_Revamp__r.name,User__r.email,User__r.Manager.email,
                                              Account__r.Owner.email,Account__r.Owner.Manager.email
                                              from Activation__c where id in :setofid];
        List<Messaging.SingleEmailMessage> mails =   new List<Messaging.SingleEmailMessage>();
        for(Activation__c ac : listofActivation)
        {
            String OrderNo =ac.Order_For_Revamp__r.name==null || ac.Order_For_Revamp__r.name=='' ? '' : +ac.Order_For_Revamp__r.name;
            String xcode =ac.Xcode_Name__c==null || ac.Xcode_Name__c=='' ? '' : +ac.Xcode_Name__c;
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(ac.User__r.email);
            mail.setToAddresses(sendTo);
            mail.setReplyTo('no-reply@salesforce.com');
            mail.setSenderDisplayName('Foundit - Monster');
            mail.whatid=ac.Id;
            List<String> ccTo = new List<String>();
            ccTo.add(ac.User__r.Manager.email);
            ccTo.add(ac.Account__r.Owner.email);
            ccTo.add(ac.Account__r.Owner.Manager.email);
            mail.setCcAddresses(ccTo);
            mail.setSubject('Services activated');
            String body = 'Hi '+ac.User__r.name+',<br/><br/>';
            body += 'Services activated, Please find the below details,<br/><br/>';
            body += 'Xcode: '+xcode+',<br/>';
            body += 'Account Name: '+ac.Account__r.name+',<br/>';
            body += 'Account Id: '+ac.Account_Id__c+',<br/>';
            body += 'Order No: '+OrderNo+'<br/><br/>';
            body += 'Thanks You.<br/>';
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        Messaging.sendEmail(mails);  
    }
}