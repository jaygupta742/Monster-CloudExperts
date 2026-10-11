@isTest
public class Batch_AccountOwnerChnageTest {
    
    @isTest
    public static void startTest(){
        List<User> lstUser = [SELECT Id, Name, Profile_Name__c 
                              FROM User 
                              WHERE IsActive = true and Profile_Name__c ='Monster - Sales' LIMIT 1];
        
        System.debug('user : ' + lstUser);
        
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
        
        Trigger__c userSetting = new Trigger__c(name ='User',Active__c = true);
        lstTriggerSettings.add(userSetting);
        
        insert lstTriggerSettings;
        
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
        a.OwnerId = lstUser[0].id;
        insert a;
        
        startFuture(lstUser[0].id);
        
        String jobName = 'MyScheduledJob';
        String cronExp = '0 0 0 * * ?'; 
        
        Batch_AccountOwnerChnage batchJob = new Batch_AccountOwnerChnage();
        Database.executeBatch(batchJob,1);
        
        System.schedule(jobName, cronExp, new Batch_AccountOwnerChnage());
    }
    
    @future
    public static void startFuture(String user){
        
        List<User> lstUser = [SELECT Id, Name, Profile_Name__c 
                              FROM User 
                              WHERE Id =: user LIMIT 1];
        
        lstUser[0].isActive = false;
        update lstUser;

    }
}