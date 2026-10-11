public class ActivateServices {

    @AuraEnabled
    public static string ActivateServicenow(string rid){
        Order__c oo=[select id,name,Status__c,ownerid,Account__c,Account__r.Name,Account__r.AccountID__c,Sales_Channel__c,Order_Type__c,Gross_Total__c,
                     Contact__r.name,Contact__r.email,Contact__r.mobilephone,Comments__c from Order__c where id=:rid];
        
        List<Order_Item_Services__c> oli=[select id,name,Status__c,Order__c from Order_Item_Services__c where Order__c=:rid];
        User uu=[select id,name,email,manager.email from User where id=:oo.OwnerId];
        
        oo.Status__c='Active';
        update oo;
        
        for(Order_Item_Services__c o:oli){
            o.Status__c='Active';
        }
        
        update oli;
        
        return rid;
    }
}