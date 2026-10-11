public without sharing class NewEscalateApproval {    
    @AuraEnabled
    public static string escateapproval(string rid){
        boolean b;
        List<ProcessInstance> app=[SELECT Id, Status, CreatedDate, CompletedDate, TargetObjectId, 
                                   (SELECT Id, StepStatus, Actor.Name, ElapsedTimeInDays, ElapsedTimeInMinutes, 
                                    CreatedDate, ProcessNodeId, ProcessNode.Name, Comments 
                                    FROM StepsAndWorkitems order by CreatedDate) from ProcessInstance Where TargetObjectID = :rid AND Status = 'Pending'];
       // system.debug('approval pro:'+app[0].StepsAndWorkitems);
        
        QuotesN__c qq=[select id,name,Level_of_Approval_Done__c,Level_1_Approval_Done__c,Level_2_Approval_Done__c,Level_3_Approval_Done__c,
                       Level_4_Approval_Done__c,Level_of_Approval_maxima_from_QLI__c,Approver_1__c,Approver_2__c,Approver_3__c from QuotesN__c where id=:rid];
        
        /*List<ProcessInstanceWorkitem> workItems = [
SELECT Id, ProcessInstanceId,ProcessNodeId
FROM ProcessInstanceWorkitem 
WHERE ProcessInstanceId= :app[0].Id 
];*/
        
        //List<ProcessInstanceWorkitem> prolist=[SELECT Id, Actor.Name, ElapsedTimeInDays, ElapsedTimeInMinutes, 
        // CreatedDate, ProcessNodeId, ProcessNode.Name, Comments from ProcessInstanceWorkitem where ProcessInstanceId=:app[0].Id];
        //system.debug('prolist:'+prolist);
        decimal num=qq.Level_of_Approval_maxima_from_QLI__c-1;
        system.debug('num:'+num);
        
        if(app!=null){
            if(qq.Level_of_Approval_Done__c==null){
                qq.Level_of_Approval_Done__c=0;
            }
            system.debug('level of approval:'+qq.Level_of_Approval_maxima_from_QLI__c);
            system.debug('level of approval done:'+qq.Level_of_Approval_Done__c);
            
            if((qq.Level_of_Approval_maxima_from_QLI__c==3 && qq.Level_of_Approval_Done__c<2) ||(qq.Level_of_Approval_maxima_from_QLI__c==4 && qq.Level_of_Approval_Done__c<3) ||
               (qq.Level_of_Approval_maxima_from_QLI__c==2 && qq.Level_of_Approval_Done__c<1)){
                 ProcessInstanceWorkitem pi = [select Id,OriginalActorId from ProcessInstanceWorkitem where ProcessInstanceId= :app[0].Id];
                  system.debug('pi:'+pi);
                   
                   Approval.ProcessWorkitemRequest prWkItem = new Approval.ProcessWorkitemRequest();
                  prWkItem.setWorkItemID(pi.id);
                   prWkItem.setComments('Escalated and got Approved!!');
                   prWkItem.setAction('Approve');
                   Approval.ProcessResult appResult = Approval.process(prWkItem);
               }
        }
        /* if((qq.Level_of_Approval_maxima_from_QLI__c==3 && qq.Level_of_Approval_Done__c<2) ||(qq.Level_of_Approval_maxima_from_QLI__c==4 && qq.Level_of_Approval_Done__c<3) ||
(qq.Level_of_Approval_maxima_from_QLI__c==2 && qq.Level_of_Approval_Done__c<1)){
b=true;

}
else{
b=false;
}
*/
        return rid;
    }
    
    @AuraEnabled
    public static String sendMail(String rid){
        system.debug('recordId : ' + rid);
        list<String> toadd = new list<String>();
        list<String> allApprover = new List<String>();
        Map<String, Integer> map_approver_order = new map<String, Integer> ();
        QuotesN__c qlist = new QuotesN__c();
        qlist = [select Id,Name,owner.email,Approver_1__c,Approver_1__r.Email, Approver_2__r.Email,
                 Approver_3__r.Email, Approver_4__r.Email, Level_of_Approval_maxima_from_QLI__c from QuotesN__c where Id=:rid];
        
        String c_user = UserInfo.getUserId();
        String c_email = UserInfo.getUserEmail();
        String c_profile = UserInfo.getProfileId();
        
        Profile admin_profile = [SELECT Id, Name FROM Profile WHERE Name =: 'System Admin']; 
        
        system.debug('user email id : ' + qlist.Approver_1__r.Email);
        allApprover.add(qlist.Approver_1__r.Email);
        allApprover.add(qlist.Approver_2__r.Email);
        allApprover.add(qlist.Approver_3__r.Email);
        allApprover.add(qlist.Approver_4__r.Email);
        
        system.debug('c user profile id : ' + c_profile);
        system.debug('admin profile id : ' + admin_profile.Id);
        if(c_profile == admin_profile.Id) map_approver_order.put(c_user, 0);
        map_approver_order.put(qlist.Approver_1__c, 1);
        map_approver_order.put(qlist.Approver_2__c, 2);
        map_approver_order.put(qlist.Approver_3__c, 3);
        map_approver_order.put(qlist.Approver_4__c, 4);
        
        if(map_approver_order.containsKey(c_user)) {
            if(map_approver_order.get(c_user) >= qlist.Level_of_Approval_maxima_from_QLI__c) {
                return 'error-1';
            } else {
                system.debug('on else block');
                toadd.add(c_email);
               // toadd.add('bapi98deba@gmail.com');
               // toadd.add('skthorat2141@gmail.com');
                string body ='<br/>This is to inform that you have escalate approval <br/>';
                
                list<Messaging.SingleEmailMessage>  mails = new list<Messaging.SingleEmailMessage>();
                 
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                
                // System.debug('The To add is  : '+toadd);
                email.setToAddresses(toadd);
                email.setSubject('Update About Approval ');
                email.setHtmlBody(body+'Regards, <br/><br/><b> Developer</b>' );
                
                mails.add(email);
                System.debug('Sending mail');
                Messaging.sendEmail(mails);
                return 'success';
            }
        } else {
            return 'error-2';
        }
    }
}


/*@AuraEnabled
public static boolean getquoteinfo(string rid){
boolean bool;
List<QuotesN__c> qqq=[select id,name,Level_of_Approval_Done__c,Level_1_Approval_Done__c,Level_2_Approval_Done__c,Level_3_Approval_Done__c,
Level_4_Approval_Done__c,Level_of_Approval_maxima_from_QLI__c from QuotesN__c where id=:rid];

for(QuotesN__c qq:qqq){
if((qq.Level_of_Approval_maxima_from_QLI__c==3 && qq.Level_of_Approval_Done__c<2) ||(qq.Level_of_Approval_maxima_from_QLI__c==4 && qq.Level_of_Approval_Done__c<3) ||
(qq.Level_of_Approval_maxima_from_QLI__c==2 && qq.Level_of_Approval_Done__c<1)){
bool=true;
break;
}
//system.debug('b:'+b);
else{
bool=false;

}
}
system.debug('bool:'+bool);

return bool;
}*/