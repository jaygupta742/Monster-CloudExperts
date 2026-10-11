//Created By : Abdul Aziz , Created Date : 15/07/2024 , Description : Test Class For B2CIntegration
@IsTest
private class B2CIntegration_Test2 {
    @IsTest
    static void testDoPostWithValidData() {
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        // Create required test data
        RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Person_Account' LIMIT 1];
        
        PA_Owner_Assignment__c paOwnerAssignment = new PA_Owner_Assignment__c(
            Name='TestData',
            UserId__c = UserInfo.getUserId(),
            Count__c = 100,
            Location__c = 'Gulf'
        );
        insert paOwnerAssignment;
        
        // Create a user to be assigned
        User testUser = [SELECT Id FROM User WHERE isactive=true limit 1];
        
        // Call the doPost method
        String response = B2CIntegration.doPost(
            '123456', 'John', 'Doe', 'john.doe@example.com',
            'alt.john.doe@example.com', '1234567890', '0987654321', 
            'Current Location', '5 Years', 'Categories',
            'Resume Text', 'Industry', 'Roles', 'ResId', 
            '50000', Datetime.now(), Datetime.now(), 'American', 
            '123 Main St', 'United States', 'Source_File', 'attachment.pdf', 'Lead Source', 'Lead Score', 'Team', 'Bachelor', '2020', 'Company Name'
        );
        
        
    }
    
    @IsTest
    static void testDoPostWithExistingAccount() {
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        // Create required test data
        RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Person_Account' LIMIT 1];
        
        Account existingAccount = new Account(
            Name='test1407',
            Seeker_ID__c = '123456', 
            Last_Name__c = 'Doe', 
            First_Name__c = 'John', 
            Email__c = 'john.doe@example.com'
        );
        insert existingAccount;
        
        // Call the doPost method
        String response = B2CIntegration.doPost(
            '123456', 'John', 'Doe', 'john.doe@example.com',
            'alt.john.doe@example.com', '1234567890', '0987654321', 
            'Current Location', '5 Years', 'Categories',
            'A', 'Industry', 'Roles', 'ResId', 
            '50000', Datetime.now(), Datetime.now(), 'American', 
            '123 Main St', 'United States', 'Source_File', 'attachment.pdf', 'Lead Source', 'Lead Score', 'Edtech-Courses', 'Bachelor', '2020', 'Company Name'
        );
    }
    
    @IsTest
    static void testDoPostWithInvalidCountry() {
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        // Call the doPost method with an invalid country
        String response = B2CIntegration.doPost(
            '123456', 'John', 'Doe', 'john.doe@example.com',
            'alt.john.doe@example.com', '1234567890', '0987654321', 
            'Current Location', '5 Years', 'Categories',
            'Resume Text', 'Industry', 'Roles', 'ResId', 
            '50000', Datetime.now(), Datetime.now(), 'American', 
            '123 Main St', 'InvalidCountry', 'Source_File', 'attachment.pdf', 'Lead Source', 'Lead Score', 'Team', 'Bachelor', '2020', 'Company Name'
        );
        
    }
    
    @IsTest
    static void testDoPostWithEmptyExperience() {
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        // Call the doPost method with an empty experience
        String response = B2CIntegration.doPost(
            '123456', 'John', 'Doe', 'john.doe@example.com',
            'alt.john.doe@example.com', '1234567890', '0987654321', 
            'Current Location', '', 'Categories',
            'Resume Text', 'Industry', 'Roles', 'ResId', 
            '50000', Datetime.now(), Datetime.now(), 'American', 
            '123 Main St', 'United States', 'Source_File', 'attachment.pdf', 'Lead Source', 'Lead Score', 'Team', 'Bachelor', '2020', 'Company Name'
        );
        
    }
    @IsTest
    static void testDoPostWithExistingAccount1() {
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        // Create required test data
        RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Person_Account' LIMIT 1];
        
        Account existingAccount = new Account(
            Name='test1407',
            Last_Owner_Update__c=System.today().addDays(-50),
            Seeker_ID__c = '123456', 
            Last_Name__c = 'Doe', 
            First_Name__c = 'John', 
            Email__c = 'john.doe@example.com'
        );
        insert existingAccount;
        
        // Call the doPost method
        String response = B2CIntegration.doPost(
            '123456', 'John', 'Doe', 'john.doe@example.com',
            'alt.john.doe@example.com', '1234567890', '0987654321', 
            'Current Location', '5 Years', 'Categories',
            'A', 'Industry', 'Roles', 'ResId', 
            '50000', Datetime.now(), Datetime.now(), 'American', 
            '123 Main St', 'United States', 'Source_File', 'attachment.pdf', 'Lead Source', 'Lead Score', 'Edtech-Courses', 'Bachelor', '2020', 'Company Name'
        );
    }
}