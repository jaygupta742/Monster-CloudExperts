@isTest
public class SurevyMonkeyWhenTheCaseIsClosed_Test {
    
    public static testmethod void met(){
        
        List<Trigger__c> ttr = new List<Trigger__c>();
       
        Trigger__c tr = new Trigger__c(name = 'Compliance',active__c = true);
        ttr.add(tr);
       
        Trigger__c tr1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        ttr.add(tr1);
       
       Trigger__c tr2 = new Trigger__c(name = 'Account',active__c = true);
        ttr.add(tr2);
       
       Trigger__c tr3 = new Trigger__c(name = 'Contact',active__c = true);
        ttr.add(tr3);
        
        Trigger__c tr4 = new Trigger__c(name = 'Case',active__c = true);
        ttr.add(tr4);
      
       insert ttr;
       
       User u1 = [SELECT id,lastname,Alias FROM user WHERE Profile_Name__c ='Monster - Service/CR' AND IsActive = true AND Alias='ASriniva' LIMIT 1];
        Case_Escalation__c ce = new Case_Escalation__c();
        ce.Name = '1stescalation';
        ce.UID__c = u1.id;
        ce.Email__c = 'email@gmail.com';
        insert ce;
        
        user u = [SELECT id,lastname,Alias FROM user WHERE Profile_Name__c ='Monster - Service/CR' AND IsActive = true AND Alias='akand' LIMIT 1];
        system.runAs(u){
        
         Account a = new Account();
          a.Name = 'Testaccount';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='eeee';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='Hong Kong';
        a.Website='www.asdfert.com';
        a.Phone= '+918965874589';
        a.OtherPhone__c = '+987456985474';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Segment__c = 'Commercial';
        a.Lead_Source1__c= 'Call Inbound';
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
        insert a;
        
        List<contact> con = new List<contact>();
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        con.add(c);
     
       /* Contact c1 = new Contact();
        c1.AccountID= a.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='9898989898';
        con.add(c1);
          
        Contact c11 = new Contact();
        c11.AccountID= a.Id;
        c11.LastName='MahendraBaahubali';
        c11.Email='mbahu@gmail.com';
        c11.Phone='9898989898';
        con.add(c11);
        insert con;*/
            
        Test.startTest();
        //con=[select id,name,CSAT_Mail_Sent__c from contact limit 1];
      
         case__c ca = new case__C();
         ca.Category__c = 'Seeker';
         ca.Account__c = a.id;
         ca.Contact__c =c.id;
         
         ca.SuppliedEmail__c = 'testing@gmail.com';
         ca.Keyword_Search__c = true;
         insert ca;
       
        ca.Status__c = 'Closed';
        ca.Category__c = 'Employer';
        ca.Issue__c = 'Login Issue';
        ca.OwnerId = u.id;
        ca.Escalated_Time__c = Date.newInstance(2020,6,10);
        update ca;
           
       List<case__c> locc = new List<case__c>();
       locc.add(ca);
         try{ 
           List<id> li = new List<id>();
        for(case__c ca1 : locc)
        {
             li.add(ca1.id); 
        }
        SurevyMonkeyWhenTheCaseIsClosed.insertEmail(li);
        SurevyMonkeyWhenTheCaseIsClosed.met(li);
        Test.stopTest();
        }
        catch(exception e)
        {
            
        }
        c.CSAT_Mail_Sent__c = true;
        update c;
        }
    }
}