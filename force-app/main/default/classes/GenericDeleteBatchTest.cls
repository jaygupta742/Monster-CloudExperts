@isTest(SeeAllData = true) public class GenericDeleteBatchTest {
    @isTest public static void startTest(){
        GenericDeleteBatch BAD = new GenericDeleteBatch('SELECT id FROM Account_Team_Member__c LIMIT 100');
        DataBase.executeBatch(BAD,200); 
    }
}