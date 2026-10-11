@istest
public class Batchtochangesegmentnames_Test {
    static testMethod void testManualShareRead(){
        trigger__C t = new trigger__C(name='Account',active__C = true);
        insert t;
        trigger__C t1 = new trigger__C(name='EmailMessage',active__C = true);
        insert t1;
        
        list<account> acc = new list<account>();
       
        Account a = new Account();
        a.Name = 'Testaccount';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='eeee';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='Hong Kong';
        a.Website='www.asdfert.com';
        a.Phone= '+918965874589';
        a.OtherPhone__c = '+987456985474';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Segment__c = 'Enterprise Business';
        
        a.Lead_Source1__c= 'Call Inbound';
            acc.add(a);
            
        Account a1 = new Account();
        a1.Name = 'Testaccount';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='eeee';
        a1.Lead_Source__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='Hong Kong';
        a1.Website='www.asdfert.com';
        a1.Phone= '+918965874589';
        a1.OtherPhone__c = '+987456985474';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='OK';
        a1.Segment__c = 'SMB Business';
        
        a1.Lead_Source1__c= 'Call Inbound';
            acc.add(a1);
        
        insert acc;
        
        
        Batchtochangesegmentnames b1 = new Batchtochangesegmentnames();
        database.executeBatch(b1,200);
    }
}