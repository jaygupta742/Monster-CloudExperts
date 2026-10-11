@isTest(SeeAllData = true) public class restorePersonAccountBatchTest {
    @isTest public static void startTest(){
        restorePersonAccountBatch BAD = new restorePersonAccountBatch();
        DataBase.executeBatch(BAD,200); 
    }
}