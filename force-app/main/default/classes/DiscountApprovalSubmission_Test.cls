@isTest
public class DiscountApprovalSubmission_Test {
	 public static testmethod void discApproval(){
         
    
        List<Trigger__c> cs= new List<Trigger__c>();
         
        Trigger__c t7 = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t7);
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);                     
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);
         
       insert cs;
                             
        user u = new user();
        u =[SELECT Id From User WHERE username=:UserInfo.getUsername()];
         
        Account a = new Account();
        a.Name = 'Testaccount';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='eeee';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Segment__c='ECOMM';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+919999988888';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Lead_Source1__c='ECOMM';
        
        a.BillingCountry='India' ; //To change Address from Object to Standard Address in Account
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
         
         
         a.ShippingCountry ='India';
         a.ShippingStreet ='vega street';
         a.ShippingCity ='ubcity';
         a.ShippingState = 'ourstate';
         a.ShippingPostalCode ='45555555';
         
          insert a;
       
        
        Xcode__c  x= new Xcode__c();
        x.Created_For_Account__c=a.id;
        x.Name='testacc';
        insert x;
        
        Xcode_Account__c ca=[select id from Xcode_Account__c where Account__c=:a.id ];
        Xcode_Account__c  xc= new Xcode_Account__c();
        xc.id=ca.id;
        xc.Is_Primary__c=true;
        update xc;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='tcon@gmail.com';
        c.Phone='9999988888';
        c.PrimarySalesContact__c=true;
        insert c;
         
    a.Lead_Account_Status__c='Active';
     Update a;
   
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Rejected';
        insert o;
    
    
     
         
     Product_Attribute__c pa=new Product_Attribute__c ();
     //pa.Product__c=m1.id;
     pa.Attributes__c='A;B;C;';
     insert pa;
   
        
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
    pl.OwnerId=u.id;
    pl.Active__c=true;
    insert pl;
   
     ProductM__c m=new ProductM__c();
     m.name='classic resume search';
     m.Active__c=true;
     m.Price_List1__c = 'HKD';
     insert m;
    
    ProductM__c m1=new ProductM__c();
    m1.name='branding';
    m1.Active__c=true;
    m1.Price_List1__c = 'INR; ';
    insert m1;
   test.startTest();
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=a.id;
        qp.OwnerId=u.id;
        qp.Opportunity__c=o.id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
       // qp.Start_Date__c = system.today();
        //qp.End_Date__c = system.today()+30;
        qp.Primary_Contact__c=c.id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=c.id;
        qp.PostingContact__c=c.id;
        qp.PriceList__c = pl.Id; 
        insert qp;
    
        Proposal_Line_Item__c   p= new Proposal_Line_Item__c();
        p.Quantity__c=1.00;
        p.APTS_Tax_Amount__c=12.00;
        p.APTS_Tax_Code__c='testCode';
        p.APTS_Tax_Rate__c=3;
        //p.APTTS_Tax_Amount__c=1000;
        //p.APTTS_Tax_Rate__c=3;
        p.Start_Date__c = system.today();
        p.End_Date__c = system.today()+30;
        p.AgencyCommission__c=23;
        p.Agency_Commission_Amount__c=2000;
        p.CityTaxAmount__c=2000;
        p.CityTaxRate__c=32;
        p.CountyTaxAmount__c=2000;
        p.CountyTaxRate__c=32;
        p.Custom_Job_Template__c = 'Yes';
        p.Earliest_Product_Start_Date__c = system.today();
        p.Media_Type__c = 'nonMedia';
        p.Net_Total_from_Line_Item__c = 200;
        p.Order_Quota_Type__c = 'Core';
        p.Product_Start_Date__c = system.today();
    	p.Organization_based_on_OSD__c = 'osd';
        p.Owner_on_Start_Date_OSD__c = u.Id;
        p.Payment_Amount__c=2898;
        p.PostingLocation__c = 'bangalore';
        p.Primary_Rep_Manager__c = u.Id;
        p.Product_Cateogry__c= 'Banner';
        p.Start_Date__c=system.today();
        p.End_Date__c=system.today()+2;
        p.Product_Family__c = 'Resume';
        p.Product_Name_Foreign__c = 'test';
        p.Product_SubCategory__c = 'Banner';
        p.ResumeFamilyCount__c = 22;
        p.Rev_Share_Type__c = 'Gross';
        p.Proposal_Locked__c=qp.id;
        insert p;
         
        APTS_APAC_Payment__c ap= new APTS_APAC_Payment__c();
        ap.Proposal__c=qp.id;
        ap.Payment_Amount__c=120;
        ap.TDS_Amount_c__c=0;    
        ap.Due_Date__c=system.today()+3;
        insert ap; 
         
        OrderC__c ord = new OrderC__c();
        ord.Account__c = a.id;
        ord.QuoteProposal__c = qp.id;
        ord.Opportunity__c=o.id;
        ord.PrimarySalesRep__c=userInfo.getUserId();
        ord.PriceList__c = pl.id;
        ord.Contract_End_Date__c=system.today()+2;
        Ord.Payment_Amount__c=400;
        ord.TDS_Amount__c=400;   
        insert ord;
        
        Order_Line_Item__c cc= new Order_Line_Item__c();
        cc.Quantity__c=11;
        cc.Order__c=ord.id;
        cc.End_Date__c=system.today()+1;
        insert cc;
        cc.End_Date__c=system.today()+2;
        update cc;            
       
        //Send_to_Order.myMethod(qp.Id);
        
        
        Approval_Records__c apprvlRec = new Approval_Records__c();
        apprvlRec.Name = qp.id;
        insert apprvlRec;
         
        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
	    app.setObjectId(qp.id);
        app.setComments('January Re-Approval ');
	    app.setSubmitterId(qp.OwnerId);
        app.setSkipEntryCriteria(true);
        app.setProcessDefinitionNameOrId('Discount_Approval_Process_Revised_Temp');
		Approval.ProcessResult result = Approval.process(app);	 
         DiscountApprovalSubmission.submitAndProcessApprovalRequest();

	    test.stopTest();
     }
    
}