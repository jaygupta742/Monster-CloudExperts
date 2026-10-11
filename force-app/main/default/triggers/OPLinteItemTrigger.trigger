trigger OPLinteItemTrigger on Opp_Line_Item__c (after insert,before delete) {
    List<Opportunity_Comment__c> opportunityCommentsList = new List<Opportunity_Comment__c>();
    
    if(trigger.isInsert && Trigger.isAfter){
        for(Opp_Line_Item__c oppLineItem : Trigger.new){
            system.debug('Trigger.old : ' + Trigger.old);
            system.debug('Trigger.new : ' + Trigger.new);
            Opportunity_Comment__c opportunityCommentsRecord = new Opportunity_Comment__c();
            opportunityCommentsRecord.Opportunities_Revamp__c = oppLineItem.Opportunities__c;
            opportunityCommentsRecord.Created_By__c = oppLineItem.CreatedBy.Name;
            opportunityCommentsRecord.Comment__c = '<b>' + oppLineItem.Product_Name__c + ' - ' + oppLineItem.SKU_Type__c + '</b>' + ' Product Was Added';
            opportunityCommentsRecord.Comment__c = opportunityCommentsRecord.Comment__c != null ? opportunityCommentsRecord.Comment__c.replace('null' , '') : '';
            opportunityCommentsList.add(opportunityCommentsRecord);
        }
    }
    if(trigger.isDelete && Trigger.isBefore){
        
        system.debug('Trigger.old : ' + Trigger.old);
        system.debug('Trigger.new : ' + Trigger.new);
        for(Opp_Line_Item__c oppLineItem : Trigger.old){
            Opportunity_Comment__c opportunityCommentsRecord = new Opportunity_Comment__c();
            opportunityCommentsRecord.Opportunities_Revamp__c = oppLineItem.Opportunities__c;
            opportunityCommentsRecord.Created_By__c = oppLineItem.CreatedBy.Name;
            opportunityCommentsRecord.Comment__c = '<b>' + oppLineItem.Product_Name__c + ' - ' + oppLineItem.SKU_Type__c + '</b>' + ' Product Was Deleted';
            opportunityCommentsRecord.Comment__c = opportunityCommentsRecord.Comment__c != null ? opportunityCommentsRecord.Comment__c.replace('null' , '') : '';
            opportunityCommentsList.add(opportunityCommentsRecord);
        }
    }
    
    if(!opportunityCommentsList.isEmpty()){
        insert opportunityCommentsList;
    }
    
    
}