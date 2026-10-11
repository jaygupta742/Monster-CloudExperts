@isTest
public class Batch_SharePorfolioWithNewAcc_Test {
    @isTest
    public static void testBatch(){
        List<User> lstUser = [SELECT Id, Name, Profile_Name__c 
                              FROM User 
                              WHERE IsActive = true and Profile_Name__c ='Monster - Sales Ops/LM' LIMIT 2];
        
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
        update a;
        
        Price_Master__c INR = new Price_Master__c();
        INR.Name = 'INR';
        insert INR;
        
        list<OpportunityN__c> lstOpportunity = new list<OpportunityN__c>();
        OpportunityN__c opp1 = new OpportunityN__c();
        opp1.Account__c = a.Id;
        opp1.Contact__c = c.Id;
		opp1.Price_Master__c = INR.Id;
        opp1.Opportunity_Type__c = 'Free Trial';
        opp1.Closure_probablity__c = 'Will';
        opp1.Stage__c = 'Identification';
        opp1.Close_Date__c = Date.today();
        opp1.Expected_Revenue__c = 1200;
        opp1.OwnerId = lstUser[0].Id;
        lstOpportunity.add(opp1);
        
        OpportunityN__c opp2 = new OpportunityN__c();
        opp2.Account__c = a.Id;
        opp2.Contact__c = c.Id;
		opp2.Price_Master__c = INR.Id;
        opp2.Opportunity_Type__c = 'Free Trial';
        opp2.Closure_probablity__c = 'Will';
        opp2.Stage__c = 'Identification';
        opp2.Close_Date__c = Date.today();
        opp2.Expected_Revenue__c = 1200;
        opp2.OwnerId = lstUser[1].Id;
        lstOpportunity.add(opp2);
        
        insert lstOpportunity;        
        
        QuotesN__c quote1 = new QuotesN__c();
        quote1.Account__c = a.Id;
        quote1.Price_Master__c = INR.Id;
        quote1.Opportunities__c = opp1.Id;
        quote1.Contact__c = c.Id;
        quote1.Quote_Type__c = 'New Customer';
        quote1.CurrencyIsoCode = 'INR';
        quote1.Selling_Country__c = 'India';
        quote1.Start_Date__c = date.today();
        quote1.End_Date__c = date.today().addDays(30);
        
        QuotesN__c quote2 = new QuotesN__c();
        quote2.Account__c = a.Id;
        quote2.Price_Master__c = INR.Id;
        quote2.Opportunities__c = opp2.Id;
        quote2.Contact__c = c.Id;
        quote2.Quote_Type__c = 'New Customer';
        quote2.CurrencyIsoCode = 'INR';
        quote2.Selling_Country__c = 'India';
        quote2.Start_Date__c = date.today();
        quote2.End_Date__c = date.today().addDays(30);
        
        List<QuotesN__c> lstQuote = new List<QuotesN__c> ();
        lstQuote.add(quote1);
        lstQuote.add(quote2);
        insert lstQuote;
            
        a.OwnerId = lstUser[1].id;
        Update a;

        //Database.executeBatch(New Batch_SharePorfolioWithNewAcc(lstAccount, lstAccount, null, null), 1);        
    }
}