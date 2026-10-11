//Crerated By : Abdul Aziz , Date : 07/09/2023 , Description : Test Class for CreateOrderFromQuote
//Last Modified By : Abdul Aziz ,Last Modified Date : 10/06/2024 , Description : Test Class for AddProductcomponent
@isTest
public class AddProductcomponent_Test {
    
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
        c1.AccountID= a1.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='9898989898';
        c1.PrimaryServiceContact__c=true;
        insert c1;
        
        /*  a.Lead_Account_Status__c='Active';
Update a;*/        
        
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
        
        
        List<ProductC__c> prodList = new List<ProductC__c>();
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
        // pc.Product_Type__c='Upsell';
        pc.Product_Type__c='Free Trial';
        pc.CurrencyIsoCode='INR';
        pc.Unit_List_Price_Value__c=200;
        pc.DB_Type_Industry__c='Full';
        pc.DB_Scope_Geography__c='All';
        pc.Discount_Cap__c=12;
        pc.From__c= 200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        pc.Channel__c=uu.Channel__c;
        pc.Tenure_Months__c = '3 Months';
        
        prodList.add(pc);
        
        
        
        ProductC__c pc1 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc1.Active__c=true;
        pc1.SKU_Type__c='Bundle-x';
        pc1.Product_category__c='Standard';
        pc1.Price_Master__c=pm.id;
        pc1.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc1.Channel__c = uu.Channel__c;
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Description__c='hiuhiuh';
        pc1.Product_Country__c='India';
        pc1.Primary_Selling_Country__c='India';
        pc1.Tenure_Months__c='12 Months';
        pc1.Bin__c='vghvgh';
        pc1.Product_Type__c='Core-Std';
        pc1.Channel__c=uu.Channel__c;
        pc1.Category__c = 'A';
        
        // pc1.Channel__c=	'EA';
        prodList.add(pc1);
        
        ProductC__c pc2 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc2.Active__c=true;
        pc2.SKU_Type__c='Bundle-x';
        pc2.Product_category__c='Standard';
        pc2.Price_Master__c=pm.id;
        pc2.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc2.Channel__c = '';
        pc2.Main_Product_Type__c='RDA';
        pc2.Product_Description__c='hiuhiuh';
        pc2.Product_Country__c='India';
        pc2.Primary_Selling_Country__c='India';
        pc2.Tenure_Months__c='6 Months';
        pc2.Bin__c='vghvgh';
        pc2.Product_Type__c='Core-Std';
        pc2.Channel__c=uu.Channel__c;
        pc2.Category__c = 'A';
        prodList.add(pc2);
        
        ProductC__c pc4 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc4.Active__c=true;
        pc4.SKU_Type__c='Bundle-x';
        pc4.Product_category__c='Standard';
        pc4.Price_Master__c=pm.id;
        pc4.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc4.Channel__c = '';
        pc4.Main_Product_Type__c='RDA';
        pc4.Product_Description__c='hiuhiuh';
        pc4.Product_Country__c='India';
        pc4.Primary_Selling_Country__c='India';
        pc4.Tenure_Months__c='1 Month';
        pc4.Bin__c='vghvgh';
        pc4.Product_Type__c='Upsell';
        pc4.Channel__c=uu.Channel__c;
        pc4.Category__c = 'A';
        prodList.add(pc4);
        
        ProductC__c pc5 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc5.Active__c=true;
        pc5.SKU_Type__c='Bundle-x';
        pc5.Product_category__c='Standard';
        pc5.Price_Master__c=pm.id;
        pc5.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc5.Channel__c = '';
        pc5.Main_Product_Type__c='RDA';
        pc5.Product_Description__c='hiuhiuh';
        pc5.Product_Country__c='India';
        pc5.Primary_Selling_Country__c='India';
        pc5.Tenure_Months__c='1 Week';
        pc5.Bin__c='vghvgh';
        pc5.Product_Type__c='Upsell';
        pc5.Channel__c=uu.Channel__c;
        pc5.Category__c = 'A';
        prodList.add(pc5);
        
        ProductC__c pc6 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc6.Active__c=true;
        pc6.SKU_Type__c='Bundle-x';
        pc6.Product_category__c='Standard';
        pc6.Price_Master__c=pm.id;
        pc6.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc6.Channel__c = '';
        pc6.Main_Product_Type__c='RDA';
        pc6.Product_Description__c='hiuhiuh';
        pc6.Product_Country__c='India';
        pc6.Primary_Selling_Country__c='India';
        pc6.Tenure_Months__c='Tenure';
        pc6.Bin__c='vghvgh';
        pc6.Product_Type__c='Core-Std';
        pc6.Channel__c=uu.Channel__c;
        pc6.Category__c = 'A';
        prodList.add(pc6);
        
        ProductC__c pc7 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc7.Active__c=true;
        pc7.SKU_Type__c='Bundle-x';
        pc7.Product_category__c='Standard';
        pc7.Price_Master__c=pm.id;
        pc7.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc7.Channel__c = '';
        pc7.Main_Product_Type__c='RDA';
        pc7.Product_Description__c='hiuhiuh';
        pc7.Product_Country__c='India';
        pc7.Primary_Selling_Country__c='India';
        pc7.Tenure_Months__c='0.1 Months';
        pc7.Bin__c='vghvgh';
        pc7.Product_Type__c='Upsell';
        pc7.Channel__c=uu.Channel__c;
        pc7.Category__c = 'A';
        prodList.add(pc7);
        
        ProductC__c pc1d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc1d.Active__c=true;
        pc1d.SKU_Type__c='Bundle-x';
        pc1d.Product_category__c='Standard';
        pc1d.Price_Master__c=pm.id;
        pc1d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc1d.Channel__c = '';
        pc1d.Main_Product_Type__c='RDA';
        pc1d.Product_Description__c='hiuhiuh';
        pc1d.Product_Country__c='India';
        pc1d.Primary_Selling_Country__c='India';
        pc1d.Tenure_Months__c='1 Day';
        pc1d.Bin__c='vghvgh';
        pc1d.Product_Type__c='Upsell';
        pc1d.Channel__c=uu.Channel__c;
        pc1d.Category__c = 'A';
        prodList.add(pc1d);
        
        ProductC__c pc2d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc2d.Active__c=true;
        pc2d.SKU_Type__c='Bundle-x';
        pc2d.Product_category__c='Standard';
        pc2d.Price_Master__c=pm.id;
        pc2d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc2d.Channel__c = '';
        pc2d.Main_Product_Type__c='RDA';
        pc2d.Product_Description__c='hiuhiuh';
        pc2d.Product_Country__c='India';
        pc2d.Primary_Selling_Country__c='India';
        pc2d.Tenure_Months__c='2 Days';
        pc2d.Bin__c='vghvgh';
        pc2d.Product_Type__c='Upsell';
        pc2d.Channel__c=uu.Channel__c;
        pc2d.Category__c = 'A';
        prodList.add(pc2d);
        
        ProductC__c pc4d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc4d.Active__c=true;
        pc4d.SKU_Type__c='Bundle-x';
        pc4d.Product_category__c='Standard';
        pc4d.Price_Master__c=pm.id;
        pc4d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc4d.Channel__c = '';
        pc4d.Main_Product_Type__c='RDA';
        pc4d.Product_Description__c='hiuhiuh';
        pc4d.Product_Country__c='India';
        pc4d.Primary_Selling_Country__c='India';
        pc4d.Tenure_Months__c='4 Days';
        pc4d.Bin__c='vghvgh';
        pc4d.Product_Type__c='Upsell';
        pc4d.Channel__c=uu.Channel__c;
        pc4d.Category__c = 'A';
        prodList.add(pc4d);
        
        ProductC__c pc5d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc5d.Active__c=true;
        pc5d.SKU_Type__c='Bundle-x';
        pc5d.Product_category__c='Standard';
        pc5d.Price_Master__c=pm.id;
        pc5d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc5d.Channel__c = '';
        pc5d.Main_Product_Type__c='RDA';
        pc5d.Product_Description__c='hiuhiuh';
        pc5d.Product_Country__c='India';
        pc5d.Primary_Selling_Country__c='India';
        pc5d.Tenure_Months__c='5 Days';
        pc5d.Bin__c='vghvgh';
        pc5d.Product_Type__c='Upsell';
        pc5d.Channel__c=uu.Channel__c;
        pc5d.Category__c = 'A';
        prodList.add(pc5d);
        
        ProductC__c pc6d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc6d.Active__c=true;
        pc6d.SKU_Type__c='Bundle-x';
        pc6d.Product_category__c='Standard';
        pc6d.Price_Master__c=pm.id;
        pc6d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc6d.Channel__c = '';
        pc6d.Main_Product_Type__c='RDA';
        pc6d.Product_Description__c='hiuhiuh';
        pc6d.Product_Country__c='India';
        pc6d.Primary_Selling_Country__c='India';
        pc6d.Tenure_Months__c='6 Days';
        pc6d.Bin__c='vghvgh';
        pc6d.Product_Type__c='Upsell';
        pc6d.Channel__c=uu.Channel__c;
        pc6d.Category__c = 'A';
        prodList.add(pc6d);
        
        ProductC__c pc7d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc7d.Active__c=true;
        pc7d.SKU_Type__c='Bundle-x';
        pc7d.Product_category__c='Standard';
        pc7d.Price_Master__c=pm.id;
        pc7d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc7d.Channel__c = '';
        pc7d.Main_Product_Type__c='RDA';
        pc7d.Product_Description__c='hiuhiuh';
        pc7d.Product_Country__c='India';
        pc7d.Primary_Selling_Country__c='India';
        pc7d.Tenure_Months__c='7 Days';
        pc7d.Bin__c='vghvgh';
        pc7d.Product_Type__c='Upsell';
        pc7d.Channel__c=uu.Channel__c;
        pc7d.Category__c = 'A';
        prodList.add(pc7d);
        
        ProductC__c pc14d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc14d.Active__c=true;
        pc14d.SKU_Type__c='Bundle-x';
        pc14d.Product_category__c='Standard';
        pc14d.Price_Master__c=pm.id;
        pc14d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc14d.Channel__c = '';
        pc14d.Main_Product_Type__c='RDA';
        pc14d.Product_Description__c='hiuhiuh';
        pc14d.Product_Country__c='India';
        pc14d.Primary_Selling_Country__c='India';
        pc14d.Tenure_Months__c='14 Days';
        pc14d.Bin__c='vghvgh';
        pc14d.Product_Type__c='Upsell';
        pc14d.Channel__c=uu.Channel__c;
        pc14d.Category__c = 'A';
        prodList.add(pc14d);
        
        ProductC__c pc2m = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc2m.Active__c=true;
        pc2m.SKU_Type__c='Bundle-x';
        pc2m.Product_category__c='Standard';
        pc2m.Price_Master__c=pm.id;
        pc2m.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc2m.Channel__c = '';
        pc2m.Main_Product_Type__c='RDA';
        pc2m.Product_Description__c='hiuhiuh';
        pc2m.Product_Country__c='India';
        pc2m.Primary_Selling_Country__c='India';
        pc2m.Tenure_Months__c='2 Months';
        pc2m.Bin__c='vghvgh';
        pc2m.Product_Type__c='Upsell';
        pc2m.Channel__c=uu.Channel__c;
        pc2m.Category__c = 'A';
        prodList.add(pc2m);
        
        
        ProductC__c pc60d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc60d.Active__c=true;
        pc60d.SKU_Type__c='Bundle-x';
        pc60d.Product_category__c='Standard';
        pc60d.Price_Master__c=pm.id;
        pc60d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc60d.Channel__c = '';
        pc60d.Main_Product_Type__c='RDA';
        pc60d.Product_Description__c='hiuhiuh';
        pc60d.Product_Country__c='India';
        pc60d.Primary_Selling_Country__c='India';
        pc60d.Tenure_Months__c='9 Months';
        pc60d.Bin__c='vghvgh';
        pc60d.Product_Type__c='Upsell';
        pc60d.Channel__c=uu.Channel__c;
        pc60d.Category__c = 'A';
        prodList.add(pc60d);
        
        ProductC__c pc9d = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc9d.Active__c=true;
        pc9d.SKU_Type__c='Bundle-x';
        pc9d.Product_category__c='Standard';
        pc9d.Price_Master__c=pm.id;
        pc9d.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc9d.Channel__c = '';
        pc9d.Main_Product_Type__c='RDA';
        pc9d.Product_Description__c='hiuhiuh';
        pc9d.Product_Country__c='India';
        pc9d.Primary_Selling_Country__c='India';
        pc9d.Tenure_Months__c='60 Days';
        pc9d.Bin__c='vghvgh';
        pc9d.Product_Type__c='Upsell';
        pc9d.Channel__c=uu.Channel__c;
        pc9d.Category__c = 'A';
        prodList.add(pc9d);
        insert prodList;
        a.Lead_Account_Status__c='Active';
        update a;
        
        a1.Lead_Account_Status__c='Active';
        // update a1;
        
        
        TopUps__c tp1=new TopUps__c();
        tp1.Mandatory__c=true;
        tp1.Product__c=pc9d.id;
        tp1.Product__c=pc1.id;
        tp1.Price_Master__c=pm.id;
        insert tp1;
        
        
        OpportunityN__c no = new OpportunityN__c();
        no .Account__c= a.id;
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
        
        OpportunityN__c no1 = new OpportunityN__c();
        
        no1.Account__c= a.Id;
        //  no1.Contact__c=c.id;
        no1.Close_Date__c = date.today().adddays(10);
        no1.Closure_Week__c ='Week-2';
        no1.Closure_probablity__c ='Will';
        no1.Expected_Revenue__c=12121222;
        no1.Price_Master__c = pm.Id; 
        no1.Stage__c = 'Proposal Sent';
        no1.Opportunity_Type__c='Upsell';
        
        no1.Actual_Revenue__c= 12131;
        no1.OwnerId = uu.Id; 
        
        //   insert no1;
        
        List<Opp_Line_Item__c> oplilist= new List<Opp_Line_Item__c>();
        Opp_Line_Item__c opli = new Opp_Line_Item__c();
        opli.Opportunities__c= no.id;
        opli.Account__c= a.id;
        opli.Product__c=pc1.id;
        opli.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli.DB_Scope_Geography__c='All';
        opli.DB_Type_Industry__c='Full';
        opli.CurrencyIsoCode='INR';
        opli.Unit_Price__c=500;
        opli.Product_Country__c='India';
        opli.Product_Selling_Country__c='India';
        opli.SKU_Code__c='RDAS1ME01M00BN1';
        opli.Tenure_Months__c= '12 Months';
        opli.Discount_Value__c=12;
        opli.Quantity_Unit__c= 1;
        opli.Base_Total__c=200;
        opli.OPLI__c = opli.Id;
        opli.Discount_Amount_1__c=200;
        opli.Gross_Total__c=100;
        opli.of_Master_Login__c='5';
        oplilist.add(opli);
        
        
        Opp_Line_Item__c opli1day = new Opp_Line_Item__c();
        opli1day.Opportunities__c= no.id;
        opli1day.Account__c= a.id;
        opli1day.Product__c=pc1d.id;
        opli1day.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli1day.DB_Scope_Geography__c='All';
        opli1day.DB_Type_Industry__c='Full';
        opli1day.CurrencyIsoCode='INR';
        opli1day.Unit_Price__c=500;
        opli1day.Product_Country__c='India';
        opli1day.Product_Selling_Country__c='India';
        opli1day.SKU_Code__c='RDAS1ME01M00BN1';
        opli1day.Tenure_Months__c= '1 Day';
        opli1day.Discount_Value__c=12;
        opli1day.Quantity_Unit__c= 1;
        opli1day.Base_Total__c=200;
        opli1day.OPLI__c = opli.Id;
        opli1day.Discount_Amount_1__c=200;
        opli1day.Gross_Total__c=100;
        opli1day.of_Master_Login__c='5';
        //  oplilist.add(opli1day);
        
        Opp_Line_Item__c opli7 = new Opp_Line_Item__c();
        opli7.Opportunities__c= no.id;
        opli7.Account__c= a.id;
        opli7.Product__c=pc7.id;
        opli7.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli7.DB_Scope_Geography__c='All';
        opli7.DB_Type_Industry__c='Full';
        opli7.CurrencyIsoCode='INR';
        opli7.Unit_Price__c=500;
        opli7.Product_Country__c='India';
        opli7.Product_Selling_Country__c='India';
        opli7.SKU_Code__c='RDAS1ME01M00BN1';
        opli7.Tenure_Months__c= '0.1 Months';
        opli7.Discount_Value__c=12;
        opli7.Quantity_Unit__c= 1;
        opli7.Base_Total__c=200;
        opli7.OPLI__c = opli.Id;
        opli7.Discount_Amount_1__c=200;
        opli7.Gross_Total__c=100;
        opli7.of_Master_Login__c='5';
        oplilist.add(opli7);
        
        Opp_Line_Item__c opli1 = new Opp_Line_Item__c();
        opli1.Opportunities__c= no.id;
        opli1.Account__c= a.id;
        opli1.Product__c=pc2.id;
        opli1.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli1.DB_Scope_Geography__c='All';
        opli1.DB_Type_Industry__c='Full';
        opli1.CurrencyIsoCode='INR';
        opli1.Unit_Price__c=500;
        opli1.Product_Country__c='India';
        opli1.Product_Selling_Country__c='India';
        opli1.SKU_Code__c='RDAS1ME01M00BN1';
        opli1.Tenure_Months__c= '6 Months';
        opli1.Discount_Value__c=12;
        opli1.Quantity_Unit__c= 1;
        opli1.Base_Total__c=200;
        opli1.OPLI__c = opli1.Id;
        opli1.Discount_Amount_1__c=200;
        opli1.Gross_Total__c=100;
        opli1.of_Master_Login__c='5';
        oplilist.add(opli1);
        
        Opp_Line_Item__c opli2 = new Opp_Line_Item__c();
        opli2.Opportunities__c= no.id;
        opli2.Account__c= a.id;
        opli2.Product__c=pc.id;
        opli2.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli2.DB_Scope_Geography__c='All';
        opli2.DB_Type_Industry__c='Full';
        opli2.CurrencyIsoCode='INR';
        opli2.Unit_Price__c=500;
        opli2.Product_Country__c='India';
        opli2.Product_Selling_Country__c='India';
        opli2.SKU_Code__c='RDAS1ME01M00BN1';
        opli2.Tenure_Months__c= '3 Months';
        opli2.Discount_Value__c=12;
        opli2.Quantity_Unit__c= 1;
        opli2.Base_Total__c=200;
        opli2.OPLI__c = opli1.Id;
        opli2.Discount_Amount_1__c=200;
        opli2.Gross_Total__c=100;
        opli2.of_Master_Login__c='5';
        oplilist.add(opli2);
        
        Opp_Line_Item__c opli3 = new Opp_Line_Item__c();
        opli3.Opportunities__c= no.id;
        opli3.Account__c= a.id;
        opli3.Product__c=pc4.id;
        opli3.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli3.DB_Scope_Geography__c='All';
        opli3.DB_Type_Industry__c='Full';
        opli3.CurrencyIsoCode='INR';
        opli3.Unit_Price__c=500;
        opli3.Product_Country__c='India';
        opli3.Product_Selling_Country__c='India';
        opli3.SKU_Code__c='RDAS1ME01M00BN1';
        opli3.Tenure_Months__c= '1 Month';
        opli3.Discount_Value__c=12;
        opli3.Quantity_Unit__c= 1;
        opli3.Base_Total__c=200;
        opli3.OPLI__c = opli1.Id;
        opli3.Discount_Amount_1__c=200;
        opli3.Gross_Total__c=100;
        opli3.of_Master_Login__c='5';
        oplilist.add(opli3);
        
        Opp_Line_Item__c opli4 = new Opp_Line_Item__c();
        opli4.Opportunities__c= no.id;
        opli4.Account__c= a.id;
        opli4.Product__c=pc5.id;
        opli4.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli4.DB_Scope_Geography__c='All';
        opli4.DB_Type_Industry__c='Full';
        opli4.CurrencyIsoCode='INR';
        opli4.Unit_Price__c=500;
        opli4.Product_Country__c='India';
        opli4.Product_Selling_Country__c='India';
        opli4.SKU_Code__c='RDAS1ME01M00BN1';
        opli4.Tenure_Months__c= '0.1 Months';
        opli4.Discount_Value__c=12;
        opli4.Quantity_Unit__c= 1;
        opli4.Base_Total__c=200;
        opli4.OPLI__c = opli1.Id;
        opli4.Discount_Amount_1__c=200;
        opli4.Gross_Total__c=100;
        opli4.of_Master_Login__c='5';
        oplilist.add(opli4);
        
        Opp_Line_Item__c opli5 = new Opp_Line_Item__c();
        opli5.Opportunities__c= no.id;
        opli5.Account__c= a.id;
        opli5.Product__c=pc6.id;
        opli5.Price_Master__c=pm.id;
        opli5.OPLI__c = opli1.Id;
        opli.Quantity_Unit__c=1;
        opli5.DB_Scope_Geography__c='All';
        opli5.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli5);
        
        Opp_Line_Item__c opli1d = new Opp_Line_Item__c();
        opli1d.Opportunities__c= no.id;
        opli1d.Account__c= a.id;
        opli1d.Product__c=pc5.id;
        opli1d.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli1d.DB_Scope_Geography__c='All';
        opli1d.DB_Type_Industry__c='Full';
        opli1d.CurrencyIsoCode='INR';
        opli1d.Unit_Price__c=500;
        opli1d.Product_Country__c='India';
        opli1d.Product_Selling_Country__c='India';
        opli1d.SKU_Code__c='RDAS1ME01M00BN1';
        opli1d.Tenure_Months__c= '1 Week';
        opli1d.Discount_Value__c=12;
        opli1d.Quantity_Unit__c= 1;
        opli1d.Base_Total__c=200;
        opli1d.OPLI__c = opli1.Id;
        opli1d.Discount_Amount_1__c=200;
        opli1d.Gross_Total__c=100;
        opli1d.of_Master_Login__c='5';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli1d);
        
        Opp_Line_Item__c opli2d = new Opp_Line_Item__c();
        opli2d.Opportunities__c= no1.id;
        opli2d.Account__c= a.id;
        opli2d.Product__c=pc2d.id;
        opli2d.Price_Master__c=pm.id;
        // opli.Quantity_Unit__c=1;
        opli2d.DB_Scope_Geography__c='All';
        opli2d.DB_Type_Industry__c='Full';
        opli2d.CurrencyIsoCode='INR';
        opli2d.Unit_Price__c=500;
        opli2d.Product_Country__c='India';
        opli2d.Product_Selling_Country__c='India';
        opli2d.SKU_Code__c='RDAS1ME01M00BN1';
        opli2d.Tenure_Months__c= '2 Days';
        opli2d.Discount_Value__c=12;
        opli2d.Quantity_Unit__c= 1;
        opli2d.Base_Total__c=200;
        opli2d.OPLI__c = opli1.Id;
        opli2d.Discount_Amount_1__c=200;
        opli2d.Gross_Total__c=100;
        opli2d.of_Master_Login__c='5';
        oplilist.add(opli2d);
        
        Opp_Line_Item__c opli4d = new Opp_Line_Item__c();
        opli4d.Opportunities__c= no.id;
        opli4d.Account__c= a.id;
        opli4d.Product__c=pc4d.id;
        opli4d.Price_Master__c=pm.id;
        opli4d.OPLI__c = opli1.Id;
        opli4d.Quantity_Unit__c=1;
        opli4d.DB_Scope_Geography__c='All';
        opli4d.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli4d);
        
        Opp_Line_Item__c opli5d = new Opp_Line_Item__c();
        opli5d.Opportunities__c= no.id;
        opli5d.Account__c= a.id;
        opli5d.Product__c=pc5d.id;
        opli5d.Price_Master__c=pm.id;
        opli5d.OPLI__c = opli1.Id;
        opli5d.Quantity_Unit__c=1;
        opli5d.DB_Scope_Geography__c='All';
        opli5d.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli5d);
        
        Opp_Line_Item__c opli6d = new Opp_Line_Item__c();
        opli6d.Opportunities__c= no.id;
        opli6d.Account__c= a.id;
        opli6d.Product__c=pc6d.id;
        opli6d.Price_Master__c=pm.id;
        opli6d.OPLI__c = opli1.Id;
        opli6d.Quantity_Unit__c=1;
        opli6d.DB_Scope_Geography__c='All';
        opli6d.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli6d);
        
        Opp_Line_Item__c opli7d = new Opp_Line_Item__c();
        opli7d.Opportunities__c= no.id;
        opli7d.Account__c= a.id;
        opli7d.Product__c=pc7d.id;
        opli7d.Price_Master__c=pm.id;
        opli7d.OPLI__c = opli1.Id;
        opli7d.Quantity_Unit__c=1;
        opli7d.DB_Scope_Geography__c='All';
        opli7d.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli7d);
        
        Opp_Line_Item__c opli14d = new Opp_Line_Item__c();
        opli14d.Opportunities__c= no.id;
        opli14d.Account__c= a.id;
        opli14d.Product__c=pc14d.id;
        opli14d.Price_Master__c=pm.id;
        opli14d.OPLI__c = opli1.Id;
        opli14d.Quantity_Unit__c=1;
        opli14d.DB_Scope_Geography__c='All';
        opli14d.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli14d);
        
        Opp_Line_Item__c opli60d = new Opp_Line_Item__c();
        opli60d.Opportunities__c= no.id;
        opli60d.Account__c= a.id;
        opli60d.Product__c=pc60d.id;
        opli60d.Price_Master__c=pm.id;
        opli60d.OPLI__c = opli1.Id;
        opli60d.Quantity_Unit__c=1;
        opli60d.DB_Scope_Geography__c='All';
        opli60d.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli60d);
        
        Opp_Line_Item__c opli2m = new Opp_Line_Item__c();
        opli2m.Opportunities__c= no.id;
        opli2m.Account__c= a.id;
        opli2m.Product__c=pc2m.id;
        opli2m.Price_Master__c=pm.id;
        opli2m.OPLI__c = opli1.Id;
        opli2m.Quantity_Unit__c=1;
        opli2m.DB_Scope_Geography__c='All';
        opli2m.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli2m);
        
        Opp_Line_Item__c opli9m = new Opp_Line_Item__c();
        opli9m.Opportunities__c= no.id;
        opli9m.Account__c= a.id;
        opli9m.Product__c=pc9d.id;
        opli9m.Price_Master__c=pm.id;
        opli9m.OPLI__c = opli1.Id;
        opli9m.Quantity_Unit__c=1;
        opli9m.DB_Scope_Geography__c='All';
        opli9m.DB_Type_Industry__c='Full';
        // opli5.Product_Type1__c = 'Core-Std';
        oplilist.add(opli9m);
        
        TopUps__c tc = new TopUps__c();
        tc.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc.BIN__c='vghvgh';
        tc.Top_Up_Type__c = 'Master Login';
        tc.Inventory_Quota_Tenure__c='Per Month';
        tc.Price_Master__c=pm.id;
        tc.Product__c=pc.id;
        tc.Mandatory__c=true;
        // tc.UOM__c='Tenure';
        insert tc;
        list<TopUps__c> tplist=new list<TopUps__c>();
        TopUps__c tc1 = new TopUps__c();
        tc1.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc1.BIN__c='vghvgh';
        tc1.Top_Up_Type__c = '';
        tc1.Inventory_Quota_Tenure__c='Per Month';
        tc1.Price_Master__c=pm.id;
        tc1.Product__c=pc1.id;
        tc1.Mandatory__c=true;
        tc1.Unit_Price__c = 400;
        
        tplist.add(tc1);
        
        TopUps__c tc2 = new TopUps__c();
        tc2.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc2.BIN__c='vghvgh';
        tc2.Top_Up_Type__c = '';
        tc2.Inventory_Quota_Tenure__c='Per Month';
        tc2.Price_Master__c=pm.id;
        tc2.Product__c=pc2.id;
        tc2.Mandatory__c=true;
        tc2.Unit_Price__c = 400;
        
        tplist.add(tc2);
        
        TopUps__c tc3 = new TopUps__c();
        tc3.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc3.BIN__c='vghvgh';
        tc3.Top_Up_Type__c = '';
        tc3.Inventory_Quota_Tenure__c='Per Month';
        tc3.Price_Master__c=pm.id;
        tc3.Product__c=pc4.id;
        tc3.Mandatory__c=true;
        tc3.Unit_Price__c = 400;
        
        tplist.add(tc3);
        
        TopUps__c tc4 = new TopUps__c();
        tc4.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc4.BIN__c='vghvgh';
        tc4.Top_Up_Type__c = '';
        tc4.Inventory_Quota_Tenure__c='Per Month';
        tc4.Price_Master__c=pm.id;
        tc4.Product__c=pc5.id;
        tc4.Mandatory__c=true;
        tc4.Unit_Price__c = 400;
        
        tplist.add(tc4); 
        
        TopUps__c tc5 = new TopUps__c();
        tc5.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc5.BIN__c='vghvgh';
        tc5.Top_Up_Type__c = '';
        tc5.Inventory_Quota_Tenure__c='Per Month';
        tc5.Price_Master__c=pm.id;
        tc5.Product__c=pc7.id;
        tc5.Mandatory__c=true;
        tc5.Unit_Price__c = 400;
        
        tplist.add(tc5);
        
        TopUps__c tc6 = new TopUps__c();
        tc6.Top_Up_Type__c='CV VIEWS';
        // tc.SKU_Type__c=''
        tc6.BIN__c='vghvgh';
        tc6.Top_Up_Type__c = '';
        tc6.Inventory_Quota_Tenure__c='Per Month';
        tc6.Price_Master__c=pm.id;
        tc6.Product__c=pc14d.id;
        tc6.Mandatory__c=true;
        tc6.Unit_Price__c = 400;
        
        //   tplist.add(tc6);
        
        insert tplist;
        
        OPLI_Accessories__c plia = new OPLI_Accessories__c();
        plia.Top_Ups__c= tc.id;
        plia.Account__c=a.id;
        plia.Opp_Line_Item__c=opli.id;
        plia.Opportunities__c=no.id;
        plia.Product__c=pc.id;
        
        insert plia;
        
        OPLI_Accessories__c plia1 = new OPLI_Accessories__c();
        plia1.Top_Ups__c= tc1.id;
        plia1.Account__c=a.id;
        plia1.Opp_Line_Item__c=opli.id;
        plia1.Opportunities__c=no.id;
        plia1.Product__c=pc.id;
        
        insert plia1;
        
        
        PL_Accessories__c pliAcc = new PL_Accessories__c();
        pliAcc.Price_Master__c=pm.id;
        pliAcc.Product__c=pc.id;
        pliAcc.Mandatory__c=true;
        pliAcc.Top_Ups__c=tc.id;
        
        insert pliAcc;
        
        list<QuotesN__c>  listq=new list<QuotesN__c>();
        QuotesN__c qcca = new QuotesN__c(); 
        qcca.Quote_Type__c=''; 
        qcca.Account__c=a.id;
        qcca.Contact__c=c.id;
        qcca.Opportunities__c=no.id;
        //qcc.Price_Master__c=pm.id;
        qcca.CurrencyIsoCode ='INR';
        qcca.Active__c=True;
        qcca.Order_Created__c = true;
        qcca.Order_Status_Verified_For_Upsell__c = true;
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
        
        
        insert listq;
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        Quote_Line_Items__c qla = new Quote_Line_Items__c();
        qla.Quotes__c = qcca.Id;
        qla.Account__c = no.Account__c;
        //  qla.Active__c = true;
        //  qla.Order_Created__c = true;
        // qla.Order_Status_Verified_For_Upsell__c = true;
        //  qla.Quote_Type__c = '';
        qla.Opportunities__c = no.id;
        qla.Product__c = pc1.Id;
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
        
        test.stopTest();
        
        //   pc1.Tenure_Months__c='Per Month';
        //  update pc1;
        List<AddProductcomponent.oppItemWrapper> wrlist11=new List<AddProductcomponent.oppItemWrapper>();
        
        AddProductcomponent.oppItemWrapper wr3121=new AddProductcomponent.oppItemWrapper(opli2d);
        wr3121.opli= opli2d;
        wr3121.ckb=true;
        //  wrlist11.add(wr3121);
        
        List<AddProductcomponent.oppItemWrapper> wrlist=new List<AddProductcomponent.oppItemWrapper>();
        AddProductcomponent.oppItemWrapper wr=new AddProductcomponent.oppItemWrapper(opli);
        wr.opli= opli;
        wr.category='Test';
        wr.channel='test';
        wr.bin='test';
        wr.basetotal=100;
        wr.disamt=20;
        wr.discap= 10;
        wr.gstValue=12;
        wr.principal='test';
        wr.invcount=10;
        wr.grosstotal=20;
        wr.typeProd='test';
        wr.uom='test';
        wr.prodName='test';
        wr.progeo='test';
        wr.sku='test';
        wr.prodtenure='test';
        wr.priceRate=12;
        wr.dbindustry='test';
        wr.proocountry='india';
        wr.proscountry='india';
        wr.skutype='test';
        wr.prodID='test';
        wr.procode='test';
        wr.prodesc='test';
        wr.to=12;
        wr.fromqty=13;
        wr.Masterlogin='test';
        wr.ckb=true;
        wr.ctc = 123;
        wrlist.add(wr);
        
        AddProductcomponent.oppItemWrapper wr6=new AddProductcomponent.oppItemWrapper(opli1);
        wr6.opli= opli1;
        wr6.category='Test';
        wr6.channel='test';
        wr6.bin='test';
        wr6.basetotal=100;
        wr6.disamt=20;
        wr6.discap= 10;
        wr6.gstValue=12;
        wr6.principal='test';
        wr6.invcount=10;
        wr6.grosstotal=20;
        wr6.typeProd='test';
        wr6.uom='test';
        wr6.prodName='test';
        wr6.progeo='test';
        wr6.sku='test';
        wr6.prodtenure='test';
        wr6.priceRate=12;
        wr6.dbindustry='test';
        wr6.proocountry='india';
        wr6.proscountry='india';
        wr6.skutype='test';
        wr6.prodID='test';
        wr6.procode='test';
        wr6.prodesc='test';
        wr6.to=12;
        wr6.fromqty=13;
        wr6.Masterlogin='test';
        wr6.ckb=true;
        wr6.ctc = 123;
        //wr6.ckb=true;
        wrlist.add(wr6);
        
        AddProductcomponent.oppItemWrapper wr3=new AddProductcomponent.oppItemWrapper(opli3);
        wr3.opli= opli3;
        wr3.ckb=true;
        wrlist.add(wr3);
        AddProductcomponent.oppItemWrapper wr32=new AddProductcomponent.oppItemWrapper(opli2);
        wr32.opli= opli2;
        wr32.ckb=true;
        wrlist.add(wr32);
        
        AddProductcomponent.oppItemWrapper wr77=new AddProductcomponent.oppItemWrapper(opli7);
        wr77.opli= opli7;
        wr77.ckb=true;
        wrlist.add(wr77);
        
        AddProductcomponent.oppItemWrapper wr1w=new AddProductcomponent.oppItemWrapper(opli4);
        wr1w.opli= opli4;
        wr1w.ckb=true;
        wrlist.add(wr1w);  
        
        AddProductcomponent.oppItemWrapper wr1222=new AddProductcomponent.oppItemWrapper(opli1d);
        wr1222.opli= opli1d;
        wr1222.ckb=true;
        wrlist.add(wr1222);  
        
        AddProductcomponent.oppItemWrapper wr1d=new AddProductcomponent.oppItemWrapper(opli2d);
        wr1d.opli= opli2d;
        wr1d.ckb=true;
        //   wrlist.add(wr1d);   
        
        List<AddProductcomponent.oppItemWrapper1> wrlist2=new List<AddProductcomponent.oppItemWrapper1>();
        AddProductcomponent.oppItemWrapper1 wr2=new AddProductcomponent.oppItemWrapper1(plia);
        wr2.ckb=true;
        wr2.category='test';
        wr2.dbindustry='test';
        wr2.category='test';
        wr2.typeProd='test';
        wr2.principal='test';
        wr2.priceRate=120;
        wr2.gst=12;
        wr2.proocountry='india';
        
        
        wrlist2.add(wr2);
        
        AddProductcomponent.oppliWrapper wwr=new AddProductcomponent.oppliWrapper();
        wwr.name = 'name';
        wwr.oplitenure = '1 Week';
        wwr.recordid = qulist1[0].id;
        
        // try{  
        
        AddProductcomponent cc=new AddProductcomponent();
        
        AddProductcomponent.getAccountStatusApex(String.valueOf(no.Id));
        AddProductcomponent.fetchOpportunity(String.valueOf(no.Id));
        AddProductcomponent.fetchOpportunity(String.valueOf(no.Id));
        AddProductcomponent.usrdetails(no.Id);
        AddProductcomponent.getoplitenure(qulist1[0].Id);
        
        AddProductcomponent.fetchProducts(String.valueOf(no.Id));
        //     AddProductcomponent.fetchAccessories(String.valueOf(no.Id));
        try{
            AddProductcomponent.saveOpli(Json.serialize(wrlist),String.valueOf(no.Id),'Standard');  
        }
        catch(Exception e){}
        //   AddProductcomponent.saveOpli(Json.serialize(wrlist),String.valueOf(pc.Id));
        
        AddProductcomponent.getproductnames();
        AddProductcomponent.getskutype();
        AddProductcomponent.getptype();
        AddProductcomponent.todaysdate();
        AddProductcomponent.previousdate();
        
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','1 Month');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','0.1 Months');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','2 Months');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','9 Months');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','1 Week');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','12 Months');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','6 Months');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','3 Months');
        
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','1 Day');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','2 Days');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','4 Days');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','5 Days');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','6 Days');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','7 Days');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','14 Days');
        AddProductcomponent.getenddate(Json.serialize(wrlist),'2022-05-10','60 Days');
        
        AddProductcomponent.gettenure(String.valueOf(pc.Id));
        AddProductcomponent.getCountry(String.valueOf(pc.Id));
        AddProductcomponent.getchannels(String.valueOf(pc.Id));
        AddProductcomponent.fetchOppli(String.valueOf(no.Id), 'test','test');
        AddProductcomponent.fetchOpplii(String.valueOf(no.Id), 'test','test');
        // AddProductcomponent.saveOplit(Json.serialize(wrlist),Json.serialize(wrlist2),String.valueOf(no.Id));
        try{
            AddProductcomponent.saveOplit(Json.serialize(wrlist),Json.serialize(wrlist2),String.valueOf(no.Id));
        }
        catch(Exception e){}
        
        
        //   AddProductcomponent.saveOplit(Json.serialize(wrlist11),Json.serialize(wrlist2),String.valueOf(no1.Id));
        //  AddProductcomponent.saveOplit(Json.serialize(wrlist2),Json.serialize(wrlist),String.valueOf(pc.Id));
        //   }
        /*   catch(exception e){

}*/
        AddProductcomponent.fetchAccessories(String.valueOf(no.Id));
        try{AddProductcomponent.getoplitenure1(String.valueOf(opli1day.Id));}
        Catch(Exception e){}
        
        
        /*     }
catch(exception e){

}*/
        
        
    }
}