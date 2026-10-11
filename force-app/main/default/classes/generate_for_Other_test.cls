@istest
public class generate_for_Other_test {

    
        
    public static testmethod void mymethod(){
          
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
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
        /*
        ProductM__c m1=new ProductM__c();
    m1.name='Premium Resume Search';
     m1.Active__c=true;
        m1.Price_List1__c = 'INR; ';
        
    insert m1;
        
        
        Account acc =new Account();
        acc.Name = 'Test new A1111';
        acc.SalesChannel__c = 'ECOMM';
        acc.Segment__c = 'Commercial';
        acc.Import_Source__c = 'test rep gen';
        acc.Lead_Source1__c = 'ECOMM';
        acc.APAC_Industry__c = 'Automobile';
        acc.Account_Type__c = 'NIT';
        acc.No_of_Employees__c = 20;
        acc.Location__c = 'Philippines';
        acc.Website = 'www.tesqwqwt.com';
        acc.Phone = '+917855523658';
        acc.CreditStatus__c ='OK';
        acc.Lead_Account_Status__c = 'Inactive';
        acc.RegistrationNumber__c='ssssyyyssss';
        insert acc;
        
        Contact con = new contact();
        con.AccountId = acc.id;
        con.LastName = 'Test new Contact';
        con.ContactStatus__c = 'Active';
        con.Phone = acc.phone;
        con.Email = 'Test@gmail.com';
        con.MobilePhone = '7845125252';    
        Insert con;
        
        Address1__c addr =new Address1__c();
        addr.Account__c = acc.id;
        addr.Country__c = 'India';
        addr.State__c = 'Karnataka';
        addr.Type__c = 'Billing';
        addr.Address1__c = 'Test Address';
        addr.City__c = 'Bangalore';
        addr.PinCode__c = '4545454';
        Insert addr;
        
        Opportunity__c opp =new Opportunity__c();
        opp.Name__c = acc.Name;
        opp.Account__c = acc.id;
        opp.Close_Date__c = system.today() + 3;
        opp.OpportunityType__c='GCS Opportunity';
        opp.Stage__c='Rejected';
        Insert opp;
        
        Product_PriceList__c ppl = new Product_PriceList__c();
        ppl.Name = 'HKD';
        
        apttus_proposal_proposal__c app= new apttus_proposal_proposal__c();
        app.Account__c= acc.id;
        app.Opportunity__c=opp.Id;
        app.APTS_Quote_Type__c='PFC';
        app.Order_Type__c='PFC';
        app.Channel__c= 'PFC';
        app.PriceList__c= ppl.Id;
        app.Primary_Contact__c=con.id;
        app.Selling_Country__c='India';
        app.BillContact__c = con.Id;
        app.Billing_Address__c=addr.id;
        app.PostingContact__c= con.Id;
        app.Posting_Address__c= addr.id;
        Insert app;                         */
        
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
        pl.Active__c=true;
       // pl.OwnerId=u.id;
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
          
        
        a.Segment__c = 'Commercial';
        
        a.Lead_Source1__c= 'Call Inbound';
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
        o.OpportunityType__c='Trial';
        o.Stage__c='Rejected';
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
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
        qp.PriceList__c=pl.id;
        
        insert qp; 
          
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
        pli.Adjustment_Type__c = 'Base Price Override';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 10;       
        pli.Price__c = 400;   
        pli.Start_Date__c=system.today();
        pli.End_Date__c=system.today()+20;
        insert pli;
        
        test.startTest();
        Pagereference pageref = Page.generate_for_Other;
        pageref.getParameters().put('id',pli.id);
        Test.setCurrentPage(pageref);
        generate_for_Other gfo = new generate_for_Other();
        gfo.getCountriesOptions();
        gfo.Addtocart();
        gfo.selectedCountry1 = '1 Month';
        gfo.Addtocart();
        gfo.selectedCountry1 = '3 Months';
        gfo.Addtocart();
        gfo.selectedCountry1 = '6 Months';
        gfo.Addtocart();
        
        test.stopTest();
       // ql.add(pli);
        
    }
    
  
}