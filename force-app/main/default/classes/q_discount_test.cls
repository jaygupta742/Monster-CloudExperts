@istest

public class q_discount_test
{
public static testmethod void mi1()
{
    list< Trigger__c> tt = new list< Trigger__c>();
    Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tt.add(t);
    
    Trigger__c t1 = new Trigger__c(name ='Contact',Active__c = true);
     tt.add(t1);
    Trigger__c t2 = new Trigger__c(name ='Opportunity',Active__c = true);
     tt.add(t2);
    Trigger__c t3 = new Trigger__c(name ='Quote',Active__c = true);
     tt.add(t3);
    
        insert tt;

ProductM__c m=new ProductM__c();
    m.name='classic resume search';
     m.Active__c=true;
    insert m;
    
    ProductM__c m1=new ProductM__c();
    m1.name='branding';
     m1.Active__c=true;
    insert m1;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
    pl.Active__c=True;
    insert pl;
    
    Product_Price_Entry__c pe=new Product_Price_Entry__c();
    pe.PriceList__c=pl.id;
    pe.Product__c=m1.id;
    pe.DiscountLimit__c = true;
    pe.MaxDiscount__c = 80;
    insert pe;
    
     Product_Price_Entry__c pe1=new Product_Price_Entry__c();
    pe1.PriceList__c=pl.id;
    pe1.Product__c=m.id;
    pe1.DiscountLimit__c = true;
    pe1.MaxDiscount__c = 80;
    insert pe1;
    
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
          sobj.Product__c = m.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
    
          insert sobj;
          
         /*   Discount_Attributes__c sobj6 = new Discount_Attributes__c();
          sobj6.Product__c = m1.id;  
          sobj6.Max_Value__c = 20.00;               
          sobj6.Adjustment_Type__c = '% Discount';
    
          insert sobj6;*/
          
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
        a.ShippingCountry='India';//@yamini
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        a.Segment__c = 'Commercial';
        
        
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
        o.Stage__c='Identification';
        insert o;
        
        /*Address1__c addr= new Address1__c();  @yamini
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/  
        
        a.Lead_Account_Status__c='Active';
        Update a; 
    
            apttus_proposal_proposal__c klo=new apttus_proposal_proposal__c();
            klo.PriceList__c=pl.id;
            klo.Approval_Status__c = 'Required Approval';
            klo.Account__c=a.id;
        klo.Opportunity__c=o.id;
        klo.APTS_Quote_Type__c='PFC';
        klo.Order_Type__c='PFC';
        klo.Channel__c='PFC';
        klo.Primary_Contact__c=c.id;
        klo.Selling_Country__c='India';
        klo.BillContact__c=c.id;
        klo.PostingContact__c=c.id;
      
        klo.PriceList__c = pl.Id; 
       // klo.Billing_Address__c=addr.id;  @yamini
       // klo.Posting_Address__c= addr.id;

     
            insert klo;
                Klo.Manager1__c = UserInfo.getUserId();
             update klo;
              Proposal_Line_Item__c sobj1 = new Proposal_Line_Item__c();
            
              sobj1.Product__c = m.id;           // Product
              sobj1.Adjustment_Amount__c = 50.00;              
              sobj1.Adjustment_Type__c = '% Discount';          
              sobj1.Quantity__c = 1; 
              sobj1.Discount_Exception__c = false;
              //sobj1.Base_Price_Total_4_Roll_Up__c = 1000; 
              //sobj1.Base_Total__c=1000; 
              sobj1.Proposal_Locked__c = klo.id;    
              sobj1.Status__c = 'Pending';                      
            //  sobj1.Start_Date__c = system.today(); 
            //  sobj1.End_Date__c = system.today()+6;    
              sobj1.Price__c = 20000.0000;
            
            insert sobj1;
      System.debug('jjjjjjjjjjjjjjj'+sobj1.Price__c);
            System.debug('jjjjjjjjjjjjjjj'+sobj1.Quantity__c);
    System.debug('jjjjjjjjjjjjjjj'+sobj1.Base_Total__c);
    
            test.startTest();
            
            PageReference tpageRef = Page.q_discount;
              Test.setCurrentPage(tpageRef);
            
              ApexPages.currentPage().getParameters().put('Id', klo.Id);
            
              System.assertEquals( klo.id,ApexPages.currentPage().getParameters().get('Id'));
              q_discount j=new q_discount();
                j.getqstat();
                j.save();
    
    //Start date less than today
             j.wlist[0].ql.Start_Date__c=system.today() - 3;
                j.wlist[0].ql.End_Date__c=system.today() + 30;
                j.Addnew();
    
    //End date equal to start date
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today();
                j.Addnew();
    
     //End date & start date more than 12 Months
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450;    
                j.Addnew();
    
    j.wlist[0].ql.Start_Date__c=system.today();
    j.wlist[0].ql.End_Date__c=system.today() + 30;    
                j.Addnew();
    
              
                j.Recongif();
                 j.TCP= True;
                j.Recongif();
                j.numberOfRowToRemove=0;
                j.rem=sobj1.id;
                j.wlist[0].b=true;
    
             
     //Start date less than today
             j.wlist[0].ql.Start_Date__c=system.today() - 3;
                j.wlist[0].ql.End_Date__c=system.today() + 30;
                j.generate_for_other_month();
    
    //End date equal to start date
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today();
                j.generate_for_other_month();
    
     //End date & start date more than 12 Months
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450;    
                j.generate_for_other_month();
    
    j.wlist[0].ql.Start_Date__c=system.today();
    j.wlist[0].ql.End_Date__c=system.today() + 30;  
                
                j.generate_for_other_month();
    
     //Start date less than today
             j.wlist[0].ql.Start_Date__c=system.today() - 3;
                j.wlist[0].ql.End_Date__c=system.today() + 30;
                j.go();
    
    //End date equal to start date
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today();
                j.go();
    
     //End date & start date more than 12 Months
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450;    
                j.go();
    // end date not equal to contract duration
    j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450; 
    
    //econtract duration is 6 month
     j.wlist[0].ql.Contract_Duration1__c='6 Months';
     j.wlist[0].ql.Start_Date__c=system.today();
     j.wlist[0].ql.End_Date__c=system.today() + 450; 

    
    j.wlist[0].ql.Start_Date__c=system.today();
    j.wlist[0].ql.End_Date__c=system.today() + 30;
    j.wlist[0].ql.Price__c = 100;
    j.wlist[0].ql.Quantity__c = 1;
    j.wlist[0].ql.Adjustment_Type__c = '% Discount';
    j.wlist[0].ql.Adjustment_Amount__c = 35;
    

                j.go();
    
                j.check_approval();
              
                
                j.qq.Approval_Status__c= 'Required Approval';
                j.qq.Manager1__c = userinfo.getuserid();
    
                j.generate_for_other_month();
                
                System.debug('Status fo Approval ' +klo.Approval_Status__c+'ffff '+Klo.Base_Total__c );
                //j.submit();
                j.remove();
    system.debug('aaa--->'+ j.qq.Approval_Status__c);
    system.debug('bbb--->'+j.qq.Manager1__c);
      
    
    APTS_APAC_Payment__c aa = new APTS_APAC_Payment__c();
    aa.Proposal__c = j.qq.id;
    insert aa;
    
      system.debug('ccc--->'+j.qq.Total_Discount__c); 
    system.debug('ddd--->'+j.qq.Payment_count__c);  
                
    
    
    try{j.submit();}catch(exception e){
        
        system.debug('errorrrr'+e);
    }
    
     q_discount obj_qdiscount = new q_discount();
    obj_qdiscount.getqstat();
    obj_qdiscount.save();
    obj_qdiscount.generate_for_other_month();
    obj_qdiscount.go();
    obj_qdiscount.Addnew();
    obj_qdiscount.Addnew();
    
    
   test.stopTest();
}
    
    public static testmethod void mi2()
{
    list< Trigger__c> tt = new list< Trigger__c>();
    Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tt.add(t);
    
    Trigger__c t1 = new Trigger__c(name ='Contact',Active__c = true);
     tt.add(t1);
    Trigger__c t2 = new Trigger__c(name ='Opportunity',Active__c = true);
     tt.add(t2);
    Trigger__c t3 = new Trigger__c(name ='Quote',Active__c = true);
     tt.add(t3);
    
        insert tt;

ProductM__c m=new ProductM__c();
    m.name='classic resume search';
     m.Active__c=true;
    insert m;
    
    ProductM__c m1=new ProductM__c();
    m1.name='branding';
     m1.Active__c=true;
    insert m1;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
    pl.Active__c=True;
    insert pl;
    
    Product_Price_Entry__c pe=new Product_Price_Entry__c();
    pe.PriceList__c=pl.id;
    pe.Product__c=m1.id;
    pe.DiscountLimit__c = true;
    pe.MaxDiscount__c = 80;
    insert pe;
    
     Product_Price_Entry__c pe1=new Product_Price_Entry__c();
    pe1.PriceList__c=pl.id;
    pe1.Product__c=m.id;
    pe1.DiscountLimit__c = true;
    pe1.MaxDiscount__c = 80;
    insert pe1;
    
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
          sobj.Product__c = m.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
    
          insert sobj;
          
         /*   Discount_Attributes__c sobj6 = new Discount_Attributes__c();
          sobj6.Product__c = m1.id;  
          sobj6.Max_Value__c = 20.00;               
          sobj6.Adjustment_Type__c = '% Discount';
    
          insert sobj6;*/
          
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
        a.ShippingCountry='India';//@yamini
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        a.Segment__c = 'Commercial';
        
        
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
        o.Stage__c='Identification';
        insert o;
        
        /*Address1__c addr= new Address1__c();  @yamini
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/  
        
        a.Lead_Account_Status__c='Active';
        Update a; 
    
            apttus_proposal_proposal__c klo=new apttus_proposal_proposal__c();
            klo.PriceList__c=pl.id;
            klo.Approval_Status__c = 'Required Approval';
            klo.Account__c=a.id;
        klo.Opportunity__c=o.id;
        klo.APTS_Quote_Type__c='PFC';
        klo.Order_Type__c='PFC';
        klo.Channel__c='PFC';
        klo.Primary_Contact__c=c.id;
        klo.Selling_Country__c='India';
        klo.BillContact__c=c.id;
        klo.PostingContact__c=c.id;
      
        klo.PriceList__c = pl.Id; 
       // klo.Billing_Address__c=addr.id;  @yamini
       // klo.Posting_Address__c= addr.id;

     
            insert klo;
                Klo.Manager1__c = UserInfo.getUserId();
             update klo;
              Proposal_Line_Item__c sobj1 = new Proposal_Line_Item__c();
            
              sobj1.Product__c = m.id;           // Product
              sobj1.Adjustment_Amount__c = 50.00;              
              sobj1.Adjustment_Type__c = '% Discount';          
              sobj1.Quantity__c = 1; 
              sobj1.Discount_Exception__c = false;
              //sobj1.Base_Price_Total_4_Roll_Up__c = 1000; 
              //sobj1.Base_Total__c=1000; 
              sobj1.Proposal_Locked__c = klo.id;    
              sobj1.Status__c = 'Pending';                      
            //  sobj1.Start_Date__c = system.today(); 
            //  sobj1.End_Date__c = system.today()+6;    
              sobj1.Price__c = 20000.0000;
            
            insert sobj1;
      System.debug('jjjjjjjjjjjjjjj'+sobj1.Price__c);
            System.debug('jjjjjjjjjjjjjjj'+sobj1.Quantity__c);
    System.debug('jjjjjjjjjjjjjjj'+sobj1.Base_Total__c);
    
            test.startTest();
            
            PageReference tpageRef = Page.q_discount;
              Test.setCurrentPage(tpageRef);
            
              ApexPages.currentPage().getParameters().put('Id', klo.Id);
            
              System.assertEquals( klo.id,ApexPages.currentPage().getParameters().get('Id'));
              q_discount j=new q_discount();
                j.getqstat();
                j.save();
    
    //Start date less than today
             j.wlist[0].ql.Start_Date__c=system.today() - 3;
                j.wlist[0].ql.End_Date__c=system.today() + 30;
                j.Addnew();
    
    //End date equal to start date
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today();
                j.Addnew();
    
     //End date & start date more than 12 Months
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450;    
                j.Addnew();
    
    j.wlist[0].ql.Start_Date__c=system.today();
    j.wlist[0].ql.End_Date__c=system.today() + 30;    
                j.Addnew();
    
              
                j.Recongif();
                 j.TCP= True;
                j.Recongif();
                j.numberOfRowToRemove=0;
                j.rem=sobj1.id;
                j.wlist[0].b=true;
    
             
     //Start date less than today
             j.wlist[0].ql.Start_Date__c=system.today() - 3;
                j.wlist[0].ql.End_Date__c=system.today() + 30;
                j.generate_for_other_month();
    
    //End date equal to start date
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today();
                j.generate_for_other_month();
    
     //End date & start date more than 12 Months
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450;    
                j.generate_for_other_month();
    
    j.wlist[0].ql.Start_Date__c=system.today();
    j.wlist[0].ql.End_Date__c=system.today() + 30;  
                
                j.generate_for_other_month();
    
     //Start date less than today
             j.wlist[0].ql.Start_Date__c=system.today() - 3;
                j.wlist[0].ql.End_Date__c=system.today() + 30;
                j.go();
    
    //End date equal to start date
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today();
                j.go();
    
     //End date & start date more than 12 Months
             j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450;    
                j.go();
    // end date not equal to contract duration
    j.wlist[0].ql.Start_Date__c=system.today();
                j.wlist[0].ql.End_Date__c=system.today() + 450; 
    
    //econtract duration is 3 month
     j.wlist[0].ql.Contract_Duration1__c='3 Months';
     j.wlist[0].ql.Start_Date__c=system.today();
     j.wlist[0].ql.End_Date__c=system.today() + 450; 
    
    //econtract duration is 1 month
     j.wlist[0].ql.Contract_Duration1__c='1 Months';
     j.wlist[0].ql.Start_Date__c=system.today();
     j.wlist[0].ql.End_Date__c=system.today() + 450; 

    
    j.wlist[0].ql.Start_Date__c=system.today();
    j.wlist[0].ql.End_Date__c=system.today() + 30;
    j.wlist[0].ql.Price__c = 100;
    j.wlist[0].ql.Quantity__c = 1;
    j.wlist[0].ql.Adjustment_Type__c = '% Discount';
    j.wlist[0].ql.Adjustment_Amount__c = 35;
    

                j.go();
    
                j.check_approval();
              
                
                j.qq.Approval_Status__c= 'Required Approval';
                j.qq.Manager1__c = userinfo.getuserid();
    
                j.generate_for_other_month();
                
                System.debug('Status fo Approval ' +klo.Approval_Status__c+'ffff '+Klo.Base_Total__c );
                //j.submit();
                j.remove();
    system.debug('aaa--->'+ j.qq.Approval_Status__c);
    system.debug('bbb--->'+j.qq.Manager1__c);
      
    
    APTS_APAC_Payment__c aa = new APTS_APAC_Payment__c();
    aa.Proposal__c = j.qq.id;
    insert aa;
    
      system.debug('ccc--->'+j.qq.Total_Discount__c); 
    system.debug('ddd--->'+j.qq.Payment_count__c);  
                
    
    
    try{j.submit();}catch(exception e){
        
        system.debug('errorrrr'+e);
    }
    
     q_discount obj_qdiscount = new q_discount();
    obj_qdiscount.getqstat();
    obj_qdiscount.save();
    obj_qdiscount.generate_for_other_month();
    obj_qdiscount.go();
    obj_qdiscount.Addnew();
    obj_qdiscount.Addnew();
    
    
   test.stopTest();
}
}