@isTest
public class editallPayment_Test {

    @isTest Static void editallPayment_Test()
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
    pa.Attributes__c='A;B;C';
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
        
    Product_Attribute_Value__c pav1=new Product_Attribute_Value__c();
    pav1.Get__c='A=1;';
    pav1.Product__c=m1.id;
    pav1.Product_PriceList__c=pl.id;
    pav1.set__c='A=1;Final;';
    insert pav1;
    
    
    
    
          Discount_Attributes__c sobj = new Discount_Attributes__c();
          sobj.Product__c = m1.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
          insert sobj;
       
        
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
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        

        Opportunity__c o1 = new Opportunity__c();
        o1.Account__c=a.id;
        o1.Close_Date__c=System.today();
        o1.OpportunityType__c='Trial';
        o1.Stage__c='Identification';
        o1.Identification_Date__c = System.today();
        o1.Base_Total__c = 500;
        o1.Gross_Total__c = 500;
        o1.Net_Total__c = 1000;
        o1.Tax_Name__c = 'GST';
        o1.Tax_Amount__c = 0;
        o1.Tax_Percentage__c = 0;
        o1.Total_Discount__c = 0;
        o1.Total_Discount_Amount__c = 0;
        insert o1;
        
        
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
       // qp.Opportunity__c=o1.id;
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
        qp.Tax_Name__c = 'GST';
        qp.Tax_Percentage__c = 0;
        qp.TotalDiscount__c = 0;
        insert qp;
       
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = 'Discount Amount';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 10;
       
        pli.Price__c = 400;
        
        insert pli;
        
        
                
        APTS_APAC_Payment__c aap01 = New APTS_APAC_Payment__c();
        aap01.Proposal__c= qp.id;
        aap01.Payment_Amount__c = 0;
        aap01.TDS_Amount_c__c=0;
        aap01.APAC_Payment_Type__c ='Single Shot';
        aap01.Due_Date__c = System.today()+5;
        aap01.CurrencyIsoCode = 'INR';
        insert aap01;
        
        
        
        
        
        apttus_proposal_proposal__c qp1 = new apttus_proposal_proposal__c();
        qp1.Account__c=a.id;
        qp1.Opportunity__c=o1.id;
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
        //qp1.Posting_Address__c= addr.id;
        
       
        insert qp1;
        
        
        Proposal_Line_Item__c pli1 = new Proposal_Line_Item__c();
        pli1.Product__c = m1.id;
        pli1.Proposal_Locked__c=qp1.id;
        pli1.Adjustment_Type__c = '	Discount Amount';
        pli1.Quantity__c = 20;
        pli1.Adjustment_Amount__c = 10;
       
        pli1.Price__c = 400;
        
        insert pli1;
        
        APTS_APAC_Payment__c aap = New APTS_APAC_Payment__c();
        aap.Proposal__c= qp1.id;
        aap.Payment_Amount__c = 100;
        aap.TDS_Amount_c__c=100;
        insert aap;

        
            
        
        PageReference pageRef = Page.editallPayment;
        pageRef.getParameters().put('id', qp.Id);
        Test.setCurrentPage(pageRef);        
         ApexPages.StandardController sc = new ApexPages.StandardController(qp);
        editallPayment ep = new editallPayment(sc);
        
        
        
         ep.so[0].Payment_Amount__c = 8000;
        ep.savemethod();

 ep.so[0].Payment_Amount__c = 0;
          system.debug('qqqqqqqqqqqqqqqqqqqqq'+ep.so[0].Payment_Amount__c);
        ep.savemethod();
                
        
        ep.so[0].Payment_Amount__c = 900;
        ep.savemethod();
        ep.so[0].Payment_Amount__c = 200;
        ep.savemethod();
        
       
        
     /*    ep.so[0].Payment_Amount__c = 0;
          system.debug('qqqqqqqqqqqqqqqqqqqqq'+ep.so[0].Payment_Amount__c);
        ep.savemethod();
        ep.so[0].Payment_Amount__c = 800;
        ep.savemethod();
       
         ep.so[0].Payment_Amount__c = 1000;
         ep.so[0].Due_Date__c = System.today()-5;
         ep.savemethod();*/
        
        APTS_APAC_Payment__c aap0 = New APTS_APAC_Payment__c();
        aap0.Proposal__c= qp.id;
        aap0.Payment_Amount__c = 1000;
        aap0.TDS_Amount_c__c=100;
        aap0.APAC_Payment_Type__c ='Single Shot';
        aap0.Due_Date__c = System.today()+5;
        aap0.CurrencyIsoCode = 'INR';
        
            insert aap0;
        
         
        //delete aap0;
        
        ep.numberOfRowToRemove = 0;
        ep.removeLine();
        	 ep.Addrows();
        
        
        
        
    }
    
   @isTest Static void editallPayment_Test2()    //@renuadded
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
        
        
         ProductM__c m=new ProductM__c();
    	m.name='branding';
    	m.Active__c=true;
    	m.Price_List1__c = 'INR; ';
    	m.Trail_Custom_or_Promo__c=true;
        
    insert m;
    
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
        Product_Attribute_Value__c pav1=new Product_Attribute_Value__c();
    pav1.Get__c='A=1;';
    pav1.Product__c=m1.id;
    pav1.Product_PriceList__c=pl.id;
    pav1.set__c='A=1;Final;';
    insert pav1;
    
    
    
    
          Discount_Attributes__c sobj = new Discount_Attributes__c();
          sobj.Product__c = m1.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
    
          insert sobj;
       
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
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        

        Opportunity__c o1 = new Opportunity__c();
        o1.Account__c=a.id;
        o1.Close_Date__c=System.today();
        o1.OpportunityType__c='Trial';
        o1.Stage__c='Identification';
        o1.Identification_Date__c = System.today();
        o1.Base_Total__c = 500;
        o1.Gross_Total__c = 500;
        o1.Net_Total__c = 1000;
        o1.Tax_Name__c = 'GST';
        o1.Tax_Amount__c = 0;
        o1.Tax_Percentage__c = 0;
        o1.Total_Discount__c = 0;
        o1.Total_Discount_Amount__c = 0;
        
        insert o1;
        
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
       // qp.Opportunity__c=o1.id;
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
        qp.Tax_Name__c = 'GST';
        qp.Tax_Percentage__c = 1; //@renu
        qp.TotalDiscount__c = 0;
        
       
        insert qp;
        
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = '	Discount Amount';
        pli.Quantity__c = 20;
       // pli.Adjustment_Amount__c = 10; @renu
       
        pli.Price__c = 400;
        
        insert pli;
        
        
                
        APTS_APAC_Payment__c aap01 = New APTS_APAC_Payment__c();
        aap01.Proposal__c= qp.id;
        aap01.Payment_Amount__c = 0;
        aap01.TDS_Amount_c__c=0;
        aap01.APAC_Payment_Type__c ='Single Shot';
        aap01.Due_Date__c = System.today()+5;
        aap01.CurrencyIsoCode = 'INR';
        insert aap01;
        
        
        apttus_proposal_proposal__c qp1 = new apttus_proposal_proposal__c();
        qp1.Account__c=a.id;
        qp1.Opportunity__c=o1.id;
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
        //qp1.Posting_Address__c= addr.id;
        
       
        insert qp1;
        
        
        Proposal_Line_Item__c pli1 = new Proposal_Line_Item__c();
        pli1.Product__c = m1.id;
        pli1.Proposal_Locked__c=qp1.id;
        pli1.Adjustment_Type__c = '	Discount Amount';
        pli1.Quantity__c = 20;
       // pli1.Adjustment_Amount__c = 10;@renu
       
        pli1.Price__c = 400;
        
        insert pli1;
        
        APTS_APAC_Payment__c aap = New APTS_APAC_Payment__c();
        aap.Proposal__c= qp.id;
        aap.Payment_Amount__c = 100;
        aap.TDS_Amount_c__c=100;
        insert aap;

        
            
       
            PageReference pageRef = Page.editallPayment;
        pageRef.getParameters().put('id', qp.Id);
        Test.setCurrentPage(pageRef); 
      
         ApexPages.StandardController sc = new ApexPages.StandardController(qp);
       
        editallPayment ep = new editallPayment(sc);
            
          
         
       /* ep.so[0].Payment_Amount__c = 8000;
        ep.savemethod();*/

        ep.so[0].Payment_Amount__c = 0;
          system.debug('qqqqqqqqqqqqqqqqqqqqq'+ep.so[0].Payment_Amount__c);
          ep.savemethod();
                
        
      ep.so[0].Payment_Amount__c = 800;  
        ep.savemethod();
       ep.so[0].Payment_Amount__c = 200;
       ep.savemethod();                       
        
     ep.so[0].Payment_Amount__c = 808;  //@renu
       ep.savemethod();    
        
       {//addedbyrenu
             for(APTS_APAC_Payment__c pp : ep.so)
             {
                 pp.Due_Date__c=System.Today()-5;
             }
            ep.savemethod();
       }
        //addedbyrenu
        
       
        
       /*  ep.so[0].Payment_Amount__c = 0;
          system.debug('qqqqqqqqqqqqqqqqqqqqq'+ep.so[0].Payment_Amount__c);
        ep.savemethod();
        ep.so[0].Payment_Amount__c = 800;
        ep.savemethod();
        
         ep.so[0].Payment_Amount__c = 1000;
         ep.so[0].Due_Date__c = System.today()-5;
         ep.savemethod();*/
        
       APTS_APAC_Payment__c aap0 = New APTS_APAC_Payment__c(); 
        aap0.Proposal__c= qp.id;
        aap0.Payment_Amount__c = 1000;
        aap0.TDS_Amount_c__c=100;
        aap0.APAC_Payment_Type__c ='Single Shot';
        aap0.Due_Date__c = System.today()+5;
        aap0.CurrencyIsoCode = 'INR';
        
            insert aap0;  
        
        
         
        //delete aap0;
        
        ep.numberOfRowToRemove = 0;
        ep.removeLine();
        ep.Addrows();
       
        }
         
        }