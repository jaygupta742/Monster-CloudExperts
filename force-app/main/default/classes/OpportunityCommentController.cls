public with sharing class OpportunityCommentController {
    @AuraEnabled
    public static List<commentWrapper> getComments(Id recordId, Integer limitSize, Integer offsetSize) {
        
        List<Opportunity_Comment__c> opportunityCommentList = [
            SELECT Id, Name, CreatedDate, Comment__c, CreatedBy.Name ,CreatedBy.SmallPhotoUrl,Created_By__c
            FROM Opportunity_Comment__c 
            WHERE Opportunities_Revamp__c = :recordId 
            ORDER BY CreatedDate DESC 
            LIMIT :limitSize/2 OFFSET :offsetSize/2
        ];
        
        List<commentWrapper> commentWrapperList = new List<commentWrapper>();
        
        for(Opportunity_Comment__c opportuniyComment : opportunityCommentList){
            
            commentWrapper wrapper = new commentWrapper();
            wrapper.comment_OpportunityId = opportuniyComment.Id;
            wrapper.smallPhotoUrl = opportuniyComment.CreatedBy.SmallPhotoUrl;
            wrapper.userLink = '/lightning/r/User/'+ opportuniyComment.Id+'/view';
            wrapper.CreatedByName = opportuniyComment.CreatedBy.Name;
            wrapper.CreatedDate = opportuniyComment.CreatedDate;
            wrapper.formattedCreatedDate = formatDate(opportuniyComment.CreatedDate);
            wrapper.comment = opportuniyComment.Comment__c;
            
            commentWrapperList.add(wrapper);
        }
        
        List<OpportunityN__History> opportunityHistoryList = [Select Id,Field,OldValue,NewValue,CreatedDate,CreatedBy.Id,CreatedBy.Name 
                                                              From OpportunityN__History 
                                                              Where ParentId =: recordId AND Field IN ('Stage__c','Gross_Total_Editable__c','Closure_probablity__c','Close_Date__c')
                                                              ORDER BY CreatedDate DESC 
                                                              LIMIT :limitSize/2 OFFSET :offsetSize/2
                                                             ];
        
        
        for(OpportunityN__History opportunityHistory : opportunityHistoryList){
            
            commentWrapper wrapper = new commentWrapper();
            wrapper.comment_OpportunityId = opportunityHistory.Id;
            wrapper.smallPhotoUrl = 'https://monsterindia--abdul.sandbox.file.force.com/profilephoto/005/T';
            wrapper.userLink = '/lightning/r/User/'+ opportunityHistory.CreatedBy.Id+'/view';
            wrapper.CreatedByName = opportunityHistory.CreatedBy.Name;
            wrapper.CreatedDate = opportunityHistory.CreatedDate;
            wrapper.formattedCreatedDate = formatDate(opportunityHistory.CreatedDate);
            wrapper.comment = returnHistoryComment(opportunityHistory);
            
            commentWrapperList.add(wrapper);
        }
        
        return  commentWrapperList;
    }
    
    public class commentWrapper{
        
        @AuraEnabled public String comment_OpportunityId;
        @AuraEnabled public String smallPhotoUrl;
        @AuraEnabled public String userLink;
        @AuraEnabled public String CreatedByName;
        @AuraEnabled public DateTime CreatedDate;
        @AuraEnabled public String formattedCreatedDate;
        @AuraEnabled public String comment;
    }
    
    private static String formatDate(DateTime dt) {
        String datePart = dt.format('dd/MM/yyyy'); 
        String timePart = dt.format('HH:mm'); 
        
        return datePart + ' | ' + timePart;
    }
    
    private static String returnHistoryComment(OpportunityN__History opportunityHistory) {
        if (opportunityHistory.Field == 'Stage__c') {
            return 'Stage Changed From <b>' + (opportunityHistory.OldValue != null ? opportunityHistory.OldValue : 'None') + '</b> To <b>' + (opportunityHistory.NewValue != null ? opportunityHistory.NewValue : '') + '</b>.';
        } else if (opportunityHistory.Field == 'Gross_Total_Editable__c') {
            return 'Gross Total Changed From <b>' + (opportunityHistory.OldValue != null ? opportunityHistory.OldValue : '0') + '</b> To <b>' + (opportunityHistory.NewValue != null ? opportunityHistory.NewValue : '') + '</b>.';
        } else if (opportunityHistory.Field == 'Closure_probablity__c') {
            return 'Closure Probability Changed From <b>' + (opportunityHistory.OldValue != null ? opportunityHistory.OldValue : 'None') + '</b> To <b>' + (opportunityHistory.NewValue != null ? opportunityHistory.NewValue : '') + '</b>.';
        } /*else if (opportunityHistory.Field == 'Opli_Count_Editable__c') {
            Integer oldValue = opportunityHistory.OldValue == null ? 0 : Integer.valueOf(opportunityHistory.OldValue);
            Integer newValue = opportunityHistory.NewValue == null ? 0 : Integer.valueOf(opportunityHistory.NewValue);
            if (newValue > oldValue) {
                Integer addedCount = newValue - oldValue;
                return addedCount == 1 ? '<b>' + addedCount + '</b> Product Was Added.' : '<b>' + addedCount + '</b> Products Were Added.';
            } else if (newValue < oldValue) {
                Integer deletedCount = oldValue - newValue;
                return deletedCount == 1 ? '<b>' + deletedCount + '</b> Product Was Deleted.' : '<b>' + deletedCount + '</b> Products Were Deleted.';
            }
        }*/else if (opportunityHistory.Field == 'Close_Date__c') {
            List<String> oldDate = String.valueOf((opportunityHistory.OldValue != null ? opportunityHistory.OldValue : '')).split(' ');
            List<String> newDate = String.valueOf((opportunityHistory.NewValue != null ? opportunityHistory.NewValue : '')).split(' ');
            return 'Close Date Changed From <b>' + oldDate[0] + '</b> To <b>' + newDate[0] + '</b>.';
        }
        
        return 'No relevant change detected';
    }
    
    @AuraEnabled
    public static List<Opportunity_Comment__c> getTotalCommentsDigit(Id recordId) {
        return [
            SELECT Id
            FROM Opportunity_Comment__c 
            WHERE Opportunities_Revamp__c = :recordId 
        ];
    }
    
    @AuraEnabled
    public static String getUserName(String userId){
        return [SELECT Name
                FROM User 
                WHERE Id =: userId].Name;
    }
}