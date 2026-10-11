public class SurveyLinkSchedule Implements Schedulable{
    
    public void execute(SchedulableContext sc)
        {
            method1();
        }
    
    public void method1() 
    {
        List<contact> loc = new List<contact>();
        List<contact> loc1 = new List<contact>();
        loc= [select id,name,CSAT_Mail_Sent__c from contact where CSAT_Mail_Sent__c= true];
        for(contact c1:loc)
        {
            c1.CSAT_Mail_Sent__c = false;
            loc1.add(c1);
            System.debug('This is the list of loc');
        }
       update loc1;
    }

}