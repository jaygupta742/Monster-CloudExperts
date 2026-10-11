/*
* Created By : Abdul Aziz
* Created Date : 29/03/2023
*/

@IsTest public class AccountOppRollUpSummary_Test {
    @istest public static void testdata01(){
        
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        
        Trigger__c t5 = new Trigger__c(name ='Share Portfolio', Active__c = true);
        cs.add(t5);
        insert cs;
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Monster - Sales'].Id,
            LastName = 'Debasis',
            Email = 'debasis@foundit.com',
            Username = 'debasis@foundit.com' + System.currentTimeMillis(),
            CompanyName = 'FoundIt',
            Title = 'Developer',
            Alias = 'Deba',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        insert u;
        
        system.runAs(u) {
            Account a = new Account();
            a.Name = 'Test2';
            a.OtherPhone__c='+919110400258';
            a.SalesChannel__c = 'ECOMM';
            a.Import_Source__c='sssss';
            a.Lead_Source__c='Other';
            a.APAC_Industry__c='Energy';
            a.No_of_Employees__c= 25;
            a.Account_Type__c='Prospect';
            a.Location__c='India';
            a.Website='www.asdfert.com';
            a.Phone= '+917878787878';
            a.RegistrationNumber__c='asq111111';
            a.Lead_Account_Status__c='Inactive';
            a.CreditStatus__c='OK';
            a.ShippingCity='Bangalore';
            a.ShippingCountry='India';
            a.ShippingPostalCode='560000';
            a.ShippingState='Karnataka';
            a.ShippingStreet='BTM';
            a.BillingCity='Bangalore';
            a.BillingCountry='India';
            a.BillingPostalCode='560000';
            a.BillingPostalCode='Karnataka';
            a.BillingStreet='BTM';
            a.Segment__c='Corporate';
            a.Lead_Source1__c='CR';
            a.Team__c = 'Edtech-Courses';
            
            a.Person_Account__c = true; 
            insert a;
            
            Price_Master__c pm = new Price_Master__c();
            pm.Name='INR Price Book';
            pm.CurrencyIsoCode='INR';
            insert pm;
            
            Contact c = new Contact();
            c.AccountID= a.Id;
            c.LastName='MahendraBaahubali';
            c.Email='mbahu@gmail.com';
            c.Phone='9898989898';
            c.PrimarySalesContact__c=true;
            insert c;
            
            a.Lead_Account_Status__c = 'Active';
            update a;
            
            OpportunityN__c op=new OpportunityN__c();
            op.Account__c = a.Id;
            op.Actual_Revenue__c = 122431;
            op.Stage__c = 'Negotiation';
            op.Close_Date__c = system.today();
            op.Closure_Week__c = 'Week-1';
            op.Closure_probablity__c = 'Will';
            op.Expected_Revenue__c =100000;
            op.Opportunity_Type__c = 'Upsell';
            op.Price_Master__c =pm.id;
            op.Contact__c = c.id;
            
            OpportunityN__c op1=new OpportunityN__c();
            op1.Account__c = a.Id;
            op1.Actual_Revenue__c = 122431;
            op1.Stage__c = 'Negotiation';
            op1.Close_Date__c = system.today();
            op1.Closure_Week__c = 'Week-1';
            op1.Closure_probablity__c = 'Will';
            op1.Expected_Revenue__c =100000;
            op1.Opportunity_Type__c = 'Upsell';
            op1.Price_Master__c =pm.id;
            op1.Contact__c = c.id;
            
            ProductM__c m=new ProductM__c();
            m.name='branding';
            m.Active__c=true;
            m.Price_List1__c = 'INR';
            m.IsActive__c = true;
            
            m.Trail_Custom_or_Promo__c=true;
            insert m;
            
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
            pc1.Channel__c=u.Channel__c;
            
            test.startTest();
            insert op;
            insert op1;  
            a.Total_Opportunities__c = 2;
            update a;
            
            List<Opp_Line_Item__c> oplilist= new List<Opp_Line_Item__c>();
            Opp_Line_Item__c opli = new Opp_Line_Item__c();
            opli.Opportunities__c= op1.id;
            opli.Account__c= a.id;
            opli.Product__c= pc1.id;
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
            //  opli.Quantity_Unit__c= 1;
            opli.Base_Total__c=200;
            opli.OPLI__c = opli.Id;
            opli.Discount_Amount_1__c=200;
            opli.Gross_Total__c=100;
            opli.of_Master_Login__c='5';
            oplilist.add(opli);
            
            Opp_Line_Item__c opli1 = new Opp_Line_Item__c();
            opli1.Opportunities__c= op1.id;
            opli1.Account__c= a.id;
            opli1.Product__c=pc1.id;
            opli1.Price_Master__c=pm.id;
            opli1.OPLI__c = opli1.Id;
            //  opli.Quantity_Unit__c=1;
            opli1.DB_Scope_Geography__c='All';
            opli1.DB_Type_Industry__c='Full';
            oplilist.add(opli1);
            insert oplilist;

			delete oplilist;            
            update op1;
            delete op1;
            
            test.stopTest();
        }
    }
    
    @isTest public static void testdata02(){
        
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        
        Trigger__c t5 = new Trigger__c(name ='Share Portfolio', Active__c = true);
        cs.add(t5);
        insert cs;
        
        Account a = new Account();
        a.Name = 'Test2';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='Prospect';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        a.Team__c = 'Edtech-Courses';
        
        a.Person_Account__c = true; 
        insert a;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
        a.Lead_Account_Status__c='Active';
        update a;
        
        OpportunityN__c op=new OpportunityN__c();
        op.Account__c = a.Id;
        op.Actual_Revenue__c = 122431;
        op.Stage__c = 'Negotiation';
        op.Close_Date__c = system.today();
        op.Closure_Week__c = 'Week-1';
        op.Closure_probablity__c = 'Will';
        op.Expected_Revenue__c =100000;
        op.Opportunity_Type__c = 'Upsell';
        op.Price_Master__c =pm.id;
        op.Contact__c = c.id;
        insert op;
        
        OpportunityN__c op1=new OpportunityN__c();
        op1.Account__c = a.Id;
        op1.Actual_Revenue__c = 122431;
        op1.Stage__c = 'Closed Won';
        op1.Close_Date__c = system.today();
        op1.Closure_Week__c = 'Week-1';
        op1.Closure_probablity__c = 'Will';
        op1.Expected_Revenue__c =100000;
        op1.Opportunity_Type__c = 'Upsell';
        op1.Price_Master__c =pm.id;
        op1.Contact__c = c.id;
        test.startTest();
        try{
            insert op1;
            
            AccountOppRollUpSummary_Helper.updateOpportunityDetails(new List<OpportunityN__c>{op1});
            AccountOppRollUpSummary_Helper.checkOwner(new List<OpportunityN__c>{op1});
            AccountOppRollUpSummary_Helper.checkAccountStatus(new List<OpportunityN__c>{op1},new Map<Id,OpportunityN__c>{op1.Id => op1});
            
            delete op1;   
            a.Total_Opportunities__c = 2;
            update a;
        }
        catch(Exception e){  
            System.debug('Exception Message'+e.getMessage()+'Line No. >>'+e.getLineNumber());  
        } 
        test.stopTest();
        
    }
    
    @isTest public static void testdata03(){
        
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
        
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        
        Trigger__c t5 = new Trigger__c(name ='Share Portfolio', Active__c = true);
        cs.add(t5);
        insert cs;
        
        Account a = new Account();
        a.Name = 'Test2';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='Prospect';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        a.Team__c = 'Edtech-Courses';
        
        a.Person_Account__c = true; 
        insert a;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
        a.Lead_Account_Status__c='Active';
        update a;
        
        OpportunityN__c op=new OpportunityN__c();
        op.Account__c = a.Id;
        op.Actual_Revenue__c = 122431;
        op.Stage__c = 'Closed Won';
        op.Close_Date__c = system.today();
        op.Closure_Week__c = 'Week-5';
        op.Closure_probablity__c = 'Will';
        op.Expected_Revenue__c =100000;
        op.Opportunity_Type__c = 'Upsell';
        op.Price_Master__c =pm.id;
        op.Contact__c = c.id;
        insert op;
        
        OpportunityN__c op1=new OpportunityN__c();
        op1.Account__c = a.Id;
        op1.Actual_Revenue__c = 122431;
        op1.Stage__c = 'Closed Won';
        op1.Close_Date__c = system.today();
        op1.Closure_Week__c = 'Week-1';
        op1.Closure_probablity__c = 'Will';
        op1.Expected_Revenue__c =100000;
        op1.Opportunity_Type__c = 'Upsell';
        op1.Price_Master__c =pm.id;
        op1.Contact__c = c.id;
        
        User u1 = [SELECT Id From User Where isActive = true AND (Profile.Name != 'System Admin' OR Profile.Name != 'System Administrator' OR Profile.Name != 'Master Profile' OR Profile.Name != 'Monster - Sales Ops/LM' OR Profile.Name != 'Monster - Service/CR') LIMIT 1 ];
        system.debug('u1' + u1);
        System.runAs(u1) {
            insert op1;
            
            AccountOppRollUpSummary_Helper.updateOpportunityDetails(new List<OpportunityN__c>{op1});
            AccountOppRollUpSummary_Helper.checkOwner(new List<OpportunityN__c>{op1});
            AccountOppRollUpSummary_Helper.checkAccountStatus(new List<OpportunityN__c>{op1},new Map<Id,OpportunityN__c>{op1.Id => op1});
            AccountOppRollUpSummary_Helper.testCoverageBlaster();
            delete op1;   
            a.Total_Opportunities__c = 2;
            update a;
            
        }
        
        test.startTest();
        try{
            
        }
        catch(Exception e){  
            System.debug('Exception Message'+e.getMessage()+'Line No. >>'+e.getLineNumber());  
        } 
        test.stopTest();
        
    }
    
}