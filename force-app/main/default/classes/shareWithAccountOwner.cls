public with sharing class shareWithAccountOwner {
    @InvocableMethod(label='Share Records With Account Owner' description='Share Records With Account Owner')
    public static void shareRecords(List<FlowInputs> requests) {
        try {
            System.debug('shareWithAccountOwner.shareRecords is running'); 
            
            system.debug('request size : ' + requests.size());
            
            if(requests.size() == 0) return;
            
            Set<Id> accId = new Set<Id> ();
            Set<Id> setUserId = new Set<Id> ();
            Map<Id, Id> mapAccOwner = new Map<Id, Id> ();
            
            for(FlowInputs item : requests) {
                accId.add(item.ParentId);
                setUserId.add(item.OwnerId);
                mapAccOwner.put(item.ParentId, item.OwnerId);   
            }
            
            List<User> lstUsers = [SELECT Id, Name, ManagerId FROM User WHERE Id IN: setUserId];
            Map<Id, User> mapUsers = new Map<Id, User> (lstUsers);
            
            List<OpportunityN__c> lstOpportunity = [SELECT Id, Name, Account__c FROM OpportunityN__c WHERE Account__c IN: accId];
            List<QuotesN__c> lstQuote = [SELECT Id, Name, Account__c FROM QuotesN__c WHERE Account__c IN: accId];
            List<Order__c> lstOrder = [SELECT Id, Name, Account__c FROM Order__c WHERE Account__c IN: accId];
            
            List<OpportunityN__Share> lstOppShared = new List<OpportunityN__Share> ();
            List<QuotesN__Share> lstQuoteShared = new List<QuotesN__Share> ();
            List<Order__Share> lstOrderShared = new List<Order__Share> ();
            
            for(OpportunityN__c opp : lstOpportunity) {
                Id accOwner = mapAccOwner.get(opp.Account__c);
                OpportunityN__Share oppShared1 = new OpportunityN__Share ();
                oppShared1.ParentId = opp.Id;
                oppShared1.UserOrGroupId = accOwner;
                oppShared1.AccessLevel = 'edit';
                
                OpportunityN__Share oppShared2 = new OpportunityN__Share ();
                oppShared2.ParentId = opp.Id;
                oppShared2.UserOrGroupId = mapUsers.get(accOwner).ManagerId;
                oppShared2.AccessLevel = 'edit';
                
                lstOppShared.add(oppShared1);
                lstOppShared.add(oppShared2);
            }
            
            for(QuotesN__c quote : lstQuote) {
                Id accOwner = mapAccOwner.get(quote.Account__c);
                QuotesN__Share quoteShared1 = new QuotesN__Share ();
                quoteShared1.ParentId = quote.Id;
                quoteShared1.UserOrGroupId = accOwner;
                quoteShared1.AccessLevel = 'edit';
                
                QuotesN__Share quoteShared2 = new QuotesN__Share ();
                quoteShared2.ParentId = quote.Id;
                quoteShared2.UserOrGroupId = mapUsers.get(accOwner).ManagerId;
                quoteShared2.AccessLevel = 'edit';
                
                lstQuoteShared.add(quoteShared1);
                lstQuoteShared.add(quoteShared2);
            }
            
            for(Order__c order : lstOrder) {
                Id accOwner = mapAccOwner.get(order.Account__c);
                Order__Share orderShared1 = new Order__Share ();
                orderShared1.ParentId = order.Id;
                orderShared1.UserOrGroupId = accOwner;
                orderShared1.AccessLevel = 'edit';
                
                Order__Share orderShared2 = new Order__Share ();
                orderShared2.ParentId = order.Id;
                orderShared2.UserOrGroupId = mapUsers.get(accOwner).ManagerId;
                orderShared2.AccessLevel = 'edit';
                
                lstOrderShared.add(orderShared1);
                lstOrderShared.add(orderShared2);
            }
            
            System.debug('shared opp size : ' + lstOppShared.size());
            System.debug('shared quote size : ' + lstQuoteShared.size());
            System.debug('shared order size : ' + lstOrderShared.size());
            
            Database.SaveResult[] lsrOpp = Database.insert(lstOppShared, false);
            Database.SaveResult[] lsrQuote = Database.insert(lstQuoteShared, false);
            Database.SaveResult[] lsrOrder = Database.insert(lstOrderShared, false);
            System.debug('opp status : ' + lsrOpp);
            System.debug('quote status : ' + lsrQuote);
            System.debug('order status : ' + lsrOrder);
            
            System.debug('successfully shared');
        }
        catch(Exception e) {
            System.debug('shareWithAccountOwner.shareRecords Error message : ' + e.getMessage());
            System.debug('shareWithAccountOwner.shareRecords Error Line Number : ' + e.getLineNumber());
        }
    }
    
    public class FlowInputs{
        @InvocableVariable
        public Id ParentId;
        
        @InvocableVariable
        public Id OwnerId;
    }
}