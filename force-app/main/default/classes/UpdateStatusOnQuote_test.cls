@istest
public class UpdateStatusOnQuote_test {
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
        qcca.Start_Date__c = Date.today();
        qcca.End_Date__c = Date.today().addYears(2);
        qcca.OwnerId = uu.Id;
        listq.add(qcca);
        
        insert listq;
        
        list<Quote_Line_Items__c> qulist1=new list<Quote_Line_Items__c>();
        
        Quote_Line_Items__c qlE = new Quote_Line_Items__c();
        qlE.Quotes__c = qcca.Id;
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
        
        insert qulist1;
        
        qcca.Approval_Status_Overall__c = 'Approved';
        qcca.Level_1_Approval_Done__c = true;
        update qcca;        
        
        Order__c order1 = new Order__c();
        order1.Xcode__c = qcca.Xcode__c;
        order1.Account__c = qcca.Account__c;
        order1.Contact__c = qcca.Contact__c;
        order1.Opportunities__c = qcca.Opportunities__c;
        order1.Quotes__c = qcca.id;
        order1.Price_Master__c = qcca.Price_Master__c;
        order1.CurrencyIsoCode = qcca.CurrencyIsoCode;
        order1.Order_Date__c = Date.today();
        order1.Selling_Country__c = qcca.Selling_Country__c;
        order1.Order_Type__c = qcca.Quote_Type__c;
        order1.Account_Type__c = qcca.Account_Type__c;
        order1.Order_Status__c = 'Open';
        order1.Overall_Quote_Status__c = qcca.Approval_Status_Overall__c;
        order1.Tax_Percentage__c = qcca.Tax_Percentage__c;
        order1.Account_Entity_Use_Code1__c = qcca.Account_Entity_Use_Code1__c;
        order1.Revised_Service_End_Date1__c = qcca.Revised_Service_End_Date__c;
        order1.Base_Order_ID__c = qcca.Base_Order_ID__c;
        order1.Shared_with_Person_1__c = qcca.OwnerId;
        order1.Contribution_Person_1__c = 100;
        order1.Shared_with_Person_2__c = qcca.Shared_with_Person_2__c;
        order1.Shared_with_Person_3__c = qcca.Shared_with_Person_3__c;
        order1.Contribution_Person_2__c = qcca.Contribution_Person_2__c;
        order1.Contribution_Person_3__c = qcca.Contribution_Person_3__c;
        order1.Revised_Service_End_Date__c = Date.today();
        insert order1;
        test.stopTest();
        
    }
    
}