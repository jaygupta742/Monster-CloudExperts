@isTest
class B2CIntegration_UpdateAccount_test {
    @isTest
    static void seekertest(){
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
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
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Integration__c = true;
        insert a;
        
        PA_Owner_Assignment__c p = new PA_Owner_Assignment__c();
        p.Name = '1';
        p.Location__c = 'India';
        p.Count__c = 0;
        p.UserId__c = '0057F000004RCwEQAW';
        insert p;
        Datetime dt = System.now();
        B2CIntegration_UpdateAccount.doPost('12345', 'Invalid Number', 'Not Interested');
        B2CIntegration_UpdateAccount.doPost(a.Id, 'Invalid Number', 'Not Interested');
        system.debug('P val : '+p.Count__c);
    }
}