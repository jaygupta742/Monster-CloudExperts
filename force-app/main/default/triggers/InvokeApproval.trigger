//@Nag --> for invoking approval process of level2 reversals
trigger InvokeApproval on Credit_Request__c (before insert, after insert, before update, after update, before delete, after Undelete) {
    if(Trigger.isUpdate && Trigger.isAfter){
		for (Credit_Request__c cr :  Trigger.new) {
            System.debug('Trigger new Value--->'+Trigger.new);
            System.debug('Vertical head Approval status Value------------>'+cr.Vertical_head_Approval_status__c);
            System.debug('Approval Status Value------------>'+cr.Approval_Status__c);
            if (cr.Vertical_head_Approval_status__c == 'Approved' && cr.Approval_Status__c == null) {
                System.debug('cr Value------------>'+cr);
                Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                approvalRequest.setComments('Credit Request submitted for Approval');
                approvalRequest.setObjectId(cr.Id);
                approvalRequest.setSubmitterId(cr.ownerId);         
                // Submit the record to specific process and skip the criteria evaluation
                approvalRequest.setProcessDefinitionNameOrId('Level_2_Of_approval_Process');
                approvalRequest.setSkipEntryCriteria(false);
                Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
                System.debug('Credit Request submitted for approval successfully: '+approvalResult .isSuccess());
            }
    	}    
    } 
    //Total bad debt amount calculation
    if((trigger.isInsert && Trigger.isAfter)|| (trigger.isUpdate && Trigger.isAfter )|| (trigger.isUnDelete && Trigger.isAfter)){        
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Credit_Amount__c', 
            'Total_Bad_Debt_Value__c')
        };         
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, trigger.new, 
        'Credit_Request__c', 'Order_Custom__c', 'OrderC__c', '');
    }      
    if(trigger.isDelete){        
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Credit_Amount__c', 
            'Total_Bad_Debt_Value__c')
        };        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, trigger.old, 
        'Credit_Request__c', 'Order_Custom__c', 'OrderC__c', '');
    } 
  
}