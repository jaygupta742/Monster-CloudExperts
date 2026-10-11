trigger CVRtrigger on Client_Validation_Request__c (Before insert,Before Update) {

    Trigger__c t = Trigger__c.getvalues('CVR');
    if(t.Active__c){
        CVRHandler CVRH = new CVRHandler();
            CVRH.OnBeforeInsertandUpdate(Trigger.new);
         
    }
    
}