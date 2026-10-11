public with sharing class SeekerOrders_AddProducts_cls {
    @AuraEnabled(cacheable=true)
    public static List<ProductC__c> GetAllProducts(){
        try {
            List<ProductC__c> lstProducts = [SELECT Id, Name, Product_Name__c, SKU_Type__c, Product_Description__c, Product_Country__c, Active__c, Channel__c,
                                             DB_Scope_Geography__c, DB_Type_Industry__c, Tenure_Months__c, Bin__c, Unit_List_Price_Value__c, Product_Type__c, CurrencyIsoCode, Credit__c
                                             FROM ProductC__c WHERE Channel__c = 'Seeker-Ed Sales' AND Active__c = TRUE ORDER BY Name ASC];
            
            return lstProducts;
        } catch (Exception e) {
            System.debug('@@ GetAllProducts error message : ' + e.getMessage());
            System.debug('@@ GetAllProducts error line number : ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static string SaveProducts(String recordId, String ProductDetails) {
        try {
            List<Object> lstProductDetails = (List<Object>) JSON.deserializeUntyped(ProductDetails);
            List<Seeker_Order_Line_Item__c> lstOrderItems = new List<Seeker_Order_Line_Item__c> ();
            
            for(Object item : lstProductDetails) {
                System.debug(item);
                Map<String, Object> mapItem = (Map<String, Object>) item;
                System.debug('Product Name : ' + mapItem.get('Product_Name__c'));
                
                Seeker_Order_Line_Item__c SeekerOrders = new Seeker_Order_Line_Item__c();
                SeekerOrders.Seeker_Order__c = recordId;
                if(mapItem.containsKey('Start_Date__c') && mapItem.get('Start_Date__c') != null) SeekerOrders.Start_Date__c = Date.valueOf((String) mapItem.get('Start_Date__c'));
                if(mapItem.containsKey('End_Date__c') && mapItem.get('End_Date__c') != null) SeekerOrders.End_Date__c = Date.valueOf((String) mapItem.get('End_Date__c'));
                SeekerOrders.Product_No__c = (Id) mapItem.get('Id');
                SeekerOrders.Quantity__c = 1;
                if(mapItem.containsKey('Unit_List_Price_Value__c') && mapItem.get('Unit_List_Price_Value__c') != null) SeekerOrders.Unit_Price__c = (Decimal) mapItem.get('Unit_List_Price_Value__c');
                
                if(mapItem.containsKey('Discount__c') && mapItem.get('Discount__c') != null) SeekerOrders.Discount__c = Decimal.valueOf((String) mapItem.get('Discount__c'));
                if(mapItem.containsKey('Subvention_Cost__c') && mapItem.get('Subvention_Cost__c') != null) SeekerOrders.Subvention_Cost__c = Decimal.valueOf((String) mapItem.get('Subvention_Cost__c'));
                if(mapItem.containsKey('Commission__c') && mapItem.get('Commission__c') != null) SeekerOrders.Commission__c = 100 * (Decimal) mapItem.get('Commission__c');
                
                lstOrderItems.add(SeekerOrders);
            }
            Insert lstOrderItems;
            return 'success';
        } catch (Exception e) {
            System.debug('Save Products error message : ' + e.getMessage());
            System.debug('Save Products error line number : ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}