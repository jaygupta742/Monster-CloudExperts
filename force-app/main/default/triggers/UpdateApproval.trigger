trigger UpdateApproval on QuotesN__c (before insert, before update, after insert, after update) {
    if(Trigger.isInsert && Trigger.isBefore) {
        System.debug('Quote Trigger running before insert');
        if(UpdateApproval_helper.Flag_BeforeInsert) UpdateApproval_helper.HandleBeforeInsert(Trigger.New);
    }
    if(Trigger.isInsert && Trigger.isAfter) {
        System.debug('Quote Trigger running after insert');
        if(UpdateApproval_helper.Flag_AfterInsert) UpdateApproval_helper.HandleAfterInsert(Trigger.New);
    }
    if(Trigger.isUpdate && Trigger.isBefore) {
        System.debug('Quote Trigger running before update');
        if(UpdateApproval_helper.Flag_BeforeUpdate) UpdateApproval_helper.HandleBeforeUpdate(Trigger.New, Trigger.Old);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        System.debug('Quote Trigger running after update');
        if(UpdateApproval_helper.Flag_AfterUpdate) UpdateApproval_helper.HandleAfterUpdate(Trigger.New, Trigger.Old);
    }
}