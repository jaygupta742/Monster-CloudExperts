@isTest
public class AccountTrigger_test {
    
    @isTest
    static void met(){
        
        User u = [SELECT id,name,Profile_Name__c FROM user WHERE IsActive = true and Profile_Name__c ='Monster - Sales Ops/LM' limit 1];
        
        Profile p = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'Monster - Seeker Certification Sales'
            LIMIT 1
        ];
        
        User newUser = new User();
        newUser.LastName = 'Jay T';
        newUser.ProfileId = p.Id;
        newUser.Email = 'js@js.com';
        newUser.Username = 'js@js.com.' + System.currentTimeMillis(); // ensure uniqueness
        newUser.Alias = 'jst';
        
        // Required fields
        newUser.TimeZoneSidKey = 'Asia/Kolkata';
        newUser.LocaleSidKey = 'en_IN';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        
        insert newUser;

        
        system.debug('sales user-->'+u);
        
        List<Trigger__c> lstTriggerSettings = new List<Trigger__c>();
        
        Trigger__c Account = new Trigger__c(name ='Account',Active__c = true);
        lstTriggerSettings.add(Account);

        Trigger__c Quote = new Trigger__c(name ='Quote',Active__c = true);
        lstTriggerSettings.add(Quote);
        
        Trigger__c Attachment = new Trigger__c(name ='Attachment',Active__c = true);
        lstTriggerSettings.add(Attachment);

        Trigger__c Opportunity = new Trigger__c(name ='Opportunity',Active__c = true);
        lstTriggerSettings.add(Opportunity);
        
        Trigger__c Order = new Trigger__c(name ='Order',Active__c = true);
        lstTriggerSettings.add(Order);
        
        Trigger__c Contact = new Trigger__c(name ='Contact',Active__c = true);
        lstTriggerSettings.add(Contact);
        
        trigger__c EmailMessage = new trigger__C(name='EmailMessage',Active__c = true);
        lstTriggerSettings.add(EmailMessage);
        
        Trigger__c CaseSetting = new Trigger__c(name ='Case',Active__c = true);
        lstTriggerSettings.add(CaseSetting);
        
        insert lstTriggerSettings;
        
        
        Test.startTest();

        Account a = new Account();
        a.Name = 'Testaccount';
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
        a.BillCountry__c='India' ; //To change Address from Object to Standard Address in Account
        a.BillState__c='Karnataka';
        a.PostCountry__c ='India' ;
        a.PostState__c='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingStreet='street1';
        a.BillingPostalCode='560076';  
        a.ShippingCity='bangalore' ;
        a.ShippingPostalCode ='560076'; 
        a.ShippingStreet= 'shippingstreet';
        a.TDS_Credit_Status__c='On Hold TDS';
        a.Segment__c = 'Commercial';
        a.Lead_Source1__c= 'Call Inbound';
        a.OwnerId = u.id;
        a.Page_URL__c = 'https://www.foundit.my/career-services/certification-programs/post-graduate-certificate-data-science-ai-executive';
        insert a;
        
        Account_Team_Member__c at = new Account_Team_Member__c();
        at.AccountId__c = a.id;
        at.Sales_Channel__c = a.SalesChannel__c;
        at.Segment__c = a.Segment__c;
        at.UserId__c = a.ownerid;
        insert at;
        
        Contact c = new Contact();
        c.AccountID = a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='+919898989898';
        insert c;
        
        a.Lead_Account_Status__c = 'Active';
        try{
            update a;
        }
        catch(exception e){}
        
        delete a;
        undelete a;
        
        test.stopTest();
        
    }
    
}