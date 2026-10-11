global class BatchApexForContactRT implements Database.Batchable<sObject>, Database.Stateful{
    
     Id ActiveRT = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Monster Read Only RT').getRecordTypeId();
     Id InActiveRT = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('For Monster RT').getRecordTypeId();

    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'select id,RecordTypeId,Lastname,FirstName,Ownerid,AccStatus__c,Channel__c,Comment__c,LastModifiedById,CreatedById,CreatedDate from Contact';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Contact> scope){
        list<Contact> con = new list<Contact>();
        for(Contact c:scope){
            if(c.AccStatus__c == 'Inactive' || c.AccStatus__c=='Rejected'){
                c.RecordTypeId = InActiveRT;
            } 
            else if(c.AccStatus__c == 'Active'){
                c.RecordTypeId = ActiveRT;
            }
            con.add(c);
        }
        Update con;
    }
    global void finish(Database.BatchableContext BC){
        system.debug('aaaaaaaaaaaaa');
    }
}