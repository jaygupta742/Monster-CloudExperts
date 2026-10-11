@isTest(SeeAllData = true) public class genericHardDeleteBatchTest {
    @isTest public static void startTest(){
        genericHardDeleteBatch BAD = new genericHardDeleteBatch('SELECT id FROM Account_Team_Member__c LIMIT 100 ');
        DataBase.executeBatch(BAD,200); 
    }
}