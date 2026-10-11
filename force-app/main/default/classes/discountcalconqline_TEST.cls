@istest
public class discountcalconqline_TEST {
    @istest
    public static void testdata(){
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
        Trigger__c t3 = new trigger__c(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        insert cs; 
        
        list<Account> acclist=new list<Account>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'Enterprise Business';
        a.Segment__c='ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        acclist.add(a);
        insert acclist;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        insert o;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name = 'INR Price Book';
        pm.CurrencyIsoCode = '';
        insert pm;
        
        ProductC__c p = new ProductC__c();
        p.Price_Master__c = pm.Id;
        p.Product_Code__c = 'RDAS1AE00N';
        p.Product_SKU_Code__c = 'RDAS1AE12M00NR1';
        p.UOM__c = '1 Qty/product';
        p.Unit_List_Price_Value__c = 1277500.00;
        p.Active__c = true;
        p.Channel__c = 'SMB';
        p.SKU_Type__c = 'Access-x';
        p.Product_Description__c = '20000';
        p.Discount_Cap__c = 9;
        insert p;
        
        
        ProductC__c p1 = new ProductC__c();
        p1.Price_Master__c = pm.Id;
        p1.Product_Code__c = 'RDAS1AE00N';
        p1.Product_SKU_Code__c = 'RDAS1AE12M00NR1';
        p1.UOM__c = '1 Qty/product';
        p1.Unit_List_Price_Value__c = 1277500.00;
        p1.Active__c = true;
        p1.Channel__c = 'SMB';
        p1.SKU_Type__c = 'Access-x';
        p1.Product_Description__c = '20000';
        p1.Discount_Cap__c = 15;
        insert p1;
        
        ProductC__c p2 = new ProductC__c();
        p2.Price_Master__c = pm.Id;
        p2.Product_Code__c = 'RDAS1AE00N';
        p2.Product_SKU_Code__c = 'RDAS1AE12M00NR1';
        p2.UOM__c = '1 Qty/product';
        p2.Unit_List_Price_Value__c = 1277500.00;
        p2.Active__c = true;
        p2.Channel__c = 'SMB';
        p2.SKU_Type__c = 'Access-x';
        p2.Product_Description__c = '20000';
        p2.Discount_Cap__c = 25;
        insert p2;
        ProductC__c p3 = new ProductC__c();
        p3.Price_Master__c = pm.Id;
        p3.Product_Code__c = 'RDAS1AE00N';
        p3.Product_SKU_Code__c = 'RDAS1AE12M00NR1';
        p3.UOM__c = '1 Qty/product';
        p3.Unit_List_Price_Value__c = 1277500.00;
        p3.Active__c = true;
        p3.Channel__c = 'SMB';
        p3.SKU_Type__c = 'Access-x';
        p3.Product_Description__c = '20000';
        p3.Discount_Cap__c = 35;
        insert p3;
        
        
        
        QuotesN__c q=new QuotesN__c();
        q.Account__c = a.Id;
        
        q.Quote_Type__c = 'Free Trial';
        q.Selling_Country__c = 'INDIA';
        q.Price_Master__c = pm.Id;
        q.Contact__c = c.Id;
        q.Active__c = true;
        q.Finalised__c = true;
        q.Approval_Status_Overall__c = 'Approved';
        q.Billing_Address__c = 'Account Billing Address';
        q.Posting_Address__c = 'Account Billing Address';
        q.Validated__c = true;
        
        insert q;
        
        
        
        list<Quote_Line_Items__c> quilist = new list<Quote_Line_Items__c>();
        Quote_Line_Items__c qli = new Quote_Line_Items__c();
        // qli.Category__c = 'A';
        //qli.Actual_Disount_Cap__c = 9;
        qli.Quotes__c = q.Id;
        qli.Account__c = a.id; 
        qli.Product__c = p.Id;
        qli.Price_Master__c = pm.Id;
        
        qli.Discount_Value__c = 511000.00;
        qli.Gross_Total__c = 766500.00;
        qli.Adjusted_Value__c = 40;
        qli.Unit_Price__c = 1277500.00;
        
        qli.Base_Total__c = 5.00;
        quilist.add(qli);
        // insert quilist;
        
        Quote_Line_Items__c qll = new Quote_Line_Items__c();
        qll.Category__c = 'B'; 
        qll.Level_of_Approval_Required__c = 1;
        qll.Quotes__c = q.Id;
        qll.Account__c = a.id; 
        qll.Product__c = p1.Id;
        qll.Price_Master__c = pm.Id;  
        qll.Discount_Value__c =  9000; 
        qll.Adjusted_Value__c = 70000; 
        qll.Base_Total__c =  70000;
        
        quilist.add(qll);
        // insert qll;
        
        
        
        
        
        /*  Quote_Line_Items__c qq = new Quote_Line_Items__c();
qq.Category__c = 'B'; 
//ql.Level_of_Approval_Required__c = 1;
qq.Quotes__c = q.Id;
qq.Account__c = a.id; 
qq.Product__c = p1.Id;
qq.Price_Master__c = pm.Id;  
qq.Discount_Value__c =  85; 
qq.Adjusted_Value__c = 110; 
qq.Base_Total__c =  5;
insert qq; */
        
        
        /* Quote_Line_Items__c q11 = new Quote_Line_Items__c();
q11.Category__c = 'B'; 
//  ql.Level_of_Approval_Required__c = 2;
q11.Quotes__c = q.Id;
q11.Account__c = a.id; 
q11.Product__c = p1.Id;
q11.Price_Master__c = pm.Id;  
q11.Discount_Value__c =  75; 
q11.Adjusted_Value__c = 40; 
q11.Base_Total__c =  5;
insert q11; */
        Quote_Line_Items__c ql1 = new Quote_Line_Items__c();
        // ql1.Category__c = 'C'; 
        ql1.Level_of_Approval_Required__c = 2 ;
        ql1.Quotes__c = q.Id;
        ql1.Account__c = a.id; 
        ql1.Product__c = p2.Id;
        ql1.Price_Master__c = pm.Id;  
        ql1.Discount_Value__c =  15000; 
        ql1.Adjusted_Value__c = 40; 
        ql1.Base_Total__c =  70000;
        quilist.add(ql1);
        
        Quote_Line_Items__c ql2 = new Quote_Line_Items__c();
        ql2.Category__c = 'D'; 
        ql2.Level_of_Approval_Required__c = 1 ;
        ql2.Quotes__c = q.Id;
        ql2.Account__c = a.id; 
        ql2.Product__c = p3.Id;
        ql2.Price_Master__c = pm.Id;  
        ql2.Discount_Value__c = 15900;
        ql2.Adjusted_Value__c = 40; 
        ql2.Base_Total__c =  53000;
        ql2.Level_of_Approval_Required__c = 1;
        quilist.add(ql2);
        
        insert quilist;
         qll.Discount_Value__c =11000;
        qll.Base_Total__c =  70000;
        update qll;
         qll.Discount_Value__c =15000;
        qll.Base_Total__c =  70000;
        update qll;
        
        ql1.Discount_Value__c =20000;
        ql1.Base_Total__c =  70000;
        update ql1;
         ql1.Discount_Value__c =20000;
        ql1.Base_Total__c =  53000;
        update ql1;
        
        ql2.Discount_Value__c =25000;
        ql2.Base_Total__c =  53000;
        update ql2;
         ql2.Discount_Value__c =20000;
        ql2.Base_Total__c =  53000;
        update ql2;
        
        q.Level_1_Approval_Done__c=true;
            q.Approval_Status_Overall__c='Submitted';
        update q;
        
        q.Level_2_Approval_Done__c=true;
            q.Approval_Status_Overall__c='Submitted';
        update q;
        
         q.Level_3_Approval_Done__c=true;
            q.Approval_Status_Overall__c='Submitted';
        //update q;
        
        q.Level_3_Approval_Done__c=true;
            q.Approval_Status_Overall__c='Approved';
        update q;

        
        q.Level_4_Approval_Done__c=true;
            q.Approval_Status_Overall__c='Approved';
        update q;
        system.debug('qll Real_Discount__c//////////////////////'+ qll.Real_Discount__c);
        
    }
}