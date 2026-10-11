@istest
public class BatchApexContactRT_Test {

    public static testmethod void testcontactRT(){
        List<Account>  aa = new List<Account>();
        
        Account a = new Account();
        a.Name = 'Testaccount';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='eeee';
        a.Lead_Source__c='Other';
        a.Person_Account__c = true;
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
        a.CreatedDate = Date.newInstance(2014, 12, 9);
        a.Segment__c = 'Commercial';
        a.Lead_Source1__c= 'Call Inbound';
        aa.add(a);
        insert aa;
        
        contact c =new contact();
        c.LastName = 'Test';
        c.AccountId = aa[0].id;
        Insert c;
        
        List<Account>  aa1 = new List<Account>();
        Account a1 = new Account();
        a1.Name = 'Testaccount1';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='eeee';
        a1.Lead_Source__c='Other';
        a1.Person_Account__c = true;
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='Hong Kong';
        a1.Website='www.asdfer1t.com';
        a1.Phone= '+918965874587';
        a1.OtherPhone__c = '+9874569854744';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Active';
        a1.CreditStatus__c='OK';
        a1.CreatedDate = Date.newInstance(2014, 12, 9);
        a1.Segment__c = 'Commercial';
        a1.Lead_Source1__c= 'Call Inbound';
        aa1.add(a1);
        insert aa1;
        
        contact c1 =new contact();
        c1.LastName = 'Test';
        c1.AccountId = aa1[0].id;
        Insert c1;
        
        Test.startTest();
            
        BatchApexForContactRT brt = new BatchApexForContactRT();
        DataBase.executeBatch(brt); 
            
        Test.stopTest();
    }
}