global class OrderShareBatch implements Database.Batchable<SObject> {
    
    public Id userOrGroupId;
    
    public OrderShareBatch(Id userOrGroupId){
        this.userOrGroupId = userOrGroupId;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        if (!Test.isRunningTest()) {
            return Database.getQueryLocator(
                [SELECT Id, Opportunities__c, Quotes__c FROM Order__c 
                 WHERE Account__r.SalesChannel__c NOT IN ('Seeker', 'Seeker-Ed Sales')]
            );
        } else {
            return Database.getQueryLocator(
                [SELECT Id, Opportunities__c, Quotes__c FROM Order__c 
                 WHERE Account__r.SalesChannel__c NOT IN ('Seeker', 'Seeker-Ed Sales') LIMIT 1]
            );
        }
    }
    
    global void execute(Database.BatchableContext BC, List<Order__c> scope) {
        List<Order__Share> orderShares = new List<Order__Share>();
        List<QuotesN__Share> quoteShares = new List<QuotesN__Share>();
        List<OpportunityN__Share> opportunityShares = new List<OpportunityN__Share>();
        
        for (Order__c order : scope) {
            Order__Share orderShare = new Order__Share();
            orderShare.ParentId = order.Id; // Correct casing
            orderShare.UserOrGroupId = userOrGroupId; // Replace with actual User Id
            orderShare.AccessLevel = 'Read';
            orderShares.add(orderShare);
            
            // Create QuotesN__Share records if Quotes__c is not null
            if (order.Quotes__c != null) {
                QuotesN__Share quoteShare = new QuotesN__Share();
                quoteShare.ParentId = order.Quotes__c; // Link to the quote
                quoteShare.UserOrGroupId = userOrGroupId; // Replace with actual User Id
                quoteShare.AccessLevel = 'Read';
                quoteShares.add(quoteShare);
            }
            
            // Create OpportunityN__Share records if Opportunities__c is not null
            if (order.Opportunities__c != null) {
                OpportunityN__Share opportunityShare = new OpportunityN__Share();
                opportunityShare.ParentId = order.Opportunities__c; // Link to the opportunity
                opportunityShare.UserOrGroupId = userOrGroupId; // Replace with actual User Id
                opportunityShare.AccessLevel = 'Read';
                opportunityShares.add(opportunityShare);
            }
        }
        
        // Insert the sharing records
        if (!orderShares.isEmpty()) {
            insert orderShares;
        }
        if (!quoteShares.isEmpty()) {
            insert quoteShares;
        }
        if (!opportunityShares.isEmpty()) {
            insert opportunityShares;
        }
    }
    
    // Finish method to perform any final operations after processing
    global void finish(Database.BatchableContext BC) {
        // Optional: Add any post-processing logic, like sending notifications
    }
}