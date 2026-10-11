@istest
public class LapsedAccountOnOrderExpired_Test {

    @istest static void testpa(){
         List<Trigger__c> tp= new List<Trigger__c>();
         Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tp.add(t);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
         tp.add(tk);
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
         tp.add(t1);
         Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
         tp.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        tp.add(t2k);
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
         tp.add(t2);
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
         tp.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
         tp.add(t4);
        insert tp;
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
       List<Account> lac=new List<Account>();
        
        
        
        List<Account> acl=new List<Account>();
        for(integer i=0;i<4;i++){
            Account a= new Account();
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
        a.Phone= '+917878787874';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        //insert a;
        acl.add(a);
            
        }
        insert acl;
         list<Contact> conl= new List<Contact>();
        for(integer i=0;i<4;i++){
           
         Contact c = new Contact();
        c.AccountID= acl[i].id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='0919898989898';
        //insert c;
        conl.add(c);
        }
        insert conl;
       /* List<Address1__c> adl= new List<Address1__c>();
        for(integer i=0;i<4;i++){
             Address1__c addr= new Address1__c();
        addr.Account__c=acl[i].id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
       
        adl.add(addr);
            
        }
       insert adl;*/
        
  List<Opportunity__c> lop= new List<Opportunity__c>();

        for(integer i=0;i<4;i++){
             Opportunity__c o2 = new Opportunity__c();
        o2.Account__c=acl[i].id;
        o2.Close_Date__c=System.today();
        o2.OpportunityType__c='Trial';
        o2.Stage__c='Identification';
          lop.add(o2);
        }
        insert lop;
        
       
        
        
        
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
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        //insert a;
        lac.add(a);
        
        Account a3 = new Account();
        a3.Name = 'ANKSkkkakka';
        a3.SalesChannel__c = 'ECOMM';
        a3.Segment__c='ECOMM';
        a3.Import_Source__c='sssss';
        a3.Lead_Source1__c='Other';
        a3.APAC_Industry__c='Energy';
        a3.No_of_Employees__c= 25;
        a3.Account_Type__c='NIT';
        a3.Location__c='India';
        a3.Website='www.asdfert.com';
        a3.Phone= '+917878787878';
        a3.RegistrationNumber__c='asq111111';
        a3.Lead_Account_Status__c='Inactive';
        a3.CreditStatus__c='OK';
        a3.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a3.BillingState='Karnataka';
        a3.BillingStreet ='Test Address';
        a3.BillingCity ='bangalore' ;
        a3.BillingPostalCode='560076';
        a3.ShippingCountry='India';
        a3.ShippingCity='Test';
        a3.ShippingPostalCode='56000';
        a3.ShippingState ='Test Address';
        a3.ShippingStreet='Jssttts';
        //insert a;
        lac.add(a3);
        
        Account a4 = new Account();
        a4.Name = 'ANKSkkkakka';
        a4.SalesChannel__c = 'ECOMM';
        a4.Segment__c='ECOMM';
        a4.Import_Source__c='sssss';
        a4.Lead_Source1__c='Other';
        a4.APAC_Industry__c='Energy';
        a4.No_of_Employees__c= 25;
        a4.Account_Type__c='NIT';
        a4.Location__c='India';
        a4.Website='www.asdfert.com';
        a4.Phone= '+917878787878';
        a4.RegistrationNumber__c='asq111111';
        a4.Lead_Account_Status__c='Inactive';
        a4.CreditStatus__c='OK';
         a4.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a4.BillingState='Karnataka';
        a4.BillingStreet ='Test Address';
        a4.BillingCity ='bangalore' ;
        a4.BillingPostalCode='560076';
        a4.ShippingCountry='India';
        a4.ShippingCity='Test';
        a4.ShippingPostalCode='56000';
        a4.ShippingState ='Test Address';
        a4.ShippingStreet='Jssttts';
        lac.add(a4);
        
        
        Account a1 = new Account();
        a1.Name = 'ANKSkkkakka';
        a1.SalesChannel__c = 'ECOMM';
        a1.Segment__c='ECOMM';
        a1.Import_Source__c='sssss';
        a1.Lead_Source1__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Website='www.asdfert.com';
        a1.Phone= '+917878787822';
        a1.RegistrationNumber__c='asq1qq11111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='OK';
         a1.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a1.BillingState='Karnataka';
        a1.BillingStreet ='Test Address';
        a1.BillingCity ='bangalore' ;
        a1.BillingPostalCode='560076';
        a1.ShippingCountry='India';
        a1.ShippingCity='Test';
        a1.ShippingPostalCode='56000';
        a1.ShippingState ='Test Address';
        a1.ShippingStreet='Jssttts';
        //insert a1;
        lac.add(a1);
         Account a2 = new Account();
        a2.Name = 'ANKSkkkakka';
        a2.SalesChannel__c = 'ECOMM';
        a2.Segment__c='ECOMM';
        a2.Import_Source__c='sssss';
        a2.Lead_Source1__c='Other';
        a2.APAC_Industry__c='Energy';
        a2.No_of_Employees__c= 25;
        a2.Account_Type__c='NIT';
        a2.Location__c='India';
        a2.Website='www.asdfert.com';
        a2.Phone= '+917878787822';
        a2.RegistrationNumber__c='asq1qq11111';
        a2.Lead_Account_Status__c='Inactive';
        a2.CreditStatus__c='OK';
        a2.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a2.BillingState='Karnataka';
        a2.BillingStreet ='Test Address';
        a2.BillingCity ='bangalore' ;
        a2.BillingPostalCode='560076';
        a2.ShippingCountry='India';
        a2.ShippingCity='Test';
        a2.ShippingPostalCode='56000';
        a2.ShippingState ='Test Address';
        a2.ShippingStreet='Jssttts';
        lac.add(a2);
        
         Account a5 = new Account();
        a5.Name = 'ANKSkkkakka';
        a5.SalesChannel__c = 'ECOMM';
        a5.Segment__c='ECOMM';
        a5.Import_Source__c='sssss';
        a5.Lead_Source1__c='Other';
        a5.APAC_Industry__c='Energy';
        a5.No_of_Employees__c= 25;
        a5.Account_Type__c='NIT';
        a5.Location__c='India';
        a5.Website='www.asdfert.com';
        a5.Phone= '+917878787878';
        a5.RegistrationNumber__c='asq111111';
        a5.Lead_Account_Status__c='Inactive';
        a5.CreditStatus__c='OK';
         a5.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a5.BillingState='Karnataka';
        a5.BillingStreet ='Test Address';
        a5.BillingCity ='bangalore' ;
        a5.BillingPostalCode='560076';
        a5.ShippingCountry='India';
        a5.ShippingCity='Test';
        a5.ShippingPostalCode='56000';
        a5.ShippingState ='Test Address';
        a5.ShippingStreet='Jssttts';
        //insert a;
        lac.add(a5);
        
        insert lac;
        list<Contact> lcon= new List<Contact>();
         Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='0919898989898';
        //insert c;
        lcon.add(c);
        Contact c1= new Contact();
        c1.AccountID= a1.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='0919898989898';
        //insert c1;
        lcon.add(c1);
       Contact c2= new Contact();
        c2.AccountID= a2.Id;
        c2.LastName='MahendraBaahubali';
        c2.Email='mbahu@gmail.com';
        c2.Phone='0919898989898';
      
           lcon.add(c2);
        
        
        Contact c4 = new Contact();
        c4.AccountID= a4.Id;
        c4.LastName='MahendraBaahubali';
        c4.Email='mbahu@gmail.com';
        c4.Phone='0919898989898';
        //insert c;
        lcon.add(c4);
        
         Contact c5 = new Contact();
        c5.AccountID= a5.Id;
        c5.LastName='MahendraBaahubali';
        c5.Email='mbahu@gmail.com';
        c5.Phone='0919898989898';
        //insert c;
        lcon.add(c5);
        
        insert lcon;
       
       LIst<Account> aup= new List<Account>();

        for(integer i=0;i<4;i++){
             acl[i].Lead_Account_Status__c='Active';
          aup.add(acl[i]);
            
        }
        
       a1.Lead_Account_Status__c='Active';
        //update a1;
        aup.add(a1);
        a2.Lead_Account_Status__c='Active';
        //update a2;
        aup.add(a2);
        a.Lead_Account_Status__c='Active';
        aup.add(a);
        //update a;  
         a4.Lead_Account_Status__c='';
        aup.add(a4);
        a5.Lead_Account_Status__c='';
       aup.add(a5);
        
        update aup;
        
        
         List<apttus_proposal_proposal__c> lopi= new List<apttus_proposal_proposal__c>();
          for(integer i=0;i<4;i++){
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=acl[i].id;
        qp.Opportunity__c=lop[i].id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
        qp.Primary_Contact__c=conl[i].id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=conl[i].id;
        qp.PostingContact__c=conl[i].id;
       // qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
       // qp.Billing_Address__c=adl[i].id;
       // qp.Posting_Address__c= adl[i].id;
       
        lopi.add(qp);
          }
        insert lopi;
         LIst<Proposal_Line_Item__c> lpl= new LIst<Proposal_Line_Item__c>();
  for(integer i=0;i<4;i++){
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=lopi[i].id;
        pli.Adjustment_Type__c = 'Base Price Override';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 0;
        pli.Price__c = 400;
        
        lpl.add(pli);
  }
        insert lpl;
         LIst<OrderC__c> lord1= new LIst<OrderC__c>();
  for(integer i=0;i<3;i++){
        OrderC__c ord = new OrderC__c();
        ord.Account__c = acl[i].id;
        ord.QuoteProposal__c = lopi[i].id;
        ord.Opportunity__c=lop[i].id;
        ord.PrimarySalesRep__c=userInfo.getUserId();
        ord.PriceList__c = pl.id;
       
        lord1.add(ord);
  }
        insert lord1;
        
        
        
         List<Order_Line_Item__c> loli1= new List<Order_Line_Item__c>();
         for(integer i=0;i<3;i++){
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Order__c=lord1[i].id;
        ol.End_Date__c=system.today()+32;
        ol.Price__c=400;
        ol.Quantity__c=20;
        loli1.add(ol);
        
         }
        insert loli1;
        
        loli1[2].End_Date__c=system.today()-32;
        loli1[1].End_Date__c=system.today()+32;
        loli1[1].Price__c=00;
         loli1[1].Quantity__c=00;
        update loli1;
        
       List<Opportunity__c> oppl= new List<Opportunity__c>();
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        oppl.add(o);
       // insert o;
         Opportunity__c o1 = new Opportunity__c();
        o1.Account__c=a1.id;
        o1.Close_Date__c=System.today();
        o1.OpportunityType__c='Trial';
        o1.Stage__c='Identification';
         oppl.add(o1);
        
        Opportunity__c o2 = new Opportunity__c();
        o2.Account__c=a2.id;
        o2.Close_Date__c=System.today();
        o2.OpportunityType__c='Trial';
        o2.Stage__c='Identification';
          oppl.add(o2);
        
        Opportunity__c o4 = new Opportunity__c();
        o4.Account__c=a4.id;
        o4.Close_Date__c=System.today();
        o4.OpportunityType__c='Trial';
        o4.Stage__c='Identification';
        oppl.add(o4);
        
        
        Opportunity__c o5 = new Opportunity__c();
        o5.Account__c=a5.id;
        o5.Close_Date__c=System.today();
        o5.OpportunityType__c='Trial';
        o5.Stage__c='Identification';
        oppl.add(o5);
       
        insert oppl;
       
        
        LIst<apttus_proposal_proposal__c> lopp= new LIst<apttus_proposal_proposal__c>();
        
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
       // qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
       // qp.Posting_Address__c= addr.id;
       
        lopp.add(qp);
        apttus_proposal_proposal__c qp1 = new apttus_proposal_proposal__c();
        qp1.Account__c=a1.id;
        qp1.Opportunity__c=o1.id;
        qp1.APTS_Quote_Type__c='PFC';
        qp1.Order_Type__c='PFC';
        qp1.Channel__c='PFC';
        qp1.Primary_Contact__c=c1.id;
        qp1.Selling_Country__c='India';
        qp1.BillContact__c=c1.id;
        qp1.PostingContact__c=c1.id;
       // qp1.Billing_Address__c=
        qp1.PriceList__c = pl.Id; 
       // qp1.Billing_Address__c=addr1.id;
        //qp1.Posting_Address__c= addr1.id;
               lopp.add(qp1);
        
        
        apttus_proposal_proposal__c qp2 = new apttus_proposal_proposal__c();
        qp2.Account__c=a2.id;
        qp2.Opportunity__c=o2.id;
        qp2.APTS_Quote_Type__c='PFC';
        qp2.Order_Type__c='PFC';
        qp2.Channel__c='PFC';
        qp2.Primary_Contact__c=c2.id;
        qp2.Selling_Country__c='India';
        qp2.BillContact__c=c2.id;
        qp2.PostingContact__c=c2.id;
       // qp2.Billing_Address__c=
        qp2.PriceList__c = pl.Id; 
        //qp2.Billing_Address__c=addr2.id;
       // qp2.Posting_Address__c= addr2.id;
       
        lopp.add(qp2);
        
        
        apttus_proposal_proposal__c qp4 = new apttus_proposal_proposal__c();
        qp4.Account__c=a4.id;
        qp4.Opportunity__c=o4.id;
        qp4.APTS_Quote_Type__c='PFC';
        qp4.Order_Type__c='PFC';
        qp4.Channel__c='PFC';
        qp4.Primary_Contact__c=c4.id;
        qp4.Selling_Country__c='India';
        qp4.BillContact__c=c4.id;
        qp4.PostingContact__c=c4.id;
        //qp4.Billing_Address__c=c4.id;
        qp4.PriceList__c = pl.Id; 
       // qp4.Billing_Address__c=addr4.id;
       // qp4.Posting_Address__c= addr4.id;
       
        lopp.add(qp4);
        
        apttus_proposal_proposal__c qp5 = new apttus_proposal_proposal__c();
        qp5.Account__c=a5.id;
        qp5.Opportunity__c=o5.id;
        qp5.APTS_Quote_Type__c='PFC';
        qp5.Order_Type__c='PFC';
        qp5.Channel__c='PFC';
        qp5.Primary_Contact__c=c5.id;
        qp5.Selling_Country__c='India';
        qp5.BillContact__c=c5.id;
        qp5.PostingContact__c=c5.id;
        //qp5.Billing_Address__c=c5.id;
        qp5.PriceList__c = pl.Id; 
       // qp5.Billing_Address__c=addr5.id;
       // qp5.Posting_Address__c= addr5.id;
       
        lopp.add(qp5);
        
         
       Insert lopp;        
       test.startTest();  
 LIst<Proposal_Line_Item__c> lpli= new LIst<Proposal_Line_Item__c>();
 
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = 'Base Price Override';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 0;
        pli.Price__c = 400;
        
        lpli.add(pli);
        
         Proposal_Line_Item__c pli1 = new Proposal_Line_Item__c();
        pli1.Product__c = m1.id;
        pli1.Proposal_Locked__c=qp1.id;
        pli1.Adjustment_Type__c = 'Base Price Override';
        pli1.Quantity__c = 0;
        pli1.Adjustment_Amount__c = 00;
        
        pli1.Price__c = 400;
        lpli.add(pli1);
       
        Proposal_Line_Item__c pli2 = new Proposal_Line_Item__c();
        pli2.Product__c = m1.id;
        pli2.Proposal_Locked__c=qp2.id;
        pli2.Adjustment_Type__c = 'Base Price Override';
        pli2.Quantity__c = 10;
        pli2.Adjustment_Amount__c = 00;
        pli2.Price__c = 400;
        lpli.add(pli2); 
        
         Proposal_Line_Item__c pli4 = new Proposal_Line_Item__c();
        pli4.Product__c = m1.id;
        pli4.Proposal_Locked__c=qp.id;
        pli4.Adjustment_Type__c = 'Base Price Override';
        pli4.Quantity__c = 20;
        pli4.Adjustment_Amount__c = 0;
        pli4.Price__c = 400;
        
        lpli.add(pli4);
        
         Proposal_Line_Item__c pli5 = new Proposal_Line_Item__c();
        pli5.Product__c = m1.id;
        pli5.Proposal_Locked__c=qp5.id;
        pli5.Adjustment_Type__c = 'Base Price Override';
        pli5.Quantity__c = 20;
        pli5.Adjustment_Amount__c = 0;
        pli5.Price__c = 400;
        
        lpli.add(pli5);
        
        
        insert lpli;
        
        LIst<OrderC__c> lord= new LIst<OrderC__c>();
 
        OrderC__c ord = new OrderC__c();
        ord.Account__c = a.id;
        ord.QuoteProposal__c = qp.id;
        ord.Opportunity__c=o.id;
        ord.PrimarySalesRep__c=userInfo.getUserId();
        ord.PriceList__c = pl.id;
       
        lord.add(ord);
        
         OrderC__c ord1 = new OrderC__c();
        ord1.Account__c = a1.id;
        ord1.QuoteProposal__c = qp1.id;
        ord1.Opportunity__c=o1.id;
        ord1.PrimarySalesRep__c=userInfo.getUserId();
        ord1.PriceList__c = pl.id;
        lord.add(ord1);
         
        OrderC__c ord2 = new OrderC__c();
        ord2.Account__c = a2.id;
        ord2.QuoteProposal__c = qp2.id;
        ord2.Opportunity__c=o2.id;
        ord2.PrimarySalesRep__c=userInfo.getUserId();
        ord2.PriceList__c = pl.id;
               lord.add(ord2);
             
         OrderC__c ord4 = new OrderC__c();
        ord4.Account__c = a4.id;
        ord4.QuoteProposal__c = qp4.id;
        ord4.Opportunity__c=o4.id;
        ord4.PrimarySalesRep__c=userInfo.getUserId();
        ord4.PriceList__c = pl.id;
       
        lord.add(ord4);
        
         OrderC__c ord5 = new OrderC__c();
        ord5.Account__c = a5.id;
        ord5.QuoteProposal__c = qp5.id;
        ord5.Opportunity__c=o5.id;
        ord5.PrimarySalesRep__c=userInfo.getUserId();
        ord5.PriceList__c = pl.id;
       
        lord.add(ord5);

        
        
        insert lord;
        
        List<Order_Line_Item__c> loli= new List<Order_Line_Item__c>();
        
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Order__c=ord.id;
        ol.End_Date__c=system.today()+32;
        ol.Price__c=400;
        ol.Quantity__c=20;
        loli.add(ol);
        
        Order_Line_Item__c ol1= new Order_Line_Item__c();
        ol1.Order__c=ord1.id;
        ol1.End_Date__c=system.today()-2;
        ol1.Price__c=400;
        ol1.Quantity__c=20;
        loli.add(ol1);
        
        Order_Line_Item__c ol2= new Order_Line_Item__c();
        ol2.Order__c=ord2.id;
         ol2.Price__c=0;
        ol2.Quantity__c=0;
        ol2.End_Date__c=system.today()+22;
        loli.add(ol2);
        
         Order_Line_Item__c ol4= new Order_Line_Item__c();
        ol4.Order__c=ord4.id;
        ol4.End_Date__c=system.today()+32;
        ol4.Price__c=400;
        ol4.Quantity__c=20;
        loli.add(ol4);
        
        Order_Line_Item__c ol5= new Order_Line_Item__c();
        ol5.Order__c=ord5.id;
        ol5.End_Date__c=system.today()-32;
        ol5.Price__c=0;
        ol5.Quantity__c=0;
        loli.add(ol5);
        
        
        insert loli;
       
        
        
        
       
       
        qp.Re_Process_DateTime__c=system.now()-2;
        update qp;
         
        a.Lead_Account_Status__c='Rejected';
        update a;
        List<Account> n= new List<Account>();
        for(Account ac:acl){
           ac.id=ac.id;
            ac.Lead_Account_Status__c='Inactive';
            n.add(ac);
        }
       update n;
        
        LapsedAccountOnOrderExpired mp = new LapsedAccountOnOrderExpired();
        Id batchJobId = Database.executeBatch(mp, 200);
        
              
       
        
        
         test.stopTest();
    }
}