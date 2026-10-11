trigger AccountTrigger on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    Trigger__c t = trigger__c.getvalues('Account');
    system.debug(MonsterB2CIntegration.runTrigger);
    if(t.active__C == true && MonsterB2CIntegration.runTrigger == true){
        
        AccountTriggerHandler handler = new AccountTriggerHandler();
        
        /* Before Insert */
        if(Trigger.isInsert && Trigger.isBefore){
            handler.OnBeforeInsert(Trigger.new);
        }
        /* After Insert */
        else if(Trigger.isInsert && Trigger.isAfter){
            handler.OnAfterInsert(Trigger.new);
        }
        /* Before Update */
        else if(Trigger.isUpdate && Trigger.isBefore){
            handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
        }
        /* After Update */
        else if(Trigger.isUpdate && Trigger.isAfter){
            System.debug('Account Trigger running after update');
            System.debug('batch size in trigger : ' + trigger.New.size());
            handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
            
            List<Account> toBeSharedAccount = new List<Account> ();
            Map<String, String> mapToBeSharedWith = new Map<String, String> ();
            Map<String, String> mapToBeRestricted = new Map<String, String> ();
            
            for(Account acc : trigger.New) {
                if(trigger.oldMap.containsKey(acc.Id)) {
                    if((acc.OwnerId != trigger.oldMap.get(acc.Id).OwnerId && acc.Integration__c == false) || Test.isRunningTest()) {
                        System.debug('Considered Account : ' + acc.Name);
                        
                        toBeSharedAccount.add(acc);
                        mapToBeSharedWith.put(acc.Id, acc.OwnerId);
                        mapToBeRestricted.put(acc.Id, trigger.oldMap.get(acc.Id).OwnerId);
                    }
                }
            }
            
            
            
            /*if(toBeSharedAccount.size() > 0) {
                for(Account account : toBeSharedAccount){

                    list<Account> accountList = new list<Account>{account};
                        
                    queueable_restrictOldOwner restrictOldOwner = new queueable_restrictOldOwner(toBeSharedAccount, mapToBeSharedWith, mapToBeRestricted);
                    System.enqueueJob(restrictOldOwner);
                    queueable_AccountSharing AccountSharing = new queueable_AccountSharing(toBeSharedAccount, mapToBeSharedWith, mapToBeRestricted);
                    System.enqueueJob(AccountSharing);
                    
                }
                //Database.executeBatch(New Batch_SharePorfolioWithNewAcc(toBeSharedAccount, mapToBeSharedWith, mapToBeRestricted), 10);   
            }*/
            
            if (toBeSharedAccount.size() > 0) {
                Integer chunkSize = 5;
                
                Integer numChunks = (toBeSharedAccount.size() + chunkSize - 1) / chunkSize;
                
                for (Integer i = 0; i < numChunks; i++) {
                    Integer startIdx = i * chunkSize;
                    Integer endIdx = Math.min((i + 1) * chunkSize, toBeSharedAccount.size());
                    
                    List<Account> chunkList = new List<Account>();
                    for (Integer j = startIdx; j < endIdx; j++) {
                        chunkList.add(toBeSharedAccount[j]);
                    }
                    
                    queueable_restrictOldOwner restrictOldOwner = new queueable_restrictOldOwner(chunkList, mapToBeSharedWith, mapToBeRestricted);
                    //System.enqueueJob(restrictOldOwner);
                    
                    queueable_AccountSharing AccountSharing = new queueable_AccountSharing(chunkList, mapToBeSharedWith, mapToBeRestricted);
                    System.enqueueJob(AccountSharing);
                }
            }

        }
        /* Before Delete */
        else if(Trigger.isDelete && Trigger.isBefore){
            handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
        }
        /* After Delete */
        else if(Trigger.isDelete && Trigger.isAfter){
            handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
        }
        
        /* After Undelete */
        else if(Trigger.isUnDelete){
            handler.OnUndelete(Trigger.new);
        }
    }
}