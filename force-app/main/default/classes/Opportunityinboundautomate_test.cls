@istest
public class Opportunityinboundautomate_test {
    
    @istest
    static void oppmethinbound(){
        
        Trigger__c te = new Trigger__c(name ='Account',Active__c = true);
        insert te;        
        Trigger__c t1qq = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1qq;        
        Trigger__c t2qq = new Trigger__c(name ='Contact',Active__c = true);
        insert t2qq;        
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;        
        Trigger__c top = new Trigger__c(name='Opportunity',Active__c = true); 
        insert top;
        
   		// top = [select id,name,Active__c FROM Trigger__c WHERE name='Opportunity' LIMIT 1];
		 string bod;
       
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
        system.runAs(u){
        
            Account a = new Account();
            a.Name = 'cloud';
            a.Trade_name__c = 'cloud';
            a.SalesChannel__c = 'ECOMM';
            a.Import_Source__c='sssss';
            a.Lead_Source1__c='CR';
            a.Segment__c = 'ECOMM';
            a.OwnerId=u.id;
            a.APAC_Industry__c='Energy';
            a.No_of_Employees__c= 25;
            a.Account_Type__c='NIT';
            a.Location__c='India';
            a.Website='www.asdfert.com';
            a.Phone= '+917878787878';
            a.RegistrationNumber__c='reg111111';
            a.Lead_Account_Status__c='Inactive';
            a.CreditStatus__c='OK';
            a.SalesChannel__c ='ECOMM';            
            a.Change_Segment__c = false;            
            a.Segment__c ='ecomm';
            a.GST_ID__c = 'gst456';
            a.RegistrationNumber__c ='reg123';
            a.VATNumber__c = '8524vat';            
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
            insert a;
      
            Contact c = new Contact();
            c.AccountID= a.Id;
            c.LastName='MahendraBaahubali';
            c.Email='mbahu@gmail.com';
            c.Phone='9898989898';
            c.PrimarySalesContact__c=true;
            insert c;
            a.Lead_Account_Status__c='Active';
            Update a;
    
            Opportunity__c o = new Opportunity__c();
            o.Account__c= a.id;
            o.Contact__c = c.id;
            o.Name__c ='oppnewww';
            o.Probability__c = '0';
            o.CreatedDate = date.newInstance(2018, 12,12);
            o.Close_Date__c=system.today();
            o.OwnerId = a.OwnerId;
            o.OpportunityType__c='New Customer';
            o.Products_Interested__c = 'Branding;Trail-Job Postings';
            o.Stage__c='Identification';
            o.Branding_Revenue__c = 0;
            o.Custom_Job_Template_Revenue__c= 0;
            o.Custom_Sponsorship_Revenue__c= 0;
            o.Custom_International_Sponsorship_Reven__c = 0;
            o.Job_Postings_Revenue__c= 0;
            o.Logo_on_Job_Postings_Revenue__c= 0;
            o.Monster_Assessments_Revenue__c= 0;
            o.Monster_Mirror_Revenue__c= 0;
            o.Monster_Widget_Revenue__c= 0;
            o.Premium_Resume_Search_Revenue__c= 0;
            o.Promotional_Offer_Revenue__c= 0;
            o.Short_Message_Service_Revenue__c= 0;
            o.QHire_Revenue__c= 0;
            o.Social_Job_Ads_Revenue__c= 0;
            o.TalentBin_by_Monster_Revenue__c= 0;
            o.Target_Mailers_Revenue__c= 0;
            o.Walk_in_Pro_Event_Revenue__c= 0;
            o.Competitor__c='testing123';
            insert o;    
            
            o.Potential__c='High';
            update o;
  
            a.Lead_Account_Status__c = 'Inactive';
            update a;
        
           // test.startTest();
            PageReference sndtmp = page.Opportunityinboundautomate;
            test.setCurrentPage(sndtmp);       
            apexpages.currentPage().getParameters().put('id',o.Id);
            ApexPages.StandardController sc = new ApexPages.standardController(o);        
            Opportunityinboundautomate opvf = new Opportunityinboundautomate ();
            opvf.ccad = 'cc2gmail.com';           
            opvf.oppmail();
            opvf.ccad='';
            opvf.oppmail();
            opvf.getCcmoinbound(); 
            opvf.oppmail();
        	//test.stopTest();
    	}    
	}    
}