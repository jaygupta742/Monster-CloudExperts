/*
Created By : Vijay Somvanshi 
Created Date : 11/03/2024 */
@isTest
private class Schedulable_AccountProcessorDaily_Test {
    @isTest
    static void testSchedulableAccountProcessor() {
        Trigger__c triger = new Trigger__c();
        triger.Name	 = 'Account';
        triger.Active__c = true;
        
        insert triger;
        
        // Create test data - Insert an Account with an inactive owner
        Account testAccount = new Account(Name = 'Test Account', SalesChannel__c = 'SMB', Import_Source__c = 'web', Lead_Source__c	 = 'Product Enquiry', 
                                          AccountStatus__c = 'Lead',Lead_Account_Status__c = 'Inactive', Location__c = 'Multi-Location', Website = 'www.com',CreditStatus__c = 'Suspend',
                                          Phone = '123', RegistrationNumber__c = '11', APAC_Industry__c ='IT/Computer Software',
                                          Account_Type__c = 'IT', No_of_Employees__c = 11, CustEmplSize__c = 111, Region__c = 'Gulf');
        insert testAccount;
        
        // Set the owner as inactive
        //  List<User> ownerList = [SELECT Id FROM User WHERE Id = :testAccount.OwnerId LIMIT 1];
        user u = [select id, IsActive from user limit 1];
        
        testAccount.ownerId = u.id;
        update testAccount ;
        
        u.IsActive = false;
        update u;
        
        
        // Schedule the job
        Test.startTest();
        String cronExpression = '0 0 0 11 3 ? 2024'; // Replace with a valid cron expression
        Schedulable_AccountProcessorDaily scheduledJob = new Schedulable_AccountProcessorDaily();
        //  String jobId = System.schedule('Test_Schedulable_AccountProcessorDaily', cronExpression, scheduledJob);
        scheduledJob.execute(null);
        Test.stopTest();
        
        
        // For example, query the updated Account record and verify that the owner has changed
        Account updatedAccount = [SELECT Id, OwnerId FROM Account WHERE Id = :testAccount.Id LIMIT 1];
        System.assertNotEquals(testAccount.OwnerId, updatedAccount.OwnerId);
        
    }
}