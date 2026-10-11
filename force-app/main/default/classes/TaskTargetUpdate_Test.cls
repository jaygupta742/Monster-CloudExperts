@istest
public class TaskTargetUpdate_Test {
    @isTest
    Public Static void mymethod1(){
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c tt = Trigger__c.getValues('Quote');
        
        Trigger__c t7 = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t7);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);        
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);        
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        
        Trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio',Active__c = true);
        cs.add(SharePortfolio);
        
        insert cs;
        
        LastRunTime__c lt = new LastRunTime__c();
        lt.Name = 'LastRun';
        lt.LRT__c = system.now() -1 ;
        insert lt;
        
        List<Account> lstAccount = new List<Account>();
        
        Account TestAcc1 = new Account();
        TestAcc1.Name = 'Testaccount';
        TestAcc1.SalesChannel__c = 'ECOMM';
        TestAcc1.Import_Source__c='eeee';
        TestAcc1.Lead_Source__c='Other';
        TestAcc1.APAC_Industry__c='Energy';
        TestAcc1.No_of_Employees__c= 25;
        TestAcc1.Account_Type__c='NIT';
        TestAcc1.Location__c='Hong Kong';
        TestAcc1.Website='www.asdfert.com';
        TestAcc1.Phone= '+918965874589';
        TestAcc1.OtherPhone__c = '+987456985474';
        TestAcc1.RegistrationNumber__c='asq111111';
        TestAcc1.Lead_Account_Status__c='Inactive';
        TestAcc1.CreditStatus__c='OK';
        TestAcc1.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        TestAcc1.BillingState='Karnataka';
        TestAcc1.BillingStreet ='Test Address';
        TestAcc1.BillingCity ='bangalore' ;
        TestAcc1.BillingPostalCode='560076';
        TestAcc1.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        TestAcc1.shippingState='Karnataka';
        TestAcc1.shippingStreet ='Test Address';
        TestAcc1.shippingCity ='bangalore' ;
        TestAcc1.shippingPostalCode='560076';
        TestAcc1.Segment__c = 'Commercial';
        TestAcc1.Lead_Source1__c= 'Call Inbound';
        TestAcc1.Last_Target_Activity_Date__c = Date.today().addDays(- 20);
        lstAccount.add(TestAcc1);
        
        Account testAcc2 = new Account();
        testAcc2.Name = 'Test Acc 2';
        testAcc2.SalesChannel__c = 'ECOMM';
        testAcc2.Import_Source__c='eeee';
        testAcc2.Lead_Source__c='Other';
        testAcc2.APAC_Industry__c='Energy';
        testAcc2.No_of_Employees__c= 25;
        testAcc2.Account_Type__c='NIT';
        testAcc2.Location__c='Hong Kong';
        testAcc2.Website='www.asdfert.com';
        testAcc2.Phone= '+918965874589';
        testAcc2.OtherPhone__c = '+987456985474';
        testAcc2.RegistrationNumber__c='asq111111';
        testAcc2.Lead_Account_Status__c='Inactive';
        testAcc2.CreditStatus__c='OK';
        testAcc2.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        testAcc2.BillingState='Karnataka';
        testAcc2.BillingStreet ='Test Address';
        testAcc2.BillingCity ='bangalore' ;
        testAcc2.BillingPostalCode='560076';
        testAcc2.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        testAcc2.shippingState='Karnataka';
        testAcc2.shippingStreet ='Test Address';
        testAcc2.shippingCity ='bangalore' ;
        testAcc2.shippingPostalCode='560076';
        testAcc2.Segment__c = 'Commercial';
        testAcc2.Lead_Source1__c= 'Call Inbound';
        lstAccount.add(testAcc2);
        
        Account TestAcc3 = new Account();
        TestAcc3.Name = 'Testaccount';
        TestAcc3.SalesChannel__c = 'ECOMM';
        TestAcc3.Import_Source__c='eeee';
        TestAcc3.Lead_Source__c='Other';
        TestAcc3.APAC_Industry__c='Energy';
        TestAcc3.No_of_Employees__c= 25;
        TestAcc3.Account_Type__c='NIT';
        TestAcc3.Location__c='Hong Kong';
        TestAcc3.Website='www.asdfert.com';
        TestAcc3.Phone= '+918965874589';
        TestAcc3.OtherPhone__c = '+987456985474';
        TestAcc3.RegistrationNumber__c='asq111111';
        TestAcc3.Lead_Account_Status__c='Inactive';
        TestAcc3.CreditStatus__c='OK';
        TestAcc3.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        TestAcc3.BillingState='Karnataka';
        TestAcc3.BillingStreet ='Test Address';
        TestAcc3.BillingCity ='bangalore' ;
        TestAcc3.BillingPostalCode='560076';
        TestAcc3.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        TestAcc3.shippingState='Karnataka';
        TestAcc3.shippingStreet ='Test Address';
        TestAcc3.shippingCity ='bangalore' ;
        TestAcc3.shippingPostalCode='560076';
        TestAcc3.Segment__c = 'Commercial';
        TestAcc3.Lead_Source1__c= 'Call Inbound';
        TestAcc3.Last_Target_Activity_Date__c = Date.today();
        lstAccount.add(TestAcc3);

		
        Insert lstAccount;
        
        test.startTest();
        List<Task> lstTask = new List<Task> ();
        Task task1 = new Task();
        task1.Subject = 'Meeting';
        task1.WhatId = testAcc1.Id;
        lstTask.add(task1);
        
        Task task2 = new Task();
        task2.Subject = 'Fresh Telecall';
        task2.WhatId = testAcc2.Id;
        lstTask.add(task2);
        
        Task task3 = new Task();
        task3.Subject = 'Meeting';
        task3.WhatId = testAcc3.Id;
        lstTask.add(task3);
        
        Insert lstTask;
        test.stopTest();
    } 
}