/*
Created By : Abdul Aziz
Created Date : 16/05/2023
*/

@isTest
public class CompititorReminderTest {
    public @istest static void testdata1(){  
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        tlist.add(tk);
        
        Trigger__c tshareorder = new Trigger__c(name ='Share Portfolio', Active__c = true);
        tlist.add(tshareorder);
        Trigger__c triggerr = new Trigger__c(name ='EmailMessage', Active__c = true);
        tlist.add(triggerr);
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='EA');
        
        ulist.add(uu);
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='EA');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='EA');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        Date fivedaysback =Date.today().addDays(-8);
       // Date fivedaysback =System.today();
        
        Account a = new Account();
        a.Name = 'oppnew';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Lead_Source1__c='ECOMM';
        a.Website='www.asdfert.com';
        a.Phone= '+985478547256';
        a.OtherPhone__c = '+985478547856';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076'; 
        a.ShippingCountry='India';
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        a.OwnerId = userinfo.getUserId();
        a.Last_Competitor_Created_Date__c=fivedaysback;
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;  
        
        competitivelandscape__c cc = new competitivelandscape__c();
        cc.Account__c = a.id;
        cc.ExpDate__c = system.today();
        cc.Hire__c = 20;
        cc.Competitor__c = 'others';
        cc.CreatedDate=fivedaysback;
        insert cc;
        
        Test.StartTest();
        CompititorReminder testsche = new CompititorReminder();
        String sch = '0 0 23 * * ?';
        try{
            system.schedule('Test status Check1', sch, testsche );
        }
        catch(Exception e){}
        
        Test.stopTest();
        
    }
}