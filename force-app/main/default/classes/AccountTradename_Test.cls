@isTest
public class AccountTradename_Test {
@isTest
    Public Static void AccTradeName(){
        
         Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.Segment__c = 'ECOMM';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
       	a.Account_Status__c = 'Lead';
        a.Phone= '+917569854785';
        a.OtherPhone__c = '+968547856985';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        insert a;
        a.Name = 'Change';
        update a;
    }
}