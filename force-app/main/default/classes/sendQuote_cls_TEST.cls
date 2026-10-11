@istest
public class sendQuote_cls_TEST { 
    
    @istest
    public static void testdata1(){
        
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);
        Trigger__c t1kk = new Trigger__c(name ='OpportunityN__c',Active__c = true);
        cs.add(t1kk);
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
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
        a.Person_Account__c = true;
        
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='surajmahabudhe@gmail.com';
        c.Phone='9898989898';
        insert c;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book'; 
        insert pm;
        
        
        OpportunityN__c op=new OpportunityN__c();
        op.Account__c = a.Id;
        op.Actual_Revenue__c = 122431;
        op.Stage__c = '';
        op.Close_Date__c = system.today();
        op.Closure_Week__c = '';
        op.Contact__c = c.id; 
        insert op;
        
        Xcode__c xc = new Xcode__c();
        xc.Name='12345';
        xc.Created_For_Account__c= a.id;
        insert xc;
        
        list<QuotesN__c> qoulist =new list<QuotesN__c>();
        QuotesN__c qc = new QuotesN__c();
        qc.Quote_Type__c='Free Trial';
        qc.Xcode__c=xc.id;
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=op.id;
        qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=false;
        qc.Selling_Country__c = 'INDIA'; 
        qc.Finalised__c = true;
        qc.Attach_Service_Agreement__c = true;
        qc.Attach_Prefilled_Cart_Report__c = false;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        
        qoulist.add(qc);
        
        QuotesN__c qc1 = new QuotesN__c();
        qc1.Quote_Type__c='Free Trial';
        qc1.Xcode__c=xc.id;
        qc1.Account__c=a.id;
        qc1.Contact__c=c.id;
        qc1.Opportunities__c=op.id;
        qc1.Price_Master__c=pm.id;
        qc1.CurrencyIsoCode ='INR';
        qc1.Active__c=false;
        qc1.Selling_Country__c = 'INDIA'; 
        qc1.Finalised__c = true;
        qc1.Attach_Service_Agreement__c = false;
        qc1.Attach_Prefilled_Cart_Report__c = true;
        qc1.Approval_Status_Overall__c = 'Pending';
        qc1.Billing_Address__c = 'Account Billing Address';
        qc1.Posting_Address__c = 'Account Billing Address';
        qc1.Validated__c = true;
        qc1.Tax_Percentage__c=18;
        qoulist.add(qc1);
        QuotesN__c qc2 = new QuotesN__c();
        qc2.Quote_Type__c='Free Trial';
        qc2.Xcode__c=xc.id;
        qc2.Account__c=a.id;
        qc2.Contact__c=c.id;
        qc2.Opportunities__c=op.id;
        qc2.Price_Master__c=pm.id;
        qc2.CurrencyIsoCode ='INR';
        qc2.Active__c=false;
        qc2.Selling_Country__c = 'INDIA'; 
        qc2.Finalised__c = true;
        qc2.Attach_Service_Agreement__c = true;
        qc2.Attach_Prefilled_Cart_Report__c = true;
        qc2.Approval_Status_Overall__c = 'Pending';
        qc2.Billing_Address__c = 'Account Billing Address';
        qc2.Posting_Address__c = 'Account Billing Address';
        qc2.Validated__c = true;
        qc2.Tax_Percentage__c=18;
        
        qoulist.add(qc2);
        
        insert qoulist;
        list<sendQuote_cls.wraper> wr=new list<sendQuote_cls.wraper>();
        sendQuote_cls.wraper w=new sendQuote_cls.wraper(qc);
        w.qt = qc;
        w.cc = 'suraj@salesforce.com';
        w.name = 'q1111';
        w.to = 'suraj@gmail.com';
        wr.add(w);
        
       
        
        list<Template__c> listtem = new list<Template__c>();
        Template__c tc = new Template__c();
        tc.Name='Dubai Renewal Report- New';         
        tc.PDF__c='ME_Dubai_Renewal_Report_New';
        tc.DOC__c='';
        tc.Location__c= 'United Arab Emirates';
        listtem.add(tc);
        insert listtem;
        
        
        
        String body = 'Test Body';
        String auth = 'Test Auth';
        String need = 'Test Need';
        String timing = 'Test timing';
        String poten = 'Test poten';
        string cc = 'noreply@gmail.com';
        String reciever = 'testcc@gmail.com';
        String subject = 'testto@gmail.com';
        String com = 'Test com';
        
        
        
        
         test.startTest();
        
        PageReference pageRef = Page.QuoteNewPDF; // Add your VF page Name here 
        ApexPages.currentPage().getParameters().put('id',string.valueOf(qc.id)); 
        Test.setCurrentPage(pageRef); 
        
        try{
            // sendQuote_cls.get_Quote(string.valueOf(c.Id));
            sendQuote_cls.get_Quote(string.valueOf(qc.Id));
            sendQuote_cls.getTemplate(string.valueOf(qc.Id));
            
            sendQuote_cls.onSend( string.valueOf(qc.id), subject, reciever,cc, body, listtem ); 
            sendQuote_cls.onSend( string.valueOf(qc1.id), subject, reciever,cc, body, listtem ); 
            sendQuote_cls.onSend( string.valueOf(qc2.id), subject, reciever,cc, body, listtem ); 
            sendQuote_cls.onSend( string.valueOf(op.id), subject, reciever,cc, body, listtem ); 
            
            
        }
        catch(Exception e) {
            system.debug('getline'+e.getLineNumber());
            system.debug('getsg'+e.getMessage());
           
        }
        test.stopTest(); 
        
    }
    
    
}