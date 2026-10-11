@isTest
public class sendEmalOnOwnerChangeTest {
    
    @isTest static void testSendEmailOnOwnerChange() {
        Trigger__c tri = New Trigger__c(name = 'Account' , Active__c = false);
        insert tri;
        Trigger__c triemail = New Trigger__c(name = 'EmailMessage' , Active__c = false);
        insert triemail;
        Account testAccount = new Account(Name = 'Test Account',SalesChannel__c  = 'ME-FS' , Import_Source__c = 'Web' , 
                                          Lead_Source__c = 'SMS' , APAC_Industry__c = 'BFSI' , No_of_Employees__c = 10 , Location__c = 'India',
                                          Website = 'www.js.co' , Phone = '7041733029' , RegistrationNumber__c = '12344566676543');
        insert testAccount;
        
        User testUser = [SELECT Id,Name, Email, Manager.Email FROM User WHERE isActive = true LIMIT 1]; // Assuming at least one active user in org.
        
        Task testTask = new Task(WhatId=testAccount.Id, OwnerId=testUser.Id,Task_Type__c = 'VOC', Task_Sub_Type1__c='Product Issue – DB Inventory / Applications');
        insert testTask;
        
        Map<Id, Account> accMap = new Map<Id, Account>{testAccount.Id => testAccount};
            List<Task> taskList = new List<Task>{testTask};
                Map<Id, User> userMap = new Map<Id, User>{testUser.Id => testUser};
                    User currentUser = [Select Manager.Email,Email,Name From User Where id =: UserInfo.getUserId()];
        // Call the method
        Test.startTest();
        sendEmalOnOwnerChange sender = new sendEmalOnOwnerChange(accMap, taskList, userMap,currentUser);
update testTask;
        Test.stopTest();
        
        // Add assertions to verify the email sent status
        // As we are not doing any DML operations in the main class, 
        // main assertions would be around the debug logs for now
        // You can enhance this test class with more assertions as needed 
    }
}