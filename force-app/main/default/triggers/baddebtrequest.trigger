trigger baddebtrequest on Reversal_Bad_Debt_Requests__c (before insert, after insert, before update, after update, before delete, after Undelete) {
 if(Trigger.isUpdate && Trigger.isAfter){
    for (Reversal_Bad_Debt_Requests__c cr :  Trigger.new) {
            System.debug('Trigger new Value--->'+Trigger.new);
            System.debug('Vertical head Approval status Value------------>'+cr.Vertical_head_Approval_status__c);
            System.debug('Approval Status Value------------>'+cr.Final_Approval_Status__c);
            if (cr.Vertical_head_Approval_status__c == 'Approved' && cr.Final_Approval_Status__c == null) {
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
}