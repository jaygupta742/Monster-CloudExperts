@isTest
public class opportunityCreate_test {  
  static testmethod void oppmethod(){
     
       Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
       insert t;
       Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
       insert t2;
       Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
       insert t1k;
        
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
        a.OwnerId = userinfo.getUserId();
        insert a;
        
      Account a1 = new Account();
        a1.Name = 'oppnew';
        a1.SalesChannel__c = 'ECOMM';
        a1.Import_Source__c='sssss';
        a1.Lead_Source__c='Other';
        a1.APAC_Industry__c='Energy';
        a1.No_of_Employees__c= 25;
        a1.Account_Type__c='NIT';
        a1.Location__c='India';
        a1.Lead_Source1__c='ECOMM';
        a1.Website='www.asdfert.com';
        a1.Phone= '+985478547256';
        a1.OtherPhone__c = '+985478547856';
        a1.RegistrationNumber__c='asq111111';
        a1.Lead_Account_Status__c='Inactive';
        a1.CreditStatus__c = 'On Hold - Finance';
        a1.BillingCountry='India' ; 
        a1.BillingState='Karnataka';
        a1.BillingStreet ='Test Address';
        a1.BillingCity ='bangalore' ;
        a1.BillingPostalCode='560076'; 
        a1.ShippingCountry='India';
        a1.BillCountry__c = 'India';
        a1.BillState__c = 'Karnataka';
        a1.PostCountry__c = 'India';
        a1.PostState__c = 'Karnataka';
        a1.ShippingStreet ='Test Address';
        a1.ShippingCity ='bangalore' ;
        a1.ShippingPostalCode='560076'; 
        a1.OwnerId = userinfo.getUserId();
        insert a1;
      
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;    
     
        Contact c1 = new Contact();
        c1.AccountID= a.Id;
        c1.LastName='MahendraBaahubali';
        c1.Email='mbahu@gmail.com';
        c1.Phone='9898989898';
        c1.PrimaryServiceContact__c=true;
        insert c1;
        
        a.Lead_Account_Status__c='Active';
        Update a;
     
        
 
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Contact__c = c.id;
        o.Name__c ='oppnewd';
        o.Probability__c = '0';
        o.CreatedDate = date.newInstance(2018, 11,11);
        o.Close_Date__c=system.today();
        o.OwnerId = a.OwnerId;
        o.OpportunityType__c='New customer';
        
        o.Products_Interested__c = 'Branding';
        o.Branding_Revenue__c =0;
       
       
       o.Products_Interested__c ='Custom International Sponsorship';
        o.Custom_International_Sponsorship_Reven__c= 0;
                
       
        o.Products_Interested__c = 'Custom Job Template';
        o.Custom_Job_Template_Revenue__c= 0;
        
       o.Products_Interested__c = 'Custom Sponsorship';
        o.Custom_Sponsorship_Revenue__c= 0;
        
       o.Products_Interested__c = 'Job Postings';
        o.Products_Interested__c ='Trail-Job Postings'; 
        o.Job_Postings_Revenue__c= 0;
        
        
        o.Products_Interested__c = 'Logo on Job Postings';
        o.Logo_on_Job_Postings_Revenue__c=0;
       
        o.Products_Interested__c = 'Monster Mirror';
        o.Monster_Mirror_Revenue__c= 0;
        
        o.Products_Interested__c = 'Monster Widget';
        o.Monster_Widget_Revenue__c = 0;
        
        o.Products_Interested__c = 'Premium Resume Search';
        o.Premium_Resume_Search_Revenue__c= 0;
        
        o.Products_Interested__c = 'Promotional Offer';
        o.Promotional_Offer_Revenue__c= 0;
        
        
        o.Products_Interested__c = 'Short Message Service';
        o.Short_Message_Service_Revenue__c= 0;
        
        
        o.Products_Interested__c = 'Social Job Ads';
        o.Social_Job_Ads_Revenue__c= 0;
        
        o.Products_Interested__c = 'TalentBin by Monster';
        o.TalentBin_by_Monster_Revenue__c= 0;
        
        o.Products_Interested__c = 'Target Mailers';
        o.Target_Mailers_Revenue__c= 0;
        
        
        o.Products_Interested__c = 'Walk-in-Pro Event';
        o.Walk_in_Pro_Event_Revenue__c= 0;
        
        
        o.Products_Interested__c = 'Monster Assessments';
        o.Monster_Assessments_Revenue__c = 0;
        
        
        o.Products_Interested__c = 'QHire';
        o.QHire_Revenue__c= 0;
        
        
        o.Products_Interested__c = 'Trial-Job-Postings';
        
       
        // try
        
//o.Products_Interested__c = 'Branding;Custom International Sponsorship;Custom Job Template;Custom Sponsorship;Job Postings;Trail-Job Postings;Logo on Job Postings;Monster Mirror;Monster Widget;Premium Resume Search;Promotional Offer;Short Message Service;Social Job Ads;TalentBin by Monster;TalentBin by Monster;Target Mailers;Walk-in-Pro Event;Monster Assessments;QHire';
        
        
        test.startTest();
     
      
     Opportunity__c o6 = new Opportunity__c();
        o6.Account__c=a.id;
        o6.Close_Date__c=System.today();
        o6.OpportunityType__c='';
        o6.Stage__c ='Closed Won';
        o6.CreditStatus__c = a.CreditStatus__c;
        o6.Amount__c = 1100;
        insert o6;
        
        Opportunity__c o2 = new Opportunity__c();
        o2.Account__c=a.id;
        o2.Close_Date__c=System.today();
        o2.OpportunityType__c='Trial';
        o2.Stage__c ='Closed Lost';
        o2.CreditStatus__c = a.CreditStatus__c;
        o2.Amount__c = 1100;
        insert o2;
     PageReference pageRef = Page.opportunityCreate;
     pageRef.getParameters().put('accID', a.Id);
     pageRef.getParameters().put('accOwner', a.OwnerId);
     Test.setCurrentPage(pageRef);
     
     ApexPages.StandardController sc = new ApexPages.standardController(o); 
     opportunityCreate d = new opportunityCreate(sc);
      
      
     d.sumOfAmount();
     d.save(); 
        
       
      
    d.op.Products_Interested__c ='Branding';
      d.op.Branding_Revenue__c = 0;
    d.save();
        
        d.op.Products_Interested__c ='Custom International Sponsorship';
        d.op.Custom_International_Sponsorship_Reven__c = 0;
        d.save();      
        
        d.op.Products_Interested__c ='Custom Job Template';
        d.op.Custom_Job_Template_Revenue__c = 0;
        d.save();      
        
        d.op.Products_Interested__c ='Custom Sponsorship';
        d.op.Custom_Sponsorship_Revenue__c = 0;
        d.save();
        
        d.op.Products_Interested__c ='Job Postings';
        d.op.Products_Interested__c ='Custom Trail-Job Postings';
        d.op.Job_Postings_Revenue__c = 0;
        d.save();
        
        d.op.Products_Interested__c ='Logo on Job Postings';
        d.op.Logo_on_Job_Postings_Revenue__c = 0;
        d.save();
               
        d.op.Products_Interested__c ='Monster Mirror';
        d.op.Monster_Mirror_Revenue__c = 0;
        d.save();       
        
        d.op.Products_Interested__c ='Monster Widget';
        d.op.Monster_Widget_Revenue__c = 0;
        d.save();
               
        d.op.Products_Interested__c ='Premium Resume Search';
        d.op.Premium_Resume_Search_Revenue__c = 0;
        d.save();
        
        d.op.Products_Interested__c ='Promotional Offer';
        d.op.Promotional_Offer_Revenue__c = 0;
        d.save();
               
        d.op.Products_Interested__c ='Short Message Service';
        d.op.Short_Message_Service_Revenue__c = 0;
        d.save();
              
        d.op.Products_Interested__c ='Social Job Ads';
        d.op.Social_Job_Ads_Revenue__c = 0;
        d.save();
              
        d.op.Products_Interested__c ='TalentBin by Monster';
        d.op.TalentBin_by_Monster_Revenue__c = 0;
        d.save();           
        
        d.op.Products_Interested__c ='Target Mailers';
        d.op.Target_Mailers_Revenue__c = 0;
        d.save();       
        
        d.op.Products_Interested__c ='Walk-in-Pro Event';
        d.op.Walk_in_Pro_Event_Revenue__c = 0;
        d.save();       
        
        d.op.Products_Interested__c ='Monster Assessments';
        d.op.Monster_Assessments_Revenue__c = 0;
        d.save();
               
        d.op.Products_Interested__c ='QHire';
        d.op.QHire_Revenue__c = 0;
        d.save();
        
        //@imRam added
        
        d.op.Products_Interested__c ='Quinton';
        d.op.Quinton_Revenue__c = 0;
        d.save();
        
        d.op.Products_Interested__c ='Target Mailers';
        d.op.Target_Mailers_Revenue__c = 0;
        d.save();
            
        d.op.Amount__c = 0;
        d.save();
        d.op.OpportunityType__c = 'Free Trial';
        d.op.Products_Interested__c='Free Trial Custom Job Template Custom Sponsorship Job Postings Trail-Job Postings Logo on Job PostingsMonster Mirror Monster Widget Premium Resume SearchShort Message Service Social Job Ads Monster AssessmentsQHire';
        d.save(); 
    
        User u1 = [select id,name,profileId from user where name='Surplus-India SMB'];
        System.runAs(u1){
        Account a11 = new Account();
        a11.Name = 'oppnew';
        a11.SalesChannel__c = 'ECOMM';
        a11.Import_Source__c='sssss';
        a11.Lead_Source__c='Other';
        a11.APAC_Industry__c='Energy';
        a11.No_of_Employees__c= 25;
        a11.Account_Type__c='NIT';
        a11.Location__c='India';
        a11.Lead_Source1__c='ECOMM';
        a11.Website='www.asdfert.com';
        a11.Phone= '+985478547256';
        a11.OtherPhone__c = '+985478547856';
        a11.RegistrationNumber__c='asq111111';
        a11.Lead_Account_Status__c='Inactive';
        a11.CreditStatus__c = 'On Hold - Compliance';
        a11.BillingCountry='India' ; 
        a11.BillingState='Karnataka';
        a11.BillingStreet ='Test Address';
        a11.BillingCity ='bangalore' ;
        a11.BillingPostalCode='560076'; 
        a11.ShippingCountry='India';
        a11.BillCountry__c = 'India';
        a11.BillState__c = 'Karnataka';
        a11.PostCountry__c = 'India';
        a11.PostState__c = 'Karnataka';
        a11.ShippingStreet ='Test Address';
        a11.ShippingCity ='bangalore' ;
        a11.ShippingPostalCode='560076'; 
        a11.OwnerId = userinfo.getUserId();
        insert a11;
      
        Contact c11 = new Contact();
        c11.AccountID= a11.Id;
        c11.LastName='MahendraBaahubali';
        c11.Email='mbahu@gmail.com';
        c11.Phone='9898989898';
        c11.PrimarySalesContact__c=true;
        insert c11;
        
        Opportunity__c o11 = new Opportunity__c();
        o11.Account__c=a11.id;
        o11.Contact__c = c11.id;
        o11.Name__c ='oppnewd';
        o11.Probability__c = '0';
        //o11.CreatedDate = date.newInstance(2018, 11,11);
        o11.Close_Date__c=system.today();
        o11.OwnerId = a11.OwnerId;
        o11.OpportunityType__c='';
            try{
              insert o11; 
                
                o11.Stage__c = 'Closed lost';
                update o11;
                    
                o11.Stage__c = 'Identification';
                update o11;
                    }
            catch(Exception e){
                e.getCause();
            }
        
    
  }
        
         User u11 = [select id,name,profileId from user where name='Jayanth Muthyala'];
        System.runAs(u11){
        Account a12 = new Account();
        a12.Name = 'oppnew';
        a12.SalesChannel__c = 'ECOMM';
        a12.Import_Source__c='sssss';
        a12.Lead_Source__c='Other';
        a12.APAC_Industry__c='Energy';
        a12.No_of_Employees__c= 25;
        a12.Account_Type__c='NIT';
        a12.Location__c='India';
        a12.Lead_Source1__c='ECOMM';
        a12.Website='www.asdfert.com';
        a12.Phone= '+985478547256';
        a12.OtherPhone__c = '+985478547856';
        a12.RegistrationNumber__c='asq111111';
        a12.Lead_Account_Status__c='Inactive';
        a12.CreditStatus__c = 'On Hold - Compliance';
        a12.BillingCountry='India' ; 
        a12.BillingState='Karnataka';
        a12.BillingStreet ='Test Address';
        a12.BillingCity ='bangalore' ;
        a12.BillingPostalCode='560076'; 
        a12.ShippingCountry='India';
        a12.BillCountry__c = 'India';
        a12.BillState__c = 'Karnataka';
        a12.PostCountry__c = 'India';
        a12.PostState__c = 'Karnataka';
        a12.ShippingStreet ='Test Address';
        a12.ShippingCity ='bangalore' ;
        a12.ShippingPostalCode='560076'; 
        a12.OwnerId = userinfo.getUserId();
        insert a12;
      
        Contact c12 = new Contact();
        c12.AccountID= a12.Id;
        c12.LastName='MahendraBaahubali';
        c12.Email='mbahu@gmail.com';
        c12.Phone='9898989898';
        c12.PrimarySalesContact__c=true;
        insert c12;
        
        Opportunity__c o12 = new Opportunity__c();
        o12.Account__c=a12.id;
        o12.Contact__c = c12.id;
        o12.Name__c ='oppnewd';
        o12.Probability__c = '0';
        //o12.CreatedDate = date.newInstance(2018, 11,11);
        o12.Close_Date__c=system.today();
        o12.OwnerId = a12.OwnerId;
        o12.OpportunityType__c='';
        
        o12.Products_Interested__c ='Resume Highlighter';
        o12.Resume_Highlighter_Revenue__c= 0;
                      
        o12.Products_Interested__c = 'Express Resume';
        o12.Express_Resume_Revenue__c= 0;
            
        d.op.Products_Interested__c ='Resume Highlighter';
        d.op.Resume_Highlighter_Revenue__c = 0;
        d.save();
        
        d.op.Products_Interested__c ='Express Resume';
        d.op.Express_Resume_Revenue__c = 0;
        d.save();
            try{
              insert o12; 
               }
            catch(Exception e){
                e.getCause();
            }
        
    
  }
    }
}