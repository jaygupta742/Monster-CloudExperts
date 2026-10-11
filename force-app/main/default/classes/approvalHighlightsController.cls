public with sharing class approvalHighlightsController {
    @AuraEnabled(cacheable = true)
    public static list<Approval_Highlights_Condition__c> getConditions(){
        try{
            return [SELECT Name, Value__c, Channel__c, HighLight_Type__c FROM Approval_Highlights_Condition__c];
        } catch ( Exception e ) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String GetProcessDetails(String recordId){
        try {
            String objectApiName;
            Id sObjectId = Id.valueOf(recordId);
            if (sObjectId != null) {
                objectApiName = sObjectId.getSObjectType().getDescribe().getName();
                System.debug('Object API Name: ' + objectApiName);
            } else {
                System.debug('Invalid Record Id');
            }
            Id relatedTo;
            if(objectApiName == 'ProcessInstanceWorkitem'){ 
                ProcessInstanceWorkitem PIWI  = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId, OriginalActorId, OriginalActor.Name, ActorId, Actor.Name 
                                                 FROM ProcessInstanceWorkitem WHERE Id =: recordId];  
                relatedTo = PIWI.ProcessInstance.TargetObjectId;
            }
            else if(objectApiName =='ProcessInstanceStep'){
                ProcessInstanceStep PIWI =[SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId,OriginalActorId, StepStatus, ActorId, Comments, StepNodeId, ElapsedTimeInDays, ElapsedTimeInMinutes, ElapsedTimeInHours, 
                                           CreatedDate, CreatedById, SystemModstamp FROM ProcessInstanceStep where Id =: recordId];
                
                relatedTo = PIWI.ProcessInstance.TargetObjectId;
            }
            String TargetObjectApiName = relatedTo.getSObjectType().getDescribe().getName();

            Map<String, String> mapResponse = new Map<String, String> ();
            mapResponse.put('recordId', relatedTo);
            mapResponse.put('objectApiName', TargetObjectApiName);

            return JSON.serialize(mapResponse);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage() + ' at ' + e.getLineNumber());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<ProcessInstanceStep> FetchApprovalHistory(String QuoteId) {
        try {
            List<ProcessInstanceStep> lstApprovalHistory = [SELECT Id, ProcessInstanceId, OriginalActorId, StepStatus, ActorId, Actor.Name, Comments, CreatedDate FROM ProcessInstanceStep WHERE ProcessInstance.TargetObjectId =: QuoteId ORDER BY CreatedDate DESC];
            return lstApprovalHistory;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @auraEnabled(cacheable=true)
    public static List<ContentDocumentLink> FetchAttachmentsFromQuote(String recordId){
        system.debug(recordId);
        return [SELECT  ContentDocument.title,ContentDocumentId,ContentDocument.FileType,ContentDocument.ContentModifiedDate,ContentDocument.Owner.Name,ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId =: recordId];
    }
}