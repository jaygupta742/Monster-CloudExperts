/*
* Created By : Suraj 
* Created date : 07/10/2023
* Created For : This Is Test class use for  ValidContactEmail apex class
*/ 
@Istest
public class ValidContactEmail_Test {
    @IsTest
    public Static void testdata(){
        
        test.setMock(httpcalloutmock.class ,new MockHTTPCallout());
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
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = true);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = true);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
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
        test.startTest();
        ValidContactEmail.validemail(c.id);
        
        try{        
            ValidContactEmail.validemail(a.id);
        }
        catch(Exception e){}
        test.stopTest();
    }
}