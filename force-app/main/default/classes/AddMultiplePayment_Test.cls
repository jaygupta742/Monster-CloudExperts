@istest
public class AddMultiplePayment_Test {

    @istest static void TestPa(){
        
        
        
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
        
        
        
         user u = new user();
        u= [SELECT id,name,Price_List__c FROM USER WHERE id=:UserInfo.getUserId()];
        
        ProductM__c m=new ProductM__c();
    m.name='classic resume search';
    m.Active__c=true;
        m.Price_List1__c = 'INR; ';
    insert m;
    
    ProductM__c m1=new ProductM__c();
    m1.name='branding';
     m1.Active__c=true;
        m1.Price_List1__c = 'INR; ';
    insert m1;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
        
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
    pl.OwnerId=u.id;
    pl.Active__c=true;
    insert pl;
    
  
        
    Product_Price_Entry__c pe=new Product_Price_Entry__c();
    pe.PriceList__c=pl.id;
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
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Lead_Source1__c='ECOMM';
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
        insert a;
        Xcode__c    x= new Xcode__c();
        x.Created_For_Account__c=a.id;
        x.Name='TestPA';
        insert x;
        Xcode_Account__c ca=[select id from Xcode_Account__c where Account__c=:a.id ];
        Xcode_Account__c    xc= new Xcode_Account__c();
        xc.id=ca.id;
       // xc.Account__ca.id;
        xc.Is_Primary__c=true;
        update xc;
        
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
        o.OpportunityType__c='	New Customer ';
        o.Stage__c='Sale Declared';
        insert o;
        
       /* Address1__c addr= new Address1__c();
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
        //qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
       // qp.Billing_Address__c=addr.id;
       // qp.Posting_Address__c= addr.id;
        qp.PriceList__c=pl.id;
        insert qp;
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = 'Base Price Override';
        //pli.Adjustment_Type__c = 'None';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 100;
        
        pli.Price__c = 400;
        
        insert pli;
        
        
      
        
       /* 
       Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = 'Base Price Override';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 00;
        
        pli.Price__c = 40;
        
        insert pli;
        
        
        APTS_APAC_Payment__c aap = New APTS_APAC_Payment__c();
        aap.Proposal__c= qp.id;
        aap.TDS_Amount_c__c=100.00;
        aap.Payment_Amount__c = 700.00;
        insert aap;
        */
        
        
        PageReference pf = page.AddMultiplePayment;
        pf.getParameters().put('id',qp.id);
        test.setCurrentPage(pf);
        ApexPages.StandardController sc = new ApexPages.StandardController(qp);
        AddMultiplePayment ap =new AddMultiplePayment(sc);
        ap.tt.TDS_Amount_c__c=100.00;
         ap.tt.Payment_Amount__c =0;
        ap.Save1();
         ap.tt.Payment_Amount__c = 700.00;
         ap.Save1();
         ap.tt.Payment_Amount__c = 1900;
         ap.Save1();
        try{
             for(APTS_APAC_Payment__c pp : ap.pro1)
             {
                 pp.Proposal__c =null;
             }
            ap.Save1();
        } catch(Exception e)
        {}
        
         
        ap.Addrows();
        ap.numberOfRowToRemove=0;
        ap.removeLine();
      
    }
}