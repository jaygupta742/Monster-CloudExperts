@isTest
public class KYC_Creation_From_Opp_ClassTest {
    
    public @istest static void mymethod(){
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        insert t1k;
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        insert t41;
        
        Account a = new Account();
        a.Name = 'oppnew';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Lead_Source1__c='ECOMM';
        a.Website='www.asdfert.com';
        a.Phone= '+985478547256';
        a.OtherPhone__c = '+985478547856';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
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
        a.OwnerId = userinfo.getUserId();
        
        insert a;
        
        
        
        Account a1 = new Account();
        a1.Name = 'oppnew';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='sssss';
        a1.Lead_Source__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Lead_Source1__c='ECOMM';
        a1.Website='www.asdfert.com';
        a1.Phone= '+985478547256';
        a1.OtherPhone__c = '+985478547856';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c = 'On Hold - Finance';
        a1.BillingCountry='India' ; 
        a1.BillingState='Karnataka';
        a1.BillingStreet ='Test Address';
        a1.BillingCity ='bangalore' ;
        a1.BillingPostalCode='560076'; 
        a1.ShippingCountry='India';
        a1.BillCountry__c = 'India';
        a1.BillState__c = 'Karnataka';
        a1.PostCountry__c = 'India';
        a1.PostState__c = 'Karnataka';
        a1.ShippingStreet ='Test Address';
        a1.ShippingCity ='bangalore' ;
        a1.ShippingPostalCode='560076'; 
        a1.OwnerId = userinfo.getUserId();
        insert a1;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;    
        
        Contact c1 = new Contact();
        c1.AccountID= a.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='9898989898';
        c1.PrimaryServiceContact__c=true;
        insert c1;
        
        a.Lead_Account_Status__c='Active';
        Update a;        
        
        
        
        
        /* Opportunity__c o = new Opportunity__c();
o.Account__c=a.id;
o.Contact__c = c.id;
o.Name__c ='oppnewd';
o.Probability__c = '0';
o.CreatedDate = date.newInstance(2018, 11,11);
o.Close_Date__c=system.today();
o.OwnerId = a.OwnerId;
o.OpportunityType__c='New customer';

o.Products_Interested__c = 'Branding';
o.Branding_Revenue__c =0;


o.Products_Interested__c ='Custom International Sponsorship';
o.Custom_International_Sponsorship_Reven__c= 0;


o.Products_Interested__c = 'Custom Job Template';
o.Custom_Job_Template_Revenue__c= 0;

o.Products_Interested__c = 'Custom Sponsorship';
o.Custom_Sponsorship_Revenue__c= 0;

o.Products_Interested__c = 'Job Postings';
o.Products_Interested__c ='Trail-Job Postings'; 
o.Job_Postings_Revenue__c= 0;


o.Products_Interested__c = 'Logo on Job Postings';
o.Logo_on_Job_Postings_Revenue__c=0;

o.Products_Interested__c = 'Monster Mirror';
o.Monster_Mirror_Revenue__c= 0;

o.Products_Interested__c = 'Monster Widget';
o.Monster_Widget_Revenue__c = 0;

o.Products_Interested__c = 'Premium Resume Search';
o.Premium_Resume_Search_Revenue__c= 0;

o.Products_Interested__c = 'Promotional Offer';
o.Promotional_Offer_Revenue__c= 0;


o.Products_Interested__c = 'Short Message Service';
o.Short_Message_Service_Revenue__c= 0;


o.Products_Interested__c = 'Social Job Ads';
o.Social_Job_Ads_Revenue__c= 0;

o.Products_Interested__c = 'TalentBin by Monster';
o.TalentBin_by_Monster_Revenue__c= 0;

o.Products_Interested__c = 'Target Mailers';
o.Target_Mailers_Revenue__c= 0;


o.Products_Interested__c = 'Walk-in-Pro Event';
o.Walk_in_Pro_Event_Revenue__c= 0;


o.Products_Interested__c = 'Monster Assessments';
o.Monster_Assessments_Revenue__c = 0;


o.Products_Interested__c = 'QHire';
o.QHire_Revenue__c= 0;


o.Products_Interested__c = 'Trial-Job-Postings';





*/     
        
        
        OpportunityN__c no = new OpportunityN__c();
        no.Account__c= a.id;
        no.Contact__c=c.id;
        insert no;
        
        Client_Validation_Request__c cvr = new Client_Validation_Request__c();
        cvr.Account__c = a.id;
        cvr.Contact__c = c.id;
        cvr.Contact_Email_Address__c = 'kaleabhijeet678@gmail.com';
        cvr.Tel_Number__c = '7066025087';
        cvr.GST_ID__c = '65545444';
        cvr.PAN_Number__c = '5685465433';
        cvr.Account_Registration_Number__c = '57595765';
        cvr.Stage__c='closed';
        insert cvr;                
        
        ///////////////////////////////
        //
        Client_Validation_Request__c cv = new Client_Validation_Request__c();
        cv.Account__c = a.id;
        cv.Contact__c = c.id;
        cv.ID_Proof__c ='Aadhaar Card';
        cv.Aadhaar_Number__c ='a1224f';
        cv.Aadhar_Card_Name__c ='adhar';
        
        //    cv.RecordTypeId = Apprvdtrectyp;
        cv.Stage__c = '';
        cv.Status__c ='';
        insert cv;
        cv.Stage__c = 'Submitted';
        cv.Status__c = 'Open';
        update cv;
        
        
        
        
        
        // KYC_Creation_From_Opp_Class.createnewcvr(a.id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a.id);
        
        c.Email='sp@sp.com';
        c.PrimarySalesContact__c=true;
        update c;
        // KYC_Creation_From_Opp_Class.createnewcvr(a.id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a.id);
        
        a.ClientValidationCheck__c=false;
        update a;
        cv.Status__c = 'Approved';
        cv.Stage__c = 'Closed';
        update cv;
        
        // KYC_Creation_From_Opp_Class.createnewcvr(a.id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a.id);
        a.AccountStatus__c ='Lapsed Customer';
        a.ClientValidationCheck__c=true;
        update a;
        // KYC_Creation_From_Opp_Class.createnewcvr(a.id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a.id);
        c1.PrimarySalesContact__c=false;
        update c1;
        // KYC_Creation_From_Opp_Class.createnewcvr(a.id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a.id);
        
        // KYC_Creation_From_Opp_Class.getRecord(o.id);
        
        KYC_Creation_From_Opp_Class cc=new KYC_Creation_From_Opp_Class();
        KYC_Creation_From_Opp_Class.savekyc(no);
        KYC_Creation_From_Opp_Class.getRecord(no.Id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a.Id);
        KYC_Creation_From_Opp_Class.create_new_kyc(a1.Id);

    }
}