@IsTest(SeeAllData = true)
public class MonsterB2CIntegrationTest {

    @IsTest
    static void testInsertAndUpdateFlow() {

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];

        User u1 = new User(
            ProfileId = p.Id,
            LastName = 'User1',
            Email = 'u1@test.com',
            Username = 'u1' + System.currentTimeMillis() + '@test.com',
            Alias = 'u1',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );

        User u2 = new User(
            ProfileId = p.Id,
            LastName = 'TeamLead',
            Email = 'u2@test.com',
            Username = 'u2' + System.currentTimeMillis() + '@test.com',
            Alias = 'u2',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );

        insert new List<User>{u1, u2};

        u2.Team_Lead__c = true;
        update u2;

        Lead_Assignment_Members__c lam1 = new Lead_Assignment_Members__c(
            User__c = u1.Id,
            State_Selection__c = 'Karnataka',
            Years_Of_Experience__c = 5
        );

        Lead_Assignment_Members__c lam2 = new Lead_Assignment_Members__c(
            User__c = u2.Id,
            State_Selection__c = 'Maharashtra',
            Years_Of_Experience__c = 10
        );

        insert new List<Lead_Assignment_Members__c>{lam1, lam2};

        Account existingAcc = new Account(
            Name = 'Old',
            Email__c = 'existing@test.com',
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName()
                .get('Person_Account').getRecordTypeId(),
            Last_Activity_Created_Date__c = System.today().addDays(-10)
        );
        insert existingAcc;

        String jsonBody = JSON.serialize(new List<Object>{
            new Map<String,Object>{
                'seekerid' => '1',
                'fname' => 'New',
                'lname' => 'Lead',
                'Email' => 'newlead@test.com',
                'state' => 'Karnataka'
            },
            new Map<String,Object>{
                'seekerid' => '2',
                'fname' => 'Existing',
                'lname' => 'Lead',
                'Email' => 'existing@test.com',
                'state' => 'Delhi'
            }
        });

        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/B2CintegrationV2/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonBody);

        RestContext.request = req;

        Test.startTest();
        String response = MonsterB2CIntegration.doPost();
        //MonsterB2CIntegration.testCodeCoverageBlaster();
        Test.stopTest();

        Account inserted = [SELECT Id, OwnerId, AssignmentReason__c 
                            FROM Account 
                            WHERE Email__c = 'newlead@test.com'
                            LIMIT 1];

        Account updated = [SELECT Id, OwnerId 
                           FROM Account 
                           WHERE Email__c = 'existing@test.com'
                           LIMIT 1];


    }
}