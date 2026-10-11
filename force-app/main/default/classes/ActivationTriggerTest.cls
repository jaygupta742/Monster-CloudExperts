/*Created by : Abdul Aziz , Created Date :17/06/2023, test class for ActivationTrigger*/
@istest
public class ActivationTriggerTest {
    public @istest static void testdata1(){  
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = true);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        tlist.add(tk);
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = true);
        tlist.add(tshareorder);
        Trigger__c Activation = new Trigger__c(name ='Activation', Active__c = true);
        tlist.add(Activation);
        insert tlist;
        
        Account a = new Account();
        a.Name = 'oppnew';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Lead_Source1__c='ECOMM';
        a.Website='www.asdfert.com';
        a.Phone= '+985478547256';
        a.OtherPhone__c = '+985478547856';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076'; 
        a.ShippingCountry='India';
        a.BillCountry__c = 'India';
        a.BillState__c = 'Karnataka';
        a.PostCountry__c = 'India';
        a.PostState__c = 'Karnataka';
        a.ShippingStreet ='Test Address';
        a.ShippingCity ='bangalore' ;
        a.ShippingPostalCode='560076'; 
        insert a;
        
        Activation__c ac=new Activation__c();
        ac.Account__c=a.Id;
        ac.User__c=UserInfo.getUserId();
        try{
              insert ac;
        }
        catch(Exception e){
            
        }
      
    }
    
}