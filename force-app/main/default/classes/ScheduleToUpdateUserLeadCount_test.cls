@isTest
public class ScheduleToUpdateUserLeadCount_test {
 @istest 
    static void seekertest(){
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        PA_Owner_Assignment__c pp=new PA_Owner_Assignment__c();
        pp.Count__c=0;
        pp.UserId__c=userinfo.getUserId();
        pp.Name='malek';
        pp.Location__c='India';
        insert pp;
        
        Account a = new Account();
        a.Name = 'Pramodh';
        a.SalesChannel__c = 'SMB';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Integration__c = true;
        a.Team__c='Edtech-Courses';
        insert a;
        
        PA_Owner_Assignment__c p = new PA_Owner_Assignment__c();
        p.Name = '1';
        p.Location__c = 'India';
        p.Count__c = 0;
        p.UserId__c = '0057F000004RCwEQAW';
        insert p;
        Datetime dt = System.now();
        Datetime now = Datetime.now();
            Datetime scheduleTime = now.addSeconds(20);
            String seconds = String.valueOf(scheduleTime.second());
            String minutes = String.valueOf(scheduleTime.minute());
            String hours = String.valueOf(scheduleTime.hour());
            String dayOfMonth = String.valueOf(scheduleTime.day());
            String month = String.valueOf(scheduleTime.month());
            String year = String.valueOf(scheduleTime.year());
            String cronExpression = seconds + ' ' + minutes + ' ' + hours + ' ' + dayOfMonth + ' ' + month + ' ? ' + year;
            String jobName='UserApexScheduler'+cronExpression;
			 
            system.debug('jobName dpId'+ jobName + '' +'0057F000004RCwEQAW');
            ScheduleToUpdateUserLeadCount myClass = new ScheduleToUpdateUserLeadCount('0057F000004RCwEQAW',jobName);   
            String jobId =  system.schedule(jobName, cronExpression, myClass);
    }
}