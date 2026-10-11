@isTest
public class SalesPipelineBatchApex_test {
   
    
    static testmethod void Method1(){
    Trigger__c t = new Trigger__c();
    t.name = 'Account';
    t.active__c= true;
    insert t;
        
       /*  User u = [SELECT Id FROM User WHERE N_ExternalID__c='00516000006mcLPAAY' limit 1];
        system.runAs(u){*/
          LIst<Account> ac= new List<Account>();
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
        
        a.Segment__c = 'Commercial';
        
        a.Lead_Source1__c= 'Call Inbound';
       
        ac.add(a);
        insert ac; 
        
      list<opportunity__c> opp = new list<opportunity__c>();
            for(integer i=0;i<20;i++){
                opportunity__c o = new opportunity__c();
                 o.Account__c=ac[0].id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Amount__c = 1100;
        o.createddate = system.today() - 1; 
          
                opp.add(o);
            }
           
            
        insert opp;
            for(opportunity__c oo : opp){ system.debug('ownerid--->'+oo.ownerid+' '+oo.owner.name);  }
               
    //}  
        
        test.startTest();
              
          SalesPipelineBatchApex b = new SalesPipelineBatchApex();
            b.query = 'SELECT Id,Name, (SELECT id,name FROM ManagedUsers WHERE isactive = true) FROM User WHERE isactive = true limit 10';
             Database.executeBatch(b,10);
        test.stopTest();

    }
    
    

}