@istest
public class ActivityCreateFromAccount_test {
    @isTest
    public static void setData(){
        
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        tlist.add(t41);
        
        Trigger__c tk1 = new Trigger__c(name ='Quote',Active__c = true);
        tlist.add(tk1);
        
        Trigger__c tshareorder = new Trigger__c(name ='Share Portfolio', Active__c = true);
        tlist.add(tshareorder);
        Trigger__c triggerr = new Trigger__c(name ='EmailMessage', Active__c = true);
        tlist.add(triggerr);
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        
        
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser@example.com' + System.currentTimeMillis(),
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
        
        Task tk = new Task();
        tk.ActivityDate = System.today();
		tk.Description__c = 'Descripiton';
   		tk.Disposition_Type__c = 'Disposition_Type';
		tk.Feedback_By_Sales__c = 'Closed';
        tk.Priority = 'High';
        tk.Remarks__c = 'Disposition_Type Remark';
        tk.Status = 'Completed';
        tk.Sub_Disposition_Type__c = 'Sub_Disposition_Type';
        tk.Subject = 'Contact has been Created successfully';
        tk.Task_Type__c = 'Demo';
        tk.recording_url__c = 'aaaaaaaaadsafdfdsffeafdabvkjdsvblsvbsv svbsdbvsdjknvbsdvhsdvnsdvsdvsdjvghsbsdvhsdvnsdvsdvsdjvghsovhslvhsovhds.vhs.vhs.vhoshvsvasvsbvsisvbsdbvsdjknvbsdvhsdvnsdvsdvsdjvghsbsdvhsdvnsdvsdvsdjvghsovhslvhsovhds.vhs.vhs.vhoshvsvasvsbvsi';
        
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
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;  
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        
        OpportunityN__c op1=new OpportunityN__c();
        op1.Account__c = a.Id;
        op1.Actual_Revenue__c = 122431;
        op1.Stage__c = 'Identification';
        op1.Close_Date__c = system.today();
        op1.Closure_Week__c = 'Week-1';
        op1.Closure_probablity__c = 'Will';
        op1.Expected_Revenue__c =100000;
        op1.Opportunity_Type__c = 'Upsell';
        op1.Price_Master__c =pm.id;
        op1.Contact__c = c.id;
        
        insert op1;
        
        Test.starttest();
        ActivityCreateFromAccount.createActivity(tk, t.Id, testUser.Id, '', '', testUser.Id, 'test','Online','');
        ActivityCreateFromAccount.getLatestOpportunityRecord(a.Id);
        ActivityCreateFromAccount.getUserData();
        Test.stopTest();
    }
    
    @isTest
    public static void getAccountSuspect_test(){
         Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Segment__c='ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        a.Suspect_Prospect__c='Prospect';
        insert a;
        
        Test.starttest();
        ActivityCreateFromAccount.updateAccountStat(a.id,'Prospect');
        ActivityCreateFromAccount.getAccountSuspect(a.id);
        Test.stopTest();
    }
}