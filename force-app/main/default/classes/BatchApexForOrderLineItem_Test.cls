@istest
public class BatchApexForOrderLineItem_Test {
 @Istest Static void testrj(){
     
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
        
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
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
        insert od;
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=od.id;
        ol.Quantity__c=1;
        insert ol;
        
        
        
        //qp.PriceList__c=pl.id;
        //update qp;
         BatchApexForOrderLineItem jj=new BatchApexForOrderLineItem ();
               ID batchprocessid1 = Database.executeBatch(jj);  
 }
}