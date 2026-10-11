@istest
public class CurrencyUpdate_test2 {
       @isTest Static void Currency_Updator_Test()
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
        
        Account a = new Account();
        a.Name = 'Testaccount';
        a.SalesChannel__c = 'Enterprise Business';
        a.Import_Source__c='eeee';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='Hong Kong';
        a.Website='www.asdfert.com';
        a.Phone= '+918965874589';
        a.OtherPhone__c = '+987456985474';
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
        a.Segment__c = 'Commercial';       
        a.Lead_Source1__c= 'Call Inbound';
        a.Latest_Product_End_Date__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        a.Lead_Account_Active_Date__c =  Date.newInstance(2016, 12, 9);
        

        
        insert a;
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
       
        a.Latest_Product_End_Date__c =  datetime.newInstance(2019, 9, 15, 12, 30, 0);
        a.Lead_Account_Active_Date__c =  Date.newInstance(2019, 12, 9);
        a.Lead_Account_Status__c='Active';
        Update a;
       
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Contact__c = c.id;
        o.Name__c ='oppnewww';
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        o.OpportunitySource__c = 'Customer Service';
        insert o; 
        
        /*Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/
        a.Latest_Product_End_Date__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        a.Lead_Account_Active_Date__c =  Date.newInstance(2016, 12, 9);
        a.Lead_Account_Status__c='Active';
        Update a;
       
        ProductM__c m1=new ProductM__c();
        m1.name='Premium Resume Search';
        m1.Active__c=true;
        m1.Price_List1__c = 'INR';
        insert m1;
    
        Product_Attribute__c pa=new Product_Attribute__c ();
        pa.Product__c=m1.id;
        pa.Attributes__c='A;B;C;';
        insert pa;
    
        
        Product_PriceList__c pl=new Product_PriceList__c();
        pl.name='INR'; 
        pl.Active__c=true;
        insert pl;
        
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
        
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
        insert qp;
        //addr.Country__c='India';
        //Update addr;
        // 
         qp.PriceList__c=pl.id;
        
        update qp;
       /* Tax_Refference__c t = new Tax_Refference__c();
        t.Name = 'India';
        t.Selling_Country__c = 'India';
        t.Client_Location__c = 'India';
        t.TAx_Name__c = 'aaa';
        t.Tax_Rate__c= 20;
        Insert t; */
        
        Proposal_Line_Item__c  pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qp.id;
        pit.Quantity__c=1;
        pit.Price__c=120;
        insert pit;
        
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=120;
        ap.TDS_Amount_c__c=0;
        ap.Due_Date__c=system.today()+3;
        insert ap;
        
        orderC__c od = new OrderC__c();
        od.QuoteProposal__c=qp.id;
        od.Account__c = a.Id;
        od.Opportunity__c = o.Id;
        od.QuoteProposal__c =  qp.Id;
        od.OrderStatus__c = 'Open';
        od.OrderDate__c	 = system.today();
        od.Selling_Country__c = 'Spain';
        insert od;
        string latestproddate;
        
        
        List<Order_Line_Item__c> loo = new List<Order_Line_Item__c>();
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=od.id;
        ol.Quantity__c=1;
        ol.Order__c = od.Id;
        ol.Account_lkp__c = a.id;
        ol.Start_Date__c= system.today();
        ol.End_Date__c = system.today()+3;
       
         
        
        Order_Line_Item__c  ol1= new Order_Line_Item__c();
        ol1.Order__c=od.id;
        ol1.Quantity__c=1;
        ol.Account_lkp__c = a.Id;
        ol.Order__c = ol.Id;
        ol1.Start_Date__c= system.today();
        ol1.End_Date__c = system.today()+3;
      
        
        loo.add(ol1);
        
         //upsert loo;  
  
      //  a.Id = ol.Id;
          a.Latest_Product_End_Date__c = ol1.End_Date__c;    
          insert loo;    
    }
}