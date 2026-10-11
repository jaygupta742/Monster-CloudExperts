trigger ContactTrigger on Contact (after insert, after update, after delete) {
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            contactTriggerHandler.handleContactRoolupToAccount(Trigger.New, null, null, 'Insert');
        } else if (Trigger.isUpdate) {
            contactTriggerHandler.handleContactRoolupToAccount(Trigger.New, Trigger.Old, Trigger.oldMap, 'Update');
        } else if (Trigger.isDelete) {
            contactTriggerHandler.handleContactRoolupToAccount(null, Trigger.Old, null, 'Delete');
        }
    }
}