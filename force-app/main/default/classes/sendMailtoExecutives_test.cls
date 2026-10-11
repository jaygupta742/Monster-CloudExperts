//Last Modified By : Abdul Aziz , Date : 11/06/2024 , Description : Increased Code Coverage and Recitify errors
@isTest
public class sendMailtoExecutives_test {
    
    public static testmethod void myTest(){
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
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
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Event',Active__c = true);
        cs.add(t4);
        insert cs;
        
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Segment__c='ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        a.Suspect_Prospect__c='Prospect';
        insert a;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Monster - Sales Ops/LM' Limit 1];
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Monster - Sales' Limit 1];
        
        User u3 = new User(Alias = 'st558', Email='standarduser13@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing13', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles',
                           UserName='uniqueUserName13@gmail.com');
        insert u3;
        
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles',
                          UserName='uniqueUserName@gmail.12345com',ManagerId=u3.Id);
        //   UserName='unique@gmail.com');
        insert u;
        
        User u1 = new User(Alias = 'st12', Email='standarduser12@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing12', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p1.Id,
                           TimeZoneSidKey='America/Los_Angeles',
                           UserName='uniqueUserName12@gmail.com',ManagerId=u.Id);
        insert u1;
        
        Event eet = new Event();
        eet.Subject = 'Inbound Test Class';
        eet.StartDateTime=system.today()+1;
        eet.EndDateTime=system.today()+5;
        eet.WhatId=a.Id;
        eet.OwnerId=u1.id;
        eet.Manager__c=u1.ManagerId;
        eet.Task_Type__c='VOC';
        eet.Task_Sub_Type1__c='Technical Issue/Bug';
        insert eet;
       // sendMailtoExecutives sct = new sendMailtoExecutives(String.valueOf(eet.Id),String.valueOf(u1.id));
        
    }
    
}