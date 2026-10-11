@IsTest(SeeAllData = true)
public class MonsterCleverTapIntegrationTest {
    
    @IsTest
    static void testInsertAndUpdateFlow() {
        
        Profile p = [
            SELECT Id
            FROM Profile
            WHERE Name = 'Standard User'
            LIMIT 1
        ];
        
        User u1 = new User(
            ProfileId = p.Id,
            LastName = 'User1',
            Email = 'ctu1@test.com',
            Username = 'ctu1' + System.currentTimeMillis() + '@test.com',
            Alias = 'ctu1',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        
        insert u1;
        
        Lead_Assignment_Members__c lam = new Lead_Assignment_Members__c(
            User__c = u1.Id,
            State_Selection__c = 'Karnataka',
            Years_Of_Experience__c = 5
        );
        
        insert lam;
        
        // Existing Account
        Account existingAcc = new Account(
            Name = 'Existing Lead',
            Email__c = 'existing@test.com',
            RecordTypeId = Schema.SObjectType.Account
            .getRecordTypeInfosByDeveloperName()
            .get('Person_Account')
            .getRecordTypeId(),
            Last_Activity_Created_Date__c = System.today().addDays(-10)
        );
        
        insert existingAcc;
        
        // New request body
        String jsonBody = JSON.serialize(
            new Map<String, Object>{
                'is_test' => true,
                    'targetId' => 1234,
                    'key_values' => new Map<String, Object>{
                        'key' => 'value'
                            },
                                'profiles' => new List<Object>{
                                    new Map<String, Object>{
                                        'seekerid' => '1',
                                            'fname' => 'New',
                                            'lname' => 'Lead',
                                            'Email' => 'newlead@test.com',
                                            'state' => 'Karnataka'
                                            },
                                                new Map<String, Object>{
                                                    'seekerid' => '2',
                                                        'fname' => 'Existing',
                                                        'lname' => 'Lead',
                                                        'Email' => 'existing@test.com',
                                                        'state' => 'Delhi'
                                                        }
                                }
            }
        );
        
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/MonsterCleverTapIntegration/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonBody);
        
        RestContext.request = req;
        
        Test.startTest();
        String response = MonsterCleverTapIntegration.doPost();
        Test.stopTest();
        
        System.assertEquals('Success', response);
        
        Account inserted = [
            SELECT Id, Email__c, OwnerId, AssignmentReason__c
            FROM Account
            WHERE Email__c = 'newlead@test.com'
            LIMIT 1
        ];
        
        System.assertEquals('newlead@test.com', inserted.Email__c);
        System.assertEquals(u1.Id, inserted.OwnerId);
        System.assertEquals('STATE_USER', inserted.AssignmentReason__c);
        
        Account updated = [
            SELECT Id, Email__c
            FROM Account
            WHERE Email__c = 'existing@test.com'
            LIMIT 1
        ];
        
        System.assertEquals(existingAcc.Id, updated.Id);
    }
}