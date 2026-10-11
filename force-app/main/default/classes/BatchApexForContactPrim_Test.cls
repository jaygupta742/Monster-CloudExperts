@istest(seealldata=true)
public class BatchApexForContactPrim_Test {
    
    public static testmethod void test()
    {
       LIst<Account> ac= new List<Account>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
       
        ac.add(a);
        
        Account a1 = new Account();
        a1.Name = 'ANKSkkkakka';
        a1.Person_Account__c = False;
        a1.OtherPhone__c='+919110455258';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='sssss';
        a1.Lead_Source__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Website='www.asdfertww.com';
        a1.Phone= '+917878787873';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='OK';
        a1.ShippingCity='Bangalore';
        a1.ShippingCountry='India';
        a1.ShippingPostalCode='560000';
        a1.ShippingState='Karnataka';
        a1.ShippingStreet='BTM';
        a1.BillingCity='Bangalore';
        a1.BillingCountry='India';
        a1.BillingPostalCode='560000';
        a1.BillingPostalCode='Karnataka';
        a1.BillingStreet='BTM';
        a1.Segment__c='Corporate';
        a1.Lead_Source1__c='CR';
        
        ac.add(a1);
        
         Account a11 = new Account();
        a11.Name = 'ANKSkkkakkdda';
        a11.OtherPhone__c='+919114552741';
        a11.SalesChannel__c = 'ECOMM';
        a11.Import_Source__c='sssss';
        a11.Person_Account__c = False;
        a11.Lead_Source__c='Other';
        a11.APAC_Industry__c='Energy';
        a11.No_of_Employees__c= 25;
        a11.Account_Type__c='NIT';
        a11.Location__c='India';
        a11.Website='www.asdfertweew.com';
        a11.Phone= '+917878787866';
        a11.RegistrationNumber__c='asq111111';
        a11.Lead_Account_Status__c='Inactive';
        a11.CreditStatus__c='OK';
        a11.ShippingCity='Bangalore';
        a11.ShippingCountry='India';
        a11.ShippingPostalCode='560000';
        a11.ShippingState='Karnataka';
        a11.ShippingStreet='BTM';
        a11.BillingCity='Bangalore';
        a11.BillingCountry='India';
        a11.BillingPostalCode='560000';
        a11.BillingPostalCode='Karnataka';
        a11.BillingStreet='BTM';
        a11.Segment__c='Corporate';
        a11.Lead_Source1__c='CR';
        
        ac.add(a11);
        
        insert ac; 
        
        List<Contact> con = new List<Contact>();
        Contact c = new Contact();
        c.AccountId=ac[0].id;
        c.LastName= 'VSH';
        c.PrimarySalesContact__c=false;
       con.add(c); 
        
        Contact c1 = new Contact();
        c1.AccountId=ac[1].id;
        c1.LastName= 'VSH';
        c1.PrimarySalesContact__c=false;
       con.add(c1); 
        
        
        Contact c11 = new Contact();
        c11.AccountId=ac[1].id;
        c11.LastName= 'VSH1';
        c11.PrimarySalesContact__c=false;
       con.add(c11); 
        
        Contact c111 = new Contact();
        c111.AccountId=ac[2].id;
        c111.LastName= 'VSH1';
        c111.PrimarySalesContact__c=false;
       con.add(c111);
        
         Contact c1111 = new Contact();
        c1111.AccountId=ac[2].id;
        c1111.LastName= 'VSH1';
        c1111.PrimarySalesContact__c=true;
       con.add(c1111);
        
        insert con;
        
        BatchApexForContactPrim b = new BatchApexForContactPrim();
        b.met();
        // ID batchprocessid = Database.executeBatch(b);
        
        
    }

}