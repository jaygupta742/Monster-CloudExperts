//test class for CreateEmail
@isTest
public class CreateEmail_Test {
    public static testmethod void met(){
 trigger__c t = new trigger__C(name='EmailMessage',Active__c = true);
        insert t;
  trigger__c t1 = new trigger__C(name='Case',Active__c = true);
        insert t1;       
 Case_Escalation__c ce = new Case_Escalation__c(UID__c='0057F000003Sa4S',Email__c = 'email@gmail.com',name='1stescalation');       
        insert ce;
        
        case__c c = new case__c();
       c.Subject__c = 'subject';
       c.SuppliedEmail__c = 'sh@gmail.com';
        insert c;
        system.debug('case-->'+c);
        
        emailmessage e = new emailmessage();
        e.FromAddress = 'sh@gmail.com';
        e.Subject = 'subject';
        e.TextBody = 'text body';
        e.Status = '3';
        e.RelatedToId = c.id;
        insert e;
        system.debug('emailmessage-->'+e);
        
    }

}