@isTest
public class xcodeAccountUpdate_Test {
@isTest
    Public Static void mytest(){
   
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
        
        
        Xcode_Account__c xa = new Xcode_Account__c();
        xa= [select id,Is_Primary__c from Xcode_Account__c where Xcode__c=:x.Id];
        //System.debug('aaaaaaaaaaaaaaaa' +xa.size());
        xa.Is_Primary__c =true;
      
        
        update xa;

        
        
       
        Xcode__c x1 = new Xcode__c();
        x1.Name = 'Test';
        x1.Created_For_Account__c = a.id;
        insert x1;
        
        Xcode_Account__c xa1 = new Xcode_Account__c();
        xa1 = [select id,Is_Primary__c from Xcode_Account__c where Xcode__c=:x1.Id];
        xa1.Is_Primary__c =true;
        
        
        
        update xa1;
        
       
Xcode__c x11 = new Xcode__c();
        x11.Name = 'Test';
        x11.Created_For_Account__c = a.id;
        insert x11;   
        
        
        Xcode_Account__c xa11 = new Xcode_Account__c();
        xa11 = [select id,Is_Primary__c from Xcode_Account__c where Xcode__c=:x1.Id];
        xa11.Is_Primary__c =false;
       
        update xa11;
        
    }
}