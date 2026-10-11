@istest
public class ProposalGenerateControllerTest {

    
    public static  testmethod void proposalgenerate(){
        //by yamini
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
        
        
        
        
        
        Account acc = new Account();
          acc.Name = 'Testaccount';
        acc.SalesChannel__c = 'ECOMM';
        acc.Import_Source__c='eeee';
        acc.Lead_Source__c='Other';
        acc.APAC_Industry__c='Energy';
        acc.No_of_Employees__c= 25;
        acc.Account_Type__c='NIT';
        acc.Location__c='Hong Kong';
        acc.Website='www.asdfert.com';
        acc.Phone= '+918965874589';
        acc.OtherPhone__c = '+987456985474';
        acc.RegistrationNumber__c='asq111111';
        acc.Lead_Account_Status__c='Inactive';
        acc.CreditStatus__c='OK';
        acc.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        acc.BillingState='Karnataka';
        acc.BillingStreet ='Test Address';
        acc.BillingCity ='bangalore' ;
        acc.BillingPostalCode='560076'; 
        acc.ShippingCountry='India' ; //To change Address from Object to Standard Address in Account
        acc.ShippingState='Karnataka';
        acc.ShippingStreet ='Test Address';
        acc.ShippingCity ='bangalore' ;
        acc.ShippingPostalCode='560076';
        acc.Segment__c = 'Commercial';
        
        acc.Lead_Source1__c= 'Call Inbound';
       
        insert acc;
        
        Contact con = new contact();
        con.AccountId = acc.id;
        con.LastName = 'Test new Contact';
        con.ContactStatus__c = 'Active';
        con.Phone = acc.phone;
        con.Email = 'Test@gmail.com';
        con.MobilePhone = '+917845125252';    
        Insert con;
        
        /*Address1__c addr =new Address1__c();
        addr.Account__c = acc.id;
        addr.Country__c = 'India';
       // addr.State__c = 'Karnataka'; commented as state field need to deleted
        addr.Type__c = 'Billing';
        addr.Address1__c = 'Test Address';
        addr.City__c = 'Bangalore';
        addr.PinCode__c = '4545454';
        Insert addr;*/
        
          acc.Lead_Account_Status__c = 'Active';
          update acc;
        
        Opportunity__c opp =new Opportunity__c();
        opp.Name__c = acc.Name;
        opp.Account__c = acc.id;
        opp.Close_Date__c = system.today() + 3;
        opp.OpportunityType__c='GCS Opportunity';
        opp.Stage__c='Closed Won';
        Insert opp;
        
        //renu_is_adding_for_address_change
        
        opp.Name__c = acc.Name;
        opp.Account__c = acc.id;
        opp.Close_Date__c = system.today() + 3;
        opp.OpportunityType__c='GCS Opportunity';
        opp.Stage__c = 'Negotiation Complete';
        opp.Probability__c = '50';
        update opp;        
        
        Product_PriceList__c ppl = new Product_PriceList__c();
        ppl.Name = 'INR';
        
        apttus_proposal_proposal__c app= new apttus_proposal_proposal__c();
        app.Account__c= acc.id;
        app.Opportunity__c=opp.Id;
        app.APTS_Quote_Type__c='PFC';
        app.Order_Type__c='PFC';
        app.Channel__c= 'PFC';
        app.PriceList__c= ppl.Id;
        app.Primary_Contact__c=con.id;
        app.Selling_Country__c='India';
        app.BillContact__c = con.Id;
        /*app.Billing_Address__c=addr.id;*/
        app.PostingContact__c= con.Id;
        /*app.Posting_Address__c= addr.id;*/
        Insert app;
        
        Template__c tmp  = new Template__c();
        tmp.Name ='tmpname';
        tmp.DOC__c = 'docstring';
        tmp.PDF__c = 'pdfstng';
        tmp.Location__c = 'india';
        insert tmp;
        
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(app);
        PageReference pageRef = Page.ProposalGenerate;
        pageRef.getParameters().put('id', String.valueOf(app.Id));
        Test.setCurrentPage(pageRef);
       
        ProposalGenerateController testAccPlan = new ProposalGenerateController(sc);
        
        testAccPlan.getItems();
        testAccPlan.settype('pdf');
        testAccPlan.gettype();
        testAccplan.pdfdoc_val = 'PDF';
        testAccPlan.selectcon();
        testAccPlan.Generate(); 
        
      //  -----------------------------------------
          
        ApexPages.StandardController sc1 = new ApexPages.StandardController(app);
        PageReference pageRef1 = Page.ProposalGenerate;
        pageRef1.getParameters().put('id', String.valueOf(app.Id));
        
        Test.setCurrentPage(pageRef1);  
        
        ProposalGenerateController testAccPlan1 = new ProposalGenerateController(sc1);
        
        testAccPlan1.getItems();
        testAccPlan1.settype('DOC');
        testAccPlan1.gettype();
        testAccplan1.pdfdoc_val = 'DOC';
       //testAccplan1.b=true;
       testAccplan1.UpadteOpp();
        testAccPlan1.selectcon();
        testAccPlan1.Generate();
                  
    }
}