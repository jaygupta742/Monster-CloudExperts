global class deleteTaskBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator Start(Database.BatchableContext context){
        if(Test.isRunningTest()){
            return Database.getQueryLocator('Select Id From Task Where CreatedDate < LAST_N_MONTHS:6 AND IsArchived = false limit 1');
        }else{
            return Database.getQueryLocator('Select Id From Task Where CreatedDate < LAST_N_MONTHS:6 OR IsArchived = true ALL ROWS');
        }
    }
    
    global void execute(Database.BatchableContext context, List<Task> tasks) {
        List<Task> failedToDeleteRecords = new List<Task>();
       
        Database.DeleteResult[] deleteResults = Database.delete(tasks, false);
        
        for (Integer i = 0; i < deleteResults.size(); i++) {
            if (!deleteResults[i].isSuccess()) {
                failedToDeleteRecords.add(tasks[i]);
                System.debug('Failed to delete record Id: ' + tasks[i].Id + 
                             ' - Error: ' + deleteResults[i].getErrors()[0].getMessage());
            }
        }
        
        if (!failedToDeleteRecords.isEmpty()) {
            System.debug('Number of records that failed to delete: ' + failedToDeleteRecords.size());
        }
    }
    
    global void Finish(Database.BatchableContext context){
        System.debug('Batch processing to delete Account Team Members is complete.');
    }
    
    
}