@istest
public class DsrRportGenerator_Test {
    @istest static void testPa(){
        user u= new user();
        u=[select id from user where id='0057F000003ST4YQAW'];
         Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
         Trigger__c trr = new Trigger__c(name ='Compliance',Active__c = true);
        insert trr;
        
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
        trigger__c t4 = new trigger__C(name='Opportunity',Active__c = true);
        insert t4;
        
        trigger__c t5 = new trigger__C(name='Quote',Active__c = true);
        insert t5;
        
        trigger__c t6 = new trigger__C(name='Order',Active__c = true);
        insert t6;
        
        Account a = new Account();
        a.Name = 'Testaccount';
        a.SalesChannel__c = 'ECOMM';
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
        
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        //a.ShippingAddress='Test Address';
        a.ShippingCountry='India';
        a.ShippingState='Karnataka';
        a.ShippingStreet='Test Address';
        a.ShippingCity='bangalore';
        a.ShippingPostalCode='560076';
        
        
               
        a.Segment__c = 'Commercial';
        
        a.Lead_Source1__c= 'Call Inbound';
        insert a;
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        insert o;
        
       /* Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='India';
        addr.Type__c='Billing';
        addr.Address1__c='CTM';
        addr.City__c='Odisa';
        addr.PinCode__c='560037';
        insert addr;
        
        Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='India';
        addr1.Type__c='Shipping';
        addr1.Address1__c='BTM Ring Road';
        addr1.City__c='Bangalore';
        addr1.PinCode__c='560037';
        insert addr1; */
        
        System.runAs(u) {

        
        a.Lead_Account_Status__c='Active';
        Update a;
        
        }
      ProductM__c m=new ProductM__c();
       m.name='branding';
      m.Active__c=true;
        m.Price_List1__c = 'INR';
       
         m.Trail_Custom_or_Promo__c=true;
    insert m;
    
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
    
  
        
    Product_Price_Entry__c pe=new Product_Price_Entry__c();
    pe.PriceList__c=pl.id;
    pe.Product__c=m1.id;
    insert pe;
    
    Product_Price_Metrix__c pm=new Product_Price_Metrix__c();
    pm.Currency__c=20;
    pm.Max__c=1;
    pm.Min__c=1;
    pm.Product_Config_Code__c='1';
    pm.Product_Price_Entry__c=pe.id;
    insert pm;
    
    Product_Attribute_Value__c pav=new Product_Attribute_Value__c();
    pav.Get__c='Product:start;';
    pav.Product__c=m1.id;
    pav.Product_PriceList__c=pl.id;
    pav.set__c='A=1,2;';
    insert pav;
        Product_Attribute_Value__c pav1=new Product_Attribute_Value__c();
    pav1.Get__c='A=1;';
    pav1.Product__c=m1.id;
    pav1.Product_PriceList__c=pl.id;
    pav1.set__c='A=1;S1;Contract Duration=1 Month;Final';
    insert pav1;
    
    
   
    
          Discount_Attributes__c sobj = new Discount_Attributes__c();
          sobj.Product__c = m1.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
    
          insert sobj;
       
    
        
   
        
         Product_PriceList__c pl1=new Product_PriceList__c();
    pl1.name='INR';
        pl1.Active__c=true;
    insert pl1;
        
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
        qp.Order_Created_Date__c=system.today();
        qp.PriceList__c = pl.Id; 
        /*qp.Billing_Address__c=addr.id;
        qp.Posting_Address__c= addr.id;*/
        insert qp;
      // addr.Country__c='India';
       // Update addr;
        update qp;
       /* Tax_Refference__c t = new Tax_Refference__c();
        t.Name = 'India';
        t.Selling_Country__c = 'India';
        t.Client_Location__c = 'India';
        t.TAx_Name__c = 'aaa';
        t.Tax_Rate__c= 20;
        Insert t; */
        List<Proposal_Line_Item__c> dd= new List<Proposal_Line_Item__c>();
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qp.id;
        pit.Quantity__c=1;
        pit.Product__c=m1.id;
        pit.Product_Name_With_Attribute__c='Master Location Has Bolding = Y Posting Duration = 60 Days Posting Location = India Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit.Price__c=120;
        //insert pit;
        dd.add(pit);
        
        Proposal_Line_Item__c   pit1= new Proposal_Line_Item__c ();
        pit1.Proposal_Locked__c=qp.id;
        pit1.Quantity__c=1;
        pit1.Product__c=m1.id;
        pit1.Product_Name_With_Attribute__c='Additional Login Location Has Bolding = Y Posting Duration = 60 Days Posting Location = India Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit1.Price__c=120;
        //insert pit1;
        dd.add(pit1);
       Proposal_Line_Item__c    pit2= new Proposal_Line_Item__c ();
        pit2.Proposal_Locked__c=qp.id;
        pit2.Quantity__c=1;
        pit2.Product__c=m1.id;
        pit2.Product_Name_With_Attribute__c='Job Postings Location Has Bolding = Y Posting Duration = 60 Days Posting Location = India Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit2.Price__c=120;
        //insert pit2;
        dd.add(pit2);
        
        Proposal_Line_Item__c   pit3= new Proposal_Line_Item__c ();
        pit3.Proposal_Locked__c=qp.id;
        pit3.Quantity__c=1;
        pit3.Product__c=m1.id;
        pit3.Product_Name_With_Attribute__c='Brandings Location Has Bolding = Y Posting Duration = 60 Days Posting Location = India Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit3.Price__c=120;
        //insert pit3;
        dd.add(pit3);
        Proposal_Line_Item__c   pit4= new Proposal_Line_Item__c ();
        pit4.Proposal_Locked__c=qp.id;
        pit4.Quantity__c=1;
        pit4.Product__c=m1.id;
        pit4.Product_Name_With_Attribute__c='SMS & Target Mailers Has Bolding = Y Posting Duration = 60 Days Posting Location = India Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit4.Price__c=120;
        //insert pit4;
        dd.add(pit4);
        
        Proposal_Line_Item__c   pit5= new Proposal_Line_Item__c ();
        pit5.Proposal_Locked__c=qp.id;
        pit5.Quantity__c=1;
        pit5.Product__c=m1.id;
        pit5.Product_Name_With_Attribute__c='Type=master Location Has Bolding = Y Posting Duration = 60 Days Posting Location =Country=APAC Region except India = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit5.Price__c=120;
        //insert pit5;
        dd.add(pit5);
        
        Proposal_Line_Item__c   pit6= new Proposal_Line_Item__c ();
        pit6.Proposal_Locked__c=qp.id;
        pit6.Quantity__c=1;
        pit6.Product__c=m1.id;
        pit6.Product_Name_With_Attribute__c='Country=Job Postings Location Has Bolding = Y Posting Duration = 60 Days Posting Location = Country=Outside APAC Region Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit6.Price__c=120;
        //insert pit6;
        dd.add(pit6);
        
        Proposal_Line_Item__c   pit7= new Proposal_Line_Item__c ();
        pit7.Proposal_Locked__c=qp.id;
        pit7.Quantity__c=1;
        pit7.Product__c=m1.id;
        pit7.Product_Name_With_Attribute__c='Job Postings Location Has Bolding = Y Posting Duration = 60 Days Posting Location = Country=Outside APAC Region= Intelli Post Qty : 3000 Nos.';
        pit7.Price__c=120;
        //insert pit7;
        dd.add(pit7);
        Proposal_Line_Item__c   pit8= new Proposal_Line_Item__c ();
        pit8.Proposal_Locked__c=qp.id;
        pit8.Quantity__c=1;
        pit8.Product__c=m1.id;
        pit8.Product_Name_With_Attribute__c='Job Posting-IN-Any Location Has Bolding = Y Posting Duration = 60 Days Posting Location = India Site = Monster India Type = Intelli Post Qty : 3000 Nos.';
        pit8.Price__c=120;
        //insert pit8;
        dd.add(pit8);
        Proposal_Line_Item__c   pit9= new Proposal_Line_Item__c ();
        pit9.Proposal_Locked__c=qp.id;
        pit9.Quantity__c=1;
        pit9.Product__c=m1.id;
        pit9.Product_Name_With_Attribute__c='Job Postings Country=APAC Region except India';
        pit9.Price__c=120;
        //insert pit8;
        dd.add(pit9);
        Proposal_Line_Item__c   pit10= new Proposal_Line_Item__c    ();
        pit10.Proposal_Locked__c=qp.id;
        pit10.Quantity__c=1;
        pit10.Product__c=m1.id;
        pit10.Product_Name_With_Attribute__c='Type=master Country = Outside APAC Region';
        pit10.Price__c=120;
        //insert pit8;
        dd.add(pit10);
        insert dd;
        LIst<APTS_APAC_Payment__c> acp= new List<APTS_APAC_Payment__c>();
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=120;
        ap.TDS_Amount_c__c=0;
        ap.Due_Date__c=system.today()+1;
        acp.add(ap);
        APTS_APAC_Payment__c ap1= new APTS_APAC_Payment__c();
        ap1.Proposal__c=qp.id;
        ap1.Payment_Amount__c=120;
        ap1.APAC_Payment_Type__c='Installment - 1';
        ap1.TDS_Amount_c__c=0;
        ap1.Due_Date__c=system.today()+2;
        acp.add(ap1);
         
         APTS_APAC_Payment__c ap2= new APTS_APAC_Payment__c();
        ap2.Proposal__c=qp.id;
        ap2.Payment_Amount__c=120;
        ap2.APAC_Payment_Type__c='Installment - 2';
        ap2.TDS_Amount_c__c=0;
        ap2.Due_Date__c=system.today()+3;
        acp.add(ap2);
         APTS_APAC_Payment__c ap3= new APTS_APAC_Payment__c();
        ap3.Proposal__c=qp.id;
        ap3.Payment_Amount__c=120;
        ap3.APAC_Payment_Type__c='Installment - 3';
        ap3.TDS_Amount_c__c=0;
        ap3.Due_Date__c=system.today()+4;
        acp.add(ap3);
        
        APTS_APAC_Payment__c ap4= new APTS_APAC_Payment__c();
        ap4.Proposal__c=qp.id;
        ap4.Payment_Amount__c=120;
        ap4.APAC_Payment_Type__c='Installment - 4';
        ap4.TDS_Amount_c__c=0;
        ap4.Due_Date__c=system.today()+5;
        acp.add(ap4);
        
        APTS_APAC_Payment__c ap5= new APTS_APAC_Payment__c();
        ap5.Proposal__c=qp.id;
        ap5.Payment_Amount__c=120;
        ap5.APAC_Payment_Type__c='Installment - 5';
        ap5.TDS_Amount_c__c=0;
        ap5.Due_Date__c=system.today()+6;
        acp.add(ap5);
         APTS_APAC_Payment__c ap6= new APTS_APAC_Payment__c();
        ap6.Proposal__c=qp.id;
        ap6.Payment_Amount__c=120;
        ap6.APAC_Payment_Type__c='Installment - 6';
        ap6.TDS_Amount_c__c=0;
        ap6.Due_Date__c=system.today()+7;
        acp.add(ap6);
        
        APTS_APAC_Payment__c ap7= new APTS_APAC_Payment__c();
        ap7.Proposal__c=qp.id;
        ap7.Payment_Amount__c=40;
        ap7.APAC_Payment_Type__c='Installment - 7';
        ap7.TDS_Amount_c__c=0;
        ap7.Due_Date__c=system.today()+8;
        acp.add(ap7);
        
        APTS_APAC_Payment__c ap8= new APTS_APAC_Payment__c();
        ap8.Proposal__c=qp.id;
        ap8.Payment_Amount__c=10;
        ap8.APAC_Payment_Type__c='Installment - 8';
        ap8.TDS_Amount_c__c=0;
        ap8.Due_Date__c=system.today()+8;
        acp.add(ap8);
        APTS_APAC_Payment__c ap9= new APTS_APAC_Payment__c();
        ap9.Proposal__c=qp.id;
        ap9.APAC_Payment_Type__c='Installment - 9';
        ap9.Payment_Amount__c=10;
        ap9.TDS_Amount_c__c=0;
        ap9.Due_Date__c=system.today()+8;
        acp.add(ap9);
         APTS_APAC_Payment__c ap10= new APTS_APAC_Payment__c();
        ap10.Proposal__c=qp.id;
        ap10.APAC_Payment_Type__c='Installment - 10';
        ap10.Payment_Amount__c=10;
        ap10.TDS_Amount_c__c=0;
        ap10.Due_Date__c=system.today()+8;
        acp.add(ap10);
         APTS_APAC_Payment__c ap11= new APTS_APAC_Payment__c();
        ap11.Proposal__c=qp.id;
        ap11.APAC_Payment_Type__c='Installment - 11';
        ap11.Payment_Amount__c=10;
        ap11.TDS_Amount_c__c=0;
        ap11.Due_Date__c=system.today()+8;
        acp.add(ap11);
        
         APTS_APAC_Payment__c ap12= new APTS_APAC_Payment__c();
        ap12.Proposal__c=qp.id;
        ap12.APAC_Payment_Type__c='Installment - 12';
        ap12.Payment_Amount__c=10;
        ap12.TDS_Amount_c__c=0;
        ap12.Due_Date__c=system.today()+8;
        acp.add(ap12);
        
         APTS_APAC_Payment__c ap13= new APTS_APAC_Payment__c();
        ap13.Proposal__c=qp.id;
        ap13.Payment_Amount__c=10;
        ap13.APAC_Payment_Type__c='Installment - 13';
        ap13.TDS_Amount_c__c=0;
        ap13.Due_Date__c=system.today()+8;
        acp.add(ap13);
         
        
        APTS_APAC_Payment__c ap14= new APTS_APAC_Payment__c();
        ap14.Proposal__c=qp.id;
        ap14.Payment_Amount__c=10;
        ap14.APAC_Payment_Type__c='Installment - 14';
        ap14.TDS_Amount_c__c=0;
        ap14.Due_Date__c=system.today()+8;
        acp.add(ap14);
        
        APTS_APAC_Payment__c ap15= new APTS_APAC_Payment__c();
        ap15.Proposal__c=qp.id;
        ap15.Payment_Amount__c=10;
        ap15.APAC_Payment_Type__c='Installment - 15';
        ap15.TDS_Amount_c__c=0;
        ap15.Due_Date__c=system.today()+8;
        acp.add(ap15);
        
         APTS_APAC_Payment__c ap16= new APTS_APAC_Payment__c();
        ap16.Proposal__c=qp.id;
        ap16.APAC_Payment_Type__c='Installment - 16';
        ap16.Payment_Amount__c=10;
        ap16.TDS_Amount_c__c=0;
        ap16.Due_Date__c=system.today()+8;
        acp.add(ap16);
        
        APTS_APAC_Payment__c ap17= new APTS_APAC_Payment__c();
        ap17.Proposal__c=qp.id;
         ap17.APAC_Payment_Type__c='Installment - 17';
        ap17.Payment_Amount__c=10;
        ap17.TDS_Amount_c__c=0;
        ap17.Due_Date__c=system.today()+8;
        acp.add(ap17);
        
        APTS_APAC_Payment__c ap18= new APTS_APAC_Payment__c();
        ap18.Proposal__c=qp.id;
        ap18.APAC_Payment_Type__c='Installment - 18';
        ap18.Payment_Amount__c=10;
        ap18.TDS_Amount_c__c=0;
        ap18.Due_Date__c=system.today()+8;
        acp.add(ap18);
        
        insert acp;
       // insert ap;
        orderC__c od = new OrderC__c();
        od.QuoteProposal__c=qp.id;
        od.Account__c=a.id;
        
        insert od;
        
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=od.id;
        
        ol.Quantity__c=1;
        
        insert ol;
        DsrRportGenerator dp =new DsrRportGenerator();
        dp.sendDsrRepo();
        String st='0 0 * * * ? *';
       system.schedule('Test Territory Check', st, dp);
    }

}