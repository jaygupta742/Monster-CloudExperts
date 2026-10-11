@isTest
public class Tax_Gen_Test {
	@isTest
    static void Tax_Gen_Test(){
        List<Trigger__c> css= new List<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        css.add(t);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        css.add(tk);
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        css.add(t1);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        css.add(t1k);    
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        css.add(t2k);        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        css.add(t2);
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        css.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        css.add(t4);        
        Trigger__c t7= new Trigger__c(name ='CVR',Active__c = true);
        css.add(t7);
        insert css;
        
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
        
        /*Product_PriceList__c pl1=new Product_PriceList__c();
        pl1.name='INR';
        pl1.Active__c=true; 
        insert pl1;*/
        
        Product_Price_Entry__c ppe = new Product_Price_Entry__c();
        ppe.PriceList__c = pl.id;
        ppe.Product__c = m1.id;
        ppe.DiscountLimit__c = true;
        ppe.MaxDiscount__c = 50;
        insert ppe;
        
        /*Product_Price_Entry__c ppe1 = new Product_Price_Entry__c();
        ppe1.PriceList__c = pl1.id;
        ppe1.Product__c = m1.id;
        insert ppe1;*/
        
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=a.id;
        qp.Opportunity__c=o.id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
        qp.Primary_Contact__c=c.id;
        qp.Selling_Country__c='India';
        qp.Posting_Address__c = 'Account Posting Address';
        qp.Billing_Address__c = 'Account Billing Address';
        qp.BillContact__c=c.id;
        qp.PostingContact__c=c.id;
        qp.PriceList__c = pl.Id; 
        qp.Manager5__c='0057F000003Sa5gQAC';
        insert qp;
        
       
        Tax_Refference__c ts = new Tax_Refference__c();
        ts.Name = 'India';
        ts.Selling_Country__c = 'India';
        ts.Client_Location__c = 'India';
        ts.TAx_Name__c = 'aaa';
        ts.Tax_Rate__c= 20;
        Insert ts;
        
        System.debug('Quote posting country ->'+qp.Posting_Country__c);
        System.debug('Account shipping country -->'+a.ShippingCountry);
        
        System.debug('Quote selling country ->'+qp.Selling_Country__c);
        System.debug('Account posting country -->'+a.BillingCountry);
        
        System.debug('Account entity use code ->'+qp.Account_Entity_Use_Code__c);
        System.debug('Order type -->'+qp.Order_Type__c);
        System.debug('Tax reference -->'+ts);
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qp.id;
        pit.Quantity__c=1;
        pit.Product__c=m1.id;
        pit.Price__c=100;
        pit.Adjustment_Type__c='% Discount';
        pit.Adjustment_Amount__c=46;
        pit.Start_Date__c = system.today();
        pit.End_Date__c = system.today()+36;
        insert pit;       
        
        Proposal_Line_Item__c   pit1= new Proposal_Line_Item__c  ();
        pit1.Proposal_Locked__c=qp.id;
        pit1.Quantity__c=1;
        pit1.Product__c=m1.id;
        pit1.Price__c=100;
        //pit1.Discount_Exception__c = true;
        pit1.Adjustment_Type__c='% Discount';
        
        pit1.Adjustment_Amount__c=86;
        pit1.Start_Date__c = system.today();
        pit1.End_Date__c = system.today()+36;
        try{
           insert pit1; 
        }
        catch(Exception e){
          System.debug(e.getMessage());  
        }
        
        Proposal_Line_Item__c   pit2= new Proposal_Line_Item__c  ();
        pit2.Proposal_Locked__c=qp.id;
        pit2.Quantity__c=1;
        pit2.Product__c=m1.id;
        pit2.Price__c=100;
        pit2.Adjustment_Type__c='% Discount';
        pit2.Adjustment_Amount__c=16;
        pit2.Start_Date__c = system.today();
        pit2.End_Date__c = system.today()+36;
        insert pit2;
        
        apttus_proposal_proposal__c qp1 = new apttus_proposal_proposal__c();
        qp1.Account__c=a.id;
        qp1.Opportunity__c=o.id;
        qp1.APTS_Quote_Type__c='PFC';
        qp1.Order_Type__c='PFC';
        qp1.Channel__c='PFC';
        qp1.Primary_Contact__c=c.id;
        qp1.Selling_Country__c='India';
        qp1.Posting_Address__c = 'Account Posting Address';
        qp1.Billing_Address__c = 'Account Billing Address';
        qp1.BillContact__c=c.id;
        qp1.PostingContact__c=c.id;
        qp1.PriceList__c = pl.Id;
        qp1.Manager5__c='0057F000003Sa5gQAC';        
        insert qp1;
        
        Proposal_Line_Item__c   pit21= new Proposal_Line_Item__c  ();
        pit21.Proposal_Locked__c=qp1.id;
        pit21.Quantity__c=1;
        pit21.Product__c=m1.id;
        pit21.Price__c=100;
        pit21.Adjustment_Type__c='% Discount';
        pit21.Adjustment_Amount__c=46;
        pit21.Start_Date__c = system.today();
        pit21.End_Date__c = system.today()+36;
        insert pit21;
        
       /*PTS_APAC_Payment__c ap1= new APTS_APAC_Payment__c();
        ap1.Proposal__c=qp1.id;
        ap1.Payment_Amount__c=46;
        ap1.TDS_Amount_c__c=0;
        ap1.Due_Date__c=system.today()+3;                 
        insert ap1;*/
        
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=46;
        ap.TDS_Amount_c__c=0;
        ap.Due_Date__c=system.today()+3;                 
        insert ap;
        
        qp1.OwnerId='0050o00000YA1uZ';
        update qp1;
        
        id rt= schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('after finalize').getRecordTypeId();
        qp.RecordTypeId=rt;
        qp.PriceList__c=pl.id;
        qp.Update_Manager1__c = true;
        qp.Update_Manager2__c = true;
        qp.Update_Manager3__c = true;
        qp.Update_Manager4__c = true;
        qp.Update_Manager5__c = true;
        qp.Update_Manager6__c = true;        
        update qp;
        
        qp.SentBack__c=true;
        qp.Sent_Back_Reason__c='Contract documentation';
        update qp;
        
        Test.startTest();
        pit.Adjustment_Amount__c=36;
        update pit;
        
       
        //qp.OwnerId='0050o00000YsuwAAAR';
        //update qp;
        qp.OwnerId='0050o00000XsFo6';
        update qp;
        
        //qp.Owner.manager1__c='0050o00000YsuwAAAR';
        //update qp;
       /* qp.OwnerId='0057F000003Sc5O';
        update qp;
        
        qp.OwnerId='0057F000003SQ30';
        update qp;
        qp.OwnerId='0057F000003Sc5S';
        update qp;
        
        qp.OwnerId='0057F000003SQ2r';
        update qp;
        qp.Manager4__c='0057F000003Sa5gQAC';
        update qp;
        
        qp.Manager5__c='0057F000003Sa5gQAC';
        update qp;*/
        
        orderC__c od = new OrderC__c();
        od.Account__c = a.id;
        od.QuoteProposal__c=qp.id;
        od.LatestProdEndDt__c = System.today()+30;
        insert od;
        
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=od.id;
        ol.End_Date__c = System.today()+30;
        ol.Quantity__c=1;
        insert ol;
        
        /*Case__c cs= new Case__c();
        cs.Category__c='Seeker';
        cs.Issue__c='None';
        cs.Proposal_ID__c=qp.id;
        insert cs;*/
        Test.stopTest();
    }
}