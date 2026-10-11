@IsTest
public class discountcalconqline1_TEST {
    @istest
    public static void testdata(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        tlist.add(t41);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        tlist.add(tk);
        
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = true);
        tlist.add(tshareorder);
        
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = true);
        tlist.add(SharePortfolio);
        
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = true);
        tlist.add(QuoteLineItems);
        
        
        insert tlist;
        
        
        User uu=[select id,name,User_Channel__c,Channel__c,managerid from User where id=:userinfo.getUserId()];
        // user saleshead=[select id,name from user where name like '%Sales Head User%'];
        // user channelshead=[select id,name from user where name like '%Channel Head User%'];
        //user ceouser=[select id,name from user where name like '%CEO user%'];
        
        
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
        
        
        
        ProductM__c m=new ProductM__c();
        m.name='branding';
        m.Active__c=true;
        m.Price_List1__c = 'INR';
        m.IsActive__c = true;
        
        m.Trail_Custom_or_Promo__c=true;
        insert m;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        list<ProductC__c> plist=new list<ProductC__c>();
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Price_Master__c=pm.id;
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
        pc.Channel__c=uu.Channel__c;
        pc.Category__c='A';
        plist.add(pc);
        
        
        
        ProductC__c pc1 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc1.Active__c=true;
        pc1.SKU_Type__c='Bundle-x';
        pc1.Product_category__c='Standard';
        pc1.Price_Master__c=pm.id;
        pc1.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc1.Channel__c = '';
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Description__c='hiuhiuh';
        pc1.Product_Country__c='India';
        pc1.Primary_Selling_Country__c='India';
        pc1.Tenure_Months__c='12 Months';
        pc1.Bin__c='vghvgh';
        pc1.Product_Type__c='Upsell';
        pc1.Channel__c=uu.Channel__c;
        pc1.Category__c='B';
        
        plist.add(pc1);
        insert plist;
        
        a.Lead_Account_Status__c = 'Active';
        update a;
        
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
        insert no; 
        
        List<Opp_Line_Item__c> oplilist= new List<Opp_Line_Item__c>();
        Opp_Line_Item__c opli = new Opp_Line_Item__c();
        opli.Opportunities__c= no.id;
        opli.Account__c= a.id;
        opli.Product__c=pc.id;
        opli.Price_Master__c=pm.id;
        opli.Quantity_Unit__c=1;
        opli.DB_Scope_Geography__c='All';
        opli.DB_Type_Industry__c='Full';
        opli.CurrencyIsoCode='INR';
        opli.Unit_Price__c=500;
        opli.Product_Country__c='India';
        opli.Product_Selling_Country__c='India';
        opli.SKU_Code__c='RDAS1ME01M00BN1';
        opli.Tenure_Months__c= '12 Months';
        opli.Discount_Value__c=12;
        //  opli.Quantity_Unit__c=pc.From__c;
        opli.Base_Total__c=200;
        opli.Discount_Amount_1__c=200;
        opli.Gross_Total__c=100;
        opli.of_Master_Login__c='5';
        oplilist.add(opli);
        
        Opp_Line_Item__c opli1 = new Opp_Line_Item__c();
        opli1.Opportunities__c= no.id;
        opli1.Account__c= a.id;
        opli1.Product__c=pc1.id;
        opli1.Price_Master__c=pm.id;
        //opli.Quantity_Unit__c=100;
        opli1.DB_Scope_Geography__c='All';
        opli1.DB_Type_Industry__c='Full';
        oplilist.add(opli1);
        insert oplilist;
        
        TopUps__c tc = new TopUps__c();
        tc.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc.BIN__c='vghvgh';
        tc.Inventory_Quota_Tenure__c='Per Month';
        tc.Price_Master__c=pm.id;
        tc.Product__c=pc.id;
        tc.Mandatory__c=true;
        insert tc;
        
        
        //  list<QuotesN__c>  qlist =new list<QuotesN__c>();
        QuotesN__c qcc = new QuotesN__c();
        //   qc.Level_of_Approval_maxima_from_QLI__c =1;
        qcc.Approver_1__c = uu.Id;
        qcc.Approver_2__c = uu.Id;
        qcc.Approver_3__c = uu.Id;
        qcc.Approver_4__c = uu.Id; 
        qcc.Quote_Type__c='Free Trial';
        
        qcc.Account__c=a.id;
        qcc.Contact__c=c.id;
        qcc.Opportunities__c=no.id;
        qcc.Price_Master__c=pm.id;
        qcc.CurrencyIsoCode ='INR';
        qcc.Active__c=True;
        qcc.Selling_Country__c = 'India';
        qcc.Finalised__c = true;
        qcc.Approval_Status_Overall__c = 'Pending';
        qcc.Billing_Address__c = 'Account Billing Address';
        qcc.Posting_Address__c = 'Account Billing Address';
        qcc.Selling_Country__c = 'India';   
        qcc.Validated__c = true;
        qcc.Tax_Percentage__c=18;
        qcc.Approval_Status_Overall__c ='Pending';
        // qlist.add(qc);
        insert qcc;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c qlE = new Quote_Line_Items__c();
        qlE.Quotes__c = qcc.Id;
        qlE.Account__c = a.id;
        qlE.Opportunities__c = no.id;
        
        qlE.Product_Industry__c = 'Full';
        qlE.Product_Geo_Scope__c ='All';
        qlE.Product_Country__c = 'APAC without India';
        qlE.Tenure_Months__c = '12 Months';
        qlE.Discount_Value__c = 511000.00;
        qlE.Gross_Total__c = 766500.00; 
        qlE.Unit_Price__c = 5840.00;
        qlE.Quantity_Unit__c = 4;
        qlE.Base_Total__c = 1277500.00; 
        qulist1.add(qlE);
        
        Quote_Line_Items__c ql3 = new Quote_Line_Items__c();
        ql3.Quotes__c = qcc.Id;
        ql3.Account__c = a.id;
        ql3.Opportunities__c = no.id;
        ql3.Product__c = pc.Id;
        ql3.Price_Master__c = pm.Id;
        ql3.Product_Industry__c = 'Full';
        ql3.Product_Geo_Scope__c ='All';
        ql3.Product_Country__c = 'APAC without India';
        ql3.Tenure_Months__c = '12 Months';
        ql3.Discount_Value__c = 511000.00;
        ql3.Gross_Total__c = 766500.00;
        ql3.Adjustment_Type__c ='Amount';
        ql3.Adjusted_Value__c = 500;
        ql3.Unit_Price__c = 5840.00;
        ql3.Quantity_Unit__c = 4;
        ql3.Base_Total__c = 1277500.00; 
        qulist1.add(ql3);
        
        //  insert ql3;
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qcc.Id;
        ql4.Account__c = a.id;
        ql4.Opportunities__c = no.id;
        ql4.Product__c = pc1.Id;
        ql4.Price_Master__c = pm.Id;
        ql4.Product_Industry__c = 'Full';
        ql4.Product_Geo_Scope__c ='All';
        ql4.Product_Country__c = 'APAC without India';
        ql4.Tenure_Months__c = '12 Months';
        ql4.Discount_Value__c = 511000.00;
        ql4.Gross_Total__c = 766500.00;
        ql4.Adjustment_Type__c ='Amount';
        ql4.Adjusted_Value__c = 500;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        //  insert ql4;
        insert  qulist1;
        ql4.Adjusted_Value__c = 700;
        update ql4;
        ql4.Adjusted_Value__c = 1000;
        update ql4;
        ql4.Adjusted_Value__c = 1200;
        update ql4; 
        
        
    }
    
    @istest
    public static void testdata1(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        tlist.add(t41);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        tlist.add(tk);
        
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = true);
        tlist.add(tshareorder);
        
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = true);
        tlist.add(SharePortfolio);
        
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = true);
        tlist.add(QuoteLineItems);
        
        
        insert tlist;
        
        
        
        
        User uu=[select id,name,User_Channel__c,Channel__c,managerid from User where id=:userinfo.getUserId()];
        // user saleshead=[select id,name from user where name like '%Sales Head User%'];
        // user channelshead=[select id,name from user where name like '%Channel Head User%'];
        //user ceouser=[select id,name from user where name like '%CEO user%'];
        
        
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
        
        
        
        ProductM__c m=new ProductM__c();
        m.name='branding';
        m.Active__c=true;
        m.Price_List1__c = 'INR';
        m.IsActive__c = true;
        
        m.Trail_Custom_or_Promo__c=true;
        insert m;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        list<ProductC__c> plist=new list<ProductC__c>();
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Price_Master__c=pm.id;
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
        pc.Channel__c=uu.Channel__c;
        pc.Category__c='C';
        plist.add(pc);
        
        
        insert plist;
        
        a.Lead_Account_Status__c = 'Active';
        update a;
        
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
        insert no; 
        
        List<Opp_Line_Item__c> oplilist= new List<Opp_Line_Item__c>();
        Opp_Line_Item__c opli = new Opp_Line_Item__c();
        opli.Opportunities__c= no.id;
        opli.Account__c= a.id;
        opli.Product__c=pc.id;
        opli.Price_Master__c=pm.id;
        opli.Quantity_Unit__c=1;
        opli.DB_Scope_Geography__c='All';
        opli.DB_Type_Industry__c='Full';
        opli.CurrencyIsoCode='INR';
        opli.Unit_Price__c=500;
        opli.Product_Country__c='India';
        opli.Product_Selling_Country__c='India';
        opli.SKU_Code__c='RDAS1ME01M00BN1';
        opli.Tenure_Months__c= '12 Months';
        opli.Discount_Value__c=12;
        //  opli.Quantity_Unit__c=pc.From__c;
        opli.Base_Total__c=200;
        opli.Discount_Amount_1__c=200;
        opli.Gross_Total__c=100;
        opli.of_Master_Login__c='5';
        oplilist.add(opli);
        
        
        
        TopUps__c tc = new TopUps__c();
        tc.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc.BIN__c='vghvgh';
        tc.Inventory_Quota_Tenure__c='Per Month';
        tc.Price_Master__c=pm.id;
        tc.Product__c=pc.id;
        tc.Mandatory__c=true;
        insert tc;
        
        
        
        //  list<QuotesN__c>  qlist =new list<QuotesN__c>();
        QuotesN__c qcc = new QuotesN__c();
        //   qc.Level_of_Approval_maxima_from_QLI__c =1;
        qcc.Approver_1__c = uu.Id;
        qcc.Approver_2__c = uu.Id;
        qcc.Approver_3__c = uu.Id;
        qcc.Approver_4__c = uu.Id; 
        qcc.Quote_Type__c='Free Trial';
        
        qcc.Account__c=a.id;
        qcc.Contact__c=c.id;
        qcc.Opportunities__c=no.id;
        qcc.Price_Master__c=pm.id;
        qcc.CurrencyIsoCode ='INR';
        qcc.Active__c=True;
        qcc.Selling_Country__c = 'India';
        qcc.Finalised__c = true;
        qcc.Approval_Status_Overall__c = 'Pending';
        qcc.Billing_Address__c = 'Account Billing Address';
        qcc.Posting_Address__c = 'Account Billing Address';
        qcc.Selling_Country__c = 'India';   
        qcc.Validated__c = true;
        qcc.Tax_Percentage__c=18;
        qcc.Approval_Status_Overall__c ='Pending';
        // qlist.add(qc);
        insert qcc;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qcc.Id;
        ql4.Account__c = a.id;
        ql4.Opportunities__c = no.id;
        ql4.Product__c = pc.Id;
        ql4.Price_Master__c = pm.Id;
        ql4.Product_Industry__c = 'Full';
        ql4.Product_Geo_Scope__c ='All';
        ql4.Product_Country__c = 'APAC without India';
        ql4.Tenure_Months__c = '12 Months';
        ql4.Discount_Value__c = 511000.00;
        ql4.Gross_Total__c = 766500.00;
        ql4.Adjustment_Type__c ='Amount';
        ql4.Adjusted_Value__c = 1000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        //  insert ql4;
        insert  qulist1;
        ql4.Adjusted_Value__c = 1400;
        update ql4;
        ql4.Adjusted_Value__c = 1700;
        update ql4;
        ql4.Adjusted_Value__c = 2000;
        update ql4; 
        
    }
    
    @istest
    public static void testdata2(){
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        tlist.add(t41);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        tlist.add(tk);
        
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = true);
        tlist.add(tshareorder);
        
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = true);
        tlist.add(SharePortfolio);
        
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = true);
        tlist.add(QuoteLineItems);
        
        
        insert tlist;
        
        
        
        User uu=[select id,name,User_Channel__c,Channel__c,managerid from User where id=:userinfo.getUserId()];
        // user saleshead=[select id,name from user where name like '%Sales Head User%'];
        // user channelshead=[select id,name from user where name like '%Channel Head User%'];
        //user ceouser=[select id,name from user where name like '%CEO user%'];
        
        
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
        
        
        
        ProductM__c m=new ProductM__c();
        m.name='branding';
        m.Active__c=true;
        m.Price_List1__c = 'INR';
        m.IsActive__c = true;
        
        m.Trail_Custom_or_Promo__c=true;
        insert m;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        list<ProductC__c> plist=new list<ProductC__c>();
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Price_Master__c=pm.id;
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
        pc.Channel__c=uu.Channel__c;
        pc.Category__c='D';
        plist.add(pc);
        
        
        insert plist;
        
        a.Lead_Account_Status__c = 'Active';
        update a;
        
        
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
        insert no; 
        
        List<Opp_Line_Item__c> oplilist= new List<Opp_Line_Item__c>();
        Opp_Line_Item__c opli = new Opp_Line_Item__c();
        opli.Opportunities__c= no.id;
        opli.Account__c= a.id;
        opli.Product__c=pc.id;
        opli.Price_Master__c=pm.id;
        opli.Quantity_Unit__c=1;
        opli.DB_Scope_Geography__c='All';
        opli.DB_Type_Industry__c='Full';
        opli.CurrencyIsoCode='INR';
        opli.Unit_Price__c=500;
        opli.Product_Country__c='India';
        opli.Product_Selling_Country__c='India';
        opli.SKU_Code__c='RDAS1ME01M00BN1';
        opli.Tenure_Months__c= '12 Months';
        opli.Discount_Value__c=12;
        //  opli.Quantity_Unit__c=pc.From__c;
        opli.Base_Total__c=200;
        opli.Discount_Amount_1__c=200;
        opli.Gross_Total__c=100;
        opli.of_Master_Login__c='5';
        oplilist.add(opli);
        
        
        
        TopUps__c tc = new TopUps__c();
        tc.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc.BIN__c='vghvgh';
        tc.Inventory_Quota_Tenure__c='Per Month';
        tc.Price_Master__c=pm.id;
        tc.Product__c=pc.id;
        tc.Mandatory__c=true;
        insert tc;
        
        
        
        //  list<QuotesN__c>  qlist =new list<QuotesN__c>();
        QuotesN__c qcc = new QuotesN__c();
        //   qc.Level_of_Approval_maxima_from_QLI__c =1;
        qcc.Approver_1__c = uu.Id;
        qcc.Approver_2__c = uu.Id;
        qcc.Approver_3__c = uu.Id;
        qcc.Approver_4__c = uu.Id; 
        qcc.Quote_Type__c='Free Trial';
        
        qcc.Account__c=a.id;
        qcc.Contact__c=c.id;
        qcc.Opportunities__c=no.id;
        qcc.Price_Master__c=pm.id;
        qcc.CurrencyIsoCode ='INR';
        qcc.Active__c=True;
        qcc.Selling_Country__c = 'India';
        qcc.Finalised__c = true;
        qcc.Approval_Status_Overall__c = 'Pending';
        qcc.Billing_Address__c = 'Account Billing Address';
        qcc.Posting_Address__c = 'Account Billing Address';
        qcc.Selling_Country__c = 'India';   
        qcc.Validated__c = true;
        qcc.Tax_Percentage__c=18;
        qcc.Approval_Status_Overall__c ='Pending';
        // qlist.add(qc);
        insert qcc;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qcc.Id;
        ql4.Account__c = a.id;
        ql4.Opportunities__c = no.id;
        ql4.Product__c = pc.Id;
        ql4.Price_Master__c = pm.Id;
        ql4.Product_Industry__c = 'Full';
        ql4.Product_Geo_Scope__c ='All';
        ql4.Product_Country__c = 'APAC without India';
        ql4.Tenure_Months__c = '12 Months';
        ql4.Discount_Value__c = 511000.00;
        ql4.Gross_Total__c = 766500.00;
        ql4.Adjustment_Type__c ='Amount';
        ql4.Adjusted_Value__c = 1700;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        //  insert ql4;
        insert  qulist1;
        ql4.Adjusted_Value__c = 2000;
        update ql4;
        ql4.Adjusted_Value__c = 2200;
        update ql4;
        ql4.Adjusted_Value__c = 2500;
        update ql4; 
        
    }
}