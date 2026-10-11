@isTest(SeeAllData = true) public class OrderShareBatchTest {
    
   @isTest public static void OrderShareBatchTest(){
        OrderShareBatch batch = new OrderShareBatch([SELECT Id From User WHere isActive = true LIMIT 1].Id);
        Database.executeBatch(batch, 200); 
    }
    
}