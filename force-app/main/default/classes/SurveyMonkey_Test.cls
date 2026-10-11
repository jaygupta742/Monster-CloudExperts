//Last Modified By : Abdul Aziz , Date : 22/03/2024 , Descriptiom : Test Class For SurveyMonkey // Increase Code Coverage
@isTest
public class SurveyMonkey_Test {
    
    public static testmethod void met(){
        
        List<Trigger__c> ttr = new List<Trigger__c>();
        
        Trigger__c tr = new Trigger__c(name = 'Compliance',active__c = true);
        ttr.add(tr);
        
        Trigger__c tr1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        ttr.add(tr1);
        
        Trigger__c tr2 = new Trigger__c(name = 'Account',active__c = true);
        ttr.add(tr2);
        
        Trigger__c tr3 = new Trigger__c(name = 'Contact',active__c = true);
        ttr.add(tr3);
        
        insert ttr;
        
        user u = [SELECT id,lastname FROM user WHERE Profile_Name__c ='Monster - Service/CR' AND IsActive = true LIMIT 1];
        system.runAs(u){
            
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
            
            insert a;
            
            List<contact> con = new List<contact>();
            Contact c = new Contact();
            c.AccountID= a.Id;
            c.LastName='MahendraBaahubali';
            c.Email='mbahu@gmail.com';
            c.Phone='9898989898';
            con.add(c);
            // insert c;
            
            Contact c1 = new Contact();
            c1.AccountID= a.Id;
            c1.LastName='MahendraBaahubali';
            c1.Email='mbahu@gmail.com';
            c1.Phone='9898989898';
            con.add(c1);
            //insert c1;
            
            Contact c11 = new Contact();
            c11.AccountID= a.Id;
            c11.LastName='MahendraBaahubali';
            c11.Email='mbahu@gmail.com';
            c11.Phone='9898989898';
            con.add(c11);
            insert con;   
            
            List<Task> tas  = new List<Task>();
            
            Task t  = new Task();
            
            t.Task_Type__c = 'Call Inbound';
            t.ActivitySubType__c = 'Follow Up';
            t.WhatId = a.id;
            t.WhoId = con[0].id;
            t.Activity_Status__c = 'Closed';
            tas.add(t);
            // insert t;
            
            
            
            Task t1  = new Task();
            
            t1.Task_Type__c = 'Call Inbound';
            t1.ActivitySubType__c = 'Resume Highlighter';
            t1.WhatId = a.id;
            t1.WhoId = con[1].id;
            t1.Activity_Status__c = 'Closed';
            tas.add(t1);
            //insert t1;
            
            Task t11  = new Task();
            
            t11.Task_Type__c = 'Call Inbound';
            t11.ActivitySubType__c = 'Career Booster';
            t11.WhatId = a.id;
            t11.WhoId = con[2].id;
            t11.Activity_Status__c = 'Closed';
            tas.add(t11);
            
            insert tas;
            List<id> li = new List<id>();
            for(task tt : tas){
                li.add(tt.id);
            }
            
            // SurveyMonkey s = new SurveyMonkey();
            SurveyMonkey.insertAccounts(li);
            
            
            
        }
    }
    
}