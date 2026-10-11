public class UpdateOrderBatch implements Database.Batchable<SObject>, Schedulable {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        if(!Test.isRunningTest()){
            return Database.getQueryLocator('SELECT Id, Status__c FROM Order__c');
        } else {
            return Database.getQueryLocator('SELECT Id, Status__c FROM Order__c LIMIT 1');
        }
    }
    
    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        Database.update(scope, false);
    }
    
    public void finish(Database.BatchableContext bc) {
        // Optional: Add any logic to run after batch finishes
    }

    // Scheduler method
    public void execute(SchedulableContext sc) {
        UpdateOrderBatch batch = new UpdateOrderBatch();
        Database.executeBatch(batch, 2); 
    }
}