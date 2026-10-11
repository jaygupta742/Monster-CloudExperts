public with sharing class restrictOldOwner {
    @InvocableMethod(label='Restrict Old Account Owner' description='Restrict to view records for old Account Owner')
    public static void undoShareRecords(List<FlowInputs> requests) {
        try {
            System.debug('restrictOldOwner.undoShareRecords is running'); 
        
            system.debug('request size : ' + requests.size());
        
            if(requests.size() == 0) return;
            
            Set<Id> accId = new Set<Id> ();
            Set<Id> setOwnerId = new Set<Id> ();
            Map<Id, Id> mapAccOwner = new Map<Id, Id> ();
            for(FlowInputs item : requests) {
                accId.add(item.ParentId);
                setOwnerId.add(item.OwnerId);

                mapAccOwner.put(item.ParentId, item.OwnerId);   
            }

            List<OpportunityN__c> lstOpportunity = [SELECT Id, Name, Account__c, OwnerId FROM OpportunityN__c WHERE Account__c IN: accId AND OwnerId NOT IN: setOwnerId];
            List<QuotesN__c> lstQuote = [SELECT Id, Name, Account__c FROM QuotesN__c WHERE Account__c IN: accId AND OwnerId NOT IN: setOwnerId];
            List<Order__c> lstOrder = [SELECT Id, Name, Account__c FROM Order__c WHERE Account__c IN: accId AND OwnerId NOT IN: setOwnerId];
            
            Set<Id> setOppId = new Set<Id> ();
            Set<Id> setQuoteId = new Set<Id> ();
            Set<Id> setOrderId = new Set<Id> ();
            for(OpportunityN__c opp : lstOpportunity) {
                setOppId.add(opp.Id);
            }

            for(QuotesN__c quote : lstQuote) {
                setQuoteId.add(quote.Id);
            }

            for(Order__c order : lstOrder) {
                setOrderId.add(order.Id);
            }

            List<OpportunityN__Share> lstOppShared = [SELECT Id, ParentId, UserOrGroupId, AccessLevel
                                                      FROM OpportunityN__Share WHERE ParentId IN: setOppId AND UserOrGroupId IN: setOwnerId];
            List<QuotesN__Share> lstQuoteShared = [SELECT Id, ParentId, UserOrGroupId, AccessLevel
                                                   FROM QuotesN__Share WHERE ParentId IN: setQuoteId AND UserOrGroupId IN: setOwnerId];
            List<Order__Share> lstOrderShared = [SELECT Id, ParentId, UserOrGroupId, AccessLevel
                                                 FROM Order__Share WHERE ParentId IN: setOrderId AND UserOrGroupId IN: setOwnerId];

            System.debug('shared opp size : ' + lstOppShared.size());
            System.debug('shared quote size : ' + lstQuoteShared.size());
            System.debug('shared order size : ' + lstOrderShared.size());
            
            Delete lstOppShared;
            Delete lstQuoteShared;
            Delete lstOrderShared;
            
            System.debug('successfully removed permission');
        }
        catch(Exception e) {
            System.debug('restrictOldOwner.undoShareRecords Error message : ' + e.getMessage());
            System.debug('restrictOldOwner.undoShareRecords Error Line Number : ' + e.getLineNumber());
        }
    }

    public class FlowInputs{
        @InvocableVariable
        public Id ParentId;
        
        @InvocableVariable
        public Id OwnerId;
    }
}