@istest
public class ContactPrimUpdateTest {

    public static testmethod void primupdate(){
        
        test.startTest();
      List<Account> a =new List<Account>();  
        for(integer i = 0;i<200;i++){
            Account acc1 =new Account();
        acc1.Name = 'Test'+i;
        acc1.SalesChannel__c = 'ECOMM';
        acc1.Segment__c = 'Commercial';
        acc1.Import_Source__c = 'test rep gen';
        acc1.Lead_Source1__c = 'ECOMM';
        acc1.APAC_Industry__c = 'Automobile';
        acc1.Account_Type__c = 'NIT';
        acc1.No_of_Employees__c = 20;
        acc1.Location__c = 'Philippines';
        acc1.Website = 'www.test'+i+'.com';
        acc1.Phone = '+91783332399'+i;
        acc1.OtherPhone__c='+9999999999'  ;  
        acc1.CreditStatus__c ='OK';
        acc1.Lead_Account_Status__c = 'Inactive';
        acc1.RegistrationNumber__c='ssssyyyssss';
            
            a.add(acc1);
        }
        
       insert a;
      /*  
        list<contact> cc = new list<contact>();
        for(integer i=0;i<200;i++){
            Contact c = new Contact();
        c.AccountID= a[0].Id;
        c.LastName='Atest';
        c.Email='test@gmail.com';
        c.Phone = a[0].phone;
        c.PrimarySalesContact__c = true; 
        c.PrimaryServiceContact__c = true;
       cc.add(c);
        }
        insert cc;
        
        for(contact co : cc){
           co.PrimarySalesContact__c = true; 
        co.PrimaryServiceContact__c = true; 
        }
        update cc;
         
        */
        
         Trigger__c t = new Trigger__c(name ='Contact',Active__c = true);
        insert t;
        
        
        Contact c = new Contact();
        c.AccountID= a[0].Id;
        c.LastName='Atest';
        c.Email='test@gmail.com';
        c.Phone = a[0].phone;
        c.PrimarySalesContact__c = true; 
        c.PrimaryServiceContact__c = true;
       insert c;
        
        Contact c1 = new Contact();
        c1.AccountID= a[0].Id;
        c1.LastName='Atest1';
        c1.Email='test1@gmail.com';
        c1.phone=a[0].phone;
        c1.PrimarySalesContact__c = true;
        c1.PrimaryServiceContact__c = true;
        insert c1;
        
        Contact c2 = new Contact();
        c2.AccountID= a[0].Id;
        c2.LastName='Atest2';
        c2.Email='test2@gmail.com';
        c2.phone = a[0].phone;
        c2.PrimarySalesContact__c = true;
        insert c2;
        
         
        Contact c3 = new Contact();
        c3.AccountID= a[0].Id;
        c3.LastName='Atest3';
        c3.Email='test3@gmail.com';
        c3.phone = a[0].phone;
        c3.PrimaryServiceContact__c = true;
        insert c3;
        
        test.stopTest();
        
    }
}