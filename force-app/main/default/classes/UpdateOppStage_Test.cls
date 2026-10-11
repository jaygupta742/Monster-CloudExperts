@isTest
public class UpdateOppStage_Test {
 @isTest
    Public Static void testmytarget(){
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c tt = Trigger__c.getValues('Quote');
 
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
        t.Subject = 'Fresh Telecall';
        t.WhatId = a.Id;
        insert t;
        
        t.Subject = 'Fresh Telecall';
        Update t;
        
        
        Tax_Refference__c ts = new Tax_Refference__c();
        ts.Name = 'new';
        ts.Selling_Country__c = 'India';
        ts.Client_Location__c = 'India';
        ts.TAx_Name__c = 'aaa';
        ts.Tax_Rate__c= 20;
       	Insert ts; 
  
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
       // e.EventStatus__c = 'Completed';
        e.DurationInMinutes = 60;
        e.ActivityDateTime = datetime.newInstance(2020, 4, 25, 10, 30, 0);
        e.StartDateTime = datetime.newInstance(2020, 4, 25, 10, 30, 0);
        e.EndDateTime = datetime.newInstance(2020, 4, 25, 11, 30, 0);

        insert e;
        
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
         test.stopTest();
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
        insert qp;
       
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=120;
        ap.TDS_Amount_c__c=0;        
        ap.Due_Date__c=system.today()+3;        
        insert ap;
       
        Send_to_Order.myMethod(qp.id);
        e.EventStatus__c = 'Completed';
       
        update e;
     
       
       
       } 
}