@istest
public class UpdatePrimContnSer_Test {
    @istest static void testPa(){
        
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
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
            acc1.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
            acc1.BillingState='Karnataka';
            acc1.BillingStreet ='Test Address';
            acc1.BillingCity ='bangalore' ;
            acc1.BillingPostalCode='560076'; 
            acc1.ShippingCountry='India';
            acc1.BillCountry__c = 'India';
            acc1.BillState__c = 'Karnataka';
            acc1.PostCountry__c = 'India';
            acc1.PostState__c = 'Karnataka';
            acc1.ShippingStreet ='Test Address';
            acc1.ShippingCity ='bangalore' ;
            acc1.ShippingPostalCode='560076';     
            
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
        
        
        list<contact> cc = new list<contact>();
        
        Contact c = new Contact();
        c.AccountID= a[0].Id;
        c.LastName='Atest';
        c.Email='test@gmail.com';
        c.Phone = a[0].phone;
        c.PrimarySalesContact__c = true; 
        c.PrimaryServiceContact__c = true;
        //insert c;
        cc.add(c);
        Contact c1 = new Contact();
        c1.AccountID= a[0].Id;
        c1.LastName='Atest1';
        c1.Email='test1@gmail.com';
        c1.phone=a[0].phone;
        c1.PrimarySalesContact__c = true;
        c1.PrimaryServiceContact__c = true;
        //insert c1;
        cc.add(c1);
        Contact c2 = new Contact();
        c2.AccountID= a[0].Id;
        c2.LastName='Atest2';
        c2.Email='test2@gmail.com';
        c2.phone = a[0].phone;
        c2.PrimarySalesContact__c = true;
        // insert c2;
        cc.add(c2);
        
        Contact c3 = new Contact();
        c3.AccountID= a[0].Id;
        c3.LastName='Atest3';
        c3.Email='test3@gmail.com';
        c3.phone = a[0].phone;
        c3.PrimaryServiceContact__c = true;
        cc.add(c3);
        insert cc;
        Contact c4 = new Contact();
        c4.AccountID= a[0].Id;
        c4.LastName='Atest3';
        c4.Email='test3@gmail.com';
        c4.phone = a[0].phone;
        c4.PrimaryServiceContact__c = true;
        //c4.PrimarySalesContact__c = true;
        
        insert c4;
        c3.PrimaryServiceContact__c = true;
        //c3.PrimarySalesContact__c = true;
        update c3;
        delete c3;
    }
}