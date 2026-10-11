public with sharing class seekerOrder_AddApacPayments_cls {
    @AuraEnabled(cacheable=true)
    public static Seeker_Order__c GetOrderDetails(String recordId){
        try {
            Seeker_Order__c OrderDetails = [SELECT Id, Name, Net_Total__c, CurrencyIsoCode FROM Seeker_Order__c WHERE Id =: recordId];
            return OrderDetails;
        } catch (Exception e) {
            System.debug('Get Order Details error message: ' + e.getMessage());
            System.debug('Get Order Details error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string SaveAPACPayments(String recordId, String PaymentItems) {
        try {
            List<APAC_Payment_Seeker__c> lstAPACPayments = (List<APAC_Payment_Seeker__c>) JSON.deserialize(PaymentItems, List<APAC_Payment_Seeker__c>.class);
            System.debug('Payment Items size : ' + lstAPACPayments.size());

            Insert lstAPACPayments;
            return 'success';
        } catch (Exception e) {
            System.debug('Save APAC Payments error message: ' + e.getMessage());
            System.debug('Save APAC Payments error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}