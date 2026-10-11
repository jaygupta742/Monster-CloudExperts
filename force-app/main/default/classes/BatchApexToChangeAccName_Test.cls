@IsTest
public class BatchApexToChangeAccName_Test {
	@Istest
    Public Static void mytestmeth(){
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        Account a = new Account();
        a.Name = 'Finalsumanprax';
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
        
        insert a;
        a.Name = 'test';
        //a.LastModifiedDate = system.today() - 1;
        a.Phone = '1234567980';
        update a;
        a.Name = 'pramd';
        a.Phone = '1122334455';
        update a;
        BatchApexToChangeAccName b = new BatchApexToChangeAccName();
        b.last_record = 'A-01015370';
        ID batchprocessid = Database.executeBatch(b);
    }
}