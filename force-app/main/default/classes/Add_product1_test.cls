@istest
public class Add_product1_test
{
    public static testmethod void mytest()
    {
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
       
        Account a = new Account();
       /* a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'Fieldsales';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Call Inbound';
        a.APAC_Industry__c='Agriculture';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';*/
        //a.Lead_Account_Status__c='Inactive';//
        //a.CreditStatus__c='OK';//
       
        //@imRam added accoring to account validation
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
         a.BillCountry__c='India' ; //To change Address from Object to Standard Address in Account
        a.BillState__c='Karnataka';
        a.PostCountry__c ='India' ;
        a.PostState__c='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingStreet='street1';
        a.BillingPostalCode='560076';  
        a.ShippingCity='bangalore' ;
        a.ShippingPostalCode ='560076'; 
        a.ShippingStreet= 'shippingstreet';  
        
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
       // qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
        insert qp;
          test.startTest();  
        ApexPages.StandardController sc = new ApexPages.StandardController(qp);
        PageReference pageRef = Page.Add_product1;
        pageRef.getParameters().put('qid', String.valueOf(qp.Id));
        pageRef.getParameters().put('pbid', String.valueOf(pl.Id));
        Test.setCurrentPage(pageRef);
   
    Add_product1 k=new Add_product1();
    k.abc();
    k.configure();
    k.ww[1].b=true;
        k.toselect=m1.Id;
     
   k.configure();
         k.ww[1].b=false;
    k.ww[0].b=true;
        k.configure();
   k.ww[1].b=true;        
    k.configure();
        
      k.toselect=m1.Id;
        k.Configure_Product_Attribute();
         system.debug('law'+k.law);
         k.chk();
        k.law[0].socv = '1';
       k.configchange();
       system.debug('law2'+k.law);
      
         k.configchange();
         system.debug('law3'+k.law);
       
         k.quantity=1; 

         k.Get_Price();
        
       k.Get_Price_TCP();
        
        //@imRam added this value as line 449 amount1 is null;
         k.amount1 = 10;
        k.Get_Price_TCP();
        
         pm.Product_Config_Code__c='1-1-1';
        update pm;
          k.Get_Price();
          pm.Product_Price_Entry__c=null;
        update pm;
       k.Get_Price_TCP();
        k.Add_to_cart();
        k.canceling();
        k.to_quote();
          pav1.set__c='A=1;S2;Final';
         pav1.Product_PriceList__c=pl.id;
    update pav1;
         k.configchange();
           pav1.set__c='A=1;S3;Final';
       
            update pav1;
          k.configchange();
           pav1.set__c='A=1;C2;Final';
        
            update pav1;
         k.configchange();
           pav1.set__c='A=1;C1;Final';
        
    update pav1;
         k.configchange();
      
          pav1.Product_PriceList__c=null;
        update pav1;
          k.configchange();
       k.h.id=null;
        k.congif='A=1;S1;Contract Duration=1 Month;Final';
        k.Add_to_cart();
          k.h.id=null;
        k.congif='A=1;S1;Contract Duration=3 Months;Final';
        k.Add_to_cart();
          k.h.id=null;
        k.congif='A=1;S1;Contract Duration=6 Months;Final';
        k.Add_to_cart();
          k.h.id=null;
        k.congif='A=1;S1;Contract Duration=12 Months;Final';
        k.Add_to_cart();
        
         test.stopTest();
    }
    


}