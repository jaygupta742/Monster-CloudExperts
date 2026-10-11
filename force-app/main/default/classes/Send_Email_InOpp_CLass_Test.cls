@isTest
public class Send_Email_InOpp_CLass_Test {
    static testMethod void testMethod_c(){
        
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
        Trigger__c t3 = new trigger__c(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        
        insert cs;   
        
        //Create a user and insert it
        Profile pro = [select id from profile where name='Standard User'];
        User u = new User(alias = 'standt', email='standarduser6@testorg.com',
                          emailencodingkey='UTF-8', firstname='fake', lastname='Testing', languagelocalekey='en_US',
                          localesidkey='en_US', profileid = pro.Id,
                          timezonesidkey='America/Los_Angeles', username='standarduser6@testorg.com');
        insert u;

        //Create List of Accounts and insert it 
        list<Account> acclist=new list<Account>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'Enterprise Business';
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
        acclist.add(a);
        insert acclist; 
        
        //Create a contact under an account and insert it 
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
        //Create a Price Master and insert it 
        Price_Master__c pm=new Price_Master__c();
        pm.Name = 'INR Price Book';
        pm.CurrencyIsoCode = '';
        insert pm;
        
        //Create a product under this price master and insert it 
        ProductC__c p = new ProductC__c();
        p.Price_Master__c = pm.Id;
        //  p.Product_Type__c = 'RDA';
        //  p.Product_Name__c = 'Resume Database Access';
        p.Product_Code__c = 'RDAS1AE00N';
        p.Product_SKU_Code__c = 'RDAS1AE12M00NR1';
        p.UOM__c = '1 Qty/product';
        p.Unit_List_Price_Value__c = 1277500.00;
        p.Active__c = true;
        p.Channel__c = 'SMB';
        p.SKU_Type__c = 'Access-x';
        p.Product_Description__c = '20000';
        insert p;
        
        //Create a opportunity under an account and insert it
        OpportunityN__c o = new OpportunityN__c();
        o.Account__c = a.Id;
        o.Contact__c = c.Id;
        o.Price_Master__c = pm.Id;
        o.Opportunity_Type__c = 'Free Trial';
        o.Stage__c = 'Proposal Sent';
        o.Proposal_Date__c = Date.today();
        o.Actual_Revenue__c = 123456;
        o.OwnerId = u.Id;
        insert o;
        System.debug('TEST OPPORTUNITY ID : '+o.Id);
        Datetime dt = Datetime.now().addDays(-1);
        System.debug('TEST DT : '+ dt);
        Test.setCreatedDate(o.Id, dt);
        System.debug('TEST OPPORTUNITY CREATED DATE : '+o.CreatedDate);
        
        o = [SELECT Id, Name, RecordTypeId, Account__c, Contact__c, Xcode__c, Reason_Won_Lost__c, Stage__c, Probability__c, 
             Opportunity_Type__c, Price_Master__c, Remarks__c, Opportunity_Source__c, Closure_Week__c, Close_Date__c, 
             Closure_probablity__c, Multi_Year_Deal__c, Currency_NON_APAC__c, Estimated_Revenue_Non_APAC__c, 
             Estimated_Revenue_APAC__c, Expected_Revenue_NON_APAC__c, Opportunity_Lost_deferred__c, Expected_Revenue_APAC__c, 
             Actual_Revenue__c, Expected_Revenue__c, Previous_Stage__c, User_Channel__c, Opportunity_Number__c, Stage_Closed__c, 
             Negotiation_Date__c, Identification_Date__c, Proposal_Date__c, Closed_Won_Date__c, Expiration_Date__c, 
             Expired_Opportunity__c, OPLI_Count__c, CreatedDate, OwnerId, owner.email, Account__r.AccountID__c, owner.Name,
             Account__r.Name, Account__r.ShippingCity, Account__r.ShippingCountry, Contact__r.name, Account__r.SalesChannel__c
             FROM OpportunityN__c WHERE Id =: o.Id];
        
        System.debug('TEST OPPORTUNITY CREATED DATE : '+o.CreatedDate);
        System.debug('TEST OPPORTUNITY OWNER : '+o.OwnerId);
        System.debug('TEST OPPORTUNITY OWNER EMAIL : '+o.owner.email);
        
        String body = 'Test Body';
        String auth = 'Test Auth';
        String need = 'Test Need';
        String timing = 'Test timing';
        String poten = 'Test poten';
        String rid = o.Id;
        String cc = 'testcc@gmail.com';
        String to = 'testto@gmail.com';
        String com = 'Test com';
        
        Test.startTest();
        
        Send_Email_InOpp_CLass.getOPLI(o.Id);
        Send_Email_InOpp_CLass.getToAddress(o.Id);
        Send_Email_InOpp_CLass.getCCAddress(o.Id);
        System.debug('TEST CC : ' + cc);
        System.debug('TEST TO : ' + to);
        Send_Email_InOpp_CLass.sendemailmethod(body, auth, need, timing, poten, rid, cc, to, o, com);
        Test.stopTest();
    }
}