/*
* Created By : Abdul Aziz 
* Created Date : 29/04/2024
* Description: Test class for RecontractAgreementController 

Last Modified By		Last Modified Date			Description
Debasis Das				02/05/2024					Updating logics and comments
*/
@isTest(SeeAllData=true) public class RecontractAgreementController_Test {
    @istest public static void TestMethod01(){
        QuotesN__c Quote = [SELECT Id, Name FROM QuotesN__c WHERE Active__c =: true LIMIT 1];
        
        ApexPages.currentPage().getParameters().put('id', Quote.Id);
        ApexPages.StandardController sc = new ApexPages.standardController(Quote);
        
        RecontractAgreementController controller = new RecontractAgreementController(sc);
    }
}