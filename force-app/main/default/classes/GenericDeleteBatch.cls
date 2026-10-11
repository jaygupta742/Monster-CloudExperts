public class GenericDeleteBatch implements Database.Batchable<SObject> {

    String query;

    // Constructor that takes a dynamic SOQL query
    public GenericDeleteBatch(String soqlQuery) {
        this.query = soqlQuery;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        delete scope;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Delete Finished');
    }
}