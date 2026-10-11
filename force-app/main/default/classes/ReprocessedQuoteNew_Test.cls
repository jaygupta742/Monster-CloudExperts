@istest
public class ReprocessedQuoteNew_Test {
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
        insert p;
        
        
        
        test.startTest();
        
        list<QuotesN__c>  qlist =new list<QuotesN__c>();
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
        qlist.add(q);
        insert qlist;
        
         //  User u= new User();
        //  u=[select id,name,email,User.Manager.Email,User.Manager.FirstName,User.Manager.LastName from user where id=:q.OwnerId];
        ReprocessedQuoteNew.ReProcessedQuoteSent(q.Id);
        test.stopTest();
    }
}