@istest
public class AvoidDeletingAttachFromUnauthUser_Test {
  @istest static void myTestPa(){
        
         List<Trigger__c> cs= new List<Trigger__c>();
            
            Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
            cs.add(t);
            Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
         Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
         cs.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
         cs.add(t2k);
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
         cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
         cs.add(t4);
                Trigger__c te = new Trigger__c(name ='CVR',Active__c = true);
              cs.add(te);
      insert cs;
        DeleteAttachment__c pp= new DeleteAttachment__c();
        pp.Granted__c=false;
        pp.Name=userInfo.getUserId();
      pp.UserId__c=userInfo.getUserId();
        insert pp;
       
        
        
        
        
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
        
        ContentVersion contentVersion = new ContentVersion(
      Title = 'Penguins',
      PathOnClient = 'Penguins.jpg',
      VersionData = Blob.valueOf('Test Content'),
      IsMajorVersion = true
    );
    insert contentVersion;

    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        try{
            delete documents;
        }
        catch(exception e){}
      
  
     
        
        
    }
}