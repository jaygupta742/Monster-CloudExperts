@isTest
public class getProfile_test {
@istest
public static void myTest() {
    Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
 Account a = new Account();
        a.Name = 'Testaccountdffff';
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
        a.ShippingCountry='India';
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        a.Segment__c = 'Commercial';
        a.Email__c='ssedd@gmail.com';
        
        a.Lead_Source1__c= 'Call Inbound';
        insert a;
    PA_Owner_Assignment__c p = new PA_Owner_Assignment__c();
        p.Name = '1';
        p.Location__c = 'India';
        p.Count__c = 0;
        p.UserId__c = '0057F000004RCwEQAW';
        insert p;
        Datetime dt = System.now();
PageReference pageRef = Page.GetProfile;
        //pageRef.getParameters().put('id',p.id);
        pageRef.getParameters().put('id',a.id);
        Test.setCurrentPage(pageRef);
    Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator12());
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator13());
getProfile rr=new getProfile();    
    
    
}
}