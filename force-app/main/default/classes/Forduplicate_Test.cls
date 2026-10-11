@istest
public class Forduplicate_Test {
	@istest
    public static void duplitestclass(){
        Account_Auto_Number__c aa = new Account_Auto_Number__c();
        aa.AUTO__c = 1;
        aa.Name = 'AUTO';
        insert aa;
        LIst<Account> ac= new List<Account>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.OtherPhone__c = '+917878787878';
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
        ac.add(a);
        
        Account a1 = new Account();
        a1.Name = 'ANKSkkkakka';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='sssss';
        a1.Lead_Source__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Website='www.asdfert.com';
        a1.Phone= '+917878787878';
        a1.OtherPhone__c = '+917878787878';
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
        ac.add(a1);
        insert ac;  
    }
}