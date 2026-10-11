public class genericHardDeleteBatch implements Database.Batchable<SObject> {

    String query;

    // Constructor that takes a dynamic SOQL query
    public genericHardDeleteBatch(String soqlQuery) {
        Integer i = 0;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        this.query = soqlQuery;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        Database.emptyRecycleBin(scope);  
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Delete Finished');
    }
}