@isTest
public class BatchApexToChangeOwner_Test {
    static testMethod void testManualShareRead(){
    List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
    Id User1Id = users[0].Id;
    Id User2Id = users[1].Id;
    Id User3Id = users[2].Id;
        
       list<trigger__C> tt = new list<trigger__C>(); 
    trigger__C t = new trigger__C(name='Account',active__C = true);
        tt.add(t);
        trigger__C t1 = new trigger__C(name='EmailMessage',active__C = true);
          tt.add(t1);
        
        trigger__C t2 = new trigger__C(name='Opportunity',active__C = true);
          tt.add(t2);
        
        trigger__C t3 = new trigger__C(name='Quote',active__C = true);
          tt.add(t3);
        
         trigger__C t4 = new trigger__C(name='Order',active__C = true);
          tt.add(t4);
        
        insert tt;
        
        
        list<account> acc = new list<account>();
       
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
        a.OwnerId = User1Id;
        a.Segment__c = 'Commercial';
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        
        a.Lead_Source1__c= 'Call Inbound';
            acc.add(a);
            
        
        insert acc;
        list<contact> con = new list<contact>();
       
             Contact c = new Contact();
        c.AccountID = acc[0].Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='+919898989898';
            con.add(c);

        insert con;
        
       /* List<Address1__c> adr= new list<Address1__c>();
      
         Address1__c addr= new Address1__c();
        addr.Account__c=acc[0].id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        adr.add(addr);
       
        insert adr;*/
        
        list<Opportunity__c> opp = new list<Opportunity__c>();
      
        Opportunity__c o = new Opportunity__c();
        o.Account__c=acc[0].id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
            opp.add(o);
        Opportunity__c o1 = new Opportunity__c();
        o1.Account__c=acc[0].id;
        o1.Close_Date__c=System.today();
        o1.OpportunityType__c='Trial';
        o1.Stage__c='Identification';
            opp.add(o1);
       
        insert opp;
        
        for(account a1:acc){
             a1.Lead_Account_Status__c='Active';
        }
         Update acc;
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
        pl.Active__c = true;
    insert pl;
        
         Product_PriceList__c pl1=new Product_PriceList__c();
    pl1.name='USD';
    insert pl1;
        
        List<apttus_proposal_proposal__c> qpp = new list<apttus_proposal_proposal__c>();
        
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=acc[0].id;
        qp.Opportunity__c=opp[0].id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
        qp.Primary_Contact__c=con[0].id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=con[0].id;
        qp.PostingContact__c=con[0].id;
        
        qp.PriceList__c = pl.Id; 
        /*qp.Billing_Address__c=adr[0].id;
        qp.Posting_Address__c= adr[0].id;*/
            qpp.add(qp);
      
        apttus_proposal_proposal__c qp1 = new apttus_proposal_proposal__c();
        qp1.Account__c=acc[0].id;
        qp1.Opportunity__c=opp[0].id;
        qp1.APTS_Quote_Type__c='PFC';
        qp1.Order_Type__c='PFC';
        qp1.Channel__c='PFC';
        qp1.Primary_Contact__c=con[0].id;
        qp1.Selling_Country__c='India';
        qp1.BillContact__c=con[0].id;
        qp1.PostingContact__c=con[0].id;
        
        qp1.PriceList__c = pl.Id; 
        /*qp1.Billing_Address__c=adr[0].id;
        qp1.Posting_Address__c= adr[0].id;*/
            qpp.add(qp1);
        insert qpp;
        
         list<Proposal_Line_Item__c>    pt= new list<Proposal_Line_Item__c>();
        
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qpp[0].id;
        pit.Quantity__c=1;
        pit.Price__c=120;
            pt.add(pit);
        Proposal_Line_Item__c   pit1= new Proposal_Line_Item__c ();
        pit1.Proposal_Locked__c=qpp[1].id;
        pit1.Quantity__c=1;
        pit1.Price__c=120;
            pt.add(pit1);
       
        insert pt;
        
        list<APTS_APAC_Payment__c> apac= new list<APTS_APAC_Payment__c>();
        
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qpp[0].id;
        ap.Payment_Amount__c=120;
        ap.TDS_Amount_c__c=0;
        ap.Due_Date__c=system.today()+3;
         apac.add(ap);
        APTS_APAC_Payment__c ap1= new APTS_APAC_Payment__c();
        ap1.Proposal__c=qpp[1].id;
        ap1.Payment_Amount__c=120;
        ap1.TDS_Amount_c__c=0;
        ap1.Due_Date__c=system.today()+3;
         apac.add(ap1);
        
        insert apac;
        
        list<orderC__c> ord= new list<orderC__c>();
       
        orderC__c od = new OrderC__c();
        od.QuoteProposal__c=qpp[0].id;
        od.Account__c = acc[0].id;     
             ord.add(od);
        orderC__c od1 = new OrderC__c();
        od1.QuoteProposal__c=qpp[1].id;
        od1.Account__c = acc[0].id;     
             ord.add(od1);
        insert ord;
        
         list<Order_Line_Item__c> ordl= new list<Order_Line_Item__c>();
        
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=ord[0].id;
        ol.Quantity__c=1;
             ordl.add(ol);
        Order_Line_Item__c  ol1= new Order_Line_Item__c();
        ol1.Order__c=ord[1].id;
        ol1.Quantity__c=1;
             ordl.add(ol1);
       
        insert ordl;
       System.debug('userxx2 '+User2Id);
        for(account aa:acc){
             aa.ownerid =User2Id;
        }
            Update acc;
        
        BatchApexToChangeOwner b = new BatchApexToChangeOwner();
        b.last_record = acc[0].Accountid__c;
        database.executeBatch(b,200);
        System.debug('userxx3 '+User3Id);
        for(account aa:acc){
             aa.ownerid =User3Id;
        }
            Update acc;
        
        BatchApexToChangeOwner b1 = new BatchApexToChangeOwner();
        b1.last_record = acc[0].Accountid__c;
        database.executeBatch(b1,200);
    }
}