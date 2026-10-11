@isTest
  Public class CVRReassign_Test
{
  static testmethod void CVRReassign_Test()
  {
      Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        Trigger__c t3 = new Trigger__c(name ='CVR',Active__c = true);
        insert t3;
        
        
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Lead_Source1__c='ECOMM';
        a.Website='www.asdfert.com';
        a.Phone= '+985478547256';
        a.OtherPhone__c = '+985478547856';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076'; 
        a.ShippingCountry='India';//@yamini
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        insert a;
        
         Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
         a.Lead_Account_Status__c='Active';
        Update a;
        
        Client_Validation_Request__c d = new Client_Validation_Request__c();
        d.Account__c=a.Id;
        d.Contact__c=c.Id;
        d.Account_Registration_Number__c='123';
        d.Account_Location__c='street1';
        
        //d.RecordTypeId='default';
        d.PAN_Number__c='12345';
        d.PAN_Card_Name__c='abc';
        d.VAT_Number__c='23456';
        d.Stage__c='Submitted';
        d.Status__c='Open';
        insert d;
       
      Test.setMock(HttpCalloutMock.class, new CVRReassignMock());  
      Test.startTest();
      CVRReassign.met(d.Id);
  }
}