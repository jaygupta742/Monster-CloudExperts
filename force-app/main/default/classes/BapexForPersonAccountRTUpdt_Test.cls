@istest
public class BapexForPersonAccountRTUpdt_Test {

    @istest
    static void TestPA(){
        List<Account> ac1= new List<Account>();
          Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        Account a = new Account();
        a.Name = 'Pramodh';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '7878787878';
        a.Integration__c=false;
        a.Person_Account__c=true;
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
         ac1.add(a);
          insert ac1;   
        PA_Owner_Assignment__c p = new PA_Owner_Assignment__c();
        p.Name = '1';
        p.Location__c = 'India';
        p.Count__c = 0;
        p.UserId__c = '0057F000004RCwEQAW';
       // insert p;
        BapexForPersonAccountRTUpdt bp= new BapexForPersonAccountRTUpdt();
        DataBase.executeBatch(bp);
    }
}