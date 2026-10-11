/*
Last Modified By : Abdul Aziz , Date : 25/08/2023 , Description : Added Order Rollup Concept
*/
trigger OrderJobApexSharing on Order__c (before Insert, after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        if(OrderJobApexSharingHelper.isFirstRun){
            OrderJobApexSharingHelper.isFirstRun=false;
            if(Trigger.isInsert) OrderJobApexSharingHelper.shareOrderRevamp(Trigger.New);    
            if(Trigger.isUpdate) OrderJobApexSharingHelper.shareOrderWithSharedPerson(Trigger.New, Trigger.Old); 
        }
    }
    
    //This method will prevent duplicate orders for a perticular Quote
    if(Trigger.isBefore && Trigger.isInsert){
        OrderJobApexSharingHelper.preventDuplicateOrders(Trigger.New);
    }
}