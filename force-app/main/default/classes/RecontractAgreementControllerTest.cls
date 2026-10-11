//Last Modified By  : Abdul Aziz , Last Modified Date : 29/04/2024 , Test class for RecontractAgreementController 
@isTest
public class RecontractAgreementControllerTest {
    public @istest static void mycreatequotemethod(){
        
        test.startTest();
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
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = false);
        tlist.add(tshareorder);
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(SharePortfolio);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        insert tlist;
        
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
                            Channel__c='EA',
                            ManagerId = userinfo.getUserId()                            
                           );
        ulist.add(uu1);
        insert ulist;
        
        Guidelines__c g1=new Guidelines__c();
        g1.Name='India';
        g1.GuideLine_Details__c='India';
        insert g1;
        
        Guidelines__c g2=new Guidelines__c();
        g2.Name='SEA';
        g2.GuideLine_Details__c='g2';
        insert g2;
        
        Guidelines__c g3=new Guidelines__c();
        g3.Name='India Checked';
        g3.GuideLine_Details__c='g3';
        insert g3;
        
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
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='RDA';
        pc.Product_Name__c='Agreement PPI';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Price_Master__c=pm.id;
        pc.Product_SKU_Code__c='JPOS1SE00N';
        pc.Product_Description__c='hiuhiuhPPI Ppi ppi';
        pc.Product_Country__c='India';
        pc.Primary_Selling_Country__c='India';
        pc.Tenure_Months__c='12 Months';
        pc.Bin__c='vghvgh';
        pc.Product_Type__c='Upsell';
        pc.CurrencyIsoCode='INR';
        pc.Unit_List_Price_Value__c=200;
        pc.DB_Type_Industry__c='Full';
        pc.DB_Scope_Geography__c='All';
        pc.Discount_Cap__c=12;
        pc.From__c=200;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        pc.Channel__c=uu.Channel__c;
        //pc.Product_Description__c='test PPI test';
        //pc.Product_Country__c='India';
        insert pc;
        pc.Product_Name__c='Agreement PPI';
        //update pc;
        System.debug('Main Product name is  1***'+pc.Main_Product_Type__c);
        System.debug('Product name is  1***'+pc.name);
        System.debug('Product description is 1****'+pc.Product_Description__c);
        
        ProductC__c pc1 = new ProductC__c();
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Name__c='Agreement PPI';
        pc1.Active__c=true;
        pc1.SKU_Type__c='Bundle-x';
        pc1.Product_category__c='Standard';
        pc1.Price_Master__c=pm.id;
        pc1.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc1.Channel__c = '';
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Description__c='hiuhiuhPPI';
        pc1.Product_Country__c='India';
        pc1.Primary_Selling_Country__c='India';
        pc1.Tenure_Months__c='12 Months';
        pc1.Bin__c='vghvgh';
        pc1.Product_Type__c='Upsell';
        pc1.Channel__c=uu.Channel__c;
        pc1.Product_Country__c='India';
        // pc1.Channel__c=	'EA';
        insert pc1;
        pc1.Product_Name__c='Agreement PPI';
        update pc1;
        /* System.debug('Main Product name is  1***'+pc1.Main_Product_Type__c);
System.debug('Product name is  2***'+pc1.name);
System.debug('Product description is 2****'+pc1.Product_Description__c);*/
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
        no.OwnerId = uu.Id; 
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
        tc.Mandatory__c =false;
        update tc;
        
        OPLI_Accessories__c plia = new OPLI_Accessories__c();
        plia.Top_Ups__c= tc.id;
        plia.Account__c=a.id;
        plia.Opp_Line_Item__c=opli.id;
        plia.Opportunities__c=no.id;
        plia.Product__c=pc.id;
        insert plia;
        
        
        PL_Accessories__c pliAcc = new PL_Accessories__c();
        pliAcc.Price_Master__c=pm.id;
        pliAcc.Product__c=pc.id;
        pliAcc.Mandatory__c=true;
        pliAcc.Top_Ups__c=tc.id;
        insert pliAcc;
        
        Xcode__c xc = new Xcode__c();
        xc.Name='12345';
        xc.Created_For_Account__c= a.id;
        insert xc;
        
        list<QuotesN__c>  qlist =new list<QuotesN__c>();
        QuotesN__c qc = new QuotesN__c();
        qc.Quote_Type__c='Free Trial';
        qc.Xcode__c=xc.id;
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=no.id;
        qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=false;
        qc.Selling_Country__c = 'India';
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        qc.Start_Date__c = Date.today();
        qc.OwnerId = uu1.Id;
        qlist.add(qc);
        insert qlist;
        
        List<Quote_Line_Items__c> quliList = new List<Quote_Line_Items__c>();
        Quote_Line_Items__c qli = new Quote_Line_Items__c();
        qli.Quotes__c = qc.Id;
        qli.Account__c = a.id;
        qli.Opportunities__c = no.id;
        qli.Product__c = pc.Id;
        // qli.produ
        qli.Price_Master__c = pm.Id;
        qli.Product_Industry__c = 'Full';
        qli.Product_Geo_Scope__c ='All';
        qli.Product_Country__c = 'APAC without India';
        qli.Tenure_Months__c = '12 Months';
        qli.Discount_Value__c = 511000.00;
        qli.Gross_Total__c = 766500.00;
        qli.Adjusted_Value__c = 40;
        qli.Unit_Price__c = 1277500.00;
        qli.Quantity_Unit__c = 4;
        qli.Base_Total__c = 1277500.00;
        quliList.add(qli);
        insert quliList;
        
        List<QULI_Accessories__c> quliAcc= new List<QULI_Accessories__c>();
        QULI_Accessories__c quliA = new QULI_Accessories__c();
        quliA.Account__c= a.id;
        quliA.CurrencyIsoCode='INR';
        quliA.of_Master_Login__c='5';
        quliA.OPLI_Services__c=plia.id;
        quliA.Inventory_Count__c=10;
        quliA.Quote_Line_Items__c= qli.id;
        quliA.Quotes__c = qc.Id;
        quliA.Top_Ups__c= tc.id;
        quliA.Price_Master__c=pm.id;
        quliA.Product__c=pc.id;
        quliA.Opportunities__c=no.id;
        quliAcc.add(quliA);
        insert quliAcc;
        
        List<QULI_Accessories__c> quliAcc1= new List<QULI_Accessories__c>();
        QULI_Accessories__c quliA1 = new QULI_Accessories__c();
        quliA1.Account__c= a.id;
        quliA1.CurrencyIsoCode='INR';
        quliA1.of_Master_Login__c='5';
        quliA1.OPLI_Services__c=plia.id;
        quliA1.Inventory_Count__c=10;
        quliA1.Quote_Line_Items__c= qli.id;
        quliA1.Quotes__c = qc.Id;
        quliA1.Top_Ups__c= tc.id;
        quliA1.Price_Master__c=pm.id;
        quliA1.Product__c=pc.id;
        quliA1.Opportunities__c=no.id;
        quliAcc1.add(quliA1);
        insert quliAcc1;
        
        ApexPages.currentPage().getParameters().put('id',qc.id );
        ApexPages.currentPage().getParameters().put('showindiachecked', 'false');
        ApexPages.StandardController sc = new ApexPages.standardController(qc);
        // sc.showindiachecked='false';
        FoundIt_IN_STD fc=new FoundIt_IN_STD(sc);
        fc.showindiachecked='false';
        fc.showAccessories='false';
        fc.pli=quliList; 
        
        
        ApexPages.StandardController sc2 = new ApexPages.standardController(qc);
        ApexPages.currentPage().getParameters().put('showindiachecked', 'true');
        // sc.showindiachecked='false';
        FoundIt_IN_STD fc2=new FoundIt_IN_STD(sc2);
        fc2.showindiachecked='false';
        fc2.showAccessories='false';
        fc2.pli=quliList; 
        
    }
    public @istest static void mycreatequotemethod2(){
        
        test.startTest();
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
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = false);
        tlist.add(tshareorder);
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(SharePortfolio);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        insert tlist;
        
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
                            Channel__c='EA',
                            ManagerId = userinfo.getUserId()                            
                           );
        ulist.add(uu1);
        insert ulist;
        
        Guidelines__c g1=new Guidelines__c();
        g1.Name='India';
        g1.GuideLine_Details__c='India';
        insert g1;
        
        Guidelines__c g2=new Guidelines__c();
        g2.Name='SEA';
        g2.GuideLine_Details__c='g2';
        insert g2;
        
        Guidelines__c g3=new Guidelines__c();
        g3.Name='India Checked';
        g3.GuideLine_Details__c='g3';
        insert g3;
        
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
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='RDA';
        pc.Product_Name__c='Custom Product';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Price_Master__c=pm.id;
        pc.Product_SKU_Code__c='JPOS1SE00N';
        pc.Product_Description__c='hiuhiuhPPI Ppi ppi';
        pc.Product_Country__c='India';
        pc.Primary_Selling_Country__c='India';
        pc.Tenure_Months__c='12 Months';
        pc.Bin__c='vghvgh';
        pc.Product_Type__c='Upsell';
        pc.CurrencyIsoCode='INR';
        pc.Unit_List_Price_Value__c=200;
        pc.DB_Type_Industry__c='Full';
        pc.DB_Scope_Geography__c='All';
        pc.Discount_Cap__c=12;
        pc.From__c=200;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        pc.Channel__c=uu.Channel__c;
        //pc.Product_Description__c='test PPI test';
        //pc.Product_Country__c='India';
        insert pc;
        pc.Product_Name__c='Agreement PPI';
        //update pc;
        System.debug('Main Product name is  1***'+pc.Main_Product_Type__c);
        System.debug('Product name is  1***'+pc.name);
        System.debug('Product description is 1****'+pc.Product_Description__c);
        
        ProductC__c pc1 = new ProductC__c();
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Name__c='Agreement PPI';
        pc1.Active__c=true;
        pc1.SKU_Type__c='Bundle-x';
        pc1.Product_category__c='Standard';
        pc1.Price_Master__c=pm.id;
        pc1.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc1.Channel__c = '';
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Description__c='hiuhiuhPPI';
        pc1.Product_Country__c='India';
        pc1.Primary_Selling_Country__c='India';
        pc1.Tenure_Months__c='12 Months';
        pc1.Bin__c='vghvgh';
        pc1.Product_Type__c='Upsell';
        pc1.Channel__c=uu.Channel__c;
        pc1.Product_Country__c='India';
        // pc1.Channel__c=	'EA';
        insert pc1;
        pc1.Product_Name__c='Agreement PPI';
        update pc1;
        /* System.debug('Main Product name is  1***'+pc1.Main_Product_Type__c);
System.debug('Product name is  2***'+pc1.name);
System.debug('Product description is 2****'+pc1.Product_Description__c);*/
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
        no.OwnerId = uu.Id; 
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
        tc.Mandatory__c =false;
        update tc;
        
        OPLI_Accessories__c plia = new OPLI_Accessories__c();
        plia.Top_Ups__c= tc.id;
        plia.Account__c=a.id;
        plia.Opp_Line_Item__c=opli.id;
        plia.Opportunities__c=no.id;
        plia.Product__c=pc.id;
        insert plia;
        
        
        PL_Accessories__c pliAcc = new PL_Accessories__c();
        pliAcc.Price_Master__c=pm.id;
        pliAcc.Product__c=pc.id;
        pliAcc.Mandatory__c=true;
        pliAcc.Top_Ups__c=tc.id;
        insert pliAcc;
        
        Xcode__c xc = new Xcode__c();
        xc.Name='12345';
        xc.Created_For_Account__c= a.id;
        insert xc;
        
        list<QuotesN__c>  qlist =new list<QuotesN__c>();
        QuotesN__c qc = new QuotesN__c();
        qc.Quote_Type__c='Free Trial';
        qc.Xcode__c=xc.id;
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=no.id;
        qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=false;
        qc.Selling_Country__c = 'India';
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        qc.Start_Date__c = Date.today();
        qc.OwnerId = uu1.Id;
        qlist.add(qc);
        insert qlist;
        
        List<Quote_Line_Items__c> quliList = new List<Quote_Line_Items__c>();
        Quote_Line_Items__c qli = new Quote_Line_Items__c();
        qli.Quotes__c = qc.Id;
        qli.Account__c = a.id;
        qli.Opportunities__c = no.id;
        qli.Product__c = pc.Id;
        // qli.produ
        qli.Price_Master__c = pm.Id;
        qli.Product_Industry__c = 'Full';
        qli.Product_Geo_Scope__c ='All';
        qli.Product_Country__c = 'APAC without India';
        qli.Tenure_Months__c = '12 Months';
        qli.Discount_Value__c = 511000.00;
        qli.Gross_Total__c = 766500.00;
        qli.Adjusted_Value__c = 40;
        qli.Unit_Price__c = 1277500.00;
        qli.Quantity_Unit__c = 4;
        qli.Base_Total__c = 1277500.00;
        quliList.add(qli);
        insert quliList;
        
        List<QULI_Accessories__c> quliAcc= new List<QULI_Accessories__c>();
        QULI_Accessories__c quliA = new QULI_Accessories__c();
        quliA.Account__c= a.id;
        quliA.CurrencyIsoCode='INR';
        quliA.of_Master_Login__c='5';
        quliA.OPLI_Services__c=plia.id;
        quliA.Inventory_Count__c=10;
        quliA.Quote_Line_Items__c= qli.id;
        quliA.Quotes__c = qc.Id;
        quliA.Top_Ups__c= tc.id;
        quliA.Price_Master__c=pm.id;
        quliA.Product__c=pc.id;
        quliA.Opportunities__c=no.id;
        quliAcc.add(quliA);
        insert quliAcc;
        
        List<QULI_Accessories__c> quliAcc1= new List<QULI_Accessories__c>();
        QULI_Accessories__c quliA1 = new QULI_Accessories__c();
        quliA1.Account__c= a.id;
        quliA1.CurrencyIsoCode='INR';
        quliA1.of_Master_Login__c='5';
        quliA1.OPLI_Services__c=plia.id;
        quliA1.Inventory_Count__c=10;
        quliA1.Quote_Line_Items__c= qli.id;
        quliA1.Quotes__c = qc.Id;
        quliA1.Top_Ups__c= tc.id;
        quliA1.Price_Master__c=pm.id;
        quliA1.Product__c=pc.id;
        quliA1.Opportunities__c=no.id;
        quliAcc1.add(quliA1);
        insert quliAcc1;
        
        ApexPages.currentPage().getParameters().put('id',qc.id );
        ApexPages.currentPage().getParameters().put('showindiachecked', 'false');
        ApexPages.StandardController sc = new ApexPages.standardController(qc);
        // sc.showindiachecked='false';
        RecontractAgreementController fc=new RecontractAgreementController(sc);
       // fc.showindiachecked='false';
        //fc.showAccessories='false';
        fc.pli=quliList; 
        
        
        ApexPages.StandardController sc2 = new ApexPages.standardController(qc);
        ApexPages.currentPage().getParameters().put('showindiachecked', 'true');
        // sc.showindiachecked='false';
        RecontractAgreementController fc2=new RecontractAgreementController(sc2);
       // fc2.showindiachecked='false';
       // fc2.showAccessories='false';
        fc2.pli=quliList; 
        
    }
}