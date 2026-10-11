@isTest
public class UpdatePriceListISOtoLineItem_Test {

    
    public static testmethod void met(){
        
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
        
        List<Account> aa = new List<Account>();
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
        
        a.Lead_Source1__c= 'Call Inbound';
        
        aa.add(a);
        insert aa;
        
         List<Contact> cc = new List<Contact>();
        Contact c = new Contact();
        c.AccountID= aa[0].Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        cc.add(c);
        insert cc;
        
        List<Opportunity__c> oo = new List<Opportunity__c>();
        Opportunity__c o = new Opportunity__c();
        o.Account__c=aa[0].id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
       // o.Stage__c='Rejected';
        oo.add(o);
        insert oo;
        
       /* List<Address1__c> addr1= new List<Address1__c>();
        Address1__c addr= new Address1__c();
        addr.Account__c=aa[0].id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        addr1.add(addr);
        insert addr1;*/
        
        aa[0].Lead_Account_Status__c='Active';
        Update aa;
        
        
        List<ProductM__c> mm1=new list<ProductM__c>();
       ProductM__c m1=new ProductM__c();
    m1.name='Premium Resume Search';
     m1.Active__c=true;
        m1.Price_List1__c = 'INR';
         mm1.add(m1);
    insert mm1;
    
         List<Product_Attribute__c> paa=new List<Product_Attribute__c>();
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=mm1[0].id;
    pa.Attributes__c='A;B;C;';
        paa.add(pa);
    insert paa;
    
        
    List<Product_PriceList__c> pp = new List<Product_PriceList__c>();
    Product_PriceList__c pl = new Product_PriceList__c();
    pl.name = 'INR';
      pl.Active__c=true;
    pp.add(pl);
    insert pp;
        
          list<Product_Price_Entry__c> ppe2 = new list<Product_Price_Entry__c>();
          Product_Price_Entry__c ppe = new Product_Price_Entry__c();
        ppe.PriceList__c = pp[0].id;
        ppe.Product__c = mm1[0].id;
        ppe.DiscountLimit__c = true;
        ppe.MaxDiscount__c = 2;
        ppe2.add(ppe);
        insert ppe2;
      
        
        
 List<apttus_proposal_proposal__c> qp1 = new List<apttus_proposal_proposal__c>();
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
        /*qp.Billing_Address__c=addr.id;
        qp.Posting_Address__c= addr.id;*/
        
        qp1.add(qp);
        insert qp1;
        
        List<Proposal_Line_Item__c> pq = new List<Proposal_Line_Item__c>();
    Proposal_Line_Item__c p = new Proposal_Line_Item__c ();
        
        p.Proposal_Locked__c = qp1[0].id;
        p.Product__c = mm1[0].id;
        p.Start_Date__c = system.today();
        p.End_Date__c = system.today() + 10;
        p.Adjustment_Type__c = '% Discount';
        p.Quantity__c = 1;
        p.Adjustment_Amount__c = 10;
        p.Price__c = 8156.00;
        p.APTS_Attribute_Display__c = 'Country=India;License Type=Master;Database=N/A;Family=N/A;Search Geo=Regional;Location=N/A;View Count=N/A;Duration=12 Months;Final;:State/City=null';
       pq.add(p);
        
        
        Proposal_Line_Item__c   pit1= new Proposal_Line_Item__c  ();
        pit1.Proposal_Locked__c=qp.id;
        pit1.Quantity__c=1;
        pit1.Product__c=m1.id;
        pit1.Price__c=100;
        pit1.Adjustment_Type__c='Price Override';
        pit1.Adjustment_Amount__c=56;
        pit1.Start_Date__c = system.today();
        pit1.End_Date__c = system.today()+36;
        pit1.APTS_Attribute_Display__c = 'Country=India;License Type=Master;Database=N/A;Family=N/A;Search Geo=Regional;Location=N/A;View Count=N/A;Duration=12 Months;Final;:State/City=null';
        pq.add(pit1);
        
        Proposal_Line_Item__c   pit12= new Proposal_Line_Item__c  ();
        pit12.Proposal_Locked__c=qp.id;
        pit12.Quantity__c=1;
        pit12.Product__c=m1.id;
        pit12.Price__c=100;
        pit12.Adjustment_Type__c='Price Override';
        pit12.Adjustment_Amount__c=56;
        pit12.Start_Date__c = system.today();
        pit12.APTS_Attribute_Display__c = 'Country=India;License Type=Master;Database=N/A;Family=N/A;Search Geo=Regional;Location=N/A;View Count=N/A;Duration=12 Months;Final;:State/City=null';
        pit12.End_Date__c = system.today()+36;
       
        pq.add(pit12);
        
         Proposal_Line_Item__c   pit123= new Proposal_Line_Item__c  ();
        pit123.Proposal_Locked__c=qp.id;
        pit123.Quantity__c=1;
        pit123.Product__c=m1.id;
        pit123.Price__c=100;
        pit123.Adjustment_Type__c='Base Price Override';
        pit123.Adjustment_Amount__c=56;
        pit123.Start_Date__c = system.today();
        pit123.APTS_Attribute_Display__c = 'Country=India;License Type=Master;Database=N/A;Family=N/A;Search Geo=Regional;Location=N/A;View Count=N/A;Duration=12 Months;Final;:State/City=null';
        pit123.End_Date__c = system.today()+36;
        pq.add(pit123);
        
         Proposal_Line_Item__c   pit1234= new Proposal_Line_Item__c  ();
        pit1234.Proposal_Locked__c=qp.id;
        pit1234.Quantity__c=1;
        pit1234.Product__c=m1.id;
        pit1234.Price__c=100;
        pit1234.Adjustment_Type__c='Discount Amount';
        pit1234.Adjustment_Amount__c=56;
        pit1234.Start_Date__c = system.today();
        pit1234.APTS_Attribute_Display__c = 'Country=India;License Type=Master;Database=N/A;Family=N/A;Search Geo=Regional;Location=N/A;View Count=N/A;Duration=12 Months;Final;:State/City=null';
        pit1234.End_Date__c = system.today()+36;
        pq.add(pit1234);
         
        try{insert pq; }catch(exception e){}
        
    
    }
}