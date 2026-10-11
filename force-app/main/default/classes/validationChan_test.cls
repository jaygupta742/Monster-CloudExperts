@istest
public class validationChan_test {
    
    
    // developer name @Rj
     @istest
    
    
    public static void valmeth(){
        
        Trigger__c te = new Trigger__c(name ='CVR',Active__c = true);
        insert te;
        
        Trigger__c te1 = new Trigger__c(name ='Account',Active__c = true);
        insert te1;
        
        RecordType aprt1 = [select id from RecordType where name = 'Approved' AND sObjectType ='Client_Validation_Request__c' ];
        
        
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
        insert a;
       
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.MobilePhone ='0437723584';
        c.PrimarySalesContact__c=true;
        insert c;
          
   
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
        cv.RecordTypeId = aprt1.id ;
        cv.Stage__c = '';
         cv.Status__c ='';
        insert cv;

cv.Stage__c = 'Submitted';
                cv.Status__c = 'Open';
        update cv;
        List<String> lc = new List<string>();
        lc.add(cv.Id);
        validationChange.userchange(lc,cv.OwnerId);
        
    }

}