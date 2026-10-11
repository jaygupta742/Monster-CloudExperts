@isTest(SeeAllData = true) public class UpdateLastActivityUsingTaskBatchTest {
    
    @isTest public static void test1(){
        Database.executeBatch(new UpdateLastActivityTaskBatch(),200);
    }
    
}