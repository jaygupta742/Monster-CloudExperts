global class Schedulable_AccountProcessorDaily implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<Account> acclist = [select id, Name, OwnerId, owner.Isactive, Owner.ManagerId, owner.Profile.Name, 
                                 owner.ProfileId from Account Where owner.Isactive = false AND owner.Profile.Name = 'Monster - Sales'  ORDER BY Name ASC LIMIT 5000];
        for(Account acc : acclist){
            if(acc.OwnerId != null && acc.owner.Isactive == false && acc.owner.Profile.Name == 'Monster - Sales'){
                // Retrieve the manager of the inactive owner
                Id managerId = acc.Owner.ManagerId;
                
                // Update the owner of the Account record to the manager if the manager is present
                if(acc.Owner.ManagerId != null){
                    acc.OwnerId = managerId; 
                }
            }
        }
        // Update the modified Account records
        update acclist;
    }
}