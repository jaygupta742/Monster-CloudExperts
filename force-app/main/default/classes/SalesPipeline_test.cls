@isTest
class SalesPipeline_test {
    
    @isTEst
     static void generateMet(){
        
      
    Trigger__c t = new Trigger__c();
    t.name = 'Account';
    t.active__c= true;
    insert t;
         
         Trigger__c t1 = new Trigger__c();  
           t1.name = 'Opportunity';
    t1.active__c= true;
    insert t1;
  
        
        User u = [SELECT Id FROM User WHERE N_ExternalID__c='00516000006mcZUAAY' limit 1];
       /*  system.runAs(u){*/
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
        a.ownerid = u.id;
        a.Segment__c = 'Commercial';
        
        a.Lead_Source1__c= 'Call Inbound';
       
        ac.add(a);
        insert ac; 
        
      list<opportunity__c> opp = new list<opportunity__c>();
            for(integer i=0;i<200;i++){
                opportunity__c o = new opportunity__c();
                 o.Account__c=ac[0].id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Amount__c = 1100;
        o.createddate = system.today() - 1; 
                o.ownerid = u.id;
          
                opp.add(o);
            }
         insert opp;
         
         test.startTest();       
         SalesPipeline.GenerateExcel();
        test.stopTest();
    }

}