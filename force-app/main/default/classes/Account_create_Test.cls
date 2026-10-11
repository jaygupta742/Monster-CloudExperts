@isTest
public class Account_create_Test {
    
    @isTest 
    public Static void Account_create()
    {
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
        
        Recordtype rid = [select id from recordtype where Name = 'Person Account' and Sobjecttype = 'Account' limit 1];
        profile pro = [select id,name from profile where name='Monster - Collections' OR name='Monster - Finance' OR name='Monster - Sales Ops/LM'  limit 1];
        
        
        
        //profile pro =[select id,name from profile where id =:userinfo.getProfileId() limit 1];
        user yo = new user(LastName = 'Archana Akula',
                           Alias = 'kumar',
                           Email = 'sunil.kumar@asdf.com',
                           Username = 'sunil.kumar8029@gmail.com',
                           ProfileId = pro.id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                           Department ='Collections',
                           LocaleSidKey = 'en_US');
        
        
        //user u = new user();
        //u = [select id,name from user where profile.id='00e7F000000uSSkQAM' AND IsActive =true limit 1];
        system.runAs(yo)
        {
            
            Account a = new Account();
            a.name = 'Cloudexperts';
            a.SalesChannel__c = 'ECOMM';
            a.Segment__c = 'ECOMM';
            a.Import_Source__c = 'akbsaksa';
            a.APAC_Industry__c = 'Agriculture';
            a.No_of_Employees__c = 44;
            a.Account_Type__c = 'IT';
            a.Lead_Source1__c='CR';
            a.Location__c = 'Multi-Location';
            a.Website = 'www.ce.com';
            a.Phone ='+981234567890' ;
            a.OtherPhone__c='+981234567890';
            a.RegistrationNumber__c= 'akjbaks';
            a.GST_ID__c ='g55b55';
            a.Budget_Month__c = date.today();
            a.PAN__c ='dfvdf54';
            a.Name_as_per_PAN__c ='osbas';
            
            
            
            ApexPages.StandardController aps= new ApexPages.StandardController(a); 
            Insert a;
            
            
            
            Account_Create_Duplication__c acd = new Account_Create_Duplication__c();
            acd.name = userinfo.getUserId();
            acd.Email_id__c = 'crm@cloudexpertsindia.com';
            insert acd;
            Account_create ac = new Account_create(aps);
            ac.acc.name='';
            ac.save_custom();
            ac.acc.name='Hhhh';
            ac.save_custom();
            ac.save_custom();
            ac.acc.name='';
            ac.merge_acc();
            ac.acc.name='Kl';
            ac.merge_acc();
            ac.acc.name='';
            ac.save_ignore();
            ac.acc.name='Kl';
            ac.save_ignore();
            ac.show_button=false;
            ac.acc.name='';
            ac.save_ignore();  
            ac.acc.name='Kl';
            ac.save_ignore(); 
        }
        
        // scenario-2
        
        user yoo = new user(LastName = 'sunil',
                            Alias = 'kumar',
                            Email = 'sunil123.kumar@asdf.com',
                            Username = 'sunil123.kumar8029@gmail.com',
                            ProfileId = pro.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US');
        
        system.runAs(yoo){
            
            Account a1 = new Account();
            a1.name = 'Cloudexperts';
            a1.SalesChannel__c = 'ECOMM';
            a1.Segment__c = 'ECOMM';
            a1.Import_Source__c = 'akbsaksa';
            a1.APAC_Industry__c = 'Agriculture';
            a1.No_of_Employees__c = 44;
            a1.Account_Type__c = 'IT';
            a1.Lead_Source1__c='CR';
            a1.Location__c = 'Multi-Location';
            a1.Website = 'www.ce.com';
            a1.Phone ='+981234567890' ;
            a1.OtherPhone__c='+981234567890';
            a1.RegistrationNumber__c= 'akjbaks';
            a1.GST_ID__c ='g55b55';
            a1.Budget_Month__c = date.today();
            
            a1.PAN__c ='dfvddf54';
            a1.Name_as_per_PAN__c ='osbas';
            
            ApexPages.StandardController aps= new ApexPages.StandardController(a1); 
            Insert a1;
            a1.recordtypeid = rid.id;
            a1.Integration__c = true;
            update a1;
            
            
            test.startTest();
            Account_Create_Duplication__c acd = new Account_Create_Duplication__c();
            acd.name = userinfo.getUserId();
            acd.Email_id__c = 'crm@cloudexpertsindia.com';
            insert acd;
            Account_create ac = new Account_create(aps);
            ac.acc.name='';
            ac.save_custom();
            ac.acc.name='Hhhh';
            ac.fin = true;
            ac.fin1 = false;
            ac.save_custom();
            ac.save_custom();
            a1.integration__c = true;
            update a1;
            ac.acc.name='';
            ac.merge_acc();
            ac.acc.name='Kl';
            ac.merge_acc();
            ac.acc.name='';
            ac.save_ignore();
            ac.acc.name='Kl';
            ac.save_ignore();
            ac.show_button=false;
            ac.acc.name='';
            ac.save_ignore();  
            ac.acc.name='Kl';
            ac.save_ignore(); 
        }
        
        //scenario-3
        
        
        user yooo = new user(LastName = 'sunil',
                             Alias = 'kumar',
                             Email = 'sunie.kumar@asdf.com',
                             Username = 'sunie.kumar8029@gmail.com',
                             ProfileId = pro.id,
                             TimeZoneSidKey = 'GMT',
                             LanguageLocaleKey = 'en_US',
                             EmailEncodingKey = 'UTF-8',
                             LocaleSidKey = 'en_US');
        
        system.runAs(yooo){
            
            Account a = new Account();
            a.name = 'Cloudexperts';
            a.SalesChannel__c = 'ECOMM';
            a.Segment__c = 'ECOMM';
            a.Import_Source__c = 'akbsaksa';
            a.APAC_Industry__c = 'Agriculture';
            a.No_of_Employees__c = 44;
            a.Account_Type__c = 'IT';
            a.Lead_Source1__c='CR';
            a.Location__c = 'Multi-Location';
            a.Website = 'www.ce.com';
            a.Phone ='+981234567890' ;
            a.OtherPhone__c='+981234567890';
            a.RegistrationNumber__c= 'akjbaks';
            a.GST_ID__c ='g55b55';
            a.Budget_Month__c = date.today();
            
            
            ApexPages.StandardController aps= new ApexPages.StandardController(a); 
            Insert a;
            a.Budget_Month__c = date.today();
            a.Integration__c = true;
            update a;
            
            
            
            Account_Create_Duplication__c acd = new Account_Create_Duplication__c();
            acd.name = userinfo.getUserId();
            acd.Email_id__c = 'crm@cloudexpertsindia.com';
            insert acd;
            Account_create ac = new Account_create(aps);
            ac.acc.name='';
            ac.save_custom();
            ac.acc.name='Hhhh';
            ac.save_custom();
            ac.save_custom();
            ac.acc.name='';
            ac.merge_acc();
            ac.acc.name='Kl';
            ac.merge_acc();
            ac.acc.name='';
            ac.save_ignore();
            ac.acc.name='Kl';
            ac.save_ignore();
            ac.show_button=false;
            ac.acc.name='';
            ac.save_ignore();  
            ac.acc.name='Kl';  
            ac.fin = true;
            ac.save_ignore(); 
            
            
        }
        test.stopTest();
    } 
}