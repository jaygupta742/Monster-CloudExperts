@istest
public class Accountchangesemail_test {

 @istest
     static void  triggtest(){
       
        Trigger__c te = new Trigger__c(name ='Account',Active__c = true);
        insert te;
         Trigger__c t1qq = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1qq;
        
         Trigger__c t2qq = new Trigger__c(name ='Contact',Active__c = true);
        insert t2qq;
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
         //id='0057F000003ST4YQAW'
        user u = new user();
         u = [select id,name,profileid from user where id='0057F000003ST4YQAW' AND profile.name ='Monster - Sales Ops/LM'];
         list<Account> aklst = new list<Account>();
          list<Account> tpud = new list<Account>();
         list<contact> conlist = new list<contact>();
         system.runAs(u){
        Account a = new Account();
        a.Name = 'cloud';
        a.Trade_name__c = 'cloud';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='frstreg1';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Change_Segment__c = false;   
         a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a.BillingStreet ='Test Address';
         a.BillingCity ='bangalore' ;
         a.BillingState='Karnataka';
         a.BillingPostalCode='560076';
         a.ShippingCountry ='India';
         a.ShippingStreet ='vega street';
         a.ShippingCity ='ubcity';
         a.ShippingState = 'ourstate';
         a.ShippingPostalCode ='45555555';
         a.Location__c ='Middle East';
             a.GST_ID__c = 'gst456';
        a.VATNumber__c = 'vt111';
             insert a;
           
          Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;   
 
             a.Name = 'reconename';  
             update a;
             a.Trade_name__c = 'trado';
             update a;
             a.VATNumber__c = 'waat3';
             update a;
             a.RegistrationNumber__c = 'rgrgr323';
             update a;
             a.BillingCity = 'tn';
             update a;
             
               test.startTest();  
             a.Lead_Account_Status__c = 'Active';
             update a;
     test.stopTest();
}    
   } 
   
     @istest
     static void  triggtest3(){
       
        Trigger__c te = new Trigger__c(name ='Account',Active__c = true);
        insert te;
         Trigger__c t1qq = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1qq;
         Trigger__c t2qq = new Trigger__c(name ='Contact',Active__c = true);
        insert t2qq;
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
         //id='0057F000003ST4YQAW'
        user u = new user();
         u = [select id,name,profileid from user where id='0057F000003ST4YQAW' AND profile.name ='Monster - Sales Ops/LM'];
         list<Account> aklst = new list<Account>();
          list<Account> tpud = new list<Account>();
         list<contact> conlist = new list<contact>();
         system.runAs(u){
        Account a = new Account();
        a.Name = 'cloud';
        a.Trade_name__c = 'cloud';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
       
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='frstreg1';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Change_Segment__c = false;   
         a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a.BillingStreet ='Test Address';
         a.BillingCity ='bangalore' ;
         a.BillingState='Karnataka';
         a.BillingPostalCode='560076';
         a.ShippingCountry ='India';
         a.ShippingStreet ='vega street';
         a.ShippingCity ='ubcity';
         a.ShippingState = 'ourstate';
         a.ShippingPostalCode ='45555555';
         a.Location__c ='Malaysia';
         a.GST_ID__c = 'gst456';
        a.VATNumber__c = 'vt111';
             insert a;
           
          Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;   
             a.Name = 'reconename';  
             update a;
             a.Trade_name__c = 'trado';
             update a;
             a.VATNumber__c = 'waat3';
             update a;
             a.RegistrationNumber__c = 'rgrgr323';
             update a;
             a.BillingCity = 'tn';
             update a;
           test.startTest();   
             a.Lead_Account_Status__c = 'active';
             update a;
           test.stopTest();
}    
   } 
    
    @istest
     static void  triggtest1(){
       
        Trigger__c te = new Trigger__c(name ='Account',Active__c = true);
        insert te;
         Trigger__c t1qq = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1qq;
        
         Trigger__c t2qq = new Trigger__c(name ='Contact',Active__c = true);
        insert t2qq;
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
         //id='0057F000003ST4YQAW'
        user u = new user();
         u = [select id,name,profileid from user where id='0057F000003ST4YQAW' AND profile.name ='Monster - Sales Ops/LM'];
         list<Account> aklst = new list<Account>();
          list<Account> tpud = new list<Account>();
         list<contact> conlist = new list<contact>();
         system.runAs(u){
        Account a = new Account();
        a.Name = 'cloud';
        a.Trade_name__c = 'cloud';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='frstreg1';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Change_Segment__c = false;   
         a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
         a.BillingStreet ='Test Address';
         a.BillingCity ='bangalore' ;
         a.BillingState='Karnataka';
         a.BillingPostalCode='560076';
         a.ShippingCountry ='India';
         a.ShippingStreet ='vega street';
         a.ShippingCity ='ubcity';
         a.ShippingState = 'ourstate';
         a.ShippingPostalCode ='45555555';
         a.Location__c ='India';
             a.GST_ID__c = 'gst456';
        a.VATNumber__c = 'vt111';
             insert a;
           Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
      
             a.Name = 'reconename';  
             update a;
             a.Trade_name__c = 'trado';
             update a;
             a.VATNumber__c = 'waat3';
             update a;
             a.RegistrationNumber__c = 'rgrgr323';
             update a;
             a.BillingCity = 'tn';
             update a;
               test.startTest();  
             a.Lead_Account_Status__c = 'active';
             update a;
           test.stopTest();
}    
   } 
}