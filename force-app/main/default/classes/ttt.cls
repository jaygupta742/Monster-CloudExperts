@istest
public class ttt {

    //public @istest static void mymethod(){
       
    
    
    /*public @istest static void myquotemethod1(){
        
        
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
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu@start.com',email='absdu@gmail.com',Channel__c='IND TS');
        
        
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
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_Category__c='Standard';
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
        pc.Channel__c=uu.Channel__c; 
        
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
        //  n1.Price_Master__c=pm.id;
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
        
        list<QuotesN__c> listq=new list<QuotesN__c>();
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
        qc.Opportunities__c=n1.id;
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
        // qlist.add(qc);
        //  listq.add(qc); 
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=n2.id;
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
        
        insert listq;
        
        
        test.startTest();
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qcc.Id;
        ql4.Account__c = a.id;
        ql4.Opportunities__c = no.id;
        ql4.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql4.Product_Industry__c = 'Full';
        ql4.Product_Geo_Scope__c ='All';
        ql4.Product_Country__c = 'APAC without India'; 
        ql4.Adjusted_Value__c = 22; 
        ql4.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql4;
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India'; 
        ql2.Adjusted_Value__c = 22; 
        ql2.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        //  insert ql2;
        
        Quote_Line_Items__c ql21 = new Quote_Line_Items__c();
        ql21.Quotes__c = qc1.Id;
        ql21.Account__c = a.id;
        ql21.Opportunities__c = no.id;
        ql21.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql21.Product_Industry__c = 'Full';
        ql21.Product_Geo_Scope__c ='All';
        ql21.Product_Country__c = 'APAC without India'; 
        ql21.Adjusted_Value__c = 22; 
        ql21.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql21;
        
        Quote_Line_Items__c ql5 = new Quote_Line_Items__c();
        ql5.Quotes__c = qcc.Id;
        ql5.Account__c = a.id;
        ql5.Opportunities__c = no.id;
        ql5.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql5.Product_Industry__c = 'Full';
        ql5.Product_Geo_Scope__c ='All';
        ql5.Product_Country__c = 'APAC without India'; 
        ql5.Adjusted_Value__c = 30;
        ql5.Level_of_Approval_Required__c=3; 
        
        ql5.Category__c='C';
        insert ql5;
        
        
        Quote_Line_Items__c ql = new Quote_Line_Items__c();
        ql.Quotes__c = qc.Id;
        ql.Account__c = a.id;
        ql.Opportunities__c = no.id;
        ql.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql.Product_Industry__c = 'Full';
        ql.Product_Geo_Scope__c ='All';
        ql.Product_Country__c = 'APAC without India'; 
        ql.Adjusted_Value__c = 30;
        ql.Level_of_Approval_Required__c=3; 
        
        ql.Category__c='C';
        // insert ql;
        
        Quote_Line_Items__c ql51 = new Quote_Line_Items__c();
        ql51.Quotes__c = qc1.Id;
        ql51.Account__c = a.id;
        ql51.Opportunities__c = no.id;
        ql51.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql51.Product_Industry__c = 'Full';
        ql51.Product_Geo_Scope__c ='All';
        ql51.Product_Country__c = 'APAC without India'; 
        ql51.Adjusted_Value__c = 30;
        ql51.Level_of_Approval_Required__c=3; 
        
        ql51.Category__c='C';
        insert ql51;
        
        Quote_Line_Items__c ql86 = new Quote_Line_Items__c();
        ql86.Quotes__c = qcc.Id;
        ql86.Account__c = a.id;
        ql86.Opportunities__c = no.id;
        ql86.Product__c = pc.Id;
        //  ql86.Price_Master__c = pm.Id;
        ql86.Product_Industry__c = 'Full';
        ql86.Product_Geo_Scope__c ='All';
        ql86.Product_Country__c = 'APAC without India'; 
        ql86.Adjusted_Value__c = 45;
        ql86.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql86.Category__c='D'; 
        
        insert ql86;
        
        Quote_Line_Items__c ql6 = new Quote_Line_Items__c();
        ql6.Quotes__c = qc.Id;
        ql6.Account__c = a.id;
        ql6.Opportunities__c = no.id;
        ql6.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql6.Product_Industry__c = 'Full';
        ql6.Product_Geo_Scope__c ='All';
        ql6.Product_Country__c = 'APAC without India'; 
        ql6.Adjusted_Value__c = 45;
        ql6.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql6.Category__c='D';
        //insert ql6;
        
        Quote_Line_Items__c ql61 = new Quote_Line_Items__c();
        ql61.Quotes__c = qc1.Id;
        ql61.Account__c = a.id;
        ql61.Opportunities__c = no.id;
        ql61.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql61.Product_Industry__c = 'Full';
        ql61.Product_Geo_Scope__c ='All';
        ql61.Product_Country__c = 'APAC without India'; 
        ql61.Adjusted_Value__c = 45;
        ql61.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql61.Category__c='D';
        insert ql61;
        
        qcc.Approval_Status_Overall__c = 'Submitted';
        qcc.Level_1_Approval_Done__c = true;
        qcc.Level_2_Approval_Done__c = false;
        qcc.Level_3_Approval_Done__c = true;
        
        qc.Approval_Status_Overall__c = 'Submitted';
        qc.Level_1_Approval_Done__c = true;
        qc.Level_2_Approval_Done__c = false;
        qc.Level_3_Approval_Done__c = true;
        
        qc1.Approval_Status_Overall__c = 'Submitted';
        qc1.Level_1_Approval_Done__c = true;
        qc1.Level_2_Approval_Done__c = false;
        qc1.Level_3_Approval_Done__c = true;
        
        update listq;
        
        test.stoptest(); 
        
        
    }
    
    public @istest static void myquotemethod2(){
        
        
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
        
        User uu = new User(Alias = 'absduu1', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu1', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu1@start.com',email='absduu1@gmail.com',Channel__c='ME TS');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu2', 
                           EmailEncodingKey='UTF-8', LastName='sdscu2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu2@start.com',email='absdu2@gmail.com',Channel__c='MMW');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu22', 
                           EmailEncodingKey='UTF-8', LastName='sdsc22', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd22@start.com',email='absd22@gmail.com',Channel__c='MY FS');
        
        
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
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_Category__c='Standard';
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
        pc.Channel__c=uu.Channel__c; 
        
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
        
        
        OpportunityN__c n3 = new OpportunityN__c();
        n3.Account__c= a.id;
        n3.Contact__c=c.id;
        //  n3.Price_Master__c=pm.id;
        n3.Opportunity_Type__c='free trial';
        
        n3.Actual_Revenue__c= 12131;
        n3.Close_Date__c = date.today().adddays(10);
        n3.Closure_Week__c ='Week-2';
        n3.Closure_probablity__c ='Will';
        n3.Expected_Revenue__c=12121222;
        n3.Price_Master__c = pm.Id; 
        n3.Stage__c = 'Proposal Sent';
        
        oplist.add(n3);
        insert oplist;
        
        list<QuotesN__c> listq=new list<QuotesN__c>();
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
        qc.Opportunities__c=n1.id;
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
        // qlist.add(qc);
        listq.add(qc); 
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=n2.id;
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
        
        insert listq;
        
        
        test.startTest();
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qcc.Id;
        ql4.Account__c = a.id;
        ql4.Opportunities__c = no.id;
        ql4.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql4.Product_Industry__c = 'Full';
        ql4.Product_Geo_Scope__c ='All';
        ql4.Product_Country__c = 'APAC without India'; 
        ql4.Adjusted_Value__c = 22; 
        ql4.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql4;
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India'; 
        ql2.Adjusted_Value__c = 22; 
        ql2.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql2;
        
        Quote_Line_Items__c ql21 = new Quote_Line_Items__c();
        ql21.Quotes__c = qc1.Id;
        ql21.Account__c = a.id;
        ql21.Opportunities__c = no.id;
        ql21.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql21.Product_Industry__c = 'Full';
        ql21.Product_Geo_Scope__c ='All';
        ql21.Product_Country__c = 'APAC without India'; 
        ql21.Adjusted_Value__c = 22; 
        ql21.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql21;
        
        Quote_Line_Items__c ql5 = new Quote_Line_Items__c();
        ql5.Quotes__c = qcc.Id;
        ql5.Account__c = a.id;
        ql5.Opportunities__c = no.id;
        ql5.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql5.Product_Industry__c = 'Full';
        ql5.Product_Geo_Scope__c ='All';
        ql5.Product_Country__c = 'APAC without India'; 
        ql5.Adjusted_Value__c = 30;
        ql5.Level_of_Approval_Required__c=3; 
        
        ql5.Category__c='C';
        insert ql5;
        
        
        Quote_Line_Items__c ql = new Quote_Line_Items__c();
        ql.Quotes__c = qc.Id;
        ql.Account__c = a.id;
        ql.Opportunities__c = no.id;
        ql.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql.Product_Industry__c = 'Full';
        ql.Product_Geo_Scope__c ='All';
        ql.Product_Country__c = 'APAC without India'; 
        ql.Adjusted_Value__c = 30;
        ql.Level_of_Approval_Required__c=3; 
        
        ql.Category__c='C';
        insert ql;
        
        Quote_Line_Items__c ql51 = new Quote_Line_Items__c();
        ql51.Quotes__c = qc1.Id;
        ql51.Account__c = a.id;
        ql51.Opportunities__c = no.id;
        ql51.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql51.Product_Industry__c = 'Full';
        ql51.Product_Geo_Scope__c ='All';
        ql51.Product_Country__c = 'APAC without India'; 
        ql51.Adjusted_Value__c = 30;
        ql51.Level_of_Approval_Required__c=3; 
        
        ql51.Category__c='C';
        //    insert ql51;
        
        Quote_Line_Items__c ql86 = new Quote_Line_Items__c();
        ql86.Quotes__c = qcc.Id;
        ql86.Account__c = a.id;
        ql86.Opportunities__c = no.id;
        ql86.Product__c = pc.Id;
        //  ql86.Price_Master__c = pm.Id;
        ql86.Product_Industry__c = 'Full';
        ql86.Product_Geo_Scope__c ='All';
        ql86.Product_Country__c = 'APAC without India'; 
        ql86.Adjusted_Value__c = 45;
        ql86.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql86.Category__c='D'; 
        
        insert ql86;
        
        Quote_Line_Items__c ql6 = new Quote_Line_Items__c();
        ql6.Quotes__c = qc.Id;
        ql6.Account__c = a.id;
        ql6.Opportunities__c = no.id;
        ql6.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql6.Product_Industry__c = 'Full';
        ql6.Product_Geo_Scope__c ='All';
        ql6.Product_Country__c = 'APAC without India'; 
        ql6.Adjusted_Value__c = 45;
        ql6.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql6.Category__c='D';
        insert ql6;
        
        Quote_Line_Items__c ql61 = new Quote_Line_Items__c();
        ql61.Quotes__c = qc1.Id;
        ql61.Account__c = a.id;
        ql61.Opportunities__c = no.id;
        ql61.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql61.Product_Industry__c = 'Full';
        ql61.Product_Geo_Scope__c ='All';
        ql61.Product_Country__c = 'APAC without India'; 
        ql61.Adjusted_Value__c = 45;
        ql61.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql61.Category__c='D';
        //  insert ql61;
        
        qcc.Approval_Status_Overall__c = 'Submitted';
        qcc.Level_1_Approval_Done__c = true;
        qcc.Level_2_Approval_Done__c = true;
        qcc.Level_3_Approval_Done__c = true;
        
        qc.Approval_Status_Overall__c = 'Submitted';
        qc.Level_1_Approval_Done__c = true;
        qc.Level_2_Approval_Done__c = false;
        qc.Level_3_Approval_Done__c = true;
        
        qc1.Approval_Status_Overall__c = 'Submitted';
        qc1.Level_1_Approval_Done__c = true;
        qc1.Level_2_Approval_Done__c = false;
        qc1.Level_3_Approval_Done__c = true;
        
        update listq;
        
        test.stoptest();
        
        
    }
    
    public @istest static void myquotemethod3(){
        
        
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
        
        User uu = new User(Alias = 'absduu11', 
                           EmailEncodingKey='UTF-8', LastName='sdscuu11', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absduu11@start.com',email='absduu11@gmail.com',Channel__c='SEA TS');
        
        
        ulist.add(uu);
        //  insert uu;
        
        
        User u1 = new User(Alias = 'absdu422', 
                           EmailEncodingKey='UTF-8', LastName='sdscu422', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absdu422@start.com',email='absdu422@gmail.com',Channel__c='SG FS');
        
        
        ulist.add(u1);
        
        User u2 = new User(Alias = 'absdu232', 
                           EmailEncodingKey='UTF-8', LastName='sdsc232', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absd232@start.com',email='absd232@gmail.com',Channel__c='SMB');
        
        
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
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_Category__c='Standard';
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
        pc.Channel__c=uu.Channel__c; 
        
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
        
        
        OpportunityN__c n3 = new OpportunityN__c();
        n3.Account__c= a.id;
        n3.Contact__c=c.id;
        n3.Close_Date__c = date.today().adddays(10);
        n3.Closure_Week__c ='Week-2';
        n3.Closure_probablity__c ='Will';
        n3.Expected_Revenue__c=12121222;
        n3.Price_Master__c = pm.Id; 
        n3.Stage__c = 'Proposal Sent';
        n3.Opportunity_Type__c='free trial';
      
        n3.Actual_Revenue__c= 12131;
        // n3.OwnerId = u3.Id;
        
        oplist.add(n3);
        insert oplist;
        
        list<QuotesN__c> listq=new list<QuotesN__c>();
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
        qc.Opportunities__c=n1.id;
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
        // qlist.add(qc);
        listq.add(qc); 
        
        QuotesN__c qc1 = new QuotesN__c();  
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=n2.id;
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
        
        insert listq;
        
        
        test.startTest();
        
        Quote_Line_Items__c ql4 = new Quote_Line_Items__c();
        ql4.Quotes__c = qcc.Id;
        ql4.Account__c = a.id;
        ql4.Opportunities__c = no.id;
        ql4.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql4.Product_Industry__c = 'Full';
        ql4.Product_Geo_Scope__c ='All';
        ql4.Product_Country__c = 'APAC without India'; 
        ql4.Adjusted_Value__c = 22; 
        ql4.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql4;
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc.Id;
        ql2.Account__c = a.id;
        ql2.Opportunities__c = no.id;
        ql2.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India'; 
        ql2.Adjusted_Value__c = 22; 
        ql2.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql2;
        
        Quote_Line_Items__c ql21 = new Quote_Line_Items__c();
        ql21.Quotes__c = qc1.Id;
        ql21.Account__c = a.id;
        ql21.Opportunities__c = no.id;
        ql21.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql21.Product_Industry__c = 'Full';
        ql21.Product_Geo_Scope__c ='All';
        ql21.Product_Country__c = 'APAC without India'; 
        ql21.Adjusted_Value__c = 22; 
        ql21.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql21;
        
        Quote_Line_Items__c ql5 = new Quote_Line_Items__c();
        ql5.Quotes__c = qcc.Id;
        ql5.Account__c = a.id;
        ql5.Opportunities__c = no.id;
        ql5.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql5.Product_Industry__c = 'Full';
        ql5.Product_Geo_Scope__c ='All';
        ql5.Product_Country__c = 'APAC without India'; 
        ql5.Adjusted_Value__c = 30;
        ql5.Level_of_Approval_Required__c=3; 
        
        ql5.Category__c='C';
        insert ql5;
        
        
        Quote_Line_Items__c ql = new Quote_Line_Items__c();
        ql.Quotes__c = qc.Id;
        ql.Account__c = a.id;
        ql.Opportunities__c = no.id;
        ql.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql.Product_Industry__c = 'Full';
        ql.Product_Geo_Scope__c ='All';
        ql.Product_Country__c = 'APAC without India'; 
        ql.Adjusted_Value__c = 30;
        ql.Level_of_Approval_Required__c=3; 
        
        ql.Category__c='C';
        insert ql;
        
        Quote_Line_Items__c ql51 = new Quote_Line_Items__c();
        ql51.Quotes__c = qc1.Id;
        ql51.Account__c = a.id;
        ql51.Opportunities__c = no.id;
        ql51.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql51.Product_Industry__c = 'Full';
        ql51.Product_Geo_Scope__c ='All';
        ql51.Product_Country__c = 'APAC without India'; 
        ql51.Adjusted_Value__c = 30;
        ql51.Level_of_Approval_Required__c=3; 
        
        ql51.Category__c='C';
        //    insert ql51;
        
        Quote_Line_Items__c ql86 = new Quote_Line_Items__c();
        ql86.Quotes__c = qcc.Id;
        ql86.Account__c = a.id;
        ql86.Opportunities__c = no.id;
        ql86.Product__c = pc.Id;
        //  ql86.Price_Master__c = pm.Id;
        ql86.Product_Industry__c = 'Full';
        ql86.Product_Geo_Scope__c ='All';
        ql86.Product_Country__c = 'APAC without India'; 
        ql86.Adjusted_Value__c = 45;
        ql86.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql86.Category__c='D'; 
        
        insert ql86;
        
        Quote_Line_Items__c ql6 = new Quote_Line_Items__c();
        ql6.Quotes__c = qc.Id;
        ql6.Account__c = a.id;
        ql6.Opportunities__c = no.id;
        ql6.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql6.Product_Industry__c = 'Full';
        ql6.Product_Geo_Scope__c ='All';
        ql6.Product_Country__c = 'APAC without India'; 
        ql6.Adjusted_Value__c = 45;
        ql6.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql6.Category__c='D';
        insert ql6;
        
        Quote_Line_Items__c ql61 = new Quote_Line_Items__c();
        ql61.Quotes__c = qc1.Id;
        ql61.Account__c = a.id;
        ql61.Opportunities__c = no.id;
        ql61.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql61.Product_Industry__c = 'Full';
        ql61.Product_Geo_Scope__c ='All';
        ql61.Product_Country__c = 'APAC without India'; 
        ql61.Adjusted_Value__c = 45;
        ql61.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql61.Category__c='D';
        //  insert ql61;
        
        qcc.Approval_Status_Overall__c = 'Submitted';
        qcc.Level_1_Approval_Done__c = true;
        qcc.Level_2_Approval_Done__c = true;
        qcc.Level_3_Approval_Done__c = true;
        
        qc.Approval_Status_Overall__c = 'Submitted';
        qc.Level_1_Approval_Done__c = true;
        qc.Level_2_Approval_Done__c = false;
        qc.Level_3_Approval_Done__c = true;
        
        qc1.Approval_Status_Overall__c = 'Submitted';
        qc1.Level_1_Approval_Done__c = true;
        qc1.Level_2_Approval_Done__c = false;
        qc1.Level_3_Approval_Done__c = true;
        
        update listq;
        
        test.stoptest();
        
        
        
    }  
    
    public @istest static void myquotemethod4(){
        
        
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
        
        User u1 = new User(Alias = 'absda2', 
                           EmailEncodingKey='UTF-8', LastName='sdsca2', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absda2@start.com',email='absda2@gmail.com',Channel__c='HK FS');
        
        
        
        ulist.add(u1);
        
        User uu = new User(Alias = 'absade1', 
                           EmailEncodingKey='UTF-8', LastName='sdsace1', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p.Id, 
                           TimeZoneSidKey='America/Los_Angeles',username = 'absaeda1@start.com',email='absead1@gmail.com',Channel__c='BFSI'); 
        
        ulist.add(uu);
        
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
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_Category__c='Standard';
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
        pc.Channel__c=u1.Channel__c; 
        
        insert pc;
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book';
        insert pm;
        
        list<OpportunityN__c> oplist = new list<OpportunityN__c>();
        
        
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
        
        list<QuotesN__c> listq=new list<QuotesN__c>();
        
        QuotesN__c qc = new QuotesN__c();  
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=n1.id;
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
        // qlist.add(qc);
        listq.add(qc); 
        
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
        
        insert listq;
        
        
        
        test.startTest();
        
        Quote_Line_Items__c ql3 = new Quote_Line_Items__c();
        ql3.Quotes__c = qc.Id;
        ql3.Account__c = a.id;
        ql3.Opportunities__c = n1.id;
        ql3.Product__c = pc.Id;
        // ql3.Price_Master__c = pm.Id;
        ql3.Product_Industry__c = 'Full';
        ql3.Product_Geo_Scope__c ='All';
        ql3.Product_Country__c = 'APAC without India';  
        ql3.Level_of_Approval_Required__c=1;  
        insert ql3;
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Quotes__c = qc.Id;
        ql2.Account__c = a.id;
        
        ql2.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        ql2.Product_Industry__c = 'Full';
        ql2.Product_Geo_Scope__c ='All';
        ql2.Product_Country__c = 'APAC without India'; 
        ql2.Adjusted_Value__c = 22; 
        ql2.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert ql2;
        
        Quote_Line_Items__c qlc2 = new Quote_Line_Items__c();
        qlc2.Quotes__c = qcc.Id;
        qlc2.Account__c = a.id;
        
        qlc2.Product__c = pc.Id;
        // ql4.Price_Master__c = pm.Id;
        qlc2.Product_Industry__c = 'Full';
        qlc2.Product_Geo_Scope__c ='All';
        qlc2.Product_Country__c = 'APAC without India'; 
        qlc2.Adjusted_Value__c = 22; 
        qlc2.Level_of_Approval_Required__c = 2;
        // qulist1.add(ql4);
        insert qlc2; 
        
        
        
        Quote_Line_Items__c ql = new Quote_Line_Items__c();
        ql.Quotes__c = qc.Id;
        ql.Account__c = a.id;
        
        ql.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        ql.Product_Industry__c = 'Full';
        ql.Product_Geo_Scope__c ='All';
        ql.Product_Country__c = 'APAC without India'; 
        ql.Adjusted_Value__c = 30;
        ql.Level_of_Approval_Required__c=3; 
        
        ql.Category__c='C';
        insert ql;
        
        Quote_Line_Items__c qlc = new Quote_Line_Items__c();
        qlc.Quotes__c = qcc.Id;
        qlc.Account__c = a.id;
        
        qlc.Product__c = pc.Id;
        //  ql5.Price_Master__c = pm.Id;
        qlc.Product_Industry__c = 'Full';
        qlc.Product_Geo_Scope__c ='All';
        qlc.Product_Country__c = 'APAC without India'; 
        qlc.Adjusted_Value__c = 30;
        qlc.Level_of_Approval_Required__c=3; 
        
        qlc.Category__c='C';
        insert qlc;
        
        
        Quote_Line_Items__c ql6 = new Quote_Line_Items__c();
        ql6.Quotes__c = qc.Id;
        ql6.Account__c = a.id;
        
        ql6.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql6.Product_Industry__c = 'Full';
        ql6.Product_Geo_Scope__c ='All';
        ql6.Product_Country__c = 'APAC without India'; 
        ql6.Adjusted_Value__c = 45;
        ql6.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql6.Category__c='D';
        insert ql6;
        
        
        Quote_Line_Items__c ql6c = new Quote_Line_Items__c();
        ql6c.Quotes__c = qcc.Id;
        ql6c.Account__c = a.id;
        
        ql6c.Product__c = pc.Id;
        //  ql6.Price_Master__c = pm.Id;
        ql6c.Product_Industry__c = 'Full';
        ql6c.Product_Geo_Scope__c ='All';
        ql6c.Product_Country__c = 'APAC without India'; 
        ql6c.Adjusted_Value__c = 45;
        ql6c.Level_of_Approval_Required__c=4; 
        //l1.Actual_Disount_Cap__c=40;
        ql6c.Category__c='D';
        insert ql6c;          
        
        
        
        qc.Approval_Status_Overall__c = 'Submitted';
        qc.Level_1_Approval_Done__c = true;
        qc.Level_2_Approval_Done__c = false;
        qc.Level_3_Approval_Done__c = true; 
        
        qcc.Approval_Status_Overall__c = 'Submitted';
        qcc.Level_1_Approval_Done__c = true;
        qcc.Level_2_Approval_Done__c = false;
        //  qcc.Level_3_Approval_Done__c = true; 
        update listq;
        
        test.stoptest();
        
        
        
        
    }
    
    public @istest static void myquotemethod11(){
        
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
        pc.Product_Category__c='Standard';
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
        pc1.Product_Category__c='Standard';
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
        
        // pc1.Channel__c=  'EA';
        insert pc1;
        
        OpportunityN__c no = new OpportunityN__c();
        no.Account__c= a.id;
        no.Contact__c=c.id;
        no.Price_Master__c=pm.id;
        no.Close_Date__c = date.today().adddays(10);
        no.Closure_Week__c ='Week-2';
        no.Closure_probablity__c ='Will';
        no.Expected_Revenue__c=12121222;
        
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
        
        
    }*/
    
    public @istest static void myquotemethod22(){
        
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
        
        Trigger__c tk1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert tk1;
        
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
        pc.Product_Category__c='Standard';
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
        pc1.Product_Category__c='Standard';
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
        
        // pc1.Channel__c=  'EA';
        insert pc1;
        
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
        
       Attachment att = new Attachment();
        att.Body=blob.valueOf('sdfd');
        att.Name='att Name';
        att.ParentId=qcc.Id;
        insert att;
        
        Test.startTest();
        SendQuoteNew.checkForAttachment(String.valueOf(qcc.id));
        SendQuoteNew.get_Quote(String.valueOf(qcc.id));
        SendQuoteNew.sendAttachedPdf(String.valueOf(qcc.id));
                                             SendQuoteNew.getTemplate(String.valueOf(qcc.id));

        //sendQuotePDF.saveTheFile(String.valueOf(qlist[0].id), 'vsdfsd', 'cadcsd', '.html');
        SendQuoteNew.saveChunk(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html', String.valueOf(att.id));
        SendQuoteNew.saveChunk(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html', '');
        
         SendQuoteNew.saveChunk1(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html', String.valueOf(att.id));
        SendQuoteNew.saveChunk1(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html', '');
        
        SendQuoteNew.saveChunk2(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html', String.valueOf(att.id));
        SendQuoteNew.saveChunk2(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html', '');
        
                SendQuoteNew.saveTheFile(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html');
                SendQuoteNew.saveTheFile1(String.valueOf(qcc.id), 'dsfsd', 'cadcsd', '.html');
              //SendQuoteNew.appendToFile1(att.id, '.html');
        try{
        SendQuoteNew.onSend(String.valueOf(qcc.id),'vnsdjf','gfsdfgs@gmail.com','gfsdfgs@gmail.com',  'mbody', String.valueOf(att.Id),String.valueOf(att.Id),String.valueOf(att.Id));
        }
        catch(Exception e){
            
        }
        Test.stopTest();
       

    }
}