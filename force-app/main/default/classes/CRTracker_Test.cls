@isTest
private class CRTracker_Test {
    
  public static testmethod void met()
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
        
       map<string,id> rmp= new map<string,id>();
       list<RecordType> rt = new   list<RecordType>([SELECT id,name FROM RecordType WHERE SObjectType='CR_Tracker__c']);
       system.debug('rc-->'+rt);
       for(RecordType r : rt)
       {
            rmp.put(r.name, r.id);
       }
        
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
        a.BillingCountry='India'; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076'; 
        a.ShippingStreet = 'test address1';
        a.ShippingCity ='myco layout';
        a.ShippingState ='Chennai';
        a.ShippingCountry = 'India';
        a.ShippingPostalCode = '34567';
        a.CreditStatus__c='OK';
        
        a.Segment__c = 'Commercial';
        
        a.Lead_Source1__c= 'Call Inbound';
       
        insert a;
        
        Contact  co = new Contact ();
        co.lastname='Conto';
        co.CurrencyIsoCode='INR';
        co.AccountId = a.id;
        insert co;
      
        a.Lead_Account_Status__c='Active';
        update a;
        //Id objectRecordTypeId = Schema.SObjectType.CustomObject__c.getRecordTypeInfosByName().get('CustomObject').getRecordTypeId();
       /* 
        List<RecordType>cc=[Select Id,name From RecordType where sobjecttype = 'CR_Tracker__c' ];
        LIst<CR_Tracker__c> c = new LIst<CR_Tracker__c>(); 
        for(RecordType dd:cc){
                CR_Tracker__c cr = new CR_Tracker__c(); 
                 cr.recordtypeid=dd.id;
        
        
           }
        */
           /*     List<RecordType>cc=[Select Id,name From RecordType where sobjecttype = 'CR_Tracker__c' ];
        id lapsed;
        for(Integer i=0;i<cc.size();i++)
        {
            System.debug('record type'+cc[i].name+'id is'+cc[i].id);
            if(cc[i].name =='Lapsed Accounts')
            {
                lapsed = cc[i].id;
            }
        }

        CR_Tracker__c c = new CR_Tracker__c();
        c.Account__c=a.id;
        c.RecordTypeId=cc[0].id;
        insert c;
        
        CR_Tracker__c c1 = new CR_Tracker__c();
        c1.Account__c=a.id;
        c1.RecordTypeId=cc[1].id;
        insert c1;
        */
          test.startTest();
        
        // General RT
        CR_Tracker__c c = new CR_Tracker__c();
        c.RecordTypeId = rmp.get('General');
      
        
        Pagereference pg = page.CRTracker;
         pg.getParameters().put('id', c.Id);
        test.setCurrentPage(pg);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        CRTracker cr = new CRTracker(sc);
        
        
        // Lapsed Accounts RT
        CR_Tracker__c c1 = new CR_Tracker__c();
        c1.RecordTypeId = rmp.get('Lapsed Accounts');
       
        Pagereference pg1 = page.CRTracker;
         pg1.getParameters().put('id', c1.Id);
        test.setCurrentPage(pg1);
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(c1);
        CRTracker cr1 = new CRTracker(sc1);
        
        // 90 Days RT
        CR_Tracker__c c2 = new CR_Tracker__c();
        c2.RecordTypeId = rmp.get('90 Days');
       
        Pagereference pg2 = page.CRTracker;
         pg2.getParameters().put('id', c2.Id);
        test.setCurrentPage(pg2);
        
        ApexPages.StandardController sc2 = new ApexPages.StandardController(c2);
        CRTracker cr2 = new CRTracker(sc2);
        //
        //
        // Low or Zero RDA Usage / Or No Login
        CR_Tracker__c c11 = new CR_Tracker__c();
        c11.RecordTypeId = rmp.get('Low or Zero RDA Usage / Or No Login');
       
        Pagereference pg11 = page.CRTracker;
         pg11.getParameters().put('id', c11.Id);
        test.setCurrentPage(pg1);
        
        ApexPages.StandardController sc11 = new ApexPages.StandardController(c11);
        CRTracker cr11 = new CRTracker(sc11);
        
        // Complaints RT
        CR_Tracker__c c3 = new CR_Tracker__c();
        c3.RecordTypeId = rmp.get('Complaints');
       
        Pagereference pg3 = page.CRTracker;
         pg3.getParameters().put('id', c3.Id);
        test.setCurrentPage(pg3);
        
        ApexPages.StandardController sc3 = new ApexPages.StandardController(c3);
        CRTracker cr3 = new CRTracker(sc3);
        
        // Quarter RT
        CR_Tracker__c c4 = new CR_Tracker__c();
        c4.RecordTypeId = rmp.get('Quarter');
       
        Pagereference pg4 = page.CRTracker;
         pg4.getParameters().put('id', c4.Id);
        test.setCurrentPage(pg4);
        
        ApexPages.StandardController sc4 = new ApexPages.StandardController(c4);
        CRTracker cr4 = new CRTracker(sc4);
        
        
        
       
        
        
        test.stopTest();
    }

}