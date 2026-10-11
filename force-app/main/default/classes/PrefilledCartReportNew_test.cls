@istest
public class PrefilledCartReportNew_test {

    public @istest static void mymethod(){
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
      insert cs;
        
      List<Account> acclist=new List<Account>();
    Account a = new Account();
        a.Name = 'ANUP ENTERPRISE INDIA LTD';
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
        
         Price_Master__c pm = new Price_Master__c();
            pm.Name='INR Price Book';
            pm.CurrencyIsoCode='INR';
            insert pm;
        
      /*   OpportunityN__c o = new OpportunityN__c();
            o.Account__c= a.id;
            o.Contact__c=c.id;
            o.Close_Date__c = date.today().adddays(10);
            o.Closure_Week__c ='Week-2';
            o.Closure_probablity__c ='Will';
            o.Expected_Revenue__c=12121222;
            o.Price_Master__c = pm.Id; 
            o.Stage__c = 'Proposal Sent';
            o.Opportunity_Type__c='free trial';
            
            o.Actual_Revenue__c= 12131;
            //o.OwnerId = uu.Id; 
            
            insert o;*/
        
       
        
    
    List<ProductC__c> prolist=new List<ProductC__c>();
    ProductC__c pro=new ProductC__c();
     pro.Active__c=true;
       // m1.Price_Master__c = pl.id;
      prolist.add(pro);
    insert prolist;
           
        QuotesN__C  q=new QuotesN__C ();
        q.Account__c=a.id;
        q.Contact__c=c.id;
        q.CurrencyIsoCode='INR';
        insert q;
        
        List<Quote_Line_Items__c> qli=new List<Quote_Line_Items__c>();
        Quote_Line_Items__c qq=new Quote_Line_Items__c();
        qq.Product__c=pro.id;
        qq.Quantity_Unit__c=6;
        qq.Quotes__c=q.Id;
        qq.Unit_Price__c=199;
        qq.CurrencyIsoCode='INR';
        qli.add(qq);
        insert qli;
        
        List<string> strli=new List<string>();
        strli.add('ANUP');
        
        
         ApexPages.currentPage().getParameters().put('id',q.id );
         ApexPages.StandardController sc = new ApexPages.standardController(q);
        
        PrefilledCartReportNew ir=new PrefilledCartReportNew(sc);
        ir.qp=q;
        ir.pli=qli;
        ir.account=acclist;
        ir.basize=1;
        ir.total=1000;
        ir.ba=strli;
        ir.dec=strli;
    }
}