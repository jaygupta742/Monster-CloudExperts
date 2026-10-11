@isTest
public class requestToFinance_test {
    
    @isTest Static void mymethod_test()
        {
            
           List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
         Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
         cs.add(t1k);
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
         cs.add(t2k);
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
         cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
         cs.add(t4);
      insert cs;
            
               user logged=[select id,name,email from user where id=:userinfo.getuserid()];
            
             Account a = new Account();
        a.Name = 'ANKSkkkakka';
       a.SalesChannel__c = 'Enterprise Business';
        a.Segment__c='ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        insert a;
        
              list <OrderC__c> listord = new list<OrderC__c>();
        OrderC__c ord = new OrderC__c();
        ord.Account__c = a.id;

        ord.PrimarySalesRep__c=userInfo.getUserId();
      
        ord.Contract_End_Date__c=system.today()+2;
        Ord.Payment_Amount__c=400;
        ord.TDS_Amount__c=0; 
       
       listord.add(ord);
      
       insert listord;
        
       list <Credit_Request__c> listcr = new list<Credit_Request__c>();
        Credit_Request__c cr = new Credit_Request__c();
        cr.Billing_Account__c=a.Id;
        cr.Credit_Amount__c=20000;
        cr.Credit_Reason__c='Product Issue-Resume Database Performance';
        cr.Credit_Type__c	='Full';
        cr.Credit_Comments__c='sdvdsfvb';
        cr.Order_Number__c='CR-0071043';
        cr.OrderDate__c=System.today();
        cr.Account__c=ord.Account__c;
        cr.Order_Custom__c	=ord.id;
        cr.Approval_Status__c='Approved';
        cr.Request_To_Finance__c = false;      
        listcr.add(cr);
       
        Credit_Request__c cr1 = new Credit_Request__c();
        cr1.Approval_Status__c = 'Pending Approval';    
        cr1.Request_To_Finance__c = false;
        listcr.add(cr1);
            
        Credit_Request__c cr11 = new Credit_Request__c();
        cr11.Approval_Status__c = 'Rejected';    
        cr11.Request_To_Finance__c = false;
        listcr.add(cr11);
            
        Credit_Request__c cr12 = new Credit_Request__c();
        //cr12.Approval_Status__c = 'Rejected';    
        cr12.Request_To_Finance__c = true;
        listcr.add(cr12);
        insert listcr;
         
        requestToFinance.myMethod(listcr[0].id);
        requestToFinance.getRecord(listcr[0].id);
      
        }

}