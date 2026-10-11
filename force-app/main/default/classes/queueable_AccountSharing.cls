public class queueable_AccountSharing implements System.Queueable{
    
    public List<Account> toBeSharedAccount;
    public Map<String, String> mapToBeSharedWith;
    public Map<String, String> mapToBeRestricted;
    
    public queueable_AccountSharing(List<Account> toBeSharedAccount,Map<String, String> mapToBeSharedWith,Map<String, String> mapToBeRestricted){
        this.toBeSharedAccount = toBeSharedAccount;
        this.mapToBeSharedWith = mapToBeSharedWith;
        this.mapToBeRestricted = mapToBeRestricted;
    }
    
    public void execute(System.QueueableContext context) {
        String logs = '\n\n## shareToNewOwner Method is running\n';
        
        try {
            System.debug('Share to new owner is running');
            System.debug('size of to be Shared  list : ' + toBeSharedAccount.size());
            
            logs += 'size of to be Shared list : ' + toBeSharedAccount.size() + '\n';
            
            if(toBeSharedAccount.size() == 0) {
                logs += '##Return';
                return ; 
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
        
        
        Developer_Helper__c helper = new Developer_Helper__c();
        helper.Account__c = toBeSharedAccount.size() > 0 ? toBeSharedAccount[0].Id : null;
        helper.Operation__c = 'queueable_AccountSharing';
        helper.Logs__c = logs;
        helper.Starting_Time__c = Datetime.now();
        helper.Type__c = 'Account Share Portfolio Execute';
        helper.User__c = userinfo.getUserId();
        helper.Is_Success__c = true;
        insert helper;
    }
}