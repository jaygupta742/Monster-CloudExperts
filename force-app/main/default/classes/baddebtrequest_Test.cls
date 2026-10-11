@isTest
public class baddebtrequest_Test {
    
    public @istest static void mybaddebtrequest(){
        
        
        
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
        
        User uu=[select id,name,User_Channel__c,Channel__c from User where id=:userinfo.getUserId()];
        
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
        pc.Discount_Cap__c=12;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        pc.Channel__c=uu.Channel__c;
        
        
        
        insert pc;
        
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
        
        // pc1.Channel__c=	'EA';
        insert pc1;
        
        OpportunityN__c no = new OpportunityN__c();
        no.Account__c= a.id;
        no.Contact__c=c.id;
        no.Price_Master__c=pm.id;
        no.Opportunity_Type__c='free trial';
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
        // qc.Account_Entity_Use_Code__c= 'Null';
        qlist.add(qc);
        insert qlist;
        
        
        List<Quote_Line_Items__c> quliList = new List<Quote_Line_Items__c>();
        Quote_Line_Items__c qli = new Quote_Line_Items__c();
        qli.Quotes__c = qc.Id;
        qli.Account__c = a.id;
        qli.Opportunities__c = no.id;
        qli.Product__c = pc.Id;
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
        
        
        List<APAC_Payments__c> ApcList = new List <APAC_Payments__c>();
        APAC_Payments__c apc = new APAC_Payments__c();
        //  apc.Name='test';
        apc.APAC_Payment_Name__c='Single Shot';
        apc.Due_Date__c=system.today();
        apc.Payment_Amount__c = 5000;
        apc.TDS_Amount__c= 2000;
        apc.GST__c=18;
        ApcList.add(apc);
        
        Order__c oc = new Order__c();
        oc.Xcode__c= xc.id;
        oc.Account__c=a.id;
        oc.Contact__c=c.id;
        oc.Opportunities__c=no.id;
        oc.Quotes__c=qc.id;
        oc.Price_Master__c=pm.id;
        oc.CurrencyIsoCode='INR';
        oc.Selling_Country__c='India';
        oc.Order_Date__c= Date.today();
        oc.Order_Status__c='Open';
        oc.Overall_Quote_Status__c='Pending';
        oc.Tax_Percentage__c=18;
        insert oc;
        
        List<Order_Item__c> orderList = new List<Order_Item__c>();
        Order_Item__c oic = new Order_Item__c();
        oic.Account__c=a.id;
        ///   oic.Adjustment_Type__c=
        oic.Adjustment_Value__c=40;
        oic.CurrencyIsoCode='INR';
        oic.Quantity__c=4;
        oic.Price_Master__c=pm.id;
        oic.Product__c=pc.id;
        oic.Unit_Price__c=1277500.00;
        oic.Opportunities__c=no.id;
        oic.Quote_Line_Items__c=qli.id;
        oic.of_Master_Login__c='5';
        //oic.Start_Date__c=
        //oic.End_Date__c=
        oic.Discount_Amount__c= 511000.00;
        oic.Gross_Total__c=766500.00;
        oic.Base_Total__c=1277500.00;
        oic.Product_Industry__c='Full';
        oic.Product_Geo_Scope__c='All';
        oic.Product_Country__c= 'APAC without India';
        oic.Tenure_Months__c= '12 Months';
        oic.Order__c=oc.id;
        //  insert oic;
        orderList.add(oic);
        insert orderList;
        
        List<Order_Item_Services__c> orederItemList = new List<Order_Item_Services__c>();
        Order_Item_Services__c qq = new Order_Item_Services__c();
        qq.Account__c = a.id;
        qq.Opportunities__c =no.id;
        qq.OPLI_Services__c = plia.id;
        qq.Quotes__c = qc.id;
        qq.QULI_Accessories__c = quliA.Id;
        qq.Services__c = tc.id;
        qq.CurrencyIsoCode = 'INR';
        qq.Price_Master__c = pm.Id;
        qq.Product__c = pc.id;
        // qq.Quantity__c = oo.Quantity_Unit__c;
        //qq.Unit_Price__c = oo.Unit_Price__c;
        qq.Opp_Line_Item__c = opli.id;
        qq.Quote_Line_Items__c = qli.Id;
        qq.of_Master_Login__c = '5';
        orederItemList.add(qq);
        insert orederItemList;
        
        
        Reversal_Bad_Debt_Requests__c rbc = new Reversal_Bad_Debt_Requests__c();
        rbc.OwnerId = userinfo.getUserId();
        rbc.Account__c=a.id;
        rbc.Order__c=oc.id;
        rbc.CurrencyIsoCode = 'INR';
        rbc.Order_Date__c=Date.today();
        rbc.Order_Number__c='66556';
        rbc.Order_Value__c=766500.00;
        rbc.Request_To_Finance__c= true;
        rbc.Vertical_head_Approval_status__c='Pending Approval';
        rbc.Final_Approval_Status__c =null;
        rbc.Final_Approver_Name__c='Vikram Bhaskar';
        rbc.Vertical_Head_Approver_Email__c='vikram.bhaskar@monsterindia.com';
        rbc.Vertical_Head_Approver_Name__c= 'Abilash Nair';
        rbc.Reversal_Bad_Debt_Type__c='Full';
        rbc.Reversal_Bad_Debt_Comment__c='ededededed';
        rbc.Reversal_Bad_Debt_Reason__c='Business Closed down';
        rbc.Reversal_Amount__c= 900;
     //   rbc.Level_1_Approval_Done__c==true;
        
        insert rbc;
        
        rbc.Final_Approval_Status__c =null;
        rbc.Vertical_head_Approval_status__c='Approved';
        update rbc;
       
        
    }
    
    
    
}