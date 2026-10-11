@isTest
public class BatchApexDeletePersonAccount_Test {
    
    public static testmethod void met(){
          
List<Account>  aa = new List<Account>();
        
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
        aa.add(a);
        insert aa;
        
         Test.startTest();
            
        BatchApexDeletePersonAccount BAD = new BatchApexDeletePersonAccount();
              DataBase.executeBatch(BAD); 
            
       Test.stopTest();
        
    }

}