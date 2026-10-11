@Istest
public class BatchApexToRevertAddressToAccount_Test 
{
    @Istest Public Static void mytest1()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        
        //Account having one address
         
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
     /*    Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.state__c='Singapore State';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;
        */
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
    }
    //2nd method---posting address
    
     @Istest Public Static void mytest2()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        
       
         
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
   /*      Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Posting Address';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Posting Address';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
        Address1__c addr3= new Address1__c();
        addr3.Account__c=a.id;
        addr3.Country__c='Singapore';
        addr3.state__c='Singapore State';
        addr3.Type__c='Billing & Posting';
        addr3.Address1__c='Singapore Street';
        addr3.City__c='Singapore City';
        addr3.PinCode__c='114477225588';
        insert addr3;
        
        Address1__c addr4= new Address1__c();
        addr4.Account__c=a.id;
        addr4.Country__c='Singapore';
        addr4.state__c='Singapore State';
        addr4.Type__c='Billing & Posting';
        addr4.Address1__c='Singapore Street';
        addr4.City__c='Singapore City';
        addr4.PinCode__c='114477225588';
        insert addr4;
        
        */
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
    }
    //3rd method --billing
      @Istest Public Static void mytest3()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        
        
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
      /*   Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Billing';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Billing';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
        Address1__c addr3= new Address1__c();
        addr3.Account__c=a.id;
        addr3.Country__c='Singapore';
        addr3.state__c='Singapore State';
        addr3.Type__c='Billing & Posting';
        addr3.Address1__c='Singapore Street';
        addr3.City__c='Singapore City';
        addr3.PinCode__c='114477225588';
        insert addr3;
        
        Address1__c addr4= new Address1__c();
        addr4.Account__c=a.id;
        addr4.Country__c='Singapore';
        addr4.state__c='Singapore State';
        addr4.Type__c='Billing & Posting';
        addr4.Address1__c='Singapore Street';
        addr4.City__c='Singapore City';
        addr4.PinCode__c='114477225588';
        insert addr4;
        */
        
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
    }
    //method 4---billing and posting /billing and shipping 
    
     @Istest Public Static void mytest4()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        
       
         
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
    /*     Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Billing & Shipping';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Billing & Shipping';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
        Address1__c addr3= new Address1__c();
        addr3.Account__c=a.id;
        addr3.Country__c='Singapore';
        addr3.state__c='Singapore State';
        addr3.Type__c='Billing & Posting';
        addr3.Address1__c='Singapore Street';
        addr3.City__c='Singapore City';
        addr3.PinCode__c='114477225588';
        insert addr3;
        
        Address1__c addr4= new Address1__c();
        addr4.Account__c=a.id;
        addr4.Country__c='Singapore';
        addr4.state__c='Singapore State';
        addr4.Type__c='Billing & Posting';
        addr4.Address1__c='Singapore Street';
        addr4.City__c='Singapore City';
        addr4.PinCode__c='114477225588';
        insert addr4;
        */
        
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
    }
    
     //5th method ---------type-site address /
    @Istest Public Static void mytest5()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        
       
         
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
    /*     Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Site Address';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Site Address';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
        Address1__c addr3= new Address1__c();
        addr3.Account__c=a.id;
        addr3.Country__c='Singapore';
        addr3.state__c='Singapore State';
        addr3.Type__c='Billing';
        addr3.Address1__c='Singapore Street';
        addr3.City__c='Singapore City';
        addr3.PinCode__c='114477225588';
        insert addr3;
        
        Address1__c addr4= new Address1__c();
        addr4.Account__c=a.id;
        addr4.Country__c='Singapore';
        addr4.state__c='Singapore State';
        addr4.Type__c='Billing';
        addr4.Address1__c='Singapore Street';
        addr4.City__c='Singapore City';
        addr4.PinCode__c='114477225588';
        insert addr4;
        */
        
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
    }
    
    
    //method6----site address/posting 
    
     @Istest Public Static void mytest6()
    {
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
        
        
         Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
         insert a;
       
        
  /*       Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Site Address';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Site Address';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
        Address1__c addr3= new Address1__c();
        addr3.Account__c=a.id;
        addr3.Country__c='Singapore';
        addr3.state__c='Singapore State';
        addr3.Type__c='Posting Address';
        addr3.Address1__c='Singapore Street';
        addr3.City__c='Singapore City';
        addr3.PinCode__c='114477225588';
        insert addr3;*/
       BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1);  
        
}   
    
        
    //method 7
     @Istest Public Static void mytest7()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
         
        
    
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
    /*     Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Posting Address';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Posting Address';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
        Address1__c addr3= new Address1__c();
        addr3.Account__c=a.id;
        addr3.Country__c='Singapore';
        addr3.state__c='Singapore State';
        addr3.Type__c='Posting Address';
        addr3.Address1__c='Singapore Street';
        addr3.City__c='Singapore City';
        addr3.PinCode__c='114477225588';
        insert addr3;
        
*/       
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
     }
     //method 10
     @Istest Public Static void mytest10()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
         
        
    
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
    /*     Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Site Address';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Site Address';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
       */
       
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
     }
    
    //method 8
     @Istest Public Static void mytest8()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
         
        
    
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
   /*      Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Billing';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='Billing';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        */
       
       
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
     }
    
     //method 9
     @Istest Public Static void mytest9()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
         
        
    
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
     /*    Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
        
         Address1__c addr2= new Address1__c();
        addr2.Account__c=a.id;
        addr2.Country__c='Singapore';
        addr2.state__c='Singapore State';
        addr2.Type__c='';
        addr2.Address1__c='Singapore Street';
        addr2.City__c='Singapore City';
        addr2.PinCode__c='114477225588';
        insert addr2;
        
       */
       
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
     }
    
     //method 11---for last if condition.
     @Istest Public Static void mytest11()
    {
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c t1 = new Trigger__c(name ='EmailMessage',Active__c = true);
        insert t1;
         
        
    
        Account a = new Account();
        a.Name = 'Finalsumanprax';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Person_Account__c = False;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        
        insert a;
        
   /*     Address1__c addr1= new Address1__c();
        addr1.Account__c=a.id;
        addr1.Country__c='Singapore';
        addr1.state__c='Singapore State';
        addr1.Type__c='Site Address';
        addr1.Address1__c='Singapore Street';
        addr1.City__c='Singapore City';
        addr1.PinCode__c='114477225588';
        insert addr1;
   
       */
       
         BatchApexToRevertAddressToAccount b1=new BatchApexToRevertAddressToAccount();
        ID batchprocessid1 = Database.executeBatch(b1); 
     }
    
    
   }