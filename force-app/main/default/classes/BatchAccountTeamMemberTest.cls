/*Created By : Abdul Aziz 
Created Date : 6-apr-2023*/

@isTest
public class BatchAccountTeamMemberTest {
    
    public @istest static void mycreatequotemethod(){
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        insert t1k;
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        insert t41;
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        insert tk;
        Trigger__c creatEmail = new Trigger__c(name = 'EmailMessage', Active__c = true);
        insert creatEmail;
        
        User uu=[select id,name,User_Channel__c,Channel__c from User where id=:userinfo.getUserId()];
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        User uu1 = new User(Alias = 'absduu', 
                            EmailEncodingKey='UTF-8', 
                            LastName='sdscuu', 
                            LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', 
                            ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles',
                            username = 'absduu@start.com',
                            email='bapi98deba@gmail.com',
                            Channel__c='BFSI',
                            ManagerId = userinfo.getUserId()                            
                           );
        ulist.add(uu1);
        insert ulist;
        
        Account a = new Account();
        a.Name = 'Debasis Das';
        a.SalesChannel__c = 'EA';
        a.Import_Source__c='Import_Source__c';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Internet';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='IT';
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
        
        User user1=[select id,name from User where name='Induja A' limit 1];
        Account_Team_Member__c atm1=new Account_Team_Member__c();
        atm1.AccountId__c=a.id;
        atm1.UserId__c=user1.Id;
        insert atm1;
        
        Test.startTest();
        System.schedule('BatchAccountTeamMemberScheduler', '0 0 * * * ? *', New BatchAccountTeamMemberScheduler());
        Test.stopTest();
    }
}