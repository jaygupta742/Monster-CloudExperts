@isTest(SeeAllData=true) public class approvalHighlightsController_Test {
    @isTest public static void TestMethod01() {
        ProcessInstanceWorkitem PIWorkItem = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId, OriginalActorId, ActorId FROM ProcessInstanceWorkitem LIMIT 1];  
        ProcessInstanceStep PIStep = [SELECT Id, ProcessInstanceId, ProcessInstance.TargetObjectId, OriginalActorId, StepStatus, ActorId, Comments FROM ProcessInstanceStep LIMIT 1];
	
        String QuoteId = PIWorkItem.ProcessInstance.TargetObjectId;
        Test.startTest();
        approvalHighlightsController.getConditions();
        approvalHighlightsController.GetProcessDetails(PIWorkItem.Id);
        approvalHighlightsController.GetProcessDetails(PIStep.Id);
		approvalHighlightsController.FetchApprovalHistory(QuoteId);
        approvalHighlightsController.FetchAttachmentsFromQuote(QuoteId);
        Test.stopTest();
    }
}