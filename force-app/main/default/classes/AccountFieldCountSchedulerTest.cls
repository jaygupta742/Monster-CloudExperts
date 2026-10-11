@isTest
private class AccountFieldCountSchedulerTest {
    @isTest
    static void testScheduler() {
       list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false); 
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = false);
        tlist.add(tshareorder);
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(SharePortfolio);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        Trigger__c OrderItem = new Trigger__c(name ='OrderItem', Active__c = false);
        tlist.add(OrderItem);
        
        
        insert tlist;
        
         Account a = new Account();
        a.Name = 'Debasis Das';
        a.SalesChannel__c = 'EA';
        a.Import_Source__c='Import_Source__c';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Internet';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='IT';
        a.Location__c='India';
        a.Lead_Source1__c='ECOMM';
        a.Website='www.asdfert.com';
        a.Phone= '+985478547256';
        a.OtherPhone__c = '+985478547856';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076'; 
        a.ShippingCountry='India';
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        a.OwnerId = userinfo.getUserId();
        
        insert a;
        
        
        // Execute scheduler
        Test.startTest();
        AccountFieldCountScheduler scheduler = new AccountFieldCountScheduler();
        String jobId = System.schedule('Test Scheduler', '0 0 0 * * ?', scheduler);
        Test.stopTest();
        
        // Verify results
      //  System.assertEquals(1, [SELECT COUNT() FROM EmailMessage], 'Email should be sent');
    }
}