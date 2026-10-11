@IsTest
public class B2CIntegration_Test {

    /* ------------------------------
     * 
       Test Data Setup
    ------------------------------ */
    @testSetup
    static void setupData() {

        insert new Trigger__c(
            Name = 'Account',
            Active__c = true
        );

        insert new PA_Owner_Assignment__c(
            Name = 'malek',
            Count__c = 0,
            UserId__c = UserInfo.getUserId(),
            Location__c = 'India'
        );

        insert new PA_Owner_Assignment__c(
            Name = '1',
            Count__c = 0,
            UserId__c = UserInfo.getUserId(),
            Location__c = 'India'
        );

        insert new Account(
            Name = 'Pramodh',
            Email__c = 'test123@gmail.com',
            SalesChannel__c = 'SMB',
            Import_Source__c = 'sssss',
            Lead_Source__c = 'Other',
            APAC_Industry__c = 'Energy',
            No_of_Employees__c = 25,
            Account_Type__c = 'NIT',
            Location__c = 'India',
            Website = 'www.asdfert.com',
            Phone = '+917878787878',
            RegistrationNumber__c = 'asq111111',
            Lead_Account_Status__c = 'Inactive',
            CreditStatus__c = 'OK',
            Integration__c = true,
            Team__c = 'Edtech-Courses'
        );

        insert new Seeker_Skip__c(
            Name = 'test123@gmail.com'
        );
    }

    /* ------------------------------
       Helper: Build JSON Request
    ------------------------------ */
    private static String buildRequestBody(String seekerId, String email, String experience) {
        return JSON.serialize(new Map<String, Object>{
            'seekerid' => seekerId,
            'fname' => 'Pramodh',
            'lname' => 'Prax',
            'Email' => email,
            'alt_email' => 'alt_email@gmail.com',
            'primary_phone' => 'primary_phone',
            'mobile' => 'mobile',
            'currentLocation' => 'India',
            'experience' => experience,
            'categories' => 'Categories',
            'resume' => 'A',
            'industry' => 'Industry',
            'roles' => 'Roles',
            'resId' => 'ResId',
            'salary' => 'Salary',
            'registration' => '2022-05-16T07:37:44z',
            'Updatedate' => '2022-05-16T07:37:44z',
            'nationality' => 'Nationality',
            'address' => 'Address',
            'country' => 'India',
            'source_File' => 'Source_File',
            'attchname' => 'attchname',
            'leadsource' => 'CR',
            'leadscore' => '20',
            'team' => 'Edtech-Courses',
            'highest_education' => '11',
            'passing_year' => '11',
            'company_name' => '11',
            'pageName' => 'career',
            'pageUrl' => 'https://www.foundit.in',
            'programName' => 'PG Certificate',
            'instituteName' => 'Foundit'
        });
    }

    /* ------------------------------
       Test 1: Normal Valid Request
    ------------------------------ */
    @IsTest
    static void seekerTest_valid() {

        Test.startTest();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestBody =
            Blob.valueOf(buildRequestBody('12345', 'Email@gmail.com', '10'));

        B2CIntegration.doPost();

        Test.stopTest();
    }

    /* ------------------------------
       Test 2: Skip Email Scenario
    ------------------------------ */
    @IsTest
    static void seekerTest_skipEmail() {

        Test.startTest();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestBody =
            Blob.valueOf(buildRequestBody('12346', 'test123@gmail.com', '5'));

        B2CIntegration.doPost();

        Test.stopTest();
    }

    /* ------------------------------
       Test 3: Invalid Email Format
    ------------------------------ */
    @IsTest
    static void seekerTest_invalidEmail() {

        Test.startTest();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestBody =
            Blob.valueOf(buildRequestBody('12347', 'Emailgmail.com', '8'));

        B2CIntegration.doPost();

        Test.stopTest();
    }

    /* ------------------------------
       Test 4: Duplicate / Repeat Call
    ------------------------------ */
    @IsTest
    static void seekerTest_duplicateRequest() {

        Test.startTest();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestBody =
            Blob.valueOf(buildRequestBody('12345', 'Email@gmail.com', '10'));

        B2CIntegration.doPost();
        B2CIntegration.doPost(); // duplicate hit

        Test.stopTest();
    }
}