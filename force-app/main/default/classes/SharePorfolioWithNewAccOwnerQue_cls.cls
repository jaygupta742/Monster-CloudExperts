public class SharePorfolioWithNewAccOwnerQue_cls implements Queueable{
    public List<Account> lstNewAccount; 
    public List<Account> lstOldAccount; 
    public List<Account> toBeSharedAccount;
    public Map<String, String> mapToBeSharedWith;
    public Map<String, String> mapToBeRestricted;
    
    public SharePorfolioWithNewAccOwnerQue_cls(List<Account> accListNew, List<Account> accListOld, Map<ID, Account> accMapNew, Map<ID, Account> accMapOld){
        System.debug('SharePorfolioWithNewAccOwnerQue_cls is running');
        System.debug('batch size : ' + accListNew.size());
        this.lstNewAccount = accListNew;  
        this.lstOldAccount = accListOld;
        toBeSharedAccount = new List<Account> ();
        mapToBeSharedWith = new Map<String, String> ();
        mapToBeRestricted = new Map<String, String> ();
        Trigger__c sharePortfolio = [SELECT Id, Name, Active__c FROM Trigger__c WHERE Name =: 'Share Portfolio'];
        for(Account acc : accListNew) {
            if(accMapOld.containsKey(acc.Id)) {
                if(acc.OwnerId != accMapOld.get(acc.Id).OwnerId || sharePortfolio.Active__c) {
                    toBeSharedAccount.add(acc);
                    mapToBeSharedWith.put(acc.Id, acc.OwnerId);
                    mapToBeRestricted.put(acc.Id, accMapOld.get(acc.Id).OwnerId);
                }
            }
        }
    }
    
    public void execute(QueueableContext context) {
        restrictOldOwner();
        shareToNewOwner();
    }
    
    public void restrictOldOwner() {
        try {
            System.debug('restrictOldOwner is running');
            System.debug('size of to be restricted list : ' + toBeSharedAccount.size());

            if(toBeSharedAccount.size() == 0) return;            
            Set<Id> setOwnerId = new Set<Id> ();
            Set<Id> setAccId = new Set<Id> ();
            
            for(Account acc : toBeSharedAccount) {
                if(mapToBeRestricted.containsKey(acc.Id)) {
                    String OwnerId = mapToBeRestricted.get(acc.Id);
                    if(OwnerId != null) {
                        setOwnerId.add(OwnerId);
                        setAccId.add(acc.Id);
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
            
            List<Order__Share> lstOrderShared1 = new List<Order__Share> ();
            for(Order__Share share : lstOrderShared) {
                if(share.UserOrGroupId != share.Parent.Quotes__r.OwnerId) lstOrderShared1.add(share);
            }
            
            System.debug('shared order size : ' + lstOrderShared1.size());
             
            Map<Id, OpportunityN__Share> mapOpp = new Map<Id, OpportunityN__Share> (lstOppShared);            
            Map<Id, QuotesN__Share> mapQuote = new Map<Id, QuotesN__Share> (lstQuoteShared);              
            Map<Id, Order__Share> mapOrder = new Map<Id, Order__Share> (lstOrderShared1);


            Database.DeleteResult[] lsrOpp = Database.Delete(lstOppShared, false);
            Database.DeleteResult[] lsrQuote = Database.Delete(lstQuoteShared, false);
            Database.DeleteResult[] lsrOrder = Database.Delete(lstOrderShared1, false);
            
            System.debug('successfully removed permission');
            	
            List<Developer_Helper__c > lstDeveloperHelper = new List<Developer_Helper__c> ();
            for(Database.DeleteResult dr : lsrOpp) {
                Developer_Helper__c dhc = new Developer_Helper__c();
				String recordId = dr.getId();
                dhc.User__c = mapOpp.get(recordId).UserOrGroupId;
                dhc.Opportunity__c  = mapOpp.get(recordId).ParentId;
                dhc.Type__c = 'Restricted';
                dhc.Account__c = mapOpp.get(recordId).Parent.Account__c;
                dhc.Is_Success__c = dr.isSuccess();
                if(!dr.isSuccess()) {
                    dhc.Error_Message__c = '';
                    for(Database.Error err : dr.getErrors()) {
                        dhc.Error_Message__c += err.getMessage();
                    }
                }
                lstDeveloperHelper.add(dhc);
            }
            for(Database.DeleteResult dr : lsrQuote) {
                Developer_Helper__c dhc = new Developer_Helper__c();
				String recordId = dr.getId();
                dhc.User__c = mapQuote.get(recordId).UserOrGroupId;
                dhc.Quote__c = mapQuote.get(recordId).ParentId;
                dhc.Type__c = 'Restricted';
                dhc.Account__c = mapQuote.get(recordId).Parent.Account__c;
                dhc.Is_Success__c = dr.isSuccess();
                if(!dr.isSuccess()) {
                    dhc.Error_Message__c = '';
                    for(Database.Error err : dr.getErrors()) {
                        dhc.Error_Message__c += err.getMessage();
                    }
                }
                lstDeveloperHelper.add(dhc);
            }
            for(Database.DeleteResult dr : lsrOrder) {
                Developer_Helper__c dhc = new Developer_Helper__c();
				String recordId = dr.getId();
                dhc.User__c = mapOrder.get(recordId).UserOrGroupId;
                dhc.Order__c = mapOrder.get(recordId).ParentId;
                dhc.Type__c = 'Restricted';
                dhc.Account__c = mapOrder.get(recordId).Parent.Account__c;
                dhc.Is_Success__c = dr.isSuccess();
                if(!dr.isSuccess()) {
                    dhc.Error_Message__c = '';
                    for(Database.Error err : dr.getErrors()) {
                        dhc.Error_Message__c += err.getMessage();
                    }
                }
                lstDeveloperHelper.add(dhc);
            }
            
            Database.SaveResult[] lsrDH = Database.Insert(lstDeveloperHelper, false);
        } catch(Exception e) {
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.restrictOldOwner error message : ' + e.getMessage());
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.restrictOldOwner line number : ' + e.getLineNumber());
        }
    }
    
    public void shareToNewOwner() {
        try {
            System.debug('Share to new owner is running');
            System.debug('size of to be restricted list : ' + toBeSharedAccount.size());
            
            if(toBeSharedAccount.size() == 0) return;
            
            Set<Id> setOwnerId = new Set<Id> ();
            Set<Id> setAccId = new Set<Id> ();
            
            for(Account acc : toBeSharedAccount) {
                if(mapToBeSharedWith.containsKey(acc.Id)) {
                    String OwnerId = mapToBeSharedWith.get(acc.Id);
                    if(OwnerId != null) {
                        setOwnerId.add(OwnerId);
                        setAccId.add(acc.Id);
                    }
                }
            }
            
            List<User> lstUsers = [SELECT Id, Name, ManagerId FROM User WHERE Id IN: setOwnerId];
            Map<Id, User> mapUsers = new Map<Id, User> (lstUsers);
            
            List<OpportunityN__c> lstOpportunity = [SELECT Id, Name, Account__c FROM OpportunityN__c WHERE Account__c IN: setAccId];
            List<QuotesN__c> lstQuote = [SELECT Id, Name, Account__c FROM QuotesN__c WHERE Account__c IN: setAccId];
            List<Order__c> lstOrder = [SELECT Id, Name, Account__c FROM Order__c WHERE Account__c IN: setAccId];
            Map<id,OpportunityN__c> mapOpp = new  Map<id,OpportunityN__c>(lstOpportunity);
            Map<id,QuotesN__c> mapQuote = new  Map<id,QuotesN__c>(lstQuote);
            Map<id,Order__c> mapOrder = new  Map<id,Order__c>(lstOrder);
            
            List<OpportunityN__Share> lstOppShared = new List<OpportunityN__Share> ();
            List<QuotesN__Share> lstQuoteShared = new List<QuotesN__Share> ();
            List<Order__Share> lstOrderShared = new List<Order__Share> ();
            
            for(OpportunityN__c opp : lstOpportunity) {
                Id accOwner = mapToBeSharedWith.get(opp.Account__c);
                OpportunityN__Share oppShared = new OpportunityN__Share ();
                oppShared.ParentId = opp.Id;
                oppShared.UserOrGroupId = accOwner;
                oppShared.AccessLevel = 'edit';
                
                lstOppShared.add(oppShared);
            }
            
            for(QuotesN__c quote : lstQuote) {
                Id accOwner = mapToBeSharedWith.get(quote.Account__c);
                QuotesN__Share quoteShared = new QuotesN__Share ();
                quoteShared.ParentId = quote.Id;
                quoteShared.UserOrGroupId = accOwner;
                quoteShared.AccessLevel = 'edit';
                
                lstQuoteShared.add(quoteShared);
            }
            
            for(Order__c order : lstOrder) {
                Id accOwner = mapToBeSharedWith.get(order.Account__c);
                Order__Share orderShared = new Order__Share ();
                orderShared.ParentId = order.Id;
                orderShared.UserOrGroupId = accOwner;
                orderShared.AccessLevel = 'edit';
                
                lstOrderShared.add(orderShared);
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

            
            System.debug('successfully shared records');
            
            List<Developer_Helper__c > lstDeveloperHelper = new List<Developer_Helper__c> ();

            Integer index = 0;
            for(Database.SaveResult sr : lsrOpp) {
                Developer_Helper__c dhc = new Developer_Helper__c();
				
                dhc.User__c = lstOppShared[index].UserOrGroupId;
                dhc.Opportunity__c  = lstOppShared[index].ParentId;
                dhc.Type__c = 'Shared';
                dhc.Account__c = mapOpp.get(lstOppShared[index].ParentId).Account__c;
                dhc.Is_Success__c = sr.isSuccess();
                if(!sr.isSuccess()) {
                    dhc.Error_Message__c = '';
                    for(Database.Error err : sr.getErrors()) {
                        dhc.Error_Message__c += err.getMessage();
                    }
                }
                lstDeveloperHelper.add(dhc);
                index += 1;
            }
            
            index = 0;
            for(Database.SaveResult sr : lsrQuote) {
                Developer_Helper__c dhc = new Developer_Helper__c();
				
                dhc.User__c = lstQuoteShared[index].UserOrGroupId;
                dhc.Quote__c  = lstQuoteShared[index].ParentId;
                dhc.Type__c = 'Shared';
                dhc.Account__c = mapQuote.get(lstQuoteShared[index].ParentId).Account__c;
                dhc.Is_Success__c = sr.isSuccess();
                if(!sr.isSuccess()) {
                    dhc.Error_Message__c = '';
                    for(Database.Error err : sr.getErrors()) {
                        dhc.Error_Message__c += err.getMessage();
                    }
                }
                lstDeveloperHelper.add(dhc);
                index += 1;
            }
            
            index = 0;
            for(Database.SaveResult sr : lsrOrder) {
                Developer_Helper__c dhc = new Developer_Helper__c();
				
                dhc.User__c = lstOrderShared[index].UserOrGroupId;
                dhc.Quote__c  = lstOrderShared[index].ParentId;
                dhc.Type__c = 'Shared';
                dhc.Account__c = mapOrder.get(lstOrderShared[index].ParentId).Account__c;
                dhc.Is_Success__c = sr.isSuccess();
                if(!sr.isSuccess()) {
                    dhc.Error_Message__c = '';
                    for(Database.Error err : sr.getErrors()) {
                        dhc.Error_Message__c += err.getMessage();
                    }
                }
                lstDeveloperHelper.add(dhc);
                index += 1;
            }
            
            Database.SaveResult[] lsrDH = Database.Insert(lstDeveloperHelper, false);
        } catch(Exception e) {           
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.shareToNewOwner error message : ' + e.getMessage());
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.shareToNewOwner line number : ' + e.getLineNumber());
        }
    }
}