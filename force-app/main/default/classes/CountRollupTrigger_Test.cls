@istest
public class CountRollupTrigger_Test {
public static testmethod void metPa(){
        
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
        list<Account> acc = new list<Account>(); 
        //Sales Channel , Import Source , Lead Source , Location , Website , Phone , Registration Number , APAC Industry , Account Type , No. of Employees
        for(integer i=0;i<200;i++){
         Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
            a.Lead_Source1__c = 'CR';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917569854785';
        a.OtherPhone__c = '+968547856985';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.CurrencyIsoCode='INR';
        acc.add(a);
        }
        insert acc;
        List<OrderC__c> ord = new List<OrderC__c>(); 
       
            for(integer i=0;i<200;i++){
                 OrderC__c o = new OrderC__c();
                o.Account__c = acc[i].id;
                o.Order_Comment__c = 'Order Comments';
                ord.add(o);
            }
        insert ord;
         
        update ord;
        List<Order_Line_Item__c> ordl = new List<Order_Line_Item__c>(); 
        for(integer i=0;i<200;i++){
            Order_Line_Item__c cc= new Order_Line_Item__c();
            cc.Quantity__c=11;
            cc.Order__c=ord[i].id;
            ordl.add(cc);
        }
        
        
        insert ordl; 
        ordl[1].End_Date__C=system.today();
        update ordl;
        delete ord;
        undelete ord;
    }
}