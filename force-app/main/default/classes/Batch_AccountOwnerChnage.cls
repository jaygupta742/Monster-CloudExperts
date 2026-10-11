global class Batch_AccountOwnerChnage implements Database.batchable<sObject>, Database.stateful, Schedulable {
    global Integer updatedrecord = 0;
    global List<Account> acclist2;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select id, Name, OwnerId, owner.Isactive, Owner.ManagerId from Account Where owner.Isactive = false and owner.Profile.Name = 'Monster - Sales' ]);
    }
    global void execute(Database.BatchableContext bc, List<Account> acclist){
        for(Account acc : acclist){
            system.debug('acclist'+acc.name);
            if(acc.OwnerId != null && acc.owner.Isactive == false){
                // Retrieve the manager of the inactive owner
                Id managerId = acc.Owner.ManagerId;
                system.debug('manger'+acc.Owner.ManagerId);
                // Update the owner of the Account record to the manager if the manager is present
                if(acc.Owner.ManagerId != null){
                    acc.OwnerId = managerId;
                    system.debug('check ownerId'+acc.OwnerId);
                    //  acclist2.add(acc);
                }
            }
        }
        //acclist2 = acclist;
        //update acclist;
        if(!Test.isRunningTest()){
            Database.update(acclist, false);
        }
        //updatedrecord = updatedrecord + acclist.size();
        
    }
    
    global void execute(SchedulableContext context){
        Batch_AccountOwnerChnage batchJob = new Batch_AccountOwnerChnage();
        Database.executeBatch(batchJob,1);
    }
    
    global void finish(Database.BatchableContext bc){
        //system.debug('in finished'+acclist2.size());
        //update acclist2;
        System.debug('Job finished');
    }
}