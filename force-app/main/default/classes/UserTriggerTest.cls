//Creaeted By : Abdul Aziz , Created Date : 15/04/2024 , Description : Test Class For UserTrigger
@isTest
private class UserTriggerTest {
    
    @isTest
    static void testUserDeactivation() {
        // Create a test user
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'jaipur123@mmw.com',
            Alias = 'tuser',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            ProfileId = [SELECT Id FROM Profile LIMIT 1].Id,
            IsActive = true
        );
        insert testUser;
        
        testUser.IsActive = false;
        Test.startTest();
        update testUser;
        Test.stopTest();   
    }
}