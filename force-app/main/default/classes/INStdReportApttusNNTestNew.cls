@isTest
public class INStdReportApttusNNTestNew {
    
    @isTest Static void Tax_Generation_Test()
    {
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
        Case_Escalation__c jj= new Case_Escalation__c();
        jj.name='1stescalation';
        jj.UID__c='0057F000003Sa4a';
        jj.Email__c='monsterescalation@gmail.com';
        insert jj;
        
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
        
         Product_PriceList__c pl1=new Product_PriceList__c();
    pl1.name='INR';
    pl1.Active__c=true; 
    insert pl1;
        
        Product_Price_Entry__c ppe = new Product_Price_Entry__c();
        ppe.PriceList__c = pl.id;
        ppe.Product__c = m1.id;
        ppe.DiscountLimit__c = true;
        ppe.MaxDiscount__c = 80;
        insert ppe;
        
         Product_Price_Entry__c ppe1 = new Product_Price_Entry__c();
        ppe1.PriceList__c = pl1.id;
        ppe1.Product__c = m1.id;
        insert ppe1;
        
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
     
        qp.OwnerId='0057F000003SQ2r';
        
        
        update qp;
        
        Tax_Refference__c ts = new Tax_Refference__c();
        ts.Name = 'India';
        ts.Selling_Country__c = 'India';
        ts.Client_Location__c = 'India';
        ts.TAx_Name__c = 'aaa';
        ts.Tax_Rate__c= 20;
        Insert ts; 
        
      
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qp.id;
        pit.Quantity__c=1;
        pit.Product__c=m1.id;
        pit.Price__c=100;
        pit.Adjustment_Type__c='% Discount';
        pit.Adjustment_Amount__c=56;
        pit.Start_Date__c = system.today();
        pit.End_Date__c = system.today()+36;
        insert pit;
      
        
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=46;
        ap.TDS_Amount_c__c=0;
        ap.Due_Date__c=system.today()+3;
        
         
        insert ap;
        
       
     /*  qp.OwnerId='0057F000003SQ2r';
        update qp;
        qp.OwnerId='0057F000003Sc5O';
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
        
         test.startTest();
         pit.Adjustment_Amount__c=76;
        update pit;
        qp.OwnerId='0057F000003Sc5O';
        update qp;
         qp.OwnerId='0057F000003Sc5M';
        update qp;
        qp.OwnerId='0057F000003SQ7P';
        update qp;
         
        //qp.Manager3__c='0057F000003Sa5g';
        
         qp.OwnerId='0057F000003Sa5g';
        update qp;
        qp.OwnerId='0057F000003Sc5R';
        update qp;
        qp.OwnerId='0057F000003Sa5g';
        update qp;
        
        orderC__c od = new OrderC__c();
        od.QuoteProposal__c=qp.id;
        insert od;
        
        Order_Line_Item__c  ol= new Order_Line_Item__c();
        ol.Order__c=od.id;
        ol.Quantity__c=1;
     //   insert ol;
        Case__c cs= new Case__c();
        cs.Category__c='None';
        cs.Issue__c='None';
        cs.Proposal_ID__c=qp.id;
        insert cs;
      
        id rt= schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('after finalize').getRecordTypeId();
        qp.RecordTypeId=rt;
        qp.PriceList__c=pl1.id;
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
         PageReference pageRef = Page.INStdReportApttusNN;
        pageRef.getParameters().put('id',qp.id);
        Test.setCurrentPage(pageRef);
       
         ApexPages.StandardController sc = new ApexPages.standardController(qp);
         INStdReportApttusNN ir = new INStdReportApttusNN(sc);
        test.stopTest();
        //update od;
        
        }
}