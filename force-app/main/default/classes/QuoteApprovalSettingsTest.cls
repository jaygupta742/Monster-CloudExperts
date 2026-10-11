//Created By : Abdul Aziz , Date : 13/07/2024 , Decsription : Apex Test Class For QuoteApprovalSettings
@IsTest
public class QuoteApprovalSettingsTest {
    @istest
    public static void testdata(){
        List<Trigger__c> lstTriggerSetting = new list<Trigger__c>();
        Trigger__c AccountSetting = new Trigger__c(Name = 'Account', Active__c = false);
        lstTriggerSetting.add(AccountSetting);
        
        Trigger__c ContactSetting = new Trigger__c(Name = 'Contact', Active__c = false);
        lstTriggerSetting.add(ContactSetting);
        
        Trigger__c OpportunitySetting = new Trigger__c(name = 'Opportunity',Active__c = false);
        lstTriggerSetting.add(OpportunitySetting);
        
        Trigger__c CVRSetting = new Trigger__c(name = 'CVR', Active__c = false);
        lstTriggerSetting.add(CVRSetting);
        
        Trigger__c QuoteSetting = new Trigger__c(name = 'Quote',Active__c = false);
        lstTriggerSetting.add(QuoteSetting);
        
        Trigger__c SharePortfolioSetting = new Trigger__c(name ='Share Portfolio', Active__c = false);
        lstTriggerSetting.add(SharePortfolioSetting);
        
        Trigger__c EmailMessageSetting = new Trigger__c(name ='EmailMessage', Active__c = false);
        lstTriggerSetting.add(EmailMessageSetting);
        
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        lstTriggerSetting.add(QuoteLineItems);
        
        Trigger__c ApacPayment = new Trigger__c(name ='ApacPayment', Active__c = false);
        lstTriggerSetting.add(ApacPayment);
        insert lstTriggerSetting;
        
        Profile Profile_StandardUser = [SELECT Id FROM Profile WHERE Name = 'Standard User']; 
        
        List<user> lstNUsers = new List<User>();
        User user1 = new User(
            Alias = 'absduu', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Santosh Pandey', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = Profile_StandardUser.Id, 
            TimeZoneSidKey = 'America/Los_Angeles',
            username = 'SantoshPandey@start.com',
            email = 'absduu@gmail.com',
            Channel__c = 'IN TS'
        );
        lstNUsers.add(user1);
        
        User user2 = new User(
            Alias = 'absd22', 
            EmailEncodingKey = 'UTF-8', 
            LastName = 'Vinod Nair', 
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = Profile_StandardUser.Id, 
            TimeZoneSidKey = 'America/Los_Angeles',
            username = 'VinodNair@start.com',
            email = 'absd22@gmail.com',
            Channel__c = 'IN TS'
        );
        lstNUsers.add(user2);
        Insert lstNUsers;
        
        user1.ManagerId = user2.Id;
        update user1;
        
        Account a = new Account();
        a.Name = 'Arun Karra';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c = 'sssss';
        a.Lead_Source__c = 'Other';
        a.APAC_Industry__c = 'Energy';
        a.No_of_Employees__c = 25;
        a.Account_Type__c = 'NIT';
        a.Location__c = 'India';
        a.Lead_Source1__c = 'ECOMM';
        a.Website = 'www.asdfert.com';
        a.Phone = '+985478547256';
        a.OtherPhone__c = '+985478547856';
        a.RegistrationNumber__c = 'asq111111';
        a.Lead_Account_Status__c = 'Inactive';
        a.CreditStatus__c = 'OK';
        a.BillingCountry = 'India' ; 
        a.BillingState = 'Karnataka';
        a.BillingStreet = 'Test Address';
        a.BillingCity = 'bangalore' ;
        a.BillingPostalCode = '560076'; 
        a.ShippingCountry = 'India';
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        a.OwnerId = user2.Id;
        a.Team__c ='Edtech-Courses';
        
        insert a;
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;  
        
        
        list<ProductC__c> plist=new list<ProductC__c>();
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Product_SKU_Code__c='JPOS1SE00N';
        pc.Product_Description__c='hiuhiuh';
        pc.Product_Country__c='India';
        pc.Primary_Selling_Country__c='India';
        pc.Tenure_Months__c='12 Months';
        pc.Bin__c='vghvgh';
        pc.Product_Type__c='Upsell';
        pc.CurrencyIsoCode='INR';
        pc.Unit_List_Price_Value__c=200;
        pc.DB_Type_Industry__c='Full';
        pc.DB_Scope_Geography__c='All';
        pc.Discount_Cap__c = 60;
        pc.From__c = 200;
        pc.of_Master_Login__c = '5';
        pc.Unit_List_Price_Value__c = 500;
        pc.Product_Code__c='JPOS1SE00N';
        pc.Category__c ='B';
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        pca.Product_SKU_Code__c='JPOS1SE00N';
        pca.Product_Description__c='hiuhiuh';
        pca.Product_Country__c='India';
        pca.Primary_Selling_Country__c='India';
        pca.Tenure_Months__c='12 Months';
        pca.Bin__c='vghvgh';
        pca.Product_Type__c='Upsell';
        pca.CurrencyIsoCode='INR';
        pca.Unit_List_Price_Value__c=200;
        pca.DB_Type_Industry__c='Full';
        pca.DB_Scope_Geography__c='All';
        pca.Discount_Cap__c=60;
        pca.From__c=200;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        pca.Category__c ='A';
        insert pca;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name = 'INR Price Book';
        insert pm;
        
        a.Lead_Account_Status__c = 'Active';
        update a;
        
        list<OpportunityN__c> oplist = new list<OpportunityN__c>();
        OpportunityN__c no = new OpportunityN__c();
        no.Account__c= a.id;
        no.Contact__c=c.id;
        no.Close_Date__c = date.today().adddays(10);
        no.Closure_Week__c ='Week-2';
        no.Closure_probablity__c ='Will';
        no.Expected_Revenue__c=12121222;
        no.Price_Master__c = pm.Id; 
        no.Stage__c = 'Proposal Sent';
        no.Opportunity_Type__c='free trial'; 
        no.Actual_Revenue__c= 12131;
        no.OwnerId = user1.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> quotes = new list<QuotesN__c>();
        QuotesN__c quote1 = new QuotesN__c(); 
        quote1.Quote_Type__c='Free Trial'; 
        quote1.Free_Trial_Product__c = true;
        quote1.Account__c=a.id;
        quote1.Contract_Type__c = 'Manual Std Offline';
        quote1.Contact__c=c.id;
        quote1.Opportunities__c = no.id;
        quote1.CurrencyIsoCode = 'INR';
        quote1.Active__c = true;
        quote1.Selling_Country__c = 'India';
        quote1.Approval_Status_Overall__c = 'Pending';
        quote1.Billing_Address__c = 'Account Billing Address';
        quote1.Posting_Address__c = 'Account Billing Address';
        quote1.Tax_Percentage__c = 18;
        quote1.Level_of_Approval_Required__c = 1;
        quote1.Approval_Status_Overall__c = 'Pending';
        quote1.Start_Date__c=Date.today();
        quotes.add(quote1);
        
        QuotesN__c quote2 = new QuotesN__c(); 
        quote2.Quote_Type__c = 'New Customer'; 
        quote2.Account__c = a.id;
        quote2.Contract_Type__c = 'Manual Std Offline';
        quote2.Contact__c = c.id;
        quote2.Opportunities__c = no.id;
        quote2.CurrencyIsoCode = 'INR';
        quote2.Active__c = true;
        quote2.Selling_Country__c = 'India';
        quote2.Approval_Status_Overall__c = 'Pending';
        quote2.Billing_Address__c = 'Account Billing Address';
        quote2.Posting_Address__c = 'Account Billing Address';
        quote2.Tax_Percentage__c=18;
        quote2.Start_Date__c=Date.today().addDays(-1);
        quotes.add(quote2);
        
        QuotesN__c quote3 = new QuotesN__c(); 
        quote3.Quote_Type__c='New Customer'; 
        quote3.Account__c = a.id;
        quote3.Contract_Type__c = 'Manual Std Offline';
        quote3.Contact__c = c.id;
        quote3.Opportunities__c = no.id;
        quote3.CurrencyIsoCode = 'INR';
        quote3.Active__c = true;
        quote3.Selling_Country__c = 'India';
        quote3.Approval_Status_Overall__c = 'Pending';
        quote3.Billing_Address__c = 'Account Billing Address';
        quote3.Posting_Address__c = 'Account Billing Address';
        quote3.Tax_Percentage__c=18;
        quote3.Start_Date__c=Date.today().addDays(-2);
        quotes.add(quote3);
        
        QuotesN__c quote4 = new QuotesN__c(); 
        quote4.Quote_Type__c = 'New Customer'; 
        quote4.Account__c = a.id;
        quote4.Contact__c = c.id;
        quote4.Contract_Type__c = 'Manual Std Offline';
        quote4.Opportunities__c = no.id;
        quote4.CurrencyIsoCode = 'INR';
        quote4.Active__c = true;
        quote4.Selling_Country__c = 'India';
        quote4.Approval_Status_Overall__c = 'Pending';
        quote4.Billing_Address__c = 'Account Billing Address';
        quote4.Posting_Address__c = 'Account Billing Address';
        quote4.Tax_Percentage__c=18;
        quote4.Start_Date__c=Date.today().addDays(-3);
        quotes.add(quote4);
        
        QuotesN__c quote5 = new QuotesN__c(); 
        quote5.Quote_Type__c = 'New Customer'; 
        quote5.Account__c = a.id;
        quote5.Contract_Type__c = 'Manual Std Offline';
        quote5.Contact__c = c.id;
        quote5.Opportunities__c = no.id;
        quote5.CurrencyIsoCode = 'INR';
        quote5.Active__c = true;
        quote5.Selling_Country__c = 'India';
        quote5.Approval_Status_Overall__c = 'Pending';
        quote5.Billing_Address__c = 'Account Billing Address';
        quote5.Posting_Address__c = 'Account Billing Address';
        quote5.Tax_Percentage__c=18;
        quote5.Start_Date__c=Date.today().addDays(-4);
        quotes.add(quote5);
        insert quotes;
        
        
        
        List<Quote_Line_Items__c> lstQuoteItems = new List<Quote_Line_Items__c> ();
        //QuoteItem1 is usefull
        //quote1 is usefull
        Quote_Line_Items__c QuoteItem1 = new Quote_Line_Items__c();
        QuoteItem1.Quotes__c = quote1.Id;
        QuoteItem1.Account__c = a.id;
        QuoteItem1.Opportunities__c = no.id;
        QuoteItem1.Product__c = pc.Id;
        QuoteItem1.Price_Master__c = pm.Id;
        QuoteItem1.Product_Industry__c = 'Full';
        QuoteItem1.Product_Geo_Scope__c ='All';
        QuoteItem1.Product_Country__c = 'APAC without India';
        QuoteItem1.Tenure_Months__c = '12 Months';
        QuoteItem1.Adjustment_Type__c = '%';
        QuoteItem1.Adjusted_Value__c = 10;
        QuoteItem1.Unit_Price__c = 500;
        QuoteItem1.Quantity_Unit__c = 1;
        QuoteItem1.Product_Country__c='India';
        lstQuoteItems.add(QuoteItem1);
        
        Quote_Line_Items__c QuoteItem2 = new Quote_Line_Items__c();
        QuoteItem2.Quotes__c = quote3.Id;
        QuoteItem2.Account__c = a.id;
        QuoteItem2.Opportunities__c = no.id;
        QuoteItem2.Product__c = pc.Id;
        QuoteItem2.Price_Master__c = pm.Id;
        QuoteItem2.Product_Industry__c = 'Full';
        QuoteItem2.Product_Geo_Scope__c ='All';
        QuoteItem2.Product_Country__c = 'APAC without India';
        QuoteItem2.Tenure_Months__c = '12 Months';
        QuoteItem2.Adjustment_Type__c ='%';
        QuoteItem2.Adjusted_Value__c = 15;
        QuoteItem2.Unit_Price__c = 500.00;
        QuoteItem2.Quantity_Unit__c = 1;
        lstQuoteItems.add(QuoteItem2);
        
        Quote_Line_Items__c QuoteItem3 = new Quote_Line_Items__c();
        QuoteItem3.Quotes__c = quote4.Id;
        QuoteItem3.Account__c = a.id;
        QuoteItem3.Opportunities__c = no.id;
        QuoteItem3.Product__c = pc.Id;
        QuoteItem3.Price_Master__c = pm.Id;
        QuoteItem3.Product_Industry__c = 'Full';
        QuoteItem3.Product_Geo_Scope__c ='All';
        QuoteItem3.Product_Country__c = 'APAC without India';
        QuoteItem3.Tenure_Months__c = '12 Months';
        QuoteItem3.Adjustment_Type__c ='%';
        QuoteItem3.Adjusted_Value__c = 20;
        QuoteItem3.Unit_Price__c = 500.00;
        QuoteItem3.Quantity_Unit__c = 1;
        lstQuoteItems.add(QuoteItem3);
        
        Quote_Line_Items__c QuoteItem4 = new Quote_Line_Items__c();
        QuoteItem4.Quotes__c = quote5.Id;
        QuoteItem4.Account__c = a.id;
        QuoteItem4.Opportunities__c = no.id;
        QuoteItem4.Product__c = pc.Id;
        QuoteItem4.Price_Master__c = pm.Id;
        QuoteItem4.Product_Industry__c = 'Full';
        QuoteItem4.Product_Geo_Scope__c ='All';
        QuoteItem4.Product_Country__c = 'APAC without India';
        QuoteItem4.Tenure_Months__c = '12 Months';
        QuoteItem4.Adjustment_Type__c ='%';
        QuoteItem4.Adjusted_Value__c = 30;
        QuoteItem4.Unit_Price__c = 500.00;
        QuoteItem4.Quantity_Unit__c = 1;
        lstQuoteItems.add(QuoteItem4);
        
        Insert lstQuoteItems;
        update quotes;
        List<APAC_Payments__c> lstapc=new  List<APAC_Payments__c>();
        APAC_Payments__c apc = new APAC_Payments__c();
        //  apc.Name='test';
        apc.Quotes__c=quotes[0].id;
        apc.APAC_Payment_Name__c='Single Shot';
        apc.Due_Date__c=system.today();
        apc.Payment_Amount__c = 0;
        apc.TDS_Amount__c= 0;
        apc.GST__c=18;
        lstapc.add(apc);
        insert lstapc;
        
         Quote_Approval_Setting__mdt w1 = new Quote_Approval_Setting__mdt();
        
        try{
            Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitrequest();
            app.setObjectId(quote1.Id);
            system.debug('quote1.Level_of_Approval_Required__c : ' + quote1.Level_of_Approval_Required__c);
            Approval.ProcessResult result = Approval.process(app);
            
            ProcessInstance pi = [SELECT TargetObjectId, CreatedDate FROM ProcessInstance WHERE TargetObjectId = :quote1.Id];
            // System.assertEquals(c2.CreatedDate,pi.CreatedDate);
            system.debug('ProcessInstance'+pi.id);
            List<ProcessInstanceStep> processInstanceSteps = [SELECT Id FROM ProcessInstanceStep WHERE ProcessInstanceId = :pi.Id];
            for(ProcessInstanceStep pis : processInstanceSteps) {
                System.debug('ProcessInstanceStep ID: ' + pis.Id);
            }
            
            // Query ProcessInstanceWorkitem using ProcessInstanceId
            List<ProcessInstanceWorkitem> processInstanceWorkitems = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstanceId = :pi.Id];
            for(ProcessInstanceWorkitem piw : processInstanceWorkitems) {
                System.debug('ProcessInstanceWorkitem ID: ' + piw.Id);
            }
            // Create test data for Quote_Approval_Setting__mdt
            Quote_Approval_Setting__mdt approvalSettings = new Quote_Approval_Setting__mdt(
                DeveloperName = 'TestApprovalSetting',
                Approver_Settings__c = '{"Growth": {"approvers": ["Manager", "Channel Head", "CBO", "CEO"], "maxLvlDiscountApprovers": 4}}',
                Discount_Approval_Settings__c = '{"Growth": [{"minDiscount": 0, "maxDiscount": 50, "levelOfApprovalRequired": 2}]}',
                Payment_Approval_Settings__c = '{"Enterprise": {"New": [{"minGrossTotal": {"USD": 0}, "maxGrossTotal": {"USD": 2000}, "minPaymentCount": 1, "maxPaymentCount": 3, "Upfront": 20, "installment": 1, "minDueAmount": {"USD": 50}, "minMaxDueDateDiff": 30, "minDueDateDiff": 10}]}}'
            );
            // insert approvalSettings;
           
            w1 = [SELECT Id, Approver_Settings__c, Discount_Approval_Settings__c, Free_Trail_Approval_Settings__c, Payment_Approval_Settings__c 
                  FROM Quote_Approval_Setting__mdt 
                  LIMIT 1];
        }catch(Exception e){
            
        }
        
        QuoteApprovalSettings obj;
        try{obj=new QuoteApprovalSettings(quotes[0],lstQuoteItems,lstapc,w1);}  catch(Exception e){}
        
        try{ QuoteApprovalSettings quoteApprovalSettings = new QuoteApprovalSettings(quotes[0], null, null, w1);}  catch(Exception e){}
        QuoteApprovalSettings quoteApprovalSettings2;
        try{ quoteApprovalSettings2= new QuoteApprovalSettings(quotes[0], null, lstapc, w1);}  catch(Exception e){}
        
        try{  Boolean paymentApprovalRequired = quoteApprovalSettings2.PaymentApprovalRequired();}  catch(Exception e){}
        QuoteApprovalSettings quoteApprovalSettings3;
        try{quoteApprovalSettings3  = new QuoteApprovalSettings(quotes[0], lstQuoteItems, null, null);}  catch(Exception e){}
        
        try{ String productApprovalCombination = quoteApprovalSettings3.ProductApprovalRequired();}  catch(Exception e){}
        
        
    }
    
}