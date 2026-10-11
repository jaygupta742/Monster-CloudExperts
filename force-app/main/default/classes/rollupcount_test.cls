@istest
public class rollupcount_test {
 @istest
    public static void testdata(){
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
        
       
            
            user uu=[select id,name,Ameyo_Lead_Id__c from user where id=:userinfo.getUserId()];
            
            List<Account> acclist=new List<Account>();
            Account a = new Account();
            a.Name = 'ANUP ENTERPRISE INDIA LTD';
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
            a.OwnerId = userinfo.getUserId();
            acclist.add(a);
            
            Account a1 = new Account();
            a1.Name = 'ANUP ENTERPRISE INDIA LTD';
            a1.SalesChannel__c = 'Enterprise Business';
            a1.Segment__c='ECOMM';
            a1.Import_Source__c='sssss';
            a1.Lead_Source1__c='Other';
            a1.APAC_Industry__c='Energy';
            a1.No_of_Employees__c= 25;
            a1.Account_Type__c='NIT';
            a1.Location__c='India';
            a1.Website='www.asdfert.com';
            a1.Phone= '+917878787878';
            a1.RegistrationNumber__c='asq111111';
            a1.Lead_Account_Status__c='Inactive';
            a1.CreditStatus__c='OK';
            a1.BillingCountry='India' ; 
            a1.BillingState='Karnataka';
            a1.BillingStreet ='Test Address';
            a1.BillingCity ='bangalore' ;
            a1.BillingPostalCode='560076';
            a1.ShippingCountry='India';
            a1.ShippingCity='Test';
            a1.ShippingPostalCode='56000';
            a1.ShippingState ='Test Address';
            a1.ShippingStreet='Jssttts';
            a1.OwnerId = userinfo.getUserId();
            acclist.add(a1);
            
            insert acclist;
           Call_Disposition__c cd=new Call_Disposition__c();
            cd.Account__c=acclist[0].id;
            cd.call_time__c=system.now();
            cd.Disposition_Type__c='Manual';
            insert cd;
                        
            
            
            
            
            
           
        
    }
}