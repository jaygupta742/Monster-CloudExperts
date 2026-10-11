@isTest
public class RollupOpportunity_test {
     @istest
	public static void RollupOpp_test(){
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
        
       String poten = 'high';
       Profile prof = [SELECT Id FROM Profile WHERE Name = 'Monster - Sales' ];
        string yo = userinfo.getUserId();
        User usr = new User(LastName = 'Swapna Chintala',
                           FirstName='JASON',
                           Alias = 'jliv',
                           Email = 'jason.liveston@asdf.com',
                           Username = 'swapnachintala@monsterindia.com.monster',
                           ProfileId = prof.id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                           LocaleSidKey = 'en_US',
                           department ='Lead Management');
        User u = new user (); 
        u=[select id,profileid from user where id='0057F000003Sa4K'];
       
        
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
        a.Segment__c = 'Commercial';       
        a.Lead_Source1__c= 'Call Inbound';
        insert a;
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
       
        a.Lead_Account_Status__c='Active';
        Update a;
       
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Contact__c = c.id;
        o.Name__c ='oppnewww';
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        o.OpportunitySource__c = 'Customer Service';
       
        insert o; 
       o.Potential__c='High';
            update o;
        
        delete o;
        delete a;
        
       
    }
}