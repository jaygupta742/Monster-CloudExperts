@isTest(SeeAllData = true) public class DeleteAllEmailRecordsBatchTest {

    @isTest public static void testin(){
        Database.executeBatch(new DeleteAllEmailRecordsBatch(),200);
    }
    
}