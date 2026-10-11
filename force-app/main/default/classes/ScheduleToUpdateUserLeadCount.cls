/*Author:Amit
* TO Fix api error issue
* Date:14/07/2024
*/
global without sharing class ScheduleToUpdateUserLeadCount Implements Schedulable {
    public String recordId;
    public String jobName;
    
    global ScheduleToUpdateUserLeadCount(String recId,String schedulerJobName) {
        this.recordId = recId;
        this.jobName= schedulerJobName;
    }
    
    global void execute(SchedulableContext ctx) {
        System.debug('Parameter 1: ' + recordId);
        user u=[select id,name,Account_Count__c from user where id=:recordId]; 
        if (u.Account_Count__c == null) {
            u.Account_Count__c = 0;    
        }
        u.Account_Count__c += 1;
        update u;
        
        CronTrigger jobRecord = [SELECT  Id FROM CronTrigger  where CronJobDetail.Name=:jobName];
        System.abortJob(jobRecord.Id);
    }
}