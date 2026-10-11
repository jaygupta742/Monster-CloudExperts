@isTest
public class ApacPaymentISOvalue_Test {
   
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
        
        /*List<Address1__c> addr1= new List<Address1__c>();
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
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
        
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
        
        insert pq;
         
         
         List<APTS_APAC_Payment__c> AAP = new List<APTS_APAC_Payment__c>();
         APTS_APAC_Payment__c app = new APTS_APAC_Payment__c();
         app.Due_Date__c = system.today()+7;
         app.Proposal__c = qp1[0].id;
         app.TDS_Amount_c__c = 0;
         app.Payment_Amount__c = 7340.40;
         
         aap.add(app);
         
         insert aap;
    
    }
    
    

}