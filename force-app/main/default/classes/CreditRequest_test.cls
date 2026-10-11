@istest
public class CreditRequest_test {   
    public static testmethod void mytestmethod(){        
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
        Trigger__c t3 = new trigger__c(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        insert cs;        
        
    	Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'Enterprise Business';
        a.Segment__c='ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
        a.Lead_Account_Status__c='Active';
        Update a;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        insert o;
        
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
        pl.Conversion_Rate__c = 200000;
    	pl.name='INR';
        
     	pl.Active__c=true;
    	insert pl;
        
        Product_Price_Entry__c ppe = new Product_Price_Entry__c();
        ppe.PriceList__c = pl.id;
        ppe.Product__c = m1.id;
        ppe.DiscountLimit__c = true;
        ppe.MaxDiscount__c = 80;
        insert ppe;
        
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
        insert qp;
        
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qp.id;
        pit.Quantity__c=1;
        pit.Price__c=120000;
        insert pit;
        
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=120000;
        ap.TDS_Amount_c__c=0;
        ap.Due_Date__c=system.today()+3;        
        insert ap;
        
        test.starttest();
        list <OrderC__c> listord = new list<OrderC__c>();
        OrderC__c ord = new OrderC__c();
        ord.QuoteProposal__c=qp.id;
        ord.Account__c = a.id;
        ord.PrimarySalesRep__c=userInfo.getUserId();
        ord.Contract_End_Date__c=system.today()+2;
        Ord.Payment_Amount__c=120000;
        ord.TDS_Amount__c=0; 
        ord.Total_Bad_Debt_Value__c =118000;
        listord.add(ord);      
        insert listord;
        
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=ord.id;
        ol.Price__c = 230000;
        ol.Quantity__c=1;
        insert ol;
        
        PageReference pageRef = Page.createcreditrequest;  
   		Test.setCurrentPage(pageRef); 
        ApexPages.currentPage().getParameters().put('id',listord[0].id );
       
        CreditRequest cc = new CreditRequest();     
        cc.Cancel();
        cc.onCancel();
        try{
        	cc.save();
        }
        catch(Exception e){
        }
           
        test.stopTest();
    }
}