public without sharing class escalateApprovalProcessController {
    
    @auraEnabled
    public static void proceedToNextStep(Id recordId,String comment) {
        
        String currentApprover = '';
        
        List<ProcessInstanceWorkitem> workItems = [
            SELECT Id, ProcessInstance.TargetObjectId,ActorId
            FROM ProcessInstanceWorkitem
            WHERE ProcessInstance.TargetObjectId = :recordId
        ];
        
        currentApprover = workItems[0].ActorId;
        
        for (ProcessInstanceWorkitem workItem : workItems) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            req.setComments('Approval Escalated : ' + comment);
            req.setAction('Approve');
            
            Approval.ProcessResult result = Approval.process(req);
            
            if (result.isSuccess()) {
                System.debug('Approval process succeeded for work item: ' + workItem.Id);
                sendEmail(currentApprover,recordId,comment);
            } else {
                System.debug('Approval process failed for work item: ' + workItem.Id);
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
    }
    
    public static void sendEmail(String userId,String quoteId,String comment){
        list<Messaging.SingleEmailMessage>  mails = new list<Messaging.SingleEmailMessage>();
        
        QuotesN__c quoteRecord = [SELECT Name From QuotesN__c Where Id = : quoteId];
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        //email.setToAddresses(new List<String>{[SELECT Email FROM User WHERE Id =: userId].Id});
        
        email.setToAddresses(new List<String>{'jaysgupta742@gmail.com'});
        email.setSubject('Approval Escalated : ' + quoteRecord.Name);
        email.setHtmlBody('Approval for quote : ' + quoteRecord.Name + ' has been escalated. <br/> <br/>Escalation Comment : ' + comment +'<br/><br/>Regards,<br/><b>'+ userinfo.getName() +'</b>' );
        
        mails.add(email);
        System.debug('Sending mail');
        Messaging.sendEmail(mails);
    }
    
    
    @auraEnabled
    public static List<ProcessInstanceWorkitem> getCurrentApprover(String recordId){
        return [
            SELECT Id, ProcessInstance.TargetObjectId,Actor.Name
            FROM ProcessInstanceWorkitem
            WHERE ProcessInstance.TargetObjectId = :recordId
        ];
    }
    
    @auraEnabled
    public static Map<String,String> getManagerName(){
        
        Map<String,String> mapOfManagers = new Map<String,String>();
        
        User manager = [SELECT Id,Name,Manager.Name From User Where Id =: Userinfo.getUserId()];
        User managerManager = [SELECT Id,Name,Manager.Name From User Where Id =: manager.Id];
        
        mapOfManagers.put('Manager',manager.Manager.Name);
        mapOfManagers.put('ManagersManager',managerManager.Manager.Name);
        
        return mapOfManagers;
        
    }
}