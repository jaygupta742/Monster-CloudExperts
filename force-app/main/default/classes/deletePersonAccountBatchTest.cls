@isTest(SeeAllData = true) public class deletePersonAccountBatchTest {
    @isTest public static void startTest(){
        deletePersonAccountBatch BAD = new deletePersonAccountBatch();
        DataBase.executeBatch(BAD,200); 
    }
}