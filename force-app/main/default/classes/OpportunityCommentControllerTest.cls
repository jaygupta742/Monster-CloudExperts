@isTest(SeeAllData = true) public class OpportunityCommentControllerTest {

    @isTest public static void test1(){
        Opportunity_Comment__c comment = [SELECT Id,Opportunities_Revamp__c From Opportunity_Comment__c ORDER BY CreatedDate ASC LIMIT 1];
        OpportunityCommentController.getComments(comment.Opportunities_Revamp__c,10,0);
        OpportunityCommentController.getTotalCommentsDigit(comment.Opportunities_Revamp__c);
        OpportunityCommentController.getUserName(userinfo.getUserId());
    }
}