/* 
* created By Suraj :  Created Date 22/08/2023  : Created For This the batchable class to share Opportunity and Quotes and Order share to account owner when change account owner
*/ 
Global class Batch_SharePorfolioWithNewAcc Implements Database.Batchable<Sobject> {
    public List<Account> toBeSharedAccount;
    public Map<String, String> mapToBeSharedWith;
    public Map<String, String> mapToBeRestricted;
    
    public Account PAccount;
    
    public String operation = '## Batch_SharePorfolioWithNewAcc is running';
    public String logs;
    
    public Batch_SharePorfolioWithNewAcc(List<Account> lstAccount, Map<String, String> mapShared, Map<String, String> mapRestrict){
        System.debug('Batch_SharePorfolioWithNewAcc contructor is running');
        System.debug('batch size : ' + lstAccount.size());
        
        this.logs = '## Batch_SharePorfolioWithNewAcc Constructor is running';
        
        toBeSharedAccount = lstAccount;
        mapToBeSharedWith = mapShared;
        mapToBeRestricted = mapRestrict;
               
        this.logs +='\n To be share Account List Size '+toBeSharedAccount.Size()+'\n';      
    }
    
    global database.QueryLocator start(Database.BatchableContext sc){
        system.debug('Calling Start Method ');
        String query = 'Select ID From Account limit 1';
        
        // insert Debug Log For Start Method
        this.logs += '\n## Batch_SharePorfolioWithNewAcc Start Method running\n\n';
        return Database.getQueryLocator( query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> scope){
        system.debug('@@Calling Execute Method ');
        system.debug('@@ scope : ' + scope);
        String Operation = '## Batch_SharePorfolioWithNewAcc Execute Method running\n\n';
        String logs = '## Batch_SharePorfolioWithNewAcc Execute Method running\n\n';
        
        logs += restrictOldOwner();
        logs += shareToNewOwner();
        
        Developer_Helper__c helper = new Developer_Helper__c();
        helper.Account__c = toBeSharedAccount.size() > 0 ? toBeSharedAccount[0].Id : null;
        helper.Operation__c = Operation;
        helper.Logs__c = logs;
        helper.Starting_Time__c = Datetime.now();
        helper.Type__c = 'Account Share Portfolio Execute';
        helper.User__c = userinfo.getUserId();
        helper.Is_Success__c = true;
        insert helper;        
    }
    
    public String restrictOldOwner() {
        String logs = '\n\n## restrictOldOwner Method running\n';
        
        try {
            System.debug('restrictOldOwner is running');
            System.debug('size of to be restricted list : ' + toBeSharedAccount.size());
            
            logs += 'size of to be restricted list : ' + toBeSharedAccount.size() + '\n';
            
            if(toBeSharedAccount.size() == 0) {
                logs += '## Return\n\n';
                return logs; 
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
                logs += 'Quote Id : [' + mapQuote.get(recordId).ParentId+ '][';
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
                logs += 'Order Id : [' + mapOrder.get(recordId).ParentId+ '][';
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
            logs += '\n##Error in restrictOldOwner Method\n';
            logs += 'Error Line Number : ' + e.getLineNumber();
            logs += 'Error Message : ' + e.getMessage();
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.restrictOldOwner error message : ' + e.getMessage());
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.restrictOldOwner line number : ' + e.getLineNumber());
        } 
        
        return logs;
    }
    
    public String shareToNewOwner() {
        String logs = '\n\n## shareToNewOwner Method is running\n';
                
        try {
            System.debug('Share to new owner is running');
            System.debug('size of to be Shared  list : ' + toBeSharedAccount.size());
            
            logs += 'size of to be Shared list : ' + toBeSharedAccount.size() + '\n';

            if(toBeSharedAccount.size() == 0) {
				logs += '##Return';
                return logs; 
            } 
            
            Set<Id> setOwnerId = new Set<Id> ();
            Set<Id> setAccId = new Set<Id> ();
            
            for(Account acc : toBeSharedAccount) {
                if(mapToBeSharedWith.containsKey(acc.Id)) {
                    String OwnerId = mapToBeSharedWith.get(acc.Id);
                    if(OwnerId != null) {
                        setOwnerId.add(OwnerId);
                        setAccId.add(acc.Id);
                        logs += 'Name of to be restricted Account : ' + acc.Name + '\n';
                    }
                }
            }
            
            List<User> lstUsers = [SELECT Id, Name, ManagerId FROM User WHERE Id IN: setOwnerId];
            Map<Id, User> mapUsers = new Map<Id, User> (lstUsers);
            
            List<OpportunityN__c> lstOpportunity = [SELECT Id, Name, Account__c FROM OpportunityN__c WHERE Account__c IN: setAccId];
            List<QuotesN__c> lstQuote = [SELECT Id, Name, Account__c FROM QuotesN__c WHERE Account__c IN: setAccId];
            List<Order__c> lstOrder = [SELECT Id, Name, Account__c FROM Order__c WHERE Account__c IN: setAccId];
            
			logs += 'Opportunity size : ' + lstOpportunity.size() + '\n';
            logs += 'Quote Size : ' + lstQuote.size() + '\n';
            logs += 'Order Size : ' + lstOrder.size() + '\n';
            
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
            
            logs += 'shared Opp Size   : ' + lstOppShared.size() + '\n';
            logs += 'shared quote Size   : ' + lstQuoteShared.size() + '\n';
            logs += 'shared order Size  : ' + lstOrderShared.size() + '\n';
            Database.SaveResult[] lsrOpp = Database.insert(lstOppShared, false);
            Database.SaveResult[] lsrQuote = Database.insert(lstQuoteShared, false);
            Database.SaveResult[] lsrOrder = Database.insert(lstOrderShared, false);
            
            System.debug('@@successfully shared records');
            logs += '\n\n##successfully shared records\n##Response Status\n';

            logs += '@@ Opportunity Status\n\n';
            Integer index = 0;
            for(Database.SaveResult sr : lsrOpp) { 
                logs += 'Opportunity Id : [' + lstOppShared[index].ParentId+ '][';
                if(!SR.isSuccess()) {
                    logs += 'ERROR]\n';
                    for(Database.Error err : SR.getErrors()) {
                        logs += err.getMessage() +'\n';
                    }
                } else {
                    logs += 'SUCCESS]\n';
                }
                index += 1;
            }
            
            index = 0;
            logs += '@@ Quote Status\n\n';
            for(Database.SaveResult sr : lsrQuote) {
                logs += 'Quote Id : [' + lstQuoteShared[index].ParentId+ '][';
                if(!SR.isSuccess()) {      
                    logs += 'ERROR]\n';
                    for(Database.Error err : SR.getErrors()) {
                        logs += err.getMessage() +'\n';
                    }
                } else {
                    logs += 'SUCCESS]\n';
                }
                index += 1;
            }
            
            logs += '@@ Quote Status\n\n';
            index = 0;
            for(Database.SaveResult sr : lsrOrder) {
                logs += 'Order Id : [' + lstOrderShared[index].ParentId+ '][';
                if(!SR.isSuccess()) {    
                    logs += 'ERROR]\n';
                    for(Database.Error err : SR.getErrors()) {
                        logs += err.getMessage() +'\n';
                    }
                } else {
                    logs += 'SUCCESS]\n';
                }
                index += 1;
            }
        } catch(Exception e) {   
            logs += '\n##Error in shareToNewOwner Method\n';
            logs += '\nError Line Number : ' + e.getLineNumber();
            logs += '\nError Message : ' + e.getMessage();
            
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.shareToNewOwner error message : ' + e.getMessage());
            System.debug('SharePorfolioWithNewAccOwnerQue_cls.shareToNewOwner line number : ' + e.getLineNumber());
        }
        
        return logs;
    }
    
    global Void Finish(Database.BatchableContext BC){
        system.debug('Calling Finish Method ');  
        this.logs += '\n\n ##Calling Finish Method';
        Developer_Helper__c helper = new Developer_Helper__c();
        helper.Account__c = this.PAccount == null ? null : this.PAccount.Id;
        helper.Operation__c = this.Operation;
        helper.Logs__c = this.logs;
        helper.Starting_Time__c = Datetime.now();
        helper.Type__c = 'Account Share Portfolio';
        helper.User__c = userinfo.getUserId();
        helper.Is_Success__c = true;
        insert helper;
    }
}