//Last Modified By : Abdul Aziz , Date : 12/07/2024 , Description : Increase Code Coverage
@istest
public class UpdateApproval_Test {
    @istest 
    public static void testdata(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='IN TS');
        ulist.add(uu);
        
        User uu22 = new User(Alias = 'absd22', 
                             EmailEncodingKey='UTF-8', LastName='Vinod Nair', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = p.Id, 
                             TimeZoneSidKey='America/Los_Angeles',username = 'VinodNair@start.com',
                             email='absd22@gmail.com',Channel__c='IN TS');
        ulist.add(uu22);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        a.OwnerId = uu22.Id;
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
       // UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataSEATS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey3', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='SEA TS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
      //  UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataMETS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey4', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='ME TS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
      //  UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataMEFS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey5', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='ME FS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
       // UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataSGFS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey6', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='SG FS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
       // UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataMYFS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey7', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='MY FS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3500.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
      //  UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataPHFS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey8', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='PH FS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
       // UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataHKFS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey9', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='HK FS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
     //   UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataEA(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey10', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='EA'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
     //  UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataSMB(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey11', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='SMB'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
       // UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdataINDTS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey12', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='IND TS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
     //   UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
    @istest
    public static void testdatafBS(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tquoteShare = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(tquoteShare);
        Trigger__c em = new Trigger__c(name ='EmailMessage', Active__c = false);
        tlist.add(em);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        
        insert tlist;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'pandey2', 
                           EmailEncodingKey='UTF-8', LastName='Santosh Pandey', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'SantoshPandey@start.com',
                           email='absduu@gmail.com',Channel__c='fBS'); 
        ulist.add(uu);
        
        
        
        
        insert ulist;
        
        
        Account a = new Account();
        a.Name = 'Arun Karra';
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
        //  pc.Price_Master__c=pm.id;
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
        pc.Discount_Cap__c=60;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        
        pc.Category__c ='B';
        
        insert pc;
        
        ProductC__c pca = new ProductC__c();
        pca.Main_Product_Type__c='JPO';
        pca.Product_Name__c='Job Posting';
        pca.Active__c=true;
        pca.SKU_Type__c='Bundle-x';
        pca.Product_category__c='Standard';
        //  pc.Price_Master__c=pm.id;
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
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pca.of_Master_Login__c='5';
        pca.Unit_List_Price_Value__c=500;
        pca.Product_Code__c='JPOS1SE00N';
        
        pca.Category__c ='A';
        
        insert pca;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
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
        no.OwnerId = uu.Id;
        oplist.add(no);
        
        insert oplist;
        
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Selling_Country__c = 'India';
        qcca.Finalised__c = true;
        qcca.Approval_Status_Overall__c = 'Pending';
        qcca.Billing_Address__c = 'Account Billing Address';
        qcca.Posting_Address__c = 'Account Billing Address';
        qcca.Selling_Country__c = 'India';   
        qcca.Validated__c = true;
        qcca.Tax_Percentage__c=18;
        qcca.Approval_Status_Overall__c ='Pending'; 
        listq.add(qcca);
        
        QuotesN__c qccb = new QuotesN__c(); 
        qccb.Quote_Type__c='Free Trial'; 
        qccb.Account__c=a.id;
        qccb.Contact__c=c.id;
        qccb.Opportunities__c=no.id;
        qccb.CurrencyIsoCode ='INR';
        qccb.Active__c=True;
        qccb.Level_3_Approval_Done__c = true;
        qccb.Selling_Country__c = 'India';
        qccb.Finalised__c = true;
        qccb.Approval_Status_Overall__c = 'Pending';
        qccb.Billing_Address__c = 'Account Billing Address';
        qccb.Posting_Address__c = 'Account Billing Address';
        qccb.Selling_Country__c = 'India';   
        qccb.Validated__c = true;
        qccb.Tax_Percentage__c=18;
        qccb.Approval_Status_Overall__c ='Pending'; 
        listq.add(qccb);
        
        insert listq;
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qcca.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 7000.00;
        ql1.Gross_Total__c = 29150.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 45;
        ql1.Unit_Price__c = 53.00;
        ql1.Quantity_Unit__c = 1;
        ql1.Base_Total__c = 3000.00; 
        
        insert ql1;
        
        Quote_Line_Items__c qlb = new Quote_Line_Items__c();
        qlb.Quotes__c = qccb.Id;
        qlb.Account__c = a.id;
        qlb.Opportunities__c = no.id;
        qlb.Product__c = pc.Id;
        qlb.Price_Master__c = pm.Id;
        qlb.Product_Industry__c = 'Full';
        qlb.Product_Geo_Scope__c ='All';
        qlb.Product_Country__c = 'APAC without India';
        qlb.Tenure_Months__c = '12 Months';
        qlb.Discount_Value__c = 7000.00;
        qlb.Gross_Total__c = 29150.00;
        qlb.Adjustment_Type__c ='Amount';
        qlb.Adjusted_Value__c = 45;
        qlb.Unit_Price__c = 53.00;
        qlb.Quantity_Unit__c = 1;
        qlb.Base_Total__c = 30000.00;  
        insert qlb;
        QuotesN__c qd = new QuotesN__c(); 
        qd.Quote_Type__c='Free Trial'; 
        qd.Account__c=a.id;
        qd.Start_Date__c=System.today();
        qd.Contact__c=c.id;
        qd.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qd.CurrencyIsoCode ='INR';
        qd.Active__c=True;
        qd.Level_3_Approval_Done__c = true;
        qd.Selling_Country__c = 'India';
        qd.Finalised__c = true;
        qd.Approval_Status_Overall__c = 'Pending';
        qd.Billing_Address__c = 'Account Billing Address';
        qd.Posting_Address__c = 'Account Billing Address';
        qd.Selling_Country__c = 'India';   
        qd.Validated__c = true;
        qd.Tax_Percentage__c=18;
        qd.Approval_Status_Overall__c ='Pending';  
        insert qd;
        
        
        Quote_Line_Items__c qld = new Quote_Line_Items__c();
        qld.Quotes__c = qd.Id;
        qld.Account__c = a.id;
        qld.Opportunities__c = no.id;
        qld.Product__c = pc.Id;
        qld.Price_Master__c = pm.Id;
        qld.Product_Industry__c = 'Full';
        qld.Product_Geo_Scope__c ='All';
        qld.Product_Country__c = 'APAC without India';
        qld.Tenure_Months__c = '12 Months';
        qld.Discount_Value__c = 7000.00;
        qld.Gross_Total__c = 29150.00;
        qld.Adjustment_Type__c ='%';
        qld.Adjusted_Value__c = 25;
        qld.Unit_Price__c = 53.00;
        qld.Quantity_Unit__c = 1;
        qld.Base_Total__c = 12000.00;  
        insert qld;
        
        update listq;
        UpdateApproval_helper.update_approvers(listq);
       // UpdateApproval_helper.update_priority(listq,1);
        UpdateApproval_helper.shareWithAccountOwner(listq);
        test.stopTest(); 
    }
}