//Created by Vijay Somvanshi on 09/08/2024 
@istest
public class SeekerLeadAssignmentScheduler_Test {
    public static testmethod void testdata(){
        List<Trigger__c> tt = new List<Trigger__c>();
        Trigger__c t = new Trigger__c(name = 'Seeker',active__c = true);
        tt.add(t);
        Trigger__c t1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        tt.add(t1);
        Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
        tt.add(t2);
        Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
        tt.add(t3);
        Trigger__c t4 = new Trigger__c(name = 'Attachment',active__c = true);
        tt.add(t4);
        insert tt;
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Case_Accounts__c = true;
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        //a.CreditStatus__c='ok';
        a.BillingStreet='street1';
        a.BillingCity='city1';
        a.BillCountry__c='INDIA';
        a.BillingState='State1';
        a.ShippingStreet='street2';
        a.ShippingCity='cty2';
        a.ShippingState='state2';
        a.ShippingPostalCode='5600182';
        a.BillingPostalCode='5600892';
        a.ShippingCountry='INDIA';
        //a.Last_Activity_Created_Date__c = system.today().addDays(-3);
        // a.OwnerId=u.id;
        a.Account_Shared__c = false;
        a.Owner_Channel1__c = true;
        insert a;
        String sch = '0 0 0 15 3 ? 2025';
        try{
            // Unschedule any existing jobs with the same name
            List<CronTrigger> cronTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'EdSales Lead Assignment Scheduler'];
            for (CronTrigger cronTrigger : cronTriggers) {
                System.abortJob(cronTrigger.Id);
            }
            Test.startTest();
            String jobId = system.schedule('new class', sch, new SeekerLeadAssignmentScheduler());
            Test.stopTest(); 
        }catch(Exception e){
            
        }
    }    
}