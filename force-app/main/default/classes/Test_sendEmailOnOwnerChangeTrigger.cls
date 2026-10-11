@isTest
private class Test_sendEmailOnOwnerChangeTrigger {

    @isTest static void testSendEmailOnOwnerChange() {
        Profile teleCallerProfile = [SELECT Id FROM Profile WHERE Name = 'Monster - Tele Caller Support and Sales' LIMIT 1];
        Profile salesProfile = [SELECT Id FROM Profile WHERE Name = 'Monster - Sales' LIMIT 1];
        
        User teleCallerUser = new User(
            Alias = 'tuser', Email = 'telecaller@test.com',
            EmailEncodingKey = 'UTF-8', LastName = 'TeleCaller',
            LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US',
            ProfileId = teleCallerProfile.Id, TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'telecaller' + Math.random() + '@test.com'
        );
        insert teleCallerUser;

        User salesUser = new User(
            Alias = 'suser', Email = 'salesuser@test.com',
            EmailEncodingKey = 'UTF-8', LastName = 'SalesUser',
            LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US',
            ProfileId = salesProfile.Id, TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'salesuser' + Math.random() + '@test.com'
        );
        insert salesUser;
        
        Trigger__c tri = New Trigger__c(name = 'Account' , Active__c = True);
        insert tri;

        // Setup: Create necessary Account
        Account testAccount = new Account(Name = 'Test Account',SalesChannel__c  = 'ME-FS' , Import_Source__c = 'Web' , 
                                         Lead_Source__c = 'SMS' , APAC_Industry__c = 'BFSI' , No_of_Employees__c = 10 , Location__c = 'India',
                                          Website = 'www.js.co' , Phone = '7041733029' , RegistrationNumber__c = '12344566676543');
        insert testAccount;
        System.runAs(teleCallerUser) {
            Trigger__c triemail = New Trigger__c(name = 'EmailMessage' , Active__c = True);
            insert triemail;
            Task teleCallerTask = new Task(Subject = 'Test Task 1', WhatId = testAccount.Id, OwnerId = teleCallerUser.Id , Task_Type__c = 'VOC');
            insert teleCallerTask;
        }
        System.runAs(salesUser) {
            
            Task salesTask = new Task(Subject = 'Test Task 2', WhatId = testAccount.Id, OwnerId = salesUser.Id,Products__c = 'Custom Job Template',
                                     Related_to_Inbound_Recruiter_task__c = 'Yes', Feedback_By_Sales__c = 'Others' , Task_Type__c = 'VOC');
            insert salesTask;

        }
        System.runAs(teleCallerUser) {
            Task teleCallerTask = [SELECT Id, Subject FROM Task WHERE Subject = 'Test Task 1' LIMIT 1];
            teleCallerTask.Subject = 'Updated Test Task 1';
            update teleCallerTask;
        }
    }
}