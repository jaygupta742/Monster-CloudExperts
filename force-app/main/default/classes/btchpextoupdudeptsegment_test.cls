@istest
public class btchpextoupdudeptsegment_test {
    
    public static testMethod void Testroc(){
        
        
        
       Trigger__c te = new Trigger__c(name ='Account',Active__c = true);
        insert te; 
        
        
        
        
        LIst<Account> ac= new List<Account>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.OtherPhone__c='+919110400258';
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
        insert ac; 
        
        btchpextoupdudeptsegment aa = new btchpextoupdudeptsegment();
         DataBase.executeBatch(aa); 
        

}
}