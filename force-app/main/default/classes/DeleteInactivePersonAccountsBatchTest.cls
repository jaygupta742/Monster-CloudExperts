@isTest(SeeAllData = true) public class DeleteInactivePersonAccountsBatchTest {
    
    @isTest public static void test1(){
        DeleteInactivePersonAccountsBatch batch = new DeleteInactivePersonAccountsBatch();
        Database.executeBatch(batch, 200); 
        
    }
}