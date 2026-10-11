/*
* Created By : Suraj 
* Created date : 07/10/2023
* Created For : This Is Test class use for  ContactDataRetriever apex class
*/ 
@Istest
public class ContactDataRetriever_Test {
    @istest
    Public static void testdata(){
        test.setMock(httpcalloutmock.class ,new MockHTTPCallout());
        
        List<Trigger__c> tt = new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name = 'Seeker',active__c = true);
        tt.add(t);
        
        Trigger__c t1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        tt.add(t1);
        
        Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
        tt.add(t2);
        
        Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
        tt.add(t3);
        
        Trigger__c t4 = new Trigger__c(name = 'Attachment',active__c = true);
        tt.add(t4);
        
        insert tt;
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        a.Team__c ='Edtech-Courses'; 
        insert a; 
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;  
        String[]  ss=New String[]{c.id};
            ContactDataRetriever.getContactData(ss); 
        
    }
}