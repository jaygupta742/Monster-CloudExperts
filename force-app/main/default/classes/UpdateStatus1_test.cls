@istest
public class UpdateStatus1_test {
    
    public @istest static void testdata1(){  
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
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='BFSI');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='HK FS');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='IND ENT');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        
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
        
        OpportunityN__c n1 = new OpportunityN__c();
        n1.Account__c= a.id;
        n1.Contact__c=c.id;
        n1.Close_Date__c = date.today().adddays(10);
        n1.Closure_Week__c ='Week-2';
        n1.Closure_probablity__c ='Will';
        n1.Expected_Revenue__c=12121222;
        n1.Price_Master__c = pm.Id; 
        n1.Stage__c = 'Proposal Sent';
        n1.Opportunity_Type__c='free trial'; 
        n1.Actual_Revenue__c= 12131;
        n1.OwnerId = u1.Id;
        
        oplist.add(n1);
        
        OpportunityN__c n2 = new OpportunityN__c();
        n2.Account__c= a.id;
        n2.Contact__c=c.id;
        // n2.Price_Master__c=pm.id;
        n2.Close_Date__c = date.today().adddays(10);
        n2.Closure_Week__c ='Week-2';
        n2.Closure_probablity__c ='Will';
        n2.Expected_Revenue__c=12121222;
        n2.Price_Master__c = pm.Id; 
        n2.Stage__c = 'Proposal Sent';
        n2.Opportunity_Type__c='free trial'; 
        n2.Actual_Revenue__c= 12131;
        n2.OwnerId = u2.Id; 
        oplist.add(n2); 
        insert oplist;
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
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
        // insert qcc;
        listq.add(qcca);
        
        QuotesN__c qcc = new QuotesN__c(); 
        qcc.Quote_Type__c='Free Trial'; 
        qcc.Account__c=a.id;
        qcc.Contact__c=c.id;
        qcc.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qcc.CurrencyIsoCode ='INR';
        qcc.Active__c=True;
        qcc.Level_3_Approval_Done__c = true;
        qcc.Selling_Country__c = 'India';
        qcc.Finalised__c = true;
        qcc.Approval_Status_Overall__c = 'Pending';
        qcc.Billing_Address__c = 'Account Billing Address';
        qcc.Posting_Address__c = 'Account Billing Address';
        qcc.Selling_Country__c = 'India';   
        qcc.Validated__c = true;
        qcc.Tax_Percentage__c=18;
        qcc.Approval_Status_Overall__c ='Pending'; 
        // insert qcc;
        listq.add(qcc);
        
        QuotesN__c qc = new QuotesN__c();  
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=no.id;
        // qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=True;
        qc.Level_3_Approval_Done__c = true;
        qc.Selling_Country__c = 'India';
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Selling_Country__c = 'India';   
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        qc.Approval_Status_Overall__c ='Pending';
        
        listq.add(qc);
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc1.CurrencyIsoCode ='INR';
        qc1.Active__c=True;
        qc1.Level_3_Approval_Done__c = true;
        qc1.Selling_Country__c = 'India';
        qc1.Finalised__c = true;
        qc1.Approval_Status_Overall__c = 'Pending';
        qc1.Billing_Address__c = 'Account Billing Address';
        qc1.Posting_Address__c = 'Account Billing Address';
        qc1.Selling_Country__c = 'India';   
        qc1.Validated__c = true;
        qc1.Tax_Percentage__c=18;
        qc1.Approval_Status_Overall__c ='Pending';
        listq.add(qc1);
        
        QuotesN__c qc2 = new QuotesN__c();  
        qc2.Account__c=a.id;
        qc2.Contact__c=c.id;
        qc2.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc2.CurrencyIsoCode ='INR';
        qc2.Active__c=True;
        qc2.Level_3_Approval_Done__c = true;
        qc2.Selling_Country__c = 'India';
        qc2.Finalised__c = true;
        qc2.Approval_Status_Overall__c = 'Pending';
        qc2.Billing_Address__c = 'Account Billing Address';
        qc2.Posting_Address__c = 'Account Billing Address';
        qc2.Selling_Country__c = 'India';   
        qc2.Validated__c = true;
        qc2.Tax_Percentage__c=18;
        qc2.Approval_Status_Overall__c ='Pending';
        listq.add(qc2);
        
        QuotesN__c qc4 = new QuotesN__c();  
        qc4.Account__c=a.id;
        qc4.Contact__c=c.id;
        qc4.Opportunities__c=no.id;
        //  qc1.Price_Master__c=pm.id;
        qc4.CurrencyIsoCode ='INR';
        qc4.Active__c=True;
        qc4.Level_3_Approval_Done__c = true;
        qc4.Selling_Country__c = 'India';
        qc4.Finalised__c = true;
        qc4.Approval_Status_Overall__c = 'Pending';
        qc4.Billing_Address__c = 'Account Billing Address';
        qc4.Posting_Address__c = 'Account Billing Address';
        qc4.Selling_Country__c = 'India';   
        qc4.Validated__c = true;
        qc4.Tax_Percentage__c=18;
        qc4.Approval_Status_Overall__c ='Pending';
        listq.add(qc4);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c qlE = new Quote_Line_Items__c();
        qlE.Quotes__c = qc.Id;
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
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qc1.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 511000.00;
        ql1.Gross_Total__c = 766500.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 500;
        ql1.Unit_Price__c = 5840.00;
        ql1.Quantity_Unit__c = 4;
        ql1.Base_Total__c = 1277500.00; 
        qulist1.add(ql1);
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc2.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        ql2.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India';
        ql2.Tenure_Months__c = '12 Months';
        ql2.Discount_Value__c = 511000.00;
        ql2.Gross_Total__c = 766500.00;
        ql2.Adjustment_Type__c ='Amount';
        ql2.Adjusted_Value__c = 700;
        ql2.Unit_Price__c = 5840.00;
        ql2.Quantity_Unit__c = 4;
        ql2.Base_Total__c = 1277500.00; 
        qulist1.add(ql2);
        
        Quote_Line_Items__c qla = new Quote_Line_Items__c();
        qla.Quotes__c = qcca.Id;
        qla.Account__c = a.id;
        qla.Opportunities__c = no.id;
        qla.Product__c = pca.Id;
        qla.Price_Master__c = pm.Id;
        qla.Product_Industry__c = 'Full';
        qla.Product_Geo_Scope__c ='All';
        qla.Product_Country__c = 'APAC without India';
        qla.Tenure_Months__c = '12 Months';
        qla.Discount_Value__c = 511000.00;
        qla.Gross_Total__c = 766500.00;
        qla.Adjustment_Type__c ='Amount';
        qla.Adjusted_Value__c = 500;
        qla.Unit_Price__c = 5840.00;
        qla.Quantity_Unit__c = 4;
        qla.Base_Total__c = 1277500.00; 
        qulist1.add(qla);
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qc4.Id;
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
        ql4.Adjusted_Value__c = 2000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        
        insert qulist1;
        
        qc1.Approval_Status_Overall__c ='Submitted';
        qc1.Level_1_Approval_Done__c = true;
        update qc1;
        
        qc2.Approval_Status_Overall__c ='Submitted';
        qc2.Level_1_Approval_Done__c = true;
        qc2.Level_2_Approval_Done__c = true;
        update qc2;
        qc2.Opportunities__c = n1.Id;
        update qc2;
        qc2.Opportunities__c = n2.Id;
        update qc2;
        
        qcca.Approval_Status_Overall__c ='Submitted';
        qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = true;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Opportunities__c = n1.Id;
        update qcca; 
        qcca.Opportunities__c = n2.Id;
        //   update qcca; 
        qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = false;
        update   qcca;      
        qc4.Approval_Status_Overall__c ='Submitted';
        qc4.Opportunities__c = n1.id;
        qc4.Level_3_Approval_Done__c = true;
        // qc4.Level_2_Approval_Done__c = true;
        update qc4;
        qc4.Opportunities__c = n2.id;
        
        //  update qc4;
        test.stopTest();
        
    }
    
    public @istest static void testdata2(){  
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
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='PH FS');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='IN TS');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='ME FS');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        
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
        
        OpportunityN__c n1 = new OpportunityN__c();
        n1.Account__c= a.id;
        n1.Contact__c=c.id;
        n1.Close_Date__c = date.today().adddays(10);
        n1.Closure_Week__c ='Week-2';
        n1.Closure_probablity__c ='Will';
        n1.Expected_Revenue__c=12121222;
        n1.Price_Master__c = pm.Id; 
        n1.Stage__c = 'Proposal Sent';
        n1.Opportunity_Type__c='free trial'; 
        n1.Actual_Revenue__c= 12131;
        n1.OwnerId = u1.Id;
        
        oplist.add(n1);
        
        OpportunityN__c n2 = new OpportunityN__c();
        n2.Account__c= a.id;
        n2.Contact__c=c.id;
        // n2.Price_Master__c=pm.id;
        n2.Close_Date__c = date.today().adddays(10);
        n2.Closure_Week__c ='Week-2';
        n2.Closure_probablity__c ='Will';
        n2.Expected_Revenue__c=12121222;
        n2.Price_Master__c = pm.Id; 
        n2.Stage__c = 'Proposal Sent';
        n2.Opportunity_Type__c='free trial'; 
        n2.Actual_Revenue__c= 12131;
        n2.OwnerId = u2.Id; 
        oplist.add(n2); 
        insert oplist;
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
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
        // insert qcc;
        listq.add(qcca);
        
        
        
        QuotesN__c qc = new QuotesN__c();  
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=no.id;
        // qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=True;
        qc.Level_3_Approval_Done__c = true;
        qc.Selling_Country__c = 'India';
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Selling_Country__c = 'India';   
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        qc.Approval_Status_Overall__c ='Pending';
        
        listq.add(qc);
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc1.CurrencyIsoCode ='INR';
        qc1.Active__c=True;
        qc1.Level_3_Approval_Done__c = true;
        qc1.Selling_Country__c = 'India';
        qc1.Finalised__c = true;
        qc1.Approval_Status_Overall__c = 'Pending';
        qc1.Billing_Address__c = 'Account Billing Address';
        qc1.Posting_Address__c = 'Account Billing Address';
        qc1.Selling_Country__c = 'India';   
        qc1.Validated__c = true;
        qc1.Tax_Percentage__c=18;
        qc1.Approval_Status_Overall__c ='Pending';
        listq.add(qc1);
        
        QuotesN__c qc2 = new QuotesN__c();  
        qc2.Account__c=a.id;
        qc2.Contact__c=c.id;
        qc2.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc2.CurrencyIsoCode ='INR';
        qc2.Active__c=True;
        qc2.Level_3_Approval_Done__c = true;
        qc2.Selling_Country__c = 'India';
        qc2.Finalised__c = true;
        qc2.Approval_Status_Overall__c = 'Pending';
        qc2.Billing_Address__c = 'Account Billing Address';
        qc2.Posting_Address__c = 'Account Billing Address';
        qc2.Selling_Country__c = 'India';   
        qc2.Validated__c = true;
        qc2.Tax_Percentage__c=18;
        qc2.Approval_Status_Overall__c ='Pending';
        listq.add(qc2);
        
        QuotesN__c qc4 = new QuotesN__c();  
        qc4.Account__c=a.id;
        qc4.Contact__c=c.id;
        qc4.Opportunities__c=no.id;
        //  qc1.Price_Master__c=pm.id;
        qc4.CurrencyIsoCode ='INR';
        qc4.Active__c=True;
        qc4.Level_3_Approval_Done__c = true;
        qc4.Selling_Country__c = 'India';
        qc4.Finalised__c = true;
        qc4.Approval_Status_Overall__c = 'Pending';
        qc4.Billing_Address__c = 'Account Billing Address';
        qc4.Posting_Address__c = 'Account Billing Address';
        qc4.Selling_Country__c = 'India';   
        qc4.Validated__c = true;
        qc4.Tax_Percentage__c=18;
        qc4.Approval_Status_Overall__c ='Pending';
        listq.add(qc4);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c qlE = new Quote_Line_Items__c();
        qlE.Quotes__c = qc.Id;
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
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qc1.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 511000.00;
        ql1.Gross_Total__c = 766500.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 500;
        ql1.Unit_Price__c = 5840.00;
        ql1.Quantity_Unit__c = 4;
        ql1.Base_Total__c = 1277500.00; 
        qulist1.add(ql1);
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc2.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        ql2.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India';
        ql2.Tenure_Months__c = '12 Months';
        ql2.Discount_Value__c = 511000.00;
        ql2.Gross_Total__c = 766500.00;
        ql2.Adjustment_Type__c ='Amount';
        ql2.Adjusted_Value__c = 700;
        ql2.Unit_Price__c = 5840.00;
        ql2.Quantity_Unit__c = 4;
        ql2.Base_Total__c = 1277500.00; 
        qulist1.add(ql2);
        
        Quote_Line_Items__c qla = new Quote_Line_Items__c();
        qla.Quotes__c = qcca.Id;
        qla.Account__c = a.id;
        qla.Opportunities__c = no.id;
        qla.Product__c = pca.Id;
        qla.Price_Master__c = pm.Id;
        qla.Product_Industry__c = 'Full';
        qla.Product_Geo_Scope__c ='All';
        qla.Product_Country__c = 'APAC without India';
        qla.Tenure_Months__c = '12 Months';
        qla.Discount_Value__c = 511000.00;
        qla.Gross_Total__c = 766500.00;
        qla.Adjustment_Type__c ='Amount';
        qla.Adjusted_Value__c = 500;
        qla.Unit_Price__c = 5840.00;
        qla.Quantity_Unit__c = 4;
        qla.Base_Total__c = 1277500.00; 
        qulist1.add(qla);
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qc4.Id;
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
        ql4.Adjusted_Value__c = 2000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        
        insert qulist1;
        
        qc1.Approval_Status_Overall__c ='Submitted';
        qc1.Level_1_Approval_Done__c = true;
        update qc1;
        
        qc2.Approval_Status_Overall__c ='Submitted';
        qc2.Level_1_Approval_Done__c = true;
        qc2.Level_2_Approval_Done__c = true;
        update qc2;
        qc2.Opportunities__c = n1.Id;
        update qc2;
        qc2.Opportunities__c = n2.Id;
        update qc2;
        
        qcca.Approval_Status_Overall__c ='Submitted';
        qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = true;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Opportunities__c = n1.Id;
        update qcca; 
        qcca.Opportunities__c = n2.Id;
        //   update qcca; 
        // qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = true;
        update   qcca;      
        qc4.Approval_Status_Overall__c ='Submitted';
        qc4.Opportunities__c = n1.id;
        qc4.Level_1_Approval_Done__c = true;
        qc4.Level_2_Approval_Done__c = false;
        update qc4;
        
        
        //    update qc4;
        test.stopTest();
        
    }
    
    
    public @istest static void testdata3(){  
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
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='ME TS');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='MMW');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='MY FS');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        
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
        
        OpportunityN__c n1 = new OpportunityN__c();
        n1.Account__c= a.id;
        n1.Contact__c=c.id;
        n1.Close_Date__c = date.today().adddays(10);
        n1.Closure_Week__c ='Week-2';
        n1.Closure_probablity__c ='Will';
        n1.Expected_Revenue__c=12121222;
        n1.Price_Master__c = pm.Id; 
        n1.Stage__c = 'Proposal Sent';
        n1.Opportunity_Type__c='free trial'; 
        n1.Actual_Revenue__c= 12131;
        n1.OwnerId = u1.Id;
        
        oplist.add(n1);
        
        OpportunityN__c n2 = new OpportunityN__c();
        n2.Account__c= a.id;
        n2.Contact__c=c.id;
        // n2.Price_Master__c=pm.id;
        n2.Close_Date__c = date.today().adddays(10);
        n2.Closure_Week__c ='Week-2';
        n2.Closure_probablity__c ='Will';
        n2.Expected_Revenue__c=12121222;
        n2.Price_Master__c = pm.Id; 
        n2.Stage__c = 'Proposal Sent';
        n2.Opportunity_Type__c='free trial'; 
        n2.Actual_Revenue__c= 12131;
        n2.OwnerId = u2.Id; 
        oplist.add(n2); 
        insert oplist;
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
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
        // insert qcc;
        listq.add(qcca);
        
        
        
        QuotesN__c qc = new QuotesN__c();  
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=no.id;
        // qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=True;
        qc.Level_3_Approval_Done__c = true;
        qc.Selling_Country__c = 'India';
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Selling_Country__c = 'India';   
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        qc.Approval_Status_Overall__c ='Pending';
        
        listq.add(qc);
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc1.CurrencyIsoCode ='INR';
        qc1.Active__c=True;
        qc1.Level_3_Approval_Done__c = true;
        qc1.Selling_Country__c = 'India';
        qc1.Finalised__c = true;
        qc1.Approval_Status_Overall__c = 'Pending';
        qc1.Billing_Address__c = 'Account Billing Address';
        qc1.Posting_Address__c = 'Account Billing Address';
        qc1.Selling_Country__c = 'India';   
        qc1.Validated__c = true;
        qc1.Tax_Percentage__c=18;
        qc1.Approval_Status_Overall__c ='Pending';
        listq.add(qc1);
        
        QuotesN__c qc2 = new QuotesN__c();  
        qc2.Account__c=a.id;
        qc2.Contact__c=c.id;
        qc2.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc2.CurrencyIsoCode ='INR';
        qc2.Active__c=True;
        qc2.Level_3_Approval_Done__c = true;
        qc2.Selling_Country__c = 'India';
        qc2.Finalised__c = true;
        qc2.Approval_Status_Overall__c = 'Pending';
        qc2.Billing_Address__c = 'Account Billing Address';
        qc2.Posting_Address__c = 'Account Billing Address';
        qc2.Selling_Country__c = 'India';   
        qc2.Validated__c = true;
        qc2.Tax_Percentage__c=18;
        qc2.Approval_Status_Overall__c ='Pending';
        listq.add(qc2);
        
        QuotesN__c qc4 = new QuotesN__c();  
        qc4.Account__c=a.id;
        qc4.Contact__c=c.id;
        qc4.Opportunities__c=no.id;
        //  qc1.Price_Master__c=pm.id;
        qc4.CurrencyIsoCode ='INR';
        qc4.Active__c=True;
        qc4.Level_3_Approval_Done__c = true;
        qc4.Selling_Country__c = 'India';
        qc4.Finalised__c = true;
        qc4.Approval_Status_Overall__c = 'Pending';
        qc4.Billing_Address__c = 'Account Billing Address';
        qc4.Posting_Address__c = 'Account Billing Address';
        qc4.Selling_Country__c = 'India';   
        qc4.Validated__c = true;
        qc4.Tax_Percentage__c=18;
        qc4.Approval_Status_Overall__c ='Pending';
        listq.add(qc4);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c qlE = new Quote_Line_Items__c();
        qlE.Quotes__c = qc.Id;
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
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qc1.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 511000.00;
        ql1.Gross_Total__c = 766500.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 500;
        ql1.Unit_Price__c = 5840.00;
        ql1.Quantity_Unit__c = 4;
        ql1.Base_Total__c = 1277500.00; 
        qulist1.add(ql1);
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc2.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        ql2.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India';
        ql2.Tenure_Months__c = '12 Months';
        ql2.Discount_Value__c = 511000.00;
        ql2.Gross_Total__c = 766500.00;
        ql2.Adjustment_Type__c ='Amount';
        ql2.Adjusted_Value__c = 700;
        ql2.Unit_Price__c = 5840.00;
        ql2.Quantity_Unit__c = 4;
        ql2.Base_Total__c = 1277500.00; 
        qulist1.add(ql2);
        
        Quote_Line_Items__c qla = new Quote_Line_Items__c();
        qla.Quotes__c = qcca.Id;
        qla.Account__c = a.id;
        qla.Opportunities__c = no.id;
        qla.Product__c = pca.Id;
        qla.Price_Master__c = pm.Id;
        qla.Product_Industry__c = 'Full';
        qla.Product_Geo_Scope__c ='All';
        qla.Product_Country__c = 'APAC without India';
        qla.Tenure_Months__c = '12 Months';
        qla.Discount_Value__c = 511000.00;
        qla.Gross_Total__c = 766500.00;
        qla.Adjustment_Type__c ='Amount';
        qla.Adjusted_Value__c = 500;
        qla.Unit_Price__c = 5840.00;
        qla.Quantity_Unit__c = 4;
        qla.Base_Total__c = 1277500.00; 
        qulist1.add(qla);
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qc4.Id;
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
        ql4.Adjusted_Value__c = 2000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        
        insert qulist1;
        
        qc1.Approval_Status_Overall__c ='Submitted';
        qc1.Level_1_Approval_Done__c = true;
        update qc1;
        
        qc2.Approval_Status_Overall__c ='Submitted';
        qc2.Level_1_Approval_Done__c = true;
        qc2.Level_2_Approval_Done__c = true;
        update qc2;
        qc2.Opportunities__c = n1.Id;
        update qc2;
        qc2.Opportunities__c = n2.Id;
        update qc2;
        
        qcca.Approval_Status_Overall__c ='Submitted';
        qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = true;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Opportunities__c = n1.Id;
        update qcca; 
        qcca.Opportunities__c = n2.Id;
        //   update qcca; 
        // qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = true;
        update   qcca;      
        qc4.Approval_Status_Overall__c ='Submitted';
        qc4.Opportunities__c = n1.id; 
        qc4.Level_1_Approval_Done__c =true;
        qc4.Level_2_Approval_Done__c = false;
        update qc4;
        
        
        //    update qc4;
        test.stopTest();
        
    }
    
    
    public @istest static void testdata4(){  
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
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='SEA TS');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='SG FS');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='SMB');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        
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
        
        OpportunityN__c n1 = new OpportunityN__c();
        n1.Account__c= a.id;
        n1.Contact__c=c.id;
        n1.Close_Date__c = date.today().adddays(10);
        n1.Closure_Week__c ='Week-2';
        n1.Closure_probablity__c ='Will';
        n1.Expected_Revenue__c=12121222;
        n1.Price_Master__c = pm.Id; 
        n1.Stage__c = 'Proposal Sent';
        n1.Opportunity_Type__c='free trial'; 
        n1.Actual_Revenue__c= 12131;
        n1.OwnerId = u1.Id;
        
        oplist.add(n1);
        
        OpportunityN__c n2 = new OpportunityN__c();
        n2.Account__c= a.id;
        n2.Contact__c=c.id;
        // n2.Price_Master__c=pm.id;
        n2.Close_Date__c = date.today().adddays(10);
        n2.Closure_Week__c ='Week-2';
        n2.Closure_probablity__c ='Will';
        n2.Expected_Revenue__c=12121222;
        n2.Price_Master__c = pm.Id; 
        n2.Stage__c = 'Proposal Sent';
        n2.Opportunity_Type__c='free trial'; 
        n2.Actual_Revenue__c= 12131;
        n2.OwnerId = u2.Id; 
        oplist.add(n2); 
        insert oplist;
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
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
        // insert qcc;
        listq.add(qcca);
        
        
        
        QuotesN__c qc = new QuotesN__c();  
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=no.id;
        // qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=True;
        qc.Level_3_Approval_Done__c = true;
        qc.Selling_Country__c = 'India';
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Selling_Country__c = 'India';   
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        qc.Approval_Status_Overall__c ='Pending';
        
        listq.add(qc);
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc1.CurrencyIsoCode ='INR';
        qc1.Active__c=True;
        qc1.Level_3_Approval_Done__c = true;
        qc1.Selling_Country__c = 'India';
        qc1.Finalised__c = true;
        qc1.Approval_Status_Overall__c = 'Pending';
        qc1.Billing_Address__c = 'Account Billing Address';
        qc1.Posting_Address__c = 'Account Billing Address';
        qc1.Selling_Country__c = 'India';   
        qc1.Validated__c = true;
        qc1.Tax_Percentage__c=18;
        qc1.Approval_Status_Overall__c ='Pending';
        listq.add(qc1);
        
        QuotesN__c qc2 = new QuotesN__c();  
        qc2.Account__c=a.id;
        qc2.Contact__c=c.id;
        qc2.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc2.CurrencyIsoCode ='INR';
        qc2.Active__c=True;
        qc2.Level_3_Approval_Done__c = true;
        qc2.Selling_Country__c = 'India';
        qc2.Finalised__c = true;
        qc2.Approval_Status_Overall__c = 'Pending';
        qc2.Billing_Address__c = 'Account Billing Address';
        qc2.Posting_Address__c = 'Account Billing Address';
        qc2.Selling_Country__c = 'India';   
        qc2.Validated__c = true;
        qc2.Tax_Percentage__c=18;
        qc2.Approval_Status_Overall__c ='Pending';
        listq.add(qc2);
        
        QuotesN__c qc4 = new QuotesN__c();  
        qc4.Account__c=a.id;
        qc4.Contact__c=c.id;
        qc4.Opportunities__c=no.id;
        //  qc1.Price_Master__c=pm.id;
        qc4.CurrencyIsoCode ='INR';
        qc4.Active__c=True;
        qc4.Level_3_Approval_Done__c = true;
        qc4.Selling_Country__c = 'India';
        qc4.Finalised__c = true;
        qc4.Approval_Status_Overall__c = 'Pending';
        qc4.Billing_Address__c = 'Account Billing Address';
        qc4.Posting_Address__c = 'Account Billing Address';
        qc4.Selling_Country__c = 'India';   
        qc4.Validated__c = true;
        qc4.Tax_Percentage__c=18;
        qc4.Approval_Status_Overall__c ='Pending';
        listq.add(qc4);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c qlE = new Quote_Line_Items__c();
        qlE.Quotes__c = qc.Id;
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
        
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        ql1.Quotes__c = qc1.Id;
        ql1.Account__c = a.id;
        ql1.Opportunities__c = no.id;
        ql1.Product__c = pc.Id;
        ql1.Price_Master__c = pm.Id;
        ql1.Product_Industry__c = 'Full';
        ql1.Product_Geo_Scope__c ='All';
        ql1.Product_Country__c = 'APAC without India';
        ql1.Tenure_Months__c = '12 Months';
        ql1.Discount_Value__c = 511000.00;
        ql1.Gross_Total__c = 766500.00;
        ql1.Adjustment_Type__c ='Amount';
        ql1.Adjusted_Value__c = 500;
        ql1.Unit_Price__c = 5840.00;
        ql1.Quantity_Unit__c = 4;
        ql1.Base_Total__c = 1277500.00; 
        qulist1.add(ql1);
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc2.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        ql2.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India';
        ql2.Tenure_Months__c = '12 Months';
        ql2.Discount_Value__c = 511000.00;
        ql2.Gross_Total__c = 766500.00;
        ql2.Adjustment_Type__c ='Amount';
        ql2.Adjusted_Value__c = 700;
        ql2.Unit_Price__c = 5840.00;
        ql2.Quantity_Unit__c = 4;
        ql2.Base_Total__c = 1277500.00; 
        qulist1.add(ql2);
        
        Quote_Line_Items__c qla = new Quote_Line_Items__c();
        qla.Quotes__c = qcca.Id;
        qla.Account__c = a.id;
        qla.Opportunities__c = no.id;
        qla.Product__c = pca.Id;
        qla.Price_Master__c = pm.Id;
        qla.Product_Industry__c = 'Full';
        qla.Product_Geo_Scope__c ='All';
        qla.Product_Country__c = 'APAC without India';
        qla.Tenure_Months__c = '12 Months';
        qla.Discount_Value__c = 511000.00;
        qla.Gross_Total__c = 766500.00;
        qla.Adjustment_Type__c ='Amount';
        qla.Adjusted_Value__c = 500;
        qla.Unit_Price__c = 5840.00;
        qla.Quantity_Unit__c = 4;
        qla.Base_Total__c = 1277500.00; 
        qulist1.add(qla);
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qc4.Id;
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
        ql4.Adjusted_Value__c = 2000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        
        insert qulist1;
        
        qc1.Approval_Status_Overall__c ='Submitted';
        qc1.Level_1_Approval_Done__c = true;
        update qc1;
        
        qc2.Approval_Status_Overall__c ='Submitted';
        qc2.Level_1_Approval_Done__c = true;
        qc2.Level_2_Approval_Done__c = true;
        update qc2;
        qc2.Opportunities__c = n1.Id;
        update qc2;
        qc2.Opportunities__c = n2.Id;
        update qc2;
        
        qcca.Approval_Status_Overall__c ='Submitted';
        qcca.Level_1_Approval_Done__c = true;
        qcca.Level_2_Approval_Done__c = true;
        qcca.Level_3_Approval_Done__c = true;
        qcca.Opportunities__c = n1.Id;
        update qcca; 
        qcca.Opportunities__c = n2.Id;
        
        qcca.Level_2_Approval_Done__c = true;
        update   qcca;      
        qc4.Approval_Status_Overall__c ='Submitted';
        qc4.Opportunities__c = n1.id; 
        qc4.Level_1_Approval_Done__c =true;
        qc4.Level_2_Approval_Done__c = false;
        update qc4;
        
        
        //    update qc4;
        test.stopTest();
        
    }
    
    public @istest static void testdata5l4(){  
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
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='IND ENT');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='ME FS');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='MY FS');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        
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
        
        
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
        insert pm;
        
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
        
        OpportunityN__c n1 = new OpportunityN__c();
        n1.Account__c= a.id;
        n1.Contact__c=c.id;
        n1.Close_Date__c = date.today().adddays(10);
        n1.Closure_Week__c ='Week-2';
        n1.Closure_probablity__c ='Will';
        n1.Expected_Revenue__c=12121222;
        n1.Price_Master__c = pm.Id; 
        n1.Stage__c = 'Proposal Sent';
        n1.Opportunity_Type__c='free trial'; 
        n1.Actual_Revenue__c= 12131;
        n1.OwnerId = u1.Id;
        
        oplist.add(n1);
        
        OpportunityN__c n2 = new OpportunityN__c();
        n2.Account__c= a.id;
        n2.Contact__c=c.id;
        // n2.Price_Master__c=pm.id;
        n2.Close_Date__c = date.today().adddays(10);
        n2.Closure_Week__c ='Week-2';
        n2.Closure_probablity__c ='Will';
        n2.Expected_Revenue__c=12121222;
        n2.Price_Master__c = pm.Id; 
        n2.Stage__c = 'Proposal Sent';
        n2.Opportunity_Type__c='free trial'; 
        n2.Actual_Revenue__c= 12131;
        n2.OwnerId = u2.Id; 
        oplist.add(n2); 
        insert oplist;
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();  
        
        
        QuotesN__c qc4 = new QuotesN__c();  
        qc4.Account__c=a.id;
        qc4.Contact__c=c.id;
        qc4.Opportunities__c=no.id;
        //  qc1.Price_Master__c=pm.id;
        qc4.CurrencyIsoCode ='INR';
        qc4.Active__c=True;
        qc4.Level_3_Approval_Done__c = true;
        qc4.Selling_Country__c = 'India';
        qc4.Finalised__c = true;
        qc4.Approval_Status_Overall__c = 'Pending';
        qc4.Billing_Address__c = 'Account Billing Address';
        qc4.Posting_Address__c = 'Account Billing Address';
        qc4.Selling_Country__c = 'India';   
        qc4.Validated__c = true;
        qc4.Tax_Percentage__c=18;
        qc4.Approval_Status_Overall__c ='Pending';
        listq.add(qc4);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>(); 
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qc4.Id;
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
        ql4.Adjusted_Value__c = 2000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        
        insert qulist1; 
        qc4.Opportunities__c = n1.Id;
        
        qc4.Level_2_Approval_Done__c =false;
        qc4.Level_1_Approval_Done__c =true;
        update qc4; 
        qc4.Opportunities__c = n2.Id; 
        qc4.Approval_Status_Overall__c = 'Submitted';
        qc4.Level_2_Approval_Done__c =false;
        qc4.Level_1_Approval_Done__c =true;
        update qc4;
        test.stopTest();
        
    }
    
    
    public @istest static void testdata6l4(){  
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
        
        insert tlist;
        
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu = new User(Alias = 'absduu', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu@start.com',email='absduu@gmail.com',Channel__c='ZUNO');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu', 
                           EmailEncodingKey='UTF-8', LastName='sdscu', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='SMB');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdsc2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd2@start.com',email='absd2@gmail.com',Channel__c='MY FS');
        
        
        ulist.add(u2);
        
        
        insert ulist;
        
        
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
        
        OpportunityN__c n1 = new OpportunityN__c();
        n1.Account__c= a.id;
        n1.Contact__c=c.id;
        n1.Close_Date__c = date.today().adddays(10);
        n1.Closure_Week__c ='Week-2';
        n1.Closure_probablity__c ='Will';
        n1.Expected_Revenue__c=12121222;
        n1.Price_Master__c = pm.Id; 
        n1.Stage__c = 'Proposal Sent';
        n1.Opportunity_Type__c='free trial'; 
        n1.Actual_Revenue__c= 12131;
        n1.OwnerId = u1.Id;
        
        oplist.add(n1);
        
        OpportunityN__c n2 = new OpportunityN__c();
        n2.Account__c= a.id;
        n2.Contact__c=c.id;
        // n2.Price_Master__c=pm.id;
        n2.Close_Date__c = date.today().adddays(10);
        n2.Closure_Week__c ='Week-2';
        n2.Closure_probablity__c ='Will';
        n2.Expected_Revenue__c=12121222;
        n2.Price_Master__c = pm.Id; 
        n2.Stage__c = 'Proposal Sent';
        n2.Opportunity_Type__c='free trial'; 
        n2.Actual_Revenue__c= 12131;
        n2.OwnerId = u2.Id; 
        oplist.add(n2); 
        insert oplist;
        test.startTest();
        list<QuotesN__c> listq=new list<QuotesN__c>();  
        
             QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c='Free Trial'; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
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
        // insert qcc;
        listq.add(qcca);
        
        QuotesN__c qc2 = new QuotesN__c();  
        
        qc2.Account__c=a.id;
        qc2.Contact__c=c.id;
        qc2.Opportunities__c=no.id;
        //   qc1.Price_Master__c=pm.id;
        qc2.CurrencyIsoCode ='INR';
        qc2.Active__c=True;
        qc2.Level_3_Approval_Done__c = true;
        qc2.Selling_Country__c = 'India';
        qc2.Finalised__c = true;
        qc2.Approval_Status_Overall__c = 'Pending';
        qc2.Billing_Address__c = 'Account Billing Address';
        qc2.Posting_Address__c = 'Account Billing Address';
        qc2.Selling_Country__c = 'India';   
        qc2.Validated__c = true;
        qc2.Tax_Percentage__c=18;
        qc2.Approval_Status_Overall__c ='Pending';
        listq.add(qc2);       
        QuotesN__c qc4 = new QuotesN__c();  
        qc4.Account__c=a.id;
        qc4.Contact__c=c.id;
        qc4.Opportunities__c=no.id;
        //  qc1.Price_Master__c=pm.id;
        qc4.CurrencyIsoCode ='INR';
        qc4.Active__c=True;
        qc4.Level_3_Approval_Done__c = true;
        qc4.Selling_Country__c = 'India';
        qc4.Finalised__c = true;
        qc4.Approval_Status_Overall__c = 'Pending';
        qc4.Billing_Address__c = 'Account Billing Address';
        qc4.Posting_Address__c = 'Account Billing Address';
        qc4.Selling_Country__c = 'India';   
        qc4.Validated__c = true;
        qc4.Tax_Percentage__c=18;
        qc4.Approval_Status_Overall__c ='Pending';
        listq.add(qc4);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>(); 
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qc4.Id;
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
        ql4.Adjusted_Value__c = 2000;
        ql4.Unit_Price__c = 5840.00;
        ql4.Quantity_Unit__c = 4;
        ql4.Base_Total__c = 1277500.00; 
        qulist1.add(ql4);
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc2.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        ql2.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India';
        ql2.Tenure_Months__c = '12 Months';
        ql2.Discount_Value__c = 511000.00;
        ql2.Gross_Total__c = 766500.00;
        ql2.Adjustment_Type__c ='Amount';
        ql2.Adjusted_Value__c = 700;
        ql2.Unit_Price__c = 5840.00;
        ql2.Quantity_Unit__c = 4;
        ql2.Base_Total__c = 1277500.00; 
        qulist1.add(ql2);
        
           Quote_Line_Items__c qla = new Quote_Line_Items__c();
        qla.Quotes__c = qcca.Id;
        qla.Account__c = a.id;
        qla.Opportunities__c = no.id;
        qla.Product__c = pca.Id;
        qla.Price_Master__c = pm.Id;
        qla.Product_Industry__c = 'Full';
        qla.Product_Geo_Scope__c ='All';
        qla.Product_Country__c = 'APAC without India';
        qla.Tenure_Months__c = '12 Months';
        qla.Discount_Value__c = 511000.00;
        qla.Gross_Total__c = 766500.00;
        qla.Adjustment_Type__c ='Amount';
        qla.Adjusted_Value__c = 500;
        qla.Unit_Price__c = 5840.00;
        qla.Quantity_Unit__c = 4;
        qla.Base_Total__c = 1277500.00; 
         
        qulist1.add(qla);
        
        insert qulist1; 
      
       qcca.Level_2_Approval_Done__c = true;
        update qcca;
        
        qc4.Opportunities__c = n1.Id;
        
        qc4.Level_2_Approval_Done__c =false;
        qc4.Level_1_Approval_Done__c =true;
        update qc4; 
        qc4.Opportunities__c = n2.Id; 
        qc4.Approval_Status_Overall__c = 'Submitted';
        qc4.Level_2_Approval_Done__c =false;
        qc4.Level_1_Approval_Done__c =true;
        update qc4;
        test.stopTest();
        
    }
    
}