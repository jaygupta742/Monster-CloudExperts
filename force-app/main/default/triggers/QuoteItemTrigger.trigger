//Created By : Abdul Aziz , Date : 01/11/2023  Description : Sales Credit Rollup Trigger
//Last Modifecd by : Abdul Aziz , Date : 14/12/2023 , Description : Added updateFreeTrialProduct();
trigger QuoteItemTrigger on Quote_Line_Items__c (after insert, after update, after delete) {
    if(Trigger.isAfter && Trigger.isInsert ) {
        QuoteItemTriggerHelper.RollUpAfterInsert(Trigger.New);
        QuoteItemTriggerHelper.updateFreeTrialProduct(Trigger.New);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        QuoteItemTriggerHelper.RollUpAfterInsert(Trigger.New);
        QuoteItemTriggerHelper.updateFreeTrialProduct(Trigger.New);
    } 
    
    if(Trigger.isAfter && Trigger.isDelete) {
        QuoteItemTriggerHelper.RollUpAfterInsert(Trigger.Old);
    }
}