@istest
public class UpdateTaskCount_test {
    
    public static testmethod void taskupdate(){
        
        test.startTest();
        List<Account> a = new List<Account>();
        for(Integer i=0; i<200; i++){
            Account acc =new Account();
            acc.Name = 'Test new A11112' + i;
            acc.SalesChannel__c = 'ECOMM';
            acc.Segment__c = 'Commercial';
            acc.Import_Source__c = 'test rep gen';
            acc.Lead_Source1__c = 'ECOMM';
            acc.APAC_Industry__c = 'Automobile';
            acc.Account_Type__c = 'NIT';
            acc.No_of_Employees__c = 20;
            acc.Location__c = 'Philippines';
            acc.Website = 'www.tesqwqwt2.com';
            acc.Phone = '+917855999958';
            acc.CreditStatus__c ='OK';
            acc.Lead_Account_Status__c = 'Inactive';
            acc.RegistrationNumber__c='ssssyyyssss';
            a.add(acc);
        }
        insert a;
        
        List<Contact> c = new List<Contact>();
        for(Account ac : a){
            Contact  con = new Contact ();
            con.Accountid= ac.id;
            con.lastname='Rocco';
            con.Phone='9845798458';
            con.Email='support@gmail.com';
            c.add(con);           
        }
        insert c;
        
        List<Opportunity__c> opp = new List<Opportunity__c>();
        for(Account ac : a){
            Opportunity__c op = new Opportunity__c();
            op.Account__c = ac.id;
            op.Close_Date__c= system.today();
            op.OpportunityType__c='Contingent';
            op.Stage__c='Identification';
            opp.add(op);
        }
        insert opp;
        
        List<Task> TestTask = new List<Task>();
        for(Integer i=0; i<200; i++){
            task rj = new task();
            rj.Subject='subject';
            rj.WhatId = a[i].id;
            rj.WhoId = c[i].id;
            rj.Task_Type__c='Call Inbound';
            rj.Priority='High';
            rj.Status='open';
            TestTask.add(rj);            
        }
        insert TestTask;
        for(Task tt : TestTask){
            tt.Status='Completed';
        }
        update TestTask;
       
        /*
       task t1 = new task();
        t1.Subject='subject';
        t1.WhatId = op.id;
        t1.WhoId= con.id;
      t1.Task_Type__c='Call Inbound';
        t1.Priority='High';
        t1.Status='open';
        insert t1;
       t1.Status='Completed';
        update t1;
       */ 
       
        
      
       
        
        
        test.stopTest();
        
    }

}