public class SeekerOrders_EditAllApacPayments {
    @AuraEnabled(cacheable=true)
    public static String GetOrderDetails(String recordId){
        try {
            Seeker_Order__c OrderDetails = [SELECT Id, Name, Net_Total__c, CurrencyIsoCode FROM Seeker_Order__c WHERE Id =: recordId];

            List<APAC_Payment_Seeker__c> lstAPACPayments = new List<APAC_Payment_Seeker__c>();
            lstAPACPayments = [SELECT Id, Name, Seeker_Order__c, Due_Date__c, Payment_Amount__c, Payment_Received_Amount__c, Payment_Date__c, Payment_Type__c 
            FROM APAC_Payment_Seeker__c WHERE Seeker_Order__c =: recordId ORDER BY Name ASC];

            Map<String, Object> mapResponse = new Map<String, Object> ();
            mapResponse.put('Order', OrderDetails);
            mapResponse.put('APACPayment', lstAPACPayments);


            return JSON.serialize(mapResponse);
        } catch (Exception e) {
            System.debug('Get Order Details error message: ' + e.getMessage());
            System.debug('Get Order Details error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string UpdatePaymentItems(String recordId, String PaymentItems) {
        try {
            Seeker_Order__c OrderDetails = [SELECT Id, Name, Net_Total__c, CurrencyIsoCode FROM Seeker_Order__c WHERE Id =: recordId];

            List<APAC_Payment_Seeker__c> lstEAPACPayments = new List<APAC_Payment_Seeker__c>();
            lstEAPACPayments = [SELECT Id, Name, Seeker_Order__c, Due_Date__c, Payment_Amount__c, Payment_Received_Amount__c, Payment_Date__c, Payment_Type__c 
            FROM APAC_Payment_Seeker__c WHERE Seeker_Order__c =: recordId ORDER BY Name ASC];

            List<APAC_Payment_Seeker__c> lstUAPACPayments = (List<APAC_Payment_Seeker__c>) JSON.deserialize(PaymentItems, List<APAC_Payment_Seeker__c>.class);

            Map<String, APAC_Payment_Seeker__c> mapUAPACPayments = new Map<String, APAC_Payment_Seeker__c> ();
            for(APAC_Payment_Seeker__c item : lstUAPACPayments) {
                mapUAPACPayments.put(item.Id, item);
            }

            List<APAC_Payment_Seeker__c> lstUpdatedItems = new List<APAC_Payment_Seeker__c> ();
            List<APAC_Payment_Seeker__c> lstDeletedItems = new List<APAC_Payment_Seeker__c> ();
            

            for(APAC_Payment_Seeker__c item : lstEAPACPayments) {
                if(mapUAPACPayments.containsKey(item.Id)) lstUpdatedItems.add(mapUAPACPayments.get(item.Id));
                else lstDeletedItems.add(item);
            }

            Delete lstDeletedItems;
            Update lstUpdatedItems;
            return 'success';
        } catch (Exception e) {
            System.debug('Update Payment Items error message: ' + e.getMessage());
            System.debug('Update Payment Items error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
    

}