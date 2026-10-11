@isTest(SeeAllData = true) public class deleteTaskBatchTest {
    @isTest public static void startTest(){
        deleteTaskBatch BAD = new deleteTaskBatch();
        DataBase.executeBatch(BAD,200); 
    }
}