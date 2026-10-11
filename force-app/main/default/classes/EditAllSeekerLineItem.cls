/* 
Created By : Suraj
Created date 26/12/2023
Created For : This is apex class use for edit all Seeker Order Line Item 
*/ 
public class EditAllSeekerLineItem {
    @AuraEnabled(cacheable=true)
    public static string getAllLineItem(String recordId) {
        try {
            system.debug('@@ recordId: ' + recordId);
            List<Seeker_Order_Line_Item__c> lstOrderItems = new List<Seeker_Order_Line_Item__c>();
            lstOrderItems = [SELECT Id, Name, Seeker_Order__c, Commission__c, Product_No__c, Product_Name__c, Product_Tenure__c, SKU_Type__c,
                             Discount__c, Quantity__c, Unit_Price__c, Subvention_Cost__c, Base_Total__c, Gross_Total__c,
                             Product_Description__c, Selling_Fee__c, Start_Date__c, End_Date__c, CurrencyIsoCode
                             FROM Seeker_Order_Line_Item__c WHERE Seeker_Order__c =: recordId];
            
            return JSON.serialize(lstOrderItems);
        } catch(Exception e) {
            system.debug('@@ Get All LineItems error message : ' + e.getMessage());
            system.debug('@@ Get All LineItems error line number : ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string UpdateOrderItems(String recordId, String OrderItems){
        try {
            List<Seeker_Order_Line_Item__c> lstEOrderItems = new List<Seeker_Order_Line_Item__c>();
            lstEOrderItems = [SELECT Id, Name, Seeker_Order__c, Commission__c, Product_No__c, Product_Name__c, Product_Tenure__c, SKU_Type__c,
                              Discount__c, Quantity__c, Unit_Price__c, Subvention_Cost__c, Base_Total__c, Gross_Total__c,
                              Product_Description__c, Selling_Fee__c, Start_Date__c, End_Date__c, CurrencyIsoCode
                              FROM Seeker_Order_Line_Item__c WHERE Seeker_Order__c =: recordId];
            
            List<Seeker_Order_Line_Item__c> lstUOrderItems = (List<Seeker_Order_Line_Item__c>) JSON.deserialize(OrderItems, List<Seeker_Order_Line_Item__c>.class);
            
            Map<String, Seeker_Order_Line_Item__c> mapUOrderItems = new Map<String, Seeker_Order_Line_Item__c> ();
            for(Seeker_Order_Line_Item__c item : lstUOrderItems) {
                mapUOrderItems.put(item.Id, item);
            }
            
            List<Seeker_Order_Line_Item__c> lstUpdatedItems = new List<Seeker_Order_Line_Item__c> ();
            List<Seeker_Order_Line_Item__c> lstDeletedItems = new List<Seeker_Order_Line_Item__c> ();
            
            
            for(Seeker_Order_Line_Item__c item : lstEOrderItems) {
                if(mapUOrderItems.containsKey(item.Id)) lstUpdatedItems.add(mapUOrderItems.get(item.Id));
                else lstDeletedItems.add(item);
            }
            
            Delete lstDeletedItems;
            Update lstUpdatedItems;
            return 'success';
        } catch (Exception e) {
            system.debug('@@ Update Order Items error message : ' + e.getMessage());
            system.debug('@@ Update Order Items error line number : ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}