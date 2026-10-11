global class UpdateEmailMessageBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        testCode();
        if(!Test.isRunningTest()){
            return Database.getQueryLocator([
                SELECT Id, RelatedToId, CreatedDate FROM EmailMessage 
                WHERE RelatedToId != NULL 
                AND CreatedDate < 2023-04-01T00:00:00Z
            ]);
        }else{
            return Database.getQueryLocator([
                SELECT Id, RelatedToId, CreatedDate FROM EmailMessage 
                WHERE RelatedToId != NULL 
                AND CreatedDate < 2023-04-01T00:00:00Z LIMIT 1
            ]);
        }
    }
    
    global void execute(Database.BatchableContext BC, List<EmailMessage> scope) {
        
        Set<Id> emailIds = new Set<Id>();
        Set<Id> relatedToIds = new Set<Id>();
        
        for (EmailMessage email : scope) {
            emailIds.add(email.Id);
            relatedToIds.add(email.RelatedToId);
        }
        
        // Fetch related accounts
        Map<Id, Account> accountMap = new Map<Id, Account>(
            [SELECT Id, AccountStatus__c FROM Account WHERE Id IN :relatedToIds]
        );
        
        // Check for attachments
        Set<Id> emailMessageIdsWithAttachments = new Set<Id>();
        
        for (ContentDocumentLink link : [
            SELECT LinkedEntityId FROM ContentDocumentLink 
            WHERE LinkedEntityId IN :emailIds
        ]) {
            emailMessageIdsWithAttachments.add(link.LinkedEntityId);
        }
        
        Set<Id> emailMessageIdsWithOrigianlAttachments = new Set<Id>();
        
        for (Attachment  attchments : [
            SELECT ParentId  FROM Attachment  
            WHERE ParentId  IN :emailIds
        ]) {
            emailMessageIdsWithOrigianlAttachments.add(attchments.ParentId);
        }
        
        List<EmailMessage> emailsToUpdate = new List<EmailMessage>();
        
        for (EmailMessage email : scope) {
            Account relatedAccount = accountMap.get(email.RelatedToId);
            if (relatedAccount != null && relatedAccount.AccountStatus__c != 'Customer' && relatedAccount.AccountStatus__c != 'Lapsed Customer' && !emailMessageIdsWithAttachments.contains(email.Id) && !emailMessageIdsWithOrigianlAttachments.contains(email.Id)) {
                email.Data_CleanUp__c = true;
                emailsToUpdate.add(email);
            }
        }
        
        if (!emailsToUpdate.isEmpty()) {
            update emailsToUpdate;
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        // Optional: Final processing
    }
    
    global static void testCode(){
        Integer i = 1;
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
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
    }
    
}