/**
 * @File Name          : Finalize.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 18/3/2019, 4:22:08 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    18/3/2019, 2:45:33 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public class Finalize {
    @AuraEnabled
    public static apttus_proposal_proposal__c getRecord(Id quoteId){
        apttus_proposal_proposal__c quote = new apttus_proposal_proposal__c();
        quote = [select Net_Total__c,Payment_Net_Total__c,Approval_Status__c,RecordTypeId from apttus_proposal_proposal__c where id =: quoteId limit 1 ];
        system.debug('Approval  '+quote.Approval_Status__c+ ' quote.Approval_Status__c  '+quote.Net_Total__c+' APAC payment '+quote.Payment_Net_Total__c);
        if((quote.Approval_Status__c == 'No Need Of Approval' || quote.Approval_Status__c == 'Ready To Finalize') &&  (quote.Net_Total__c == quote.Payment_Net_Total__c)){
            quote.Approval_Status__c = 'Finalized';
            quote.RecordTypeId = Schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('after finalize').getRecordTypeId();
            update quote;
        }
        return quote;
    }
}