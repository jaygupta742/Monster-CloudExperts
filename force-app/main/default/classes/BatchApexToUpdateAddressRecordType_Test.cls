@isTest
public class BatchApexToUpdateAddressRecordType_Test {
    
    public static testmethod void met(){
          
List<Account>  aa = new List<Account>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
         Trigger__c trr = new Trigger__c(name ='Compliance',Active__c = true);
        insert trr;
        
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
        trigger__c t4 = new trigger__C(name='Opportunity',Active__c = true);
        insert t4;
        
        trigger__c t5 = new trigger__C(name='Quote',Active__c = true);
        insert t5;
        
        trigger__c t6 = new trigger__C(name='Order',Active__c = true);
        insert t6;
         Account a = new Account();
        a.Name = 'Testaccount';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='eeee';
        a.Lead_Source__c='Other';
        a.Person_Account__c = true;
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
        a.CreatedDate = Date.newInstance(2014, 12, 9);
        a.Segment__c = 'Commercial';
        a.Lead_Source1__c= 'Call Inbound';
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';  
        aa.add(a);
        
        insert aa;
        
       
        list<Contact> ca = new List<Contact>();
        Contact c = new Contact();
        c.AccountID= aa[0].Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        ca.add(c);
        insert ca;
        
        /* list<Address1__c> ad = new List<Address1__c>();
        Address1__c addr= new Address1__c();
        addr.Account__c=aa[0].id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        ad.add(addr);
        insert ad;*/
        
        Test.startTest();
        BatchApexToUpdateAddressRecordType BAD = new BatchApexToUpdateAddressRecordType();      
              DataBase.executeBatch(BAD); 
         Test.stopTest();
        
    }


}