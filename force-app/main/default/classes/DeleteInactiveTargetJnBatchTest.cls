@isTest(SeeAllData = true) public class DeleteInactiveTargetJnBatchTest {
    
    @isTest public static void test1(){
        DeleteInactiveTargetJnBatch batch = new DeleteInactiveTargetJnBatch();
        Database.executeBatch(batch, 200); 
        
    }
}