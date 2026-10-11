public class Negate_Order {
    @AuraEnabled
    Public static boolean negate(id recordId){
        OrderC__c order = new OrderC__c();
        order = [select OrderStatus__c,Change_Type__c from OrderC__c where id =: recordId];
        if(order.OrderStatus__c != 'Rejected' || order.Change_Type__c == ''){
            return true;
        }
        else{
            order.OrderStatus__c = 'Negated';
            update order;
            return false;
        }
    }
}