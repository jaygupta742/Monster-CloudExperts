@istest
public class DragAndDropRESTAPI_Test1 {
    @istest static void testpa(){
        
    
       
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '7878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        insert a;
     
        DragAndDropRESTAPI cc= new DragAndDropRESTAPI();
        
        String tt = JSON.serialize(cc);
        RestRequest rr= new RestRequest();
        rr.requestURI='/services/apexrest/DragAndDrop';
        rr.httpMethod='Post';
        rr.addParameter('FileName', 'joshi');
          rr.addParameter('parId', a.id);
        rr.requestBody=blob.valueOf(tt);
        RestContext.request = rr;
         string dd= DragAndDropRESTAPI.attachDoc();

        
        
        
        
    }
}