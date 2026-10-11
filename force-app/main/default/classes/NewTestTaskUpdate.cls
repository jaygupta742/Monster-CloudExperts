@isTest
public class NewTestTaskUpdate {
	@isTest
    public static void setup() {
        test.startTest();
        List<Trigger__c> cs= new List<Trigger__c>();       
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
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
      	insert cs;
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
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.shippingState='Karnataka';
        a.shippingStreet ='Test Address';
        a.shippingCity ='bangalore' ;
        a.shippingPostalCode='560076';        
        a.Segment__c = 'Commercial';
        //a.Last_Target_Activity_Date__c = System.today() - 30;
        a.Lead_Source1__c= 'Call Inbound';
        insert a;
        
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
        a1.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a1.BillingState='Karnataka';
        a1.BillingStreet ='Test Address';
        a1.BillingCity ='bangalore' ;
        a1.BillingPostalCode='560076';
        a1.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        a1.shippingState='Karnataka';
        a1.shippingStreet ='Test Address';
        a1.shippingCity ='bangalore' ;
        a1.shippingPostalCode='560076';        
        a1.Segment__c = 'Commercial';
        a1.Last_Target_Activity_Date__c = System.today() - 30;
        a1.Lead_Source1__c= 'Call Inbound';
        insert a1;
        
        Task t = new Task();
        t.Subject = 'Meeting';
        t.WhatId = a.Id;
        insert t;
        t.Subject = 'Fresh Telecall';
        Update t;
        
        Task t11 = new Task();
        t11.Subject = 'Fresh Telecall';
        t11.WhatId = a1.Id;
        insert t11;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Amount__c = 1100;
        insert o;
        test.stopTest();       
   // }
    
    
   // Public Static void testmytarget(){
        
        
    }
}