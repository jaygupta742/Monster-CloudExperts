//Created By : Abdul Aziz , Created Date : 30/01/2024 , Description : Create Apac Payment From Quote
public with sharing class AddApacPaymentQuoteLWC {
    @AuraEnabled(cacheable=true)
    public static QuotesN__c GetOrderDetails(String recordId){
        try {
            QuotesN__c OrderDetails = [SELECT Id, Name, Net_Total__c, CurrencyIsoCode FROM QuotesN__c WHERE Id =: recordId];
            return OrderDetails;
        } catch (Exception e) {
            System.debug('Get Quote Details error message: ' + e.getMessage());
            System.debug('Get Quote Details error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string SaveAPACPayments(String recordId, String PaymentItems) {
        try {
            List<APAC_Payments__c> lstAPACPayments = (List<APAC_Payments__c>) JSON.deserialize(PaymentItems, List<APAC_Payments__c>.class);
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