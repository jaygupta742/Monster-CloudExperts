@isTest
public class TestClassForWholeTargetRelated {
    @isTest
    Public Static void testmytarget(){
       List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t7 = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t7);
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
      
        LastRunTime__c lt = new LastRunTime__c();
        lt.Name = 'LastRun';
        lt.LRT__c = system.now() -1 ;
        insert lt;
         test.startTest();
        List<Account>  aa = new List<Account>();
        
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
        a.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.shippingState='Karnataka';
        a.shippingStreet ='Test Address';
        a.shippingCity ='bangalore' ;
        a.shippingPostalCode='560076';
        
        a.Segment__c = 'Commercial';
        //a.Last_Target_Activity_Date__c = System.today() - 30;
        a.Lead_Source1__c= 'Call Inbound';
        insert a;
        
        Task t = new Task();
        t.Subject = 'Meeting';
        t.WhatId = a.Id;
        insert t;
        t.Subject = 'Fresh Telecall';
        Update t;
        
        Task t11 = new Task();
        t11.Subject = 'Fresh Telecall';
        t11.WhatId = a.Id;
        insert t11;
        
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
        o.Amount__c = 1100;
        insert o;
        
        Event e = new Event();
        e.WhatId = o.Id;
        e.Subject = 'Demonstration';
        e.EventStatus__c = 'Completed';
        e.DurationInMinutes = 120;
        e.ActivityDateTime = system.now();
        insert e;
        
        /*Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/
        
        
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
            
        Product_Price_Entry__c pe = new Product_Price_Entry__c();
        pe.DiscountLimit__c = false;
        pe.Product__c = m1.id;
        pe.PriceList__c = pl.id;
        insert pe;
        
        a.Lead_Account_Status__c='Active';
        Update a;
        
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=a.id;
        qp.Opportunity__c=o.id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='Upsell';
        qp.Channel__c='PFC';
        qp.Primary_Contact__c=c.id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=c.id;
        qp.PostingContact__c=c.id;
        qp.Quote_Finalize_Date_Time__c = system.now();
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
       // qp.Posting_Address__c= addr.id;
        insert qp;
        Proposal_Line_Item__c   pit= new Proposal_Line_Item__c  ();
        pit.Proposal_Locked__c=qp.id;
        pit.Quantity__c=1;
        pit.Product__c=m1.id;
        pit.Price__c=120;
        pit.Discount_Exception__c = true;
        pit.Start_Date__c=System.today();
               pit.Free_Trail__c=true;
        
        insert pit;
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=120;
        ap.TDS_Amount_c__c=0;
     
        ap.Due_Date__c=system.today()+3;
        
        insert ap;
       
         Send_to_Order.myMethod(qp.id);
        test.stopTest();
       
       
        Testpa(qp.id,o.id);
    }
    
    public static void Testpa (String qid,String oid){
        apttus_proposal_proposal__c bb= new apttus_proposal_proposal__c();
        bb=[select id from apttus_proposal_proposal__c where id=:qid];
         ApexPages.StandardController sc = new ApexPages.StandardController(bb);
        PageReference pageRef = Page.ProposalGenerate;
        pageRef.getParameters().put('id', String.valueOf(bb.id));
        Test.setCurrentPage(pageRef);
        
        ProposalGenerateController testAccPlan = new ProposalGenerateController(sc);
        //testAccPlan.updateoppstage();
        testAccPlan.getItems();
        testAccPlan.settype('pdf');
        testAccPlan.gettype();
        testAccplan.pdfdoc_val = 'PDF';
        testAccPlan.selectcon();
        testAccPlan.Generate(); 
        Opportunity__c o = new Opportunity__c();
        o.id=oid;
        o.Stage__c='Quote / Agreement Stage'; 
        o.Probability__c = '75'; 
        Update o;
        
        o.Stage__c='Need Analysis'; 
        update o;
        Send_to_Order.myMethod(qid);
        o.Opportunity_Lost_deferred__c = true;
        Update o;
       
        ApexPages.StandardController sc1 = new ApexPages.StandardController(new Target__c());
        PageReference pageRef1 = Page.NewTargets;
        Test.setCurrentPage(pageRef1);
       addtargets at = new addtargets(sc1);
        at.lt[0].user__c = userinfo.getUserId();
        at.lt[0].Start_Date__c = system.today();
        at.lt[0].End_Date__c = system.today()+9;
        at.lt[0].Opportunity_Won_Target__c = 50000.00;
        at.addnew();
        at.copy();
        at.rowtoremove = 1;
        at.remove();
        //at.save();
       
        Target__c sobj = new Target__c(
          Name = 'Zubin Thomas-1/8/2018-31/8/2018', // Target Name
          User__c = '0057F000003RvIZ',                // User
          Start_Date__c = system.today(),               // Start Date
          End_Date__c = system.today()+3,                   // End Date
          Unique_Account__c = 20,                     // New Account
          Free_Trail__c = 10,                         // Free Trail
          Demonstration__c = 10,                      // Demonstration
          Unique_Opportunity__c = 5,                  // New Opportunity
          Unique_Connects__c = 50,                    // Unique Connects
          Unique_Connects_Completed__c = 6,           // Unique Connects Completed
          Opportunity_Created_Target__c = 150000.00,  // Opportunity Created Target
          Opportunity_Won_Target__c = 50000.00       // Opportunity Won Target
        );

       
         insert sobj;
        TargetUpdate.updateusertarget();
        o.Actual_Revenue__c=null;
        update o;
        TargetUpdate.updateusertarget();
    }
}