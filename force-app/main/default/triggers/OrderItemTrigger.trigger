/*Created by : Abdul Aziz , Created Date : 07/07/2023 , Description : OrderItemTrigger trigger to update service start date and end date*/

trigger OrderItemTrigger on Order_Item__c (after insert, after update, after delete) {
    Trigger__c t = trigger__c.getvalues('OrderItem');
    if(t.active__C == true) {
        // if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        if(Trigger.isAfter && Trigger.isInsert ) {
            //  if(OrderItemTriggerHelper.isFirstRun){
            //  OrderItemTriggerHelper.isFirstRun=false;
            OrderItemTriggerHelper.updateCredits(Trigger.New);
            // }
        }
        
        if(Trigger.isAfter && Trigger.isUpdate) {
            // if(OrderItemTriggerHelper.isFirstRun){
            //   OrderItemTriggerHelper.isFirstRun=false;
            OrderItemTriggerHelper.updateServiceStartDate(Trigger.New);
            OrderItemTriggerHelper.updateServiceEndDate(Trigger.New);
            OrderItemTriggerHelper.updateCredits(Trigger.New);
            // }
        } 
        
        
        if(Trigger.isAfter && Trigger.isDelete) {
            OrderItemTriggerHelper.updateCredits(Trigger.Old);
        }
    }
    
}