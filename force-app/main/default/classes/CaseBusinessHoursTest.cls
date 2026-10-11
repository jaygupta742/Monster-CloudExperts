//test class is for Case Trigger
@isTest(seealldata = true)
public class CaseBusinessHoursTest {
    
    public static testmethod void  test(){
        
        
        user u = [SELECT id,name from user WHERE Alias = 'AbSheikh'];
        List<BusinessHours> bhs=[select id from BusinessHours where IsDefault=true];
        
        /*  List<Trigger__c> tt = new List<Trigger__c>();

Trigger__c t1 = new Trigger__c(name = 'EmailMessage',active__c = true);
tt.add(t1); 

Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
tt.add(t2);

Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
tt.add(t3);

Trigger__c t = new Trigger__c(name = 'Case', active__c = true);
tt.add(t);

insert tt;

Case_Escalation__c ce = new Case_Escalation__c();
ce.Name = '1stescalation';
ce.UID__c = '0057F000003Sa4T';
ce.Email__c = 'email@gmail.com';
insert ce;*/
        
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
        a.CreditStatus__c='OK';
        
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='some@email.com';
        c.Phone='9999988888';
        c.PrimarySalesContact__c=true;
        insert c;
        
        
        //for(integer i=0;i<200;i++){
        case__c ca = new case__C();
        ca.Category__c = 'Seeker';
        ca.Status__c = 'New';
        
        //c.add(ca);
        //}
        insert ca;
        
        //for(case__c cc : c){
        ca.Category__c = 'Employer';
        ca.OwnerId = u.id;
        //}
        
        update ca;
        
        ca.SuppliedEmail__c = 'seeta@gmail.com';
        ca.Status__c = 'Closed';
        ca.Category__c = 'Employer';
        ca.Issue__c = 'Login Issue';
        ca.Keyword_Search__c = true;
        ca.Contact__c = c.id;
        
        update ca;
        ca.Status__c = 'Reopen';
        update ca;
        
        ca.Status__c = 'Closed';
        update ca;
        
    }
    
}