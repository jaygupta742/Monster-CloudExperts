@isTest
public class AccountPromotionRequest_Test {
    @isTest Static void AccountPromotionRequest_Test()
  {
    List<Trigger__c> css= new List<Trigger__c>();
         Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
       css.add(t);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        css.add(tk);
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
       css.add(t1);
         Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        css.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        css.add(t2k);
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        css.add(t2);
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
       css.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
       css.add(t4);
        
         Trigger__c t7= new Trigger__c(name ='CVR',Active__c = true);
        css.add(t7);
        insert css;
    Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'Telesales';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.Segment__c = 'GAS'; 
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        insert a; 

      
           AccountPromotionRequest.sendmail(a.id);

        a.SalesChannel__c = 'Fieldsales.ph';
        a.Location__c='Philippines';
        update a;
       AccountPromotionRequest.sendmail(a.id);
    a.SalesChannel__c = 'Enterprise Business';
        a.Location__c='India';
        update a;
      // AccountPromotionRequest.sendmail(a.id);
      
      a.SalesChannel__c = 'Fieldsales.me';
        a.Location__c='Middle East';
        update a;
      AccountPromotionRequest.sendmail(a.id);
     
      a.SalesChannel__c = 'Fieldsales.sg';
        a.Location__c='Singapore';
        update a;
     test.startTest();
      AccountPromotionRequest.sendmail(a.id);
 
      a.SalesChannel__c = 'ECOMM';
        a.Location__c='India';
        update a;
      AccountPromotionRequest.sendmail(a.id);
      
      a.SalesChannel__c = 'ECOMM';
        a.Location__c='Middle East';
        update a;
      AccountPromotionRequest.sendmail(a.id);
      
      a.SalesChannel__c = 'ECOMM';
        a.Location__c='Singapore';
        update a;
      //AccountPromotionRequest.sendmail(a.id);
      
      a.SalesChannel__c = 'Fraud & Compliance';
        a.Location__c='Singapore';
        update a;
      //AccountPromotionRequest.sendmail(a.id);
      test.stopTest();
      //*/
  }}