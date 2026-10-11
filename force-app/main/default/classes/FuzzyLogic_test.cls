@istest
public class FuzzyLogic_test {
   
    @istest
    
  static void fuzmatchlog(){
        Trigger__c te1 = new Trigger__c(name ='Account',Active__c = true);
        insert te1;
      
      Trigger__c te2 = new Trigger__c(name ='Contact',Active__c = true);
        insert te2;
      
        Trigger__c te = new Trigger__c(name ='CVR',Active__c = true);
        insert te;
        
      Trigger__c att = new trigger__c(name ='Attachment',Active__c = true);
      insert att;
      
        RecordType aprt = [select id from RecordType where name = 'Approved' AND sObjectType ='Client_Validation_Request__c' ];
        
        
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
      a.Integration__c = false;
      
      a.BillCountry__c ='india';
      a.BillState__c = 'Karnataka';
      a.PostCountry__c = 'india';
      a.PostState__c='Karnataka';
      
         a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a.BillingStreet ='Test Address1';
         a.BillingCity ='bangaloree' ;
         a.BillingState='Karnataka';
         a.BillingPostalCode='560076';
       
        
         a.ShippingCountry ='India';
         a.ShippingStreet ='vega streett';
         a.ShippingCity ='ubcitye';
         a.ShippingState = 'Karnataka';
         a.ShippingPostalCode ='560076';
      
        insert a;
       
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.MobilePhone ='0437723584';
        c.PrimarySalesContact__c=true;
        insert c;
      
      a.Lead_Account_Status__c='active';
      update a;
          
   
        /*Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/
        
        Client_Validation_Request__c cv = new Client_Validation_Request__c();
        cv.Account__c = a.id;
        cv.Contact__c = c.id;
        cv.ID_Proof__c ='Aadhaar Card';
        cv.Aadhaar_Number__c ='a1224f';
        cv.Aadhar_Card_Name__c ='adhar';
        //cv.RecordTypeId ='0120k0000006Lqm';
        cv.RecordTypeId =aprt.id;
        cv.Stage__c = '';
         cv.Status__c ='';
        insert cv;
        
        cv.Stage__c = 'Submitted';
                cv.Status__c = 'Open';
        update cv;
        
        Validation_Review__c vr1 = new Validation_Review__c();
        vr1.Client_Validation_Request__c = cv.id;
        insert vr1;
        
        
        FuzzyLogic.generatecsv(cv.id);
        
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
      a1.Integration__c = false;
      
      
      
      
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
        
        a1.Lead_Account_Status__c='active';
      update a1;
      
        /*Address1__c addr1= new Address1__c();
        addr1.Account__c=a1.id;
        addr1.Country__c='Singapore';
        addr1.Type__c='Billing';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;*/
        
        
        
        Client_Validation_Request__c cv2 = new Client_Validation_Request__c();
        cv2.Account__c = a1.id;
        cv2.Contact__c = c1.id;
        cv2.ID_Proof__c ='Aadhaar Card';
        cv2.Aadhaar_Number__c ='a1224f';
        cv2.Aadhar_Card_Name__c ='adhar';
        //cv2.RecordTypeId ='0120k0000006Lqm';
        cv2.RecordTypeId =aprt.id;
        cv2.Stage__c = 'Submitted';
                cv2.Status__c = 'Open';
        insert cv2;
        
        Validation_Review__c vr = new Validation_Review__c();
        vr.Client_Validation_Request__c = cv2.id;
        insert vr;
        
        
        
       FuzzyLogic.generatecsv(cv2.id); 
        
    }
@istest
    public static void fuzlog2(){
        
        Trigger__c te12 = new Trigger__c(name ='Account',Active__c = true);
        insert te12;
        
         Trigger__c tcon = new Trigger__c(name ='Contact',Active__c = true);
        insert tcon;
        
        Trigger__c te1 = new Trigger__c(name ='CVR',Active__c = true);
        insert te1;
        
        
        
        Trigger__c att1 = new trigger__c(name ='Attachment',Active__c = true);
      insert att1;
        
RecordType aprt2 = [select id from RecordType where name = 'Approved' AND sObjectType ='Client_Validation_Request__c' ];
      // scenario 1 
        Account a1 = new Account();
         a1.Name = 'Account1';
        a1.SalesChannel__c = 'Fieldsales';
        a1.Import_Source__c='sourcewwe';
        a1.Lead_Source1__c='Email Inbound';
        a1.Segment__c = 'Government';
        a1.APAC_Industry__c='Biotechnology';
        a1.No_of_Employees__c= 100;
        a1.Account_Type__c='PA';
        a1.Location__c='Philippines';
        a1.Website='www.asdccc.com';
        a1.Phone= '+917878785847';
        a1.RegistrationNumber__c='asq11133';
        a1.Lead_Account_Status__c='inactive';
        a1.CreditStatus__c='Approved PrePay';
        a1.SalesChannel__c ='Fieldsales';
        
 
        a1.Change_Segment__c = false;
         
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
        
        
        
        Contact c3 = new Contact();
        c3.AccountID= a1.Id;
        c3.LastName='MahendraBaahubali';
        c3.Email='rjpramodh@gmail.com';
        c3.Phone='1235485269';
        c3.MobilePhone ='0437723258';
        c3.PrimarySalesContact__c=false;
        insert c3;
        
 a1.Lead_Account_Status__c='active'; 
        update a1;
        
        Contact c4 = new Contact();
        c4.AccountID= a1.Id;
        c4.LastName='MahendraBaahubali';
        c4.Email='rjpramodh@gmail.com';
        c4.Phone='1235485269';
        c4.MobilePhone ='0437723258';
        c4.PrimarySalesContact__c=false;
        insert c4;
        
        
        /*Address1__c addr2= new Address1__c();
        addr2.Account__c=a1.id;
        addr2.Country__c='India';
        addr2.state__c ='Rajasthan';
        addr2.Type__c='Billing';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Sing City';
        addr2.PinCode__c='114477';
        insert addr2;*/
        
        
        Client_Validation_Request__c cv3 = new Client_Validation_Request__c();
        cv3.Account__c = a1.id;
        cv3.Contact__c = c3.id;
        cv3.ID_Proof__c ='Aadhaar Card';
        cv3.Aadhaar_Number__c ='a1223e4f1';
        cv3.Aadhar_Card_Name__c ='adhar1qwe';
        //cv3.RecordTypeId ='0120k0000006Lqm';
        cv3.RecordTypeId =aprt2.id;
        cv3.Stage__c = 'Submitted';
                cv3.Status__c = 'Missing Information';
        insert cv3;
        
        
       FuzzyLogic.generatecsv(cv3.id);  
              
    }
    
}