@istest
public class CVRHandler_test {
    @istest
    public static void cvrmrthod(){
        
        Trigger__c te = new Trigger__c(name ='CVR',Active__c = true);
        insert te;
        
        Trigger__c te1 = new Trigger__c(name ='Account',Active__c = true);
        insert te1;
        
        
        Trigger__c tc = new Trigger__c(name ='Contact',Active__c = true);
        insert tc;
        
        
  // RecordType aprt = [select id from RecordType where name = 'Approved' AND sObjectType ='Client_Validation_Request__c' ];
   id Apprvdtrectyp = schema.SObjectType.Client_Validation_Request__c.getRecordTypeInfosByName().get('Approved').getRecordTypeId();
        
       // scenario 1 
        Account a = new Account();
         a.Name = 'Account';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.SalesChannel__c ='ECOMM';
        
        a.Change_Segment__c = false;
        a.Segment__c ='ecomm';
        
         a.Person_Account__c = false ;
         a.Case_Accounts__c = false;
        
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a.BillingStreet ='Test Address';
         a.BillingCity ='bangalore' ;
         a.BillingState='Karnataka';
         a.BillingPostalCode='560076';
        
         a.ShippingCountry ='India';
         a.ShippingStreet ='vega street';
         a.ShippingCity ='ubcity';
         a.ShippingState = 'ourstate';
         a.ShippingPostalCode ='45555555';
        insert a;
       
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.MobilePhone ='0437723584';
        c.PrimarySalesContact__c=true;
        insert c;
        
         a.Lead_Account_Status__c='Active';
        update a;
      
        
        Client_Validation_Request__c cv = new Client_Validation_Request__c();
        cv.Account__c = a.id;
        cv.Contact__c = c.id;
        cv.ID_Proof__c ='Aadhaar Card';
        cv.Aadhaar_Number__c ='a1224f';
        cv.Aadhar_Card_Name__c ='adhar';
        
        cv.RecordTypeId = Apprvdtrectyp;
        cv.Stage__c = '';
         cv.Status__c ='';
        insert cv;
        cv.Stage__c = 'Submitted';
        cv.Status__c = 'Open';
        update cv;
        
       Client_Validation_Request__c cv1 = new Client_Validation_Request__c();
        cv1.Account__c = a.id;
        cv1.Contact__c = c.id;
        cv1.ID_Proof__c ='Aadhaar Card';
        cv1.Aadhaar_Number__c ='a1224f';
        cv1.Aadhar_Card_Name__c ='adhar';
       
        cv1.RecordTypeId = Apprvdtrectyp;
        cv1.Reference__c = 'unvalidated';
        cv1.Related_Accounts__c = 'A-19864107';
        insert cv1;
      
       cv1.RecordTypeid = Apprvdtrectyp;
        update cv1; 
        
        
      // scenario-2
        Account a1 = new Account();
         a1.Name = 'Account';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='sssss';
        a1.Lead_Source1__c='CR';
        a1.Segment__c = 'ECOMM';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Website='www.asdfert.com';
        a1.Phone= '+917878787878';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='OK';
        a1.SalesChannel__c ='ECOMM';
        
        a1.Change_Segment__c = false;
        a1.Segment__c ='ecomm';
        
         a1.Person_Account__c = false ;
         a1.Case_Accounts__c = false;
        
        a1.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a1.BillingStreet ='Test Address';
         a1.BillingCity ='bangalore' ;
         a1.BillingState='Karnataka';
         a1.BillingPostalCode='560076';
        
         a1.ShippingCountry ='India';
         a1.ShippingStreet ='vega street';
         a1.ShippingCity ='ubcity';
         a1.ShippingState = 'ourstate';
         a1.ShippingPostalCode ='45555555';
        
        insert a1;
         
        Contact c1 = new Contact();
        c1.AccountID= a1.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='9898989898';
        c1.MobilePhone ='0437723584';
        c1.PrimarySalesContact__c=true;
        insert c1;
        
        a1.Lead_Account_Status__c='Active';
        update a1;
        
        Client_Validation_Request__c cv2 = new Client_Validation_Request__c();
        cv2.Account__c = a1.id;
        cv2.Contact__c = c1.id;
        cv2.ID_Proof__c ='Aadhaar Card';
        cv2.Aadhaar_Number__c ='a1224f';
        cv2.Aadhar_Card_Name__c ='adhar';
      
        cv2.RecordTypeId = Apprvdtrectyp;
        cv2.Stage__c = '';
         cv2.Status__c ='';
        insert cv2;
        cv2.Stage__c = 'Submitted';
        cv2.Status__c = 'Open';
        cv2.Related_Accounts__c = 'A-19864107';
        update cv2;
        
         Client_Validation_Request__c cv3 = new Client_Validation_Request__c();
        cv3.Account__c = a1.id;
        cv3.Contact__c = c1.id;
        cv3.ID_Proof__c ='Aadhaar Card';
        cv3.Aadhaar_Number__c ='a1224f';
        cv3.Aadhar_Card_Name__c ='adhar';
        
        cv3.RecordTypeid = Apprvdtrectyp;
        cv3.Reference__c = 'unvalidated';
        insert cv3;
        
        cv3.RecordTypeid = Apprvdtrectyp;
        cv3.Related_Accounts__c = 'A-19864107';
        update cv3;
        
        
      //scenario-3
      
         // scenarion -3 
       Account a2 = new Account();
         a2.Name = 'Account';
        a2.SalesChannel__c = 'ECOMM';
        a2.Import_Source__c='sssss';
        a2.Lead_Source1__c='CR';
        a2.Segment__c = 'ECOMM';
        a2.APAC_Industry__c='Energy';
        a2.No_of_Employees__c= 25;
        a2.Account_Type__c='NIT';
        a2.Location__c='India';
        a2.Website='www.asdfert.com';
        a2.Phone= '+917878787878';
        a2.RegistrationNumber__c='asq111111';
        a2.Lead_Account_Status__c='Inactive';
        a2.CreditStatus__c='OK';
        a2.SalesChannel__c ='ECOMM';
        a2.Change_Segment__c = false;
        a2.Segment__c ='ecomm';
        a2.Person_Account__c = false ;
         a2.Case_Accounts__c = false;
        
        
        a2.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a2.BillingStreet ='Test Address';
         a2.BillingCity ='bangalore' ;
         a2.BillingState='Karnataka';
         a2.BillingPostalCode='560076';
        
         a2.ShippingCountry ='India';
         a2.ShippingStreet ='vega street';
         a2.ShippingCity ='ubcity';
         a2.ShippingState = 'ourstate';
         a2.ShippingPostalCode ='45555555';
        
        
        
        insert a2;
       
        Contact c2 = new Contact();
        c2.AccountID= a2.Id;
        c2.LastName='MahendraBaahubali';
        c2.Email='mbahu@gmail.com';
        c2.Phone='9898989898';
        c2.MobilePhone ='0437723584';
        c2.PrimarySalesContact__c=true;
        insert c2;
        
        
         a2.Lead_Account_Status__c='Active';
        update a2;
        
      Client_Validation_Request__c cv4 = new Client_Validation_Request__c();
        cv4.Account__c = a2.id;
        cv4.Contact__c = c2.id;
        cv4.ID_Proof__c ='Aadhaar Card';
        cv4.Aadhaar_Number__c ='a1224f';
        cv4.Aadhar_Card_Name__c ='adhar';
      
        cv4.RecordTypeid = Apprvdtrectyp;
        cv4.Stage__c = '';
         cv4.Status__c ='';
        insert cv4;
   
        cv4.Stage__c = 'Submitted';
                cv4.Status__c = 'Open';
        cv4.Related_Accounts__c = 'A-19864107';
        update cv4;
        
        Client_Validation_Request__c cv5 = new Client_Validation_Request__c();
        cv5.Account__c = a2.id;
        cv5.Contact__c = c2.id;
        cv5.ID_Proof__c ='Aadhaar Card';
        cv5.Aadhaar_Number__c ='a1224f';
        cv5.Aadhar_Card_Name__c ='adhar';
        
        cv5.RecordTypeid = Apprvdtrectyp;
        cv5.Reference__c = 'unvalidated';
        insert cv5;
        
        cv5.RecordTypeid = Apprvdtrectyp;
        cv5.Related_Accounts__c = 'A-19864107';
        update cv5;
        
             
    }

}