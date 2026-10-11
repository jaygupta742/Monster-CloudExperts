/*Created By : Abdul Aziz
 Created Date : 5-may-2023*/

@istest
public class AddressAndContactCheck_Test {
    
    @istest static void myTestPa(){
        try{
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
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
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        insert cs;
       
        List<Account> lll=new  List<Account>();
        List<Contact> conlist=new List<Contact>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'EA';
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
        // insert a;
        lll.add(a);
        
        
        Account a1 = new Account();
        a1.Name = 'ANKShjhjhjkkkakka';
        a1.SalesChannel__c = 'EA';
        a1.Segment__c='Fieldsales.hk';
        a1.Import_Source__c='sssss';
        a1.Lead_Source1__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Website='www.asdfert.com';
        a1.Phone= '+917878787878';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='OK';
        a1.BillingCountry='India' ; 
        a1.BillingState='Karnataka';
        a1.BillingStreet ='Test Address';
        a1.BillingCity ='bangalore' ;
        a1.BillingPostalCode='560076';
        a1.ShippingCountry='India';
        a1.ShippingCity='Test';
        a1.ShippingPostalCode='56000';
        a1.ShippingState ='Test Address';
        a1.ShippingStreet='Jssttts';
        a1.Suspect_Prospect__c='Prospect';
        // insert a1;
        lll.add(a1);
        
        
        
        
        Account a2 = new Account();
        a2.Name = 'ANKShjhjhjkkkakka';
        a2.SalesChannel__c = 'Enterprise Business';
        a2.Segment__c='SMB';
        a1.Import_Source__c='sssss';
        a2.Lead_Source1__c='Other';
        a2.APAC_Industry__c='Energy';
        a2.No_of_Employees__c= 25;
        a2.Account_Type__c='NIT';
        a2.Location__c='Hong Kong';
        a2.Website='www.asdfert.com';
        a2.Phone= '+917878787878';
        a2.RegistrationNumber__c='asq111111';
        a2.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='OK';
        a2.BillingCountry='India' ; 
        a2.BillingState='Karnataka';
        a2.BillingStreet ='Test Address';
        a2.BillingCity ='bangalore' ;
        a2.BillingPostalCode='560076';
        a2.ShippingCountry='India';
        a2.ShippingCity='Test';
        a2.ShippingPostalCode='56000';
        a2.ShippingState ='Test Address';
        a2.ShippingStreet='Jssttts';
        a2.Suspect_Prospect__c='Prospect';
        // insert a1;
        lll.add(a2);
        
        
        
        
        Account a3 = new Account();
        a3.Name = 'ANKShjhjhjkkkakka';
        a3.SalesChannel__c = 'MMW';
        a3.Segment__c='Fieldsales.hk';
        a3.Import_Source__c='sssss';
        a3.Lead_Source1__c='Other';
        a3.APAC_Industry__c='Energy';
        a3.No_of_Employees__c= 25;
        a3.Account_Type__c='NIT';
        a3.Location__c='Hong Kong';
        a3.Website='www.asdfert.com';
        a3.Phone= '+917878787878';
        a3.RegistrationNumber__c='asq111111';
        a3.Lead_Account_Status__c='Inactive';
        a3.CreditStatus__c='OK';
        a3.BillingCountry='India' ; 
        a3.BillingState='Karnataka';
        a3.BillingStreet ='Test Address';
        a3.BillingCity ='bangalore' ;
        a3.BillingPostalCode='560076';
        a3.ShippingCountry='India';
        a3.ShippingCity='Test';
        a3.ShippingPostalCode='56000';
        a3.ShippingState ='Test Address';
        a3.ShippingStreet='Jssttts';
        a3.Suspect_Prospect__c='Prospect';
        // insert a1;
        lll.add(a3);
        
        
        Account a4 = new Account();
        a4.Name = 'ANKShjhjhjkkkakka';
        a4.SalesChannel__c = 'Enterprise Business';
        a4.Segment__c='IN-TS';
        a4.Import_Source__c='sssss';
        a4.Lead_Source1__c='Other';
        a4.APAC_Industry__c='Energy';
        a4.No_of_Employees__c= 25;
        a4.Account_Type__c='NIT';
        a4.Location__c='India';
        a4.Website='www.asdfert.com';
        a4.Phone= '+917878787878';
        a4.RegistrationNumber__c='asq111111';
        a4.Lead_Account_Status__c='Inactive';
        a4.CreditStatus__c='OK';
        a4.BillingCountry='India' ; 
        a4.BillingState='Karnataka';
        a4.BillingStreet ='Test Address';
        a4.BillingCity ='bangalore' ;
        a4.BillingPostalCode='560076';
        a4.ShippingCountry='India';
        a4.ShippingCity='Test';
        a4.ShippingPostalCode='56000';
        a4.ShippingState ='Test Address';
        a4.ShippingStreet='Jssttts';
        a4.Suspect_Prospect__c='Prospect';
        // insert a1;
        lll.add(a4);
        insert lll;
        
        Contact c1 = new Contact();
        c1.AccountID= a1.Id;
        c1.LastName='MahendraBajhhjli';
        c1.Email='mbahjhjhjhu@gmail.com';
        c1.Phone='0919898989899';
        conlist.add(c1);
        
        Contact c2 = new Contact();
        c2.AccountID= a2.Id;
        c2.LastName='MahendraBajhhjli2';
        c2.Email='mbahjhjhjh22@gmail.com';
        c2.Phone='0919898989899';
        conlist.add(c2);
        
        Contact c3 = new Contact();
        c3.AccountID= a3.Id;
        c3.LastName='MahendraBajhhjli2';
        c3.Email='mbahjhjhjh22@gmail.com';
        c3.Phone='0919898989899';
        conlist.add(c3);
        
        Contact c4 = new Contact();
        c4.AccountID= a4.Id;
        c4.LastName='MahendraBajhhjli2';
        c4.Email='mbahjhjhjh22@gmail.com';
        c4.Phone='0919898989899';
        conlist.add(c4);
        
        Contact c5 = new Contact();
        c5.AccountID= a4.Id;
        c5.LastName='MahendraBajhhjli2';
        c5.Email='mbahjhjhjh22@gmail.com';
        c5.Phone='0919898989899';
        conlist.add(c5);
        
        test.startTest();
        insert conlist;
        
        AddressAndContactCheck.getAddressAndContactStat(lll[0].Id);
        AddressAndContactCheck.getAddressAndContactStat(lll[1].Id);
        AddressAndContactCheck.getAddressAndContactStat(lll[2].Id);
        AddressAndContactCheck.getAddressAndContactStat(lll[3].Id);
        AddressAndContactCheck.getAddressAndContactStat(lll[4].Id);
        test.stopTest();
        }
        catch(Exception e){}
        
    }  
}