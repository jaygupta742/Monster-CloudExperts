@isTest(SeeAllData = true) public class DeleteOldEmailsBatchTest {
    
    @isTest public static void test1(){
        Database.executeBatch(new DeleteOldEmailsBatch(), 200);
    }
    
}