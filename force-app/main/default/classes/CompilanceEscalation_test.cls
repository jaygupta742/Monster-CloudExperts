//Trigger in Compilance
@isTest
public class CompilanceEscalation_test {
    
    public static testmethod void  met1(){
        
        user u = [SELECT id,name from user WHERE Alias = 'AChandra'];
        List<BusinessHours> bhs=[select id,name from BusinessHours WHERE name = 'Compliance'];
        
        trigger__c t = new trigger__c(Active__c = true ,name='Compliance');
        insert t;
        
        list<Compliance_Escalation__c> ce = new list<Compliance_Escalation__c>();
        
        Compliance_Escalation__c ce1 = new Compliance_Escalation__c(UID__c='0057F000003Sa4S',Email__c = 'email@gmail.com',name='1stescalation');
        ce.add(ce1);
        Compliance_Escalation__c ce2 = new Compliance_Escalation__c(UID__c='0057F000003Sa4S',Email__c = 'email@gmail.com',name='2ndescalation');
        ce.add(ce2);
        
        insert ce;
        
        Compliance__c NewComp = new Compliance__c();
        
        NewComp.Status__c = 'New';
        NewComp.Subject__c = 'sub';
        NewComp.Description__c = 'email.htmlBody';
        NewComp.Email__c = 'mail@gmail.com';
        NewComp.Received_To__c = 'mail@gmail.com'; 
        NewComp.IsKeyword__c = true; 
        NewComp.Priority__c = '3-Medium'; 
        NewComp.Category__c = 'Compliance';
        insert  NewComp;
        
        NewComp.Status__c = 'Open';
        NewComp.OwnerId = u.id;
        update NewComp;
        
    }
    
}