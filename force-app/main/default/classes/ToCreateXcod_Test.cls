@isTest
public class ToCreateXcod_Test {
@isTest
    Public static void mytest(){
 
    Account a = new Account();
      a.name = 'Cloudexperts';
      a.SalesChannel__c = 'ECOMM';
      a.Segment__c = 'ECOMM';
      a.Import_Source__c = 'akbsaksa';
      a.APAC_Industry__c = 'Agriculture';
      a.No_of_Employees__c = 44;
      a.Account_Type__c = 'IT';
      a.Lead_Source1__c='CR';
      a.Location__c = 'Multi-Location';
      a.Website = 'www.ce.com';
      a.Phone ='+1234567890' ;
      a.OtherPhone__c='+1234567890';
      a.RegistrationNumber__c= 'akjbaks';
        insert a;
   
       
    Xcode__c x = new Xcode__c();
    x.Name = 'Test';
    x.Created_For_Account__c = a.id;
    insert x;
    }
}