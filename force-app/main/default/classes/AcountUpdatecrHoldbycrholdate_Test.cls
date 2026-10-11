@istest
public class AcountUpdatecrHoldbycrholdate_Test {
  
    @istest
    public static void triggtest(){
       
        List<Trigger__c> tt = new List<Trigger__c>();
       
        Trigger__c t = new Trigger__c(name = 'Seeker',active__c = true);
        tt.add(t);
       
        Trigger__c t1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        tt.add(t1);
       
       Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
        tt.add(t2);
       
       Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
        tt.add(t3);
        
        Trigger__c t4 = new Trigger__c(name = 'Attachment',active__c = true);
        tt.add(t4);
       
       insert tt;

        
        
        
        Profile profileId = [SELECT Id,Name FROM Profile WHERE Id='00e7F000000uSSh' limit 1];
        
        User usr = new User(LastName = 'LIVESTON',
                           FirstName='JASON',
                           Alias = 'jliv',
                           Email = 'jason.liveston@asdf.com',
                           Username = 'jason.livestonabc@asdf.com',
                           ProfileId = profileId.id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                           LocaleSidKey = 'en_US',
                            department ='SMB Business');
        //insert usr;
                    
           User u= new user(); 
          u=[select id,profileid from user where id='0057F000003Sa4K'];
          System.runAs(u) {    
       
            
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
        //a.CreditStatus__c='ok';
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
        a.OwnerId=u.id;
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='someaddress@email.com';
        c.Phone='9999988888';
        c.Case_Contact__c = true;
        c.PrimarySalesContact__c=true;
        insert c;
       
        a.Lead_Account_Status__c='Active';
        Update a;
      
        a.CreditStatus__c='OK';
        update a;
        

        a.Change_Segment__c=false;
        a.Lead_Account_Active_Date__c = system.today();
        
        update a;
        }
        
    }

}