@isTest
public class UpdateDateforstage_Test {


    @isTest Static void Testpa11()
    {
        
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
        
        
        
        LastRunTime__c lt = new LastRunTime__c();
        lt.Name = 'LastRun';
        lt.LRT__c = system.now() -1 ;
        insert lt;
        
        
        List<Account>  aa = new List<Account>();
        
        Account a1 = new Account();
        a1.Name = 'Testaccount';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='eeee';
        a1.Lead_Source__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='Hong Kong';
        a1.Website='www.asdfert.com';
        a1.Phone= '+918965874589';
        a1.OtherPhone__c = '+987456985474';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c='On Hold - Finance';
        a1.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a1.BillingState='Karnataka';
        a1.BillingStreet ='Test Address';
        a1.BillingCity ='bangalore' ;
        a1.BillingPostalCode='560076';
        a1.shippingCountry='India' ; //To change Address from Object to Standard Address in Account
        a1.shippingState='Karnataka';
        a1.shippingStreet ='Test Address';
        a1.shippingCity ='bangalore' ;
        a1.shippingPostalCode='560076';
        a1.Segment__c = 'Commercial';
        a1.Lead_Source1__c= 'Call Inbound';
        insert a1;        
        
        Task t11 = new Task();
        t11.Subject = 'Fresh Telecall';
        t11.WhatId = a1.Id;
        insert t11;
        
        t11.Subject = 'Fresh Telecall';
        Update t11;
        
        Task t12 = new Task();
        t12.Subject = 'Fresh Telecall';
        t12.WhatId = a1.Id;
        insert t12;
        
        Contact c = new Contact();
        c.AccountID= a1.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        
        Contact c1 = new Contact();
        c1.AccountID= a1.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='9898989898';
        insert c1;
        
        a1.Lead_Account_Status__c='Active';
        update a1;
       
        
        Opportunity__c o4 = new Opportunity__c();
        o4.Account__c=a1.id;
        o4.Close_Date__c=System.today();
        o4.OpportunityType__c='Trial';
        o4.Stage__c ='Negotiation Complete';
        o4.Opportunity_Lost_deferred__c = true;
        o4.Amount__c = 1100;
        insert o4;
        
       o4.Stage__c ='Closed Won';
        update o4;
        
        
        
        Event e = new Event();
        e.WhatId = o4.Id;
        e.Subject = 'Demonstration';
        e.DurationInMinutes = 120;
        e.ActivityDateTime = system.now();
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
       
       
        test.startTest();
        Profile profileId = [SELECT Id FROM Profile WHERE id ='00e7F000000uSShQAM'];
        
     	User usr = new User(LastName = 'LIVESTON',
                           FirstName='JASON',
                           Alias = 'jliv',
                           Email = 'jason.liveston@asdf.com',
                           Username = 'jason.liveston@asdf.com',
                           ProfileId = profileId.id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                           LocaleSidKey = 'en_US'
                           );
  
 
        test.stopTest();
        
     
       } 
}