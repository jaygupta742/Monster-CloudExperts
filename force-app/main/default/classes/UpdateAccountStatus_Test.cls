@istest
public class UpdateAccountStatus_Test {
@isTest Static void TestPA()
    {
        
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
        
        ProductM__c m1=new ProductM__c();
    m1.name='Premium Resume Search';
     m1.Active__c=true;
        m1.Price_List1__c = 'INR; ';
        
    insert m1;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
        
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
    pl.Active__c=TRUE;
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
       apttus_proposal_proposal__c qp1 = new apttus_proposal_proposal__c();
        qp1.Account__c=a.id;
        qp1.Opportunity__c=o.id;
        qp1.APTS_Quote_Type__c='PFC';
        qp1.Order_Type__c='PFC';
        qp1.Channel__c='PFC';
        qp1.Primary_Contact__c=c.id;
        qp1.Selling_Country__c='India';
        qp1.BillContact__c=c.id;
        qp1.PostingContact__c=c.id;
        //qp1.Billing_Address__c=
        qp1.PriceList__c = pl.Id; 
        //qp1.Billing_Address__c=addr.id;
       // qp1.Posting_Address__c= addr.id;
       
        insert qp1;
        
        
        Proposal_Line_Item__c pli1 = new Proposal_Line_Item__c();
        pli1.Product__c = m1.id;
        pli1.Proposal_Locked__c=qp1.id;
        pli1.Adjustment_Type__c = 'Base Price Override';
        pli1.Quantity__c = 20;
        pli1.Adjustment_Amount__c = 10;
         pli1.Start_Date__c= system.today();
        pli1.End_Date__c=system.today()+2;
        pli1.Price__c = 400;
        
        insert pli1;
        OrderC__c ord1 = new OrderC__c();
        ord1.Account__c = a.id;
        ord1.QuoteProposal__c = qp1.id;
        ord1.Opportunity__c=o.id;
        ord1.PrimarySalesRep__c=userInfo.getUserId();
        ord1.PriceList__c = pl.id;
        ord1.Contract_End_Date__c=system.today()+1;
        insert ord1;
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
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
       
        insert qp;
        
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = 'Base Price Override';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 10;
        pli.Start_Date__c= system.today();
        pli.End_Date__c=system.today()+1;
        pli.Price__c = 400;
        
        insert pli;
       List<Id> pp= new  List<Id>();
        OrderC__c ord = new OrderC__c();
        ord.Account__c = a.id;
        ord.QuoteProposal__c = qp.id;
        ord.Opportunity__c=o.id;
        ord.Contract_End_Date__c=system.today()+2;
        ord.PrimarySalesRep__c=userInfo.getUserId();
        ord.PriceList__c = pl.id;
        
        insert ord;
        pp.add(ord.id);
         
        UpdateAccountStatus.UpdateFlowId(pp);
}
}