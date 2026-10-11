//Trigger in Seeker
@isTest
public class SeekerEscalation_Test {
    
     public static testmethod void  met1(){
        
        user u = [SELECT id,name from user WHERE Alias = 'Rajender'];
        List<BusinessHours> bhs=[select id,name from BusinessHours WHERE name = 'Seeker'];
        
         trigger__c t = new trigger__c(Active__c = true ,name='Seeker');
        insert t;
        
        list<Seeker_Escalation__c> ce = new list<Seeker_Escalation__c>();
        
         Seeker_Escalation__c ce1 = new Seeker_Escalation__c(UID__c='0057F000003Sa4S',Email__c = 'email@gmail.com',name='1stescalation');
        ce.add(ce1);
        Seeker_Escalation__c ce2 = new Seeker_Escalation__c(UID__c='0057F000003Sa4S',Email__c = 'email@gmail.com',name='2ndescalation');
        ce.add(ce2);
          Seeker_Escalation__c ce3 = new Seeker_Escalation__c(UID__c='0057F000003Sa4S',Email__c = 'email@gmail.com',name='3rdescalation');
        ce.add(ce3);
        
        insert ce;
        
        Seeker__c NewComp = new Seeker__c();
        
               NewComp.Status__c = 'New';
               NewComp.Subject__c = 'sub';
               NewComp.Description__c = 'email.htmlBody';
               NewComp.Email__c = 'mail@gmail.com';
               NewComp.Received_To__c = 'mail@gmail.com'; 
               NewComp.IsKeyword__c = true; 
               NewComp.Priority__c = '3-Medium'; 
               NewComp.Category__c = 'Compliance';
               NewComp.CreatedDate = system.today() - 1;
                insert  NewComp;
        
        NewComp.Status__c = 'Open';
        NewComp.OwnerId = u.id;
        update NewComp;
         
           Seeker__c NewComp1 = new Seeker__c();
        
               NewComp1.Status__c = 'New';
               NewComp1.Subject__c = 'sub';
               NewComp1.Description__c = 'email.htmlBody';
               NewComp1.Email__c = 'mail@monstergmail.com';
               NewComp1.Received_To__c = 'mail@gmail.com'; 
               NewComp1.IsKeyword__c = true; 
               NewComp1.Priority__c = '3-Medium'; 
               NewComp1.Category__c = 'Compliance';
             //  NewComp1.CreatedDate = system.today() - 3;
                insert  NewComp1;
        
        NewComp1.Status__c = 'Open';
        NewComp1.OwnerId = u.id;
        update NewComp1;
         
        
    }


}