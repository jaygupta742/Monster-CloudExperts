/*Created BY : Abdul Aziz
* Created Date : 21/07/2023*/
@istest public class UpdateAccountStatusScheduleTest {
    @istest public static void testdata1(){  
        list<Trigger__c> lstTriggerSettings = new list<Trigger__c>();
        
        Trigger__c AccountSettings = new Trigger__c(Name = 'Account', Active__c = false); 
        lstTriggerSettings.add(AccountSettings);
        
        Trigger__c ContactSettings = new Trigger__c(name ='Contact',Active__c = false);
        lstTriggerSettings.add(ContactSettings);
        
        Trigger__c OpportunitySettings = new Trigger__c(name ='Opportunity',Active__c = false);
        lstTriggerSettings.add(OpportunitySettings);
        
        Trigger__c CVRSettings = new Trigger__c(name ='CVR',Active__c = false);
        lstTriggerSettings.add(CVRSettings);
        
        Trigger__c QuoteSettings = new Trigger__c(name ='Quote',Active__c = false);
        lstTriggerSettings.add(QuoteSettings);
        
        Trigger__c ShareOrderSettings = new Trigger__c(name ='Share Order', Active__c = false);
        lstTriggerSettings.add(ShareOrderSettings);
        
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = false);
        lstTriggerSettings.add(SharePortfolio);

        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        lstTriggerSettings.add(QuoteLineItems);

        Trigger__c OrderItem = new Trigger__c(name ='OrderItem', Active__c = false);
        lstTriggerSettings.add(OrderItem);
        
        Trigger__c Order = new Trigger__c(name ='Order', Active__c = false);
        lstTriggerSettings.add(Order);
        
        Insert lstTriggerSettings;
        
        Profile StandardUserProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 

        List<User> lstUsers = new List<User>();        
        User user1 = new User(
            Alias = 'user1', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Debasis Das', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = StandardUserProfile.Id, 
            TimeZoneSidKey = 'America/Los_Angeles',
            username = 'testuser1@foundit.com',
            email = 'testuser1@foundit.com',
            Channel__c = 'EA'
        );
        lstUsers.add(user1);
        
        User user2 = new User(
            Alias = 'user2', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Abdul Aziz', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = StandardUserProfile.Id, 
            TimeZoneSidKey = 'America/Los_Angeles',
            username = 'testuser2@foundit.com',
            email = 'testuser2@foundit.com',
            Channel__c = 'EA'
        );
        lstUsers.add(user2);
        
        User user3 = new User(
            Alias = 'user3', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Developer 1', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = StandardUserProfile.Id, 
            TimeZoneSidKey = 'America/Los_Angeles',
            username = 'testuser3@foundit.com',
            email = 'testuser3@foundit.com',
            Channel__c = 'EA'
        );
        lstUsers.add(user3);        
        Insert lstUsers;
        
        Account Wipro = new Account();
        Wipro.Name = 'Wipro';
        Wipro.SalesChannel__c = 'ECOMM';
        Wipro.Import_Source__c = 'sssss';
        Wipro.Lead_Source__c = 'Other';
        Wipro.APAC_Industry__c = 'Energy';
        Wipro.No_of_Employees__c = 25;
        Wipro.Account_Type__c = 'NIT';
        Wipro.Location__c = 'India';
        Wipro.Lead_Source1__c = 'ECOMM';
        Wipro.Website = 'www.wipro.com';
        Wipro.Phone = '+985478547256';
        Wipro.OtherPhone__c = '+985478547856';
        Wipro.RegistrationNumber__c = 'asq111111';
        Wipro.Lead_Account_Status__c = 'Inactive';
        Wipro.CreditStatus__c = 'OK';
        Wipro.BillingCountry = 'India' ; 
        Wipro.BillingState = 'Karnataka';
        Wipro.BillingStreet = 'Test Address';
        Wipro.BillingCity = 'bangalore' ;
        Wipro.BillingPostalCode = '560076'; 
        Wipro.ShippingCountry = 'India';
        Wipro.BillCountry__c = 'India';
        Wipro.BillState__c = 'Karnataka';
        Wipro.PostCountry__c = 'India';
        Wipro.PostState__c = 'Karnataka';
        Wipro.ShippingStreet = 'Test Address';
        Wipro.ShippingCity = 'bangalore' ;
        Wipro.ShippingPostalCode = '560076'; 
        Wipro.OwnerId = userinfo.getUserId();
        insert Wipro;
        
        
        Contact con1 = new Contact();
        con1.AccountId = Wipro.Id;
        con1.LastName = 'MahendraBaahubali';
        con1.Email = 'mbahu@gmail.com';
        con1.Phone = '9898989898';
        con1.PrimarySalesContact__c = true;
        insert con1;  
                
        Wipro.Lead_Account_Status__c = 'Active';
        Wipro.Account_Expiration_Date__c = Date.today().addDays(-1); 
        Wipro.Slippage_End_Date__c = Date.today().addDays(-1);
        update Wipro;
        
        test.startTest();
        UpdateAccountStatusSchedule obj=new UpdateAccountStatusSchedule();
        obj.updateAccountStatusLapsed();
        String cronexp = '0 0 1 * * ? *';
        System.schedule('UpdateAccountStatusScheduletest', cronexp, new UpdateAccountStatusSchedule());
        test.stopTest();
        
    }
    
}