@isTest(SeeAllData = true) public class UpdateOrderBatchTest {
    
    @isTest public static void test1(){
        Test.startTest();
        String cron = '0 0 2 * * ?'; // Daily at 2 AM
        System.schedule('Test UpdateOrderBatch Job', cron, new UpdateOrderBatch());
        Test.stopTest();
    }
    
}