public class DiscountApprovalSubmission {
   public static void submitAndProcessApprovalRequest(){
        
         List<Approval_Records__c> approvalRecs = new List<Approval_Records__c>();
         List<apttus_proposal_proposal__c> listOfQuotes = new List<apttus_proposal_proposal__c>();
         Set<Id> ids = new Set<Id>();
         Approval.ProcessResult[] processResults = null;
        
         approvalRecs = [SELECT Id,Name FROM Approval_Records__c];
        
        for(Approval_Records__c apprvlRec :approvalRecs )
        {
            ids.add(apprvlRec.Name);
        }
        
         listOfQuotes = [Select id,ownerId from apttus_proposal_proposal__c where id=:ids];
        
        //The ProcessSubmitRequest class is used to submit a record for approval.
       List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest> ();
        for (apttus_proposal_proposal__c quot: listOfQuotes) {
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('January Re-Approval ');
                    req1.setObjectId(quot.Id);
                    req1.setProcessDefinitionNameOrId('Discount_Approval_Process_Revised_Temp');
	        		req1.setSkipEntryCriteria(true);
            		req1.setSubmitterId(quot.ownerId);
                    requests.add(req1);
        }
                    processResults = Approval.process(requests, true);
     }
}