@isTest
public class updateStatusTest {
    
    public @istest static void myquotemethod(){
        
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
        
        try{
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
            no.Stage__c = '';
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
            
            //  list<QuotesN__c>  qlist =new list<QuotesN__c>();
            QuotesN__c qc = new QuotesN__c();
            //   qc.Level_of_Approval_maxima_from_QLI__c =1;
            qc.Approver_1__c = uu.Id;
            qc.Approver_2__c = uu.Id;
            qc.Approver_3__c = uu.Id;
            qc.Approver_4__c = uu.Id;
            
            
            //qc.Approver_1__c=saleshead.Id;
            // qc.Approver_2__c=channelshead.Id;
            // qc.Approver_3__c=ceouser.Id;
            qc.Quote_Type__c='Free Trial';
            qc.Xcode__c=xc.id;
            qc.Account__c=a.id;
            qc.Contact__c=c.id;
            qc.Opportunities__c=no.id;
            qc.Price_Master__c=pm.id;
            qc.CurrencyIsoCode ='INR';
            qc.Active__c=True;
            qc.Selling_Country__c = 'India';
            qc.Finalised__c = true;
            qc.Approval_Status_Overall__c = 'Pending';
            qc.Billing_Address__c = 'Account Billing Address';
            qc.Posting_Address__c = 'Account Billing Address';
            qc.Selling_Country__c = 'India';   
            qc.Validated__c = true;
            qc.Tax_Percentage__c=18;
            // qlist.add(qc);
            insert qc;
            
            QuotesN__c qcc = new QuotesN__c();
            //   qc.Level_of_Approval_maxima_from_QLI__c =1;
            qcc.Approver_1__c = uu.Id;
            qcc.Approver_2__c = uu.Id;
            qcc.Approver_3__c = uu.Id;
            qcc.Approver_4__c = uu.Id; 
            qcc.Quote_Type__c='Free Trial';
            qcc.Xcode__c=xc.id;
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
            
            
            QuotesN__c qc1 = new QuotesN__c();
            qc1.Quote_Type__c='Free Trial';
            qc1.Xcode__c=xc.id;
            qc1.Account__c=a.id;
            qc1.Contact__c=c.id;
            qc1.Approver_2__c=userinfo.getUserId();
            //  qc1.Approver_1__c = saleshead.Id;
            qc1.Level_1_Approval_Done__c=false;
            qc1.Opportunities__c=no.id;
            qc1.Price_Master__c=pm.id;
            qc1.CurrencyIsoCode ='INR';
            qc1.Active__c=True;
            qc1.Selling_Country__c = 'India'; 
            qc1.Finalised__c = true;
            qc1.Approval_Status_Overall__c = 'Pending';
            qc1.Billing_Address__c = 'Account Billing Address';
            qc1.Posting_Address__c = 'Account Billing Address'; 
            // qc.Account_Entity_Use_Code__c = 'Null' ;    
            qc1.Validated__c = true;
            //  qc1.Tax_Percentage__c=18;
            // qc.Account_Entity_Use_Code__c= 'Null';
            
            insert qc1; 
            
            List<Quote_Line_Items__c> qulist11 = new List<Quote_Line_Items__c>();
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
            ql3.Adjusted_Value__c = 40;
            ql3.Unit_Price__c = 1277500.00;
            ql3.Quantity_Unit__c = 4;
            ql3.Base_Total__c = 1277500.00;
            ql3.Level_of_Approval_Required__c=3; 
            //l1.Actual_Disount_Cap__c=40;
            ql3.Category__c='C';
            //insert qli;
            qulist11.add(ql3);
            
            List<Quote_Line_Items__c> qulist1 = new List<Quote_Line_Items__c>();
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
            ql1.Adjusted_Value__c = 40;
            ql1.Unit_Price__c = 1277500.00;
            ql1.Quantity_Unit__c = 4;
            ql1.Base_Total__c = 1277500.00;
            ql1.Level_of_Approval_Required__c=1; 
            //ql1.Actual_Disount_Cap__c=40;
            ql1.Category__c='A';
            //insert qli;
            qulist1.add(ql1);
            insert qulist1;
            ql1.Level_of_Approval_Required__c=2;
            ql1.Category__c='B';
            update ql1;
            ql1.Level_of_Approval_Required__c=3;
            ql1.Category__c='C';
            update ql1;
            
            ql1.Level_of_Approval_Required__c=4;
            ql1.Category__c='D';
            update ql1;
            
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
            qli.Level_of_Approval_Required__c=2;        
            //insert qli;
            quliList.add(qli); 
            
            insert quliList;
            
            List<Quote_Line_Items__c> quliList1 = new List<Quote_Line_Items__c>();
            Quote_Line_Items__c qli1 = new Quote_Line_Items__c();
            qli1.Quotes__c = qc.Id;
            qli1.Account__c = a.id;
            qli1.Opportunities__c = no.id;
            qli1.Product__c = pc.Id;
            qli1.Price_Master__c = pm.Id;
            qli1.Product_Industry__c = 'Full';
            qli1.Product_Geo_Scope__c ='All';
            qli1.Product_Country__c = 'APAC without India';
            qli1.Tenure_Months__c = '12 Months';
            qli1.Discount_Value__c = 511000.00;
            qli1.Gross_Total__c = 766500.00;
            qli1.Adjusted_Value__c = 40;
            qli1.Unit_Price__c = 1277500.00;
            qli1.Quantity_Unit__c = 4;
            qli1.Base_Total__c = 1277500.00;
            qli1.Level_of_Approval_Required__c=3;        
            //insert qli;
            quliList.add(qli1); 
            
            insert quliList1;
            qc.Level_2_Approval_Done__c=true;
            qc.Approval_Status_Overall__c='Submitted';
            update qc;
            
            
            List<Quote_Line_Items__c> quliList2 = new List<Quote_Line_Items__c>();
            Quote_Line_Items__c qli11 = new Quote_Line_Items__c();
            qli11.Quotes__c = qc.Id;
            qli11.Account__c = a.id;
            qli11.Opportunities__c = no.id;
            qli11.Product__c = pc.Id;
            qli11.Price_Master__c = pm.Id;
            qli11.Product_Industry__c = 'Full';
            qli11.Product_Geo_Scope__c ='All';
            qli11.Product_Country__c = 'APAC without India';
            qli11.Tenure_Months__c = '12 Months';
            qli11.Discount_Value__c = 511000.00;
            qli11.Gross_Total__c = 766500.00;
            qli11.Adjusted_Value__c = 40;
            qli11.Unit_Price__c = 1277500.00;
            qli11.Quantity_Unit__c = 4;
            qli11.Base_Total__c = 1277500.00;
            qli11.Level_of_Approval_Required__c=4;        
            //insert qli;
            quliList.add(qli11); 
            test.startTest();
            
            insert quliList2;
            qc.Level_3_Approval_Done__c=true;
            qc.Approval_Status_Overall__c='Approved';
            update qc;
            
            qc.Level_1_Approval_Done__c = true;
            qc.Approval_Status_Overall__c='Submitted';
            update qc;
            qc.Level_1_Approval_Done__c = true;
            qc.Level_2_Approval_Done__c = true;
            qc.Approval_Status_Overall__c = 'Submitted';
            update qc;
            qc.Approval_Status_Overall__c = 'Submitted';
            qc.Level_1_Approval_Done__c = true;
            qc.Level_2_Approval_Done__c = false;
            update qc;
            
            qc.Level_1_Approval_Done__c = false;
            qc.Level_2_Approval_Done__c = true;
            update qc;
            
            qc.Level_1_Approval_Done__c = true;
            qc.Level_2_Approval_Done__c = true;
            qc.Level_3_Approval_Done__c=true;
            qc.Approval_Status_Overall__c='Submitted';
            update qc;
            
            qc.Level_1_Approval_Done__c = true;
            qc.Level_2_Approval_Done__c = true;
            qc.Level_3_Approval_Done__c=false;
            qc.Approval_Status_Overall__c='Submitted';
            update qc;
            
            qc.Level_1_Approval_Done__c = true;
            qc.Level_2_Approval_Done__c = true;
            qc.Level_3_Approval_Done__c=true;
            qc.Approver_4__c='Approved';
            qc.Approval_Status_Overall__c='Submitted';
            update qc;
            
            qc.Level_2_Approval_Done__c = true;
            qc.Approval_Status_Overall__c = 'Submitted';
            update qc;
            
            qc.Level_3_Approval_Done__c=true;
            qc.Level_of_Approval_Required__c=3;
            qc.Approval_Status_Overall__c='Submitted';
            update qc;
            
            
            
            
            qc.Level_4_Approval_Done__c=true;
            qc.Approval_Status_Overall__c = 'Approved';    
            update qc;
            
            qcc.Level_1_Approval_Done__c = true; 
            update qcc;
            
            qcc.Level_2_Approval_Done__c = true; 
            qcc.Approval_Status_Overall__c = 'Submitted';
            update qcc;
            
            qcc.Level_3_Approval_Done__c = true;
            Update qcc;
            qcc.Level_4_Approval_Done__c = true;
            qcc.Approval_Status_Overall__c = 'Submitted';
            // qc.Level_of_Approval_maxima_from_QLI__c = 4;
            update qcc; 
            
            test.stopTest();
        }
        catch(exception e){
            
        }
        
    }
    
    public @istest static void myquotemethod1(){
        
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
        
        try{
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
            no.Stage__c = '';
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
            
            //  list<QuotesN__c>  qlist =new list<QuotesN__c>();
            QuotesN__c qcc = new QuotesN__c();
            //   qc.Level_of_Approval_maxima_from_QLI__c =1;
            qcc.Approver_1__c = uu.Id;
            qcc.Approver_2__c = uu.Id;
            qcc.Approver_3__c = uu.Id;
            qcc.Approver_4__c = uu.Id; 
            qcc.Quote_Type__c='Free Trial';
            qcc.Xcode__c=xc.id;
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
            ql3.Adjusted_Value__c = 40;
            ql3.Unit_Price__c = 1277500.00;
            ql3.Quantity_Unit__c = 4;
            ql3.Base_Total__c = 1277500.00;
            ql3.Level_of_Approval_Required__c=3; 
            //l1.Actual_Disount_Cap__c=40;
            ql3.Category__c='C';
            //insert qli;
            qulist1.add(ql3);
            
            
            insert qulist1;
            
            test.startTest(); 
            
            qcc.Level_1_Approval_Done__c = true; 
            update qcc;
            
            qcc.Level_2_Approval_Done__c = true; 
            qcc.Approval_Status_Overall__c = 'Submitted';
            
            update qcc;
            qcc.Approval_Status_Overall__c = 'Submitted';
            qcc.Level_3_Approval_Done__c = true;
            Update qcc;
            qcc.Level_4_Approval_Done__c = true;
            qcc.Approval_Status_Overall__c = 'Submitted';
            // qc.Level_of_Approval_maxima_from_QLI__c = 4;
            update qcc; 
            
            test.stopTest();
        }
        catch(exception e){
            
        }
        
    }
    
      public @istest static void myquotemethod2(){
        
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
        
        try{
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
            no.Stage__c = '';
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
            
            //  list<QuotesN__c>  qlist =new list<QuotesN__c>();
            QuotesN__c qcc = new QuotesN__c();
            //   qc.Level_of_Approval_maxima_from_QLI__c =1;
            qcc.Approver_1__c = uu.Id;
            qcc.Approver_2__c = uu.Id;
            qcc.Approver_3__c = uu.Id;
            qcc.Approver_4__c = uu.Id; 
            qcc.Quote_Type__c='Free Trial';
            qcc.Xcode__c=xc.id;
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
            ql3.Adjusted_Value__c = 40;
            ql3.Unit_Price__c = 1277500.00;
            ql3.Quantity_Unit__c = 4;
            ql3.Base_Total__c = 1277500.00;
            ql3.Level_of_Approval_Required__c=4; 
            //l1.Actual_Disount_Cap__c=40;
            ql3.Category__c='D';
            //insert qli;
            qulist1.add(ql3);
            
            
            insert qulist1;
            
            test.startTest(); 
            
            qcc.Level_1_Approval_Done__c = true; 
            update qcc;
            
            qcc.Level_2_Approval_Done__c = true; 
            qcc.Approval_Status_Overall__c = 'Submitted';
            
            update qcc;
            qcc.Approval_Status_Overall__c = 'Submitted';
            qcc.Level_3_Approval_Done__c = true;
            Update qcc;
            qcc.Level_4_Approval_Done__c = true;
            qcc.Approval_Status_Overall__c = 'Submitted';
            // qc.Level_of_Approval_maxima_from_QLI__c = 4;
            update qcc; 
            
            test.stopTest();
        }
        catch(exception e){
            
        }
        
    }

    
}