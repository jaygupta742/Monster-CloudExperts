public class queueable_restrictOldOwner implements System.Queueable{
    
    public List<Account> toBeSharedAccount;
    public Map<String, String> mapToBeSharedWith;
    public Map<String, String> mapToBeRestricted;
    
    public queueable_restrictOldOwner(List<Account> toBeSharedAccount,Map<String, String> mapToBeSharedWith,Map<String, String> mapToBeRestricted){
        this.toBeSharedAccount = toBeSharedAccount;
        this.mapToBeSharedWith = mapToBeSharedWith;
        this.mapToBeRestricted = mapToBeRestricted;
    }
    
    public void execute(System.QueueableContext context) {
        
        String logs = '\n\n## restrictOldOwner Method running\n';
        
        try {
            System.debug('restrictOldOwner is running');
            System.debug('size of to be restricted list : ' + toBeSharedAccount.size());
            
            logs += 'size of to be restricted list : ' + toBeSharedAccount.size() + '\n';
            
            if(toBeSharedAccount.size() == 0) {
                logs += '## Return\n\n';
                return ; 
            }
            
            Set<Id> setOwnerId = new Set<Id> ();
            Set<Id> setAccId = new Set<Id> ();
            
            for(Account acc : toBeSharedAccount) {
                if(mapToBeRestricted.containsKey(acc.Id)) {
                    String OwnerId = mapToBeRestricted.get(acc.Id);
                    if(OwnerId != null) {
                        setOwnerId.add(OwnerId);
                        setAccId.add(acc.Id);
                        logs += 'Name of to be restricted Account : ' + acc.Name + '\n';
                    }
                }
            }
            
            List<OpportunityN__c> lstOpportunity = [SELECT Id, Name, Account__c, OwnerId FROM OpportunityN__c WHERE Account__c IN: setAccId];
            List<QuotesN__c> lstQuote = [SELECT Id, Name, Account__c FROM QuotesN__c WHERE Account__c IN: setAccId];
            List<Order__c> lstOrder = [SELECT Id, Name, Account__c FROM Order__c WHERE Account__c IN: setAccId];
            
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
            
            List<OpportunityN__Share> lstOppShared = [SELECT Id, ParentId, Parent.Name, Parent.Account__c, UserOrGroupId, UserOrGroup.Name, AccessLevel
                                                      FROM OpportunityN__Share WHERE ParentId IN: setOppId AND UserOrGroupId IN: setOwnerId];
            List<QuotesN__Share> lstQuoteShared = [SELECT Id, ParentId, Parent.Name, Parent.Account__c, UserOrGroupId, UserOrGroup.Name, AccessLevel
                                                   FROM QuotesN__Share WHERE ParentId IN: setQuoteId AND UserOrGroupId IN: setOwnerId];
            List<Order__Share> lstOrderShared = [SELECT Id, ParentId, Parent.Name, Parent.Account__c, UserOrGroupId, UserOrGroup.Name, AccessLevel, Parent.Quotes__r.OwnerId
                                                 FROM Order__Share WHERE ParentId IN: setOrderId AND UserOrGroupId IN: setOwnerId];
            
            System.debug('shared opp size : ' + lstOppShared.size());
            System.debug('shared quote size : ' + lstQuoteShared.size());
            System.debug('shared order size : ' + lstOrderShared.size());
            
            logs += 'Opportunity size : ' + lstOppShared.size() + '\n';
            logs += 'Quote Size : ' + lstQuoteShared.size() + '\n';
            logs += 'Order Size : ' + lstOrderShared.size() + '\n';
            
            List<Order__Share> lstOrderShared1 = new List<Order__Share> ();
            for(Order__Share share : lstOrderShared) {
                if(share.UserOrGroupId != share.Parent.Quotes__r.OwnerId) lstOrderShared1.add(share);
            }
            
            System.debug('shared order size new : ' + lstOrderShared1.size());
            
            Map<Id, OpportunityN__Share> mapOpp = new Map<Id, OpportunityN__Share> (lstOppShared);            
            Map<Id, QuotesN__Share> mapQuote = new Map<Id, QuotesN__Share> (lstQuoteShared);              
            Map<Id, Order__Share> mapOrder = new Map<Id, Order__Share> (lstOrderShared1);
            
            
            Database.DeleteResult[] lsrOpp = Database.Delete(lstOppShared, false);
            Database.DeleteResult[] lsrQuote = Database.Delete(lstQuoteShared, false);
            Database.DeleteResult[] lsrOrder = Database.Delete(lstOrderShared1, false);
            
            System.debug('successfully removed permission');
            logs += 'successfully removed permission for Opportunity , Quote, Order : \n\n ##Response Status';
            logs += '\n\n@@ Opportunity Status\n';
            
            for(Database.DeleteResult dr : lsrOpp) {
                String recordId = dr.getId();
                logs += 'Opportunity Id : [' + mapOpp.get(recordId).ParentId+ '][';
                if(!dr.isSuccess()) {
                    logs += 'ERROR]\t';
                    for(Database.Error err : dr.getErrors()) {
                        logs += err.getMessage()+'\n';
                    }
                } else {
                    logs += 'SUCCESS]\n';
                }
            }
            
            logs += '\n\n@@ Quote Status\n';
            for(Database.DeleteResult dr : lsrQuote) {
                String recordId = dr.getId();
                if(!dr.isSuccess()) {       
                    logs += 'ERROR]\t';
                    for(Database.Error err : dr.getErrors()) {
                        logs += err.getMessage()+'\n';
                    }
                } else {
                    logs += 'SUCCESS]\n';
                }
            }
            
            logs += '\n\n@@ Order Status\n';
            for(Database.DeleteResult dr : lsrOrder) {
                String recordId = dr.getId();
                if(!dr.isSuccess()) {      
                    logs += 'ERROR]\t';
                    for(Database.Error err : dr.getErrors()) {
                        logs += err.getMessage()+'\n';
                    }
                } else {
                    logs += 'SUCCESS]\n';
                }
            } 
        } catch(Exception e) {
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.restrictOldOwner error message : ' + e.getMessage());
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.restrictOldOwner line number : ' + e.getLineNumber());
        } 
        
    }
    
}