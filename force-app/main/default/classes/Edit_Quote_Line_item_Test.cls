@istest
public class Edit_Quote_Line_item_Test {

    @istest Static void Edit_Quote_Line_item_Test() {
       
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
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
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
        a.ShippingCountry='India';//@yamini
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
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
        //qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
        /*qp.Billing_Address__c=addr.id;
        qp.Posting_Address__c= addr.id;*/
        
        insert qp;
        
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
      //  pli.Adjustment_Type__c = 'Base Price Override';
        pli.Adjustment_Type__c =  '% Discount';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 10;
        
        pli.Price__c = 400;
        
        insert pli;
        
        Pagereference pageref= page.Edit_Quote_Line_item;
        pageref.getParameters().put('id', qp.id);
        Test.setCurrentPage(pageRef); 
        
        Edit_Quote_Line_item eq= new Edit_Quote_Line_item();
        
        for(Proposal_Line_Item__c pp : eq.ql)
        {
            
            //Start date less than today
             pp.Start_Date__c=system.today() - 3;
             pp.End_Date__c=system.today() + 30;
        }
        eq.save();
     for(Proposal_Line_Item__c pp : eq.ql)
     {
    //End date equal to start date
             pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today();
           }
      eq.save();
     for(Proposal_Line_Item__c pp : eq.ql){     
    
     //End date & start date more than 12 Months
            pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today() + 450;    
       }
      eq.save();
        
        for(Proposal_Line_Item__c pp : eq.ql){     
    
     //for contract duration 6 months 
            pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today() + 450;
            pp.Contract_Duration1__c = '6 Months';
       }
      eq.save();
        
        
        
     for(Proposal_Line_Item__c pp : eq.ql){          
    
   pp.Start_Date__c=system.today();
   pp.End_Date__c=system.today() + 30;
    pp.Price__c = 100;
    pp.Quantity__c = 1;
                
            
        }
        eq.save();
        eq.check_approval();
        eq.Recongif();
        eq.rem=pli.id;
      eq.remove();
        

}
     @istest Static void Edit_Quote_Line_item_Test1() {
       
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
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
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
        a.ShippingCountry='India';//@yamini
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
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
        //qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
        /*qp.Billing_Address__c=addr.id;
        qp.Posting_Address__c= addr.id;*/
        
        insert qp;
        
        
        Proposal_Line_Item__c pli = new Proposal_Line_Item__c();
        pli.Product__c = m1.id;
        pli.Proposal_Locked__c=qp.id;
      //  pli.Adjustment_Type__c = 'Base Price Override';
        pli.Adjustment_Type__c =  '% Discount';
        pli.Quantity__c = 20;
        pli.Adjustment_Amount__c = 10;
        
        pli.Price__c = 400;
        
        insert pli;
        
        Pagereference pageref= page.Edit_Quote_Line_item;
        pageref.getParameters().put('id', qp.id);
        Test.setCurrentPage(pageRef); 
        
        Edit_Quote_Line_item eq= new Edit_Quote_Line_item();
        
        for(Proposal_Line_Item__c pp : eq.ql)
        {
            
            //Start date less than today
             pp.Start_Date__c=system.today() - 3;
             pp.End_Date__c=system.today() + 30;
        }
        eq.save();
     for(Proposal_Line_Item__c pp : eq.ql)
     {
    //End date equal to start date
             pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today();
           }
      eq.save();
     for(Proposal_Line_Item__c pp : eq.ql){     
    
     //End date & start date more than 12 Months
            pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today() + 450;    
       }
      eq.save();
        
        
         for(Proposal_Line_Item__c pp : eq.ql){     
    
     //for contract duration 3 months 
            pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today() + 450;
            pp.Contract_Duration1__c = '3 Months';
       }
      eq.save();
         
         
         for(Proposal_Line_Item__c pp : eq.ql){     
    
     //for contract duration 1 months 
            pp.Start_Date__c=system.today();
                pp.End_Date__c=system.today() + 450;
            pp.Contract_Duration1__c = '1 Months';
       }
      eq.save();
        
        
        
     for(Proposal_Line_Item__c pp : eq.ql){          
    
   pp.Start_Date__c=system.today();
   pp.End_Date__c=system.today() + 30;
    pp.Price__c = 100;
    pp.Quantity__c = 1;
                
            
        }
        eq.save();
        eq.check_approval();
        eq.Recongif();
        eq.rem=pli.id;
      eq.remove();
        

}
    
}