@isTest
public class DNCBatchApexForAccount_Test {
static testmethod void met(){
        
         Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
          Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
          Trigger__c t3 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t3;
        test.startTest();
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
        a.OtherPhone__c = '+9187456985474';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
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
        a.Segment__c = 'Commercial';
        a.Lead_Account_Status__c='Inactive';
        a.Integration__c =false;
        a.Case_Accounts__c =false;
        a.Person_Account__c = false;
        a.Lead_Source1__c= 'Call Inbound';
        insert a;
        
   
       Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='+918965874589';
        c.MobilePhone = '+8909876546';
        //c.HomePhone ='+4561234567890';
        //c.OtherPhone = '+9851234567890';   
        insert c;
        
    a.Lead_Account_Status__c='Active';
        update a ;
    
        list<DND_Data__c> dn = new list<DND_Data__c>();
        DND_Data__c d = new DND_Data__c(DNC_Phone__c='918965874589');
        dn.add(d);
         DND_Data__c d1 = new DND_Data__c(DNC_Phone__c='7456985474');
        dn.add(d1);
         DND_Data__c d2 = new DND_Data__c(DNC_Phone__c='9898989898');
        dn.add(d2);
        
        insert dn;
    
        
        DNCBatchApexForAccount dd = new DNCBatchApexForAccount();
        DataBase.executeBatch(dd);
        a.Do_Not_Call__c = true;
        update a;
        test.stopTest();

    }

}