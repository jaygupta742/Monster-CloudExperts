@isTest(SeeAllData = true) public class UpdateEmailMessageBatchTest {
    
    @isTest public static void startTest(){
        UpdateEmailMessageBatch batch = new UpdateEmailMessageBatch();
        Database.executeBatch(batch, 1);       
    }
    
}