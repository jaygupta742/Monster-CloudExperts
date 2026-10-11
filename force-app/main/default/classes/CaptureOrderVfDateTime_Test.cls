@istest
public class CaptureOrderVfDateTime_Test {
  
    @istest static void testpa(){
        
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
        
        
        Folder f = [SELECT id from Folder where name = 'Monster'];
        
        Document d = new Document();
        d.name = 'Monster Logo';
        d.FolderId = f.Id;
        insert d;
         Template__c pp= new Template__c();
        pp.Name='HK Addendum Report-Apttus';
        pp.Location__c='India';
        pp.PDF__c='.pdf';
        pp.DOC__c='.doc';
        Insert pp;
        
       // Id qp.id = ApexPages.currentPage().getParameters().get('Id');
        
        user logged=[select id,name,email from user where id=:userinfo.getuserid()];
        
       
        ProductM__c m1=new ProductM__c();
    m1.name='Premium Resume Search';
     m1.Active__c=true;
         m1.Discount_Threshold__c=80;
        m1.Price_List1__c = 'INR; ';
        
    insert m1;
             ProductM__c m11=new ProductM__c();
    m11.name='Premium job Search';
     m11.Active__c=true;
        m11.Discount_Threshold__c=80;
        m11.Price_List1__c = 'INR; ';
        
    insert m11;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
        
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
        pl.Active__c=true;
    insert pl;
    
  
        
    Product_Price_Entry__c pe=new Product_Price_Entry__c();
    pe.PriceList__c=pl.id;
    pe.DiscountLimit__c=true;
        pe.MaxDiscount__c=80;
    pe.Product__c=m1.id;
    insert pe;
    
    Product_Price_Metrix__c pm=new Product_Price_Metrix__c();
    pm.Currency__c=20;
    pm.Max__c=1;
    pm.Min__c=1;
         
    pm.Product_Config_Code__c='1-1-2';
    pm.Product_Price_Entry__c=pe.id;
    insert pm;
    
    Product_Attribute_Value__c pav=new Product_Attribute_Value__c();
    pav.Get__c='Product:start;';
    pav.Product__c=m1.id;
    pav.Product_PriceList__c=pl.id;
    pav.set__c='A=1,2;';
    insert pav;
        
    
    
    
    
          Discount_Attributes__c sobj = new Discount_Attributes__c();
          sobj.Product__c = m1.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
    
          insert sobj;
       
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
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
        insert a;
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='0919898989898';
        insert c;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        insert o;
        
        /*Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/
        
        a.Lead_Account_Status__c='Active';
        Update a;
       
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=a.id;
        qp.Opportunity__c=o.id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
        
        
        qp.Primary_Contact__c=c.id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=c.id;
        qp.PostingContact__c=c.id;
        qp.Ready_For_Validation__c=system.now();
        qp.Re_Process_DateTime__c=system.now();
       // qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
       
        insert qp;
            
          
           
            
        BusinessHours bh= new BusinessHours();
        bh.IsActive = True;
        bh.Name = 'Quote To Order Tracker';
       
           
            
            
          
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = '% Discount';
        
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 1;
        pli.Price__c = 400;
        
        insert pli;
        
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
           ap.APAC_Payment_Type__c='Single Shot';
           ap.Due_Date__c=system.today()+2;
           ap.Payment_Amount__c=7920.00;
           ap.TDS_Amount_c__c=0;
           ap.Proposal__c=qp.id;
            insert ap;
        
        qp.Approval_Status__c ='No Need Of Approval';
        qp.Approval_Status__c = 'Ready To Finalize';
        update qp;
        
       
        OrderC__c ord1 = new OrderC__c();
        ord1.Account__c = a.id;
        ord1.QuoteProposal__c = qp.id;
        ord1.Opportunity__c=o.id;
        ord1.PrimarySalesRep__c=userInfo.getUserId();
        ord1.PriceList__c = pl.id;
        ord1.Contract_End_Date__c=system.today()+1;
        insert ord1;
        CaptureOrderVfDateTime.ORderRejectCatcher(ord1.id);
        CaptureOrderVfDateTime.ORderVerfiCatcher(ord1.id);
        CaptureOrderVfDateTime.getRecord(ord1.id);
         CaptureOrderVfDateTime.xCodeCount(ord1.id);
        //test.stopTest();
    }
}