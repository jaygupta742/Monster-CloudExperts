@isTest
public class reassign_Test {

    public static testmethod void met(){
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        trigger__c t4 = new trigger__C(name='Opportunity',Active__c = true);
        insert t4;
        trigger__c t5 = new trigger__C(name='Quote',Active__c = true);
        insert t5;
           user logged=[select id,name,email from user where id=:userinfo.getuserid()];
        
        ProductM__c m1=new ProductM__c();
        m1.name='branding';
        m1.Active__c=true;
        m1.Price_List1__c = 'INR; ';
        insert m1;
        
        Product_Attribute__c pa=new Product_Attribute__c ();
        pa.Product__c=m1.id;
        pa.Attributes__c='A;B;C;';
        insert pa;
        
        Product_PriceList__c pl=new Product_PriceList__c();
        pl.name='INR';
        pl.Active__c=true;
       // pl.OwnerId=u.id;
        insert pl;
        
        Product_Price_Entry__c pe=new Product_Price_Entry__c();
        pe.PriceList__c=pl.id;
        pe.Product__c=m1.id;
        insert pe;
    
        Product_Price_Metrix__c pm=new Product_Price_Metrix__c();
        pm.Currency__c=20;
        pm.Max__c=1;
        pm.Min__c=1;
        pm.Product_Config_Code__c='1-1-2';
        pm.Product_Price_Entry__c=pe.id;
        insert pm;
        
        Product_Attribute_Value__c pav=new Product_Attribute_Value__c();
        pav.Get__c='Product:start;';
        pav.Product__c=m1.id;
        pav.Product_PriceList__c=pl.id;
        pav.set__c='A=1,2;';
        insert pav;
        
        Discount_Attributes__c sobj = new Discount_Attributes__c();
        sobj.Product__c = m1.id;  
        sobj.Max_Value__c = 20.00;               
        sobj.Adjustment_Type__c = '% Discount';    
        insert sobj;
        
         Account a = new Account();
        a.Name = 'ANKSkkkakka';
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
        insert a;
        
        Xcode__c    x= new Xcode__c();
        x.Created_For_Account__c=a.id;
        x.Name='TestPA';
        insert x;
        Xcode_Account__c ca=[select id from Xcode_Account__c where Account__c=:a.id ];
        Xcode_Account__c    xc= new Xcode_Account__c();
        xc.id=ca.id;
       // xc.Account__ca.id;
        xc.Is_Primary__c=true;
        update xc;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        c.PrimarySalesContact__c=true;
        insert c;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Rejected';
        insert o;
        
        /*Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/
        
        a.Lead_Account_Status__c='Active';
        Update a;
       
        apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=a.id;
        qp.Opportunity__c=o.id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
        qp.Primary_Contact__c=c.id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=c.id;
        qp.PostingContact__c=c.id;
        //qp.Billing_Address__c=
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
        qp.PriceList__c=pl.id;
       
        insert qp; 
        
            string userid=userinfo.getuserid();
          Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
          req1.setComments('Submitting request for approval As Discount Value is high');
        req1.setObjectId(qp.id);
        req1.setSubmitterId(userid); 

          req1.setProcessDefinitionNameOrId('Discount_Approval_Process');
        req1.setSkipEntryCriteria(true);
        
     
        Approval.ProcessResult result = Approval.process(req1);   
          List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId
        From ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId =:qp.id];

       /*  test.startTest();
        Pagereference pageref = Page.reassign;
        pageref.getParameters().put('id',qp.id);
        Test.setCurrentPage(pageref);
   
        reassign r = new reassign();
     
        r.hh.User_to_Reassign__c = logged.id;
        
           r.reassign_to_user();*/
        
       // Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

    // Call method to test.
    // This causes a fake response to be sent
    // from the class that implements HttpCalloutMock. 
 /*   HttpResponse res = Approval_helper.createNewWidget('seetaram');
        
        
        RestRequest req = new RestRequest(); 
        RestResponse res1 = new RestResponse();
          req.requestURI = '/services/apexrest/Reassign';
         req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res1;
        
        test.stopTest();*/
        
        
        // joshith written
        
         Pagereference pageref = Page.reassign;
        pageref.getParameters().put('id',qp.id);
        Test.setCurrentPage(pageref);
   string ho= qp.id+','+userid;
        reassign r = new reassign();
           r.hh.User_to_Reassign__c = logged.id;
           Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
           test.starttest();
           r.reassign_to_user(); 
           
          Approval_helper hhgg=new Approval_helper ();
           Approval_helper.createNewWidget(ho); 
           
            RestRequest rr= new RestRequest();
        rr.requestURI='/services/apexrest/Reassign';
        rr.httpMethod='Post';
     
          rr.addParameter('Name', qp.id+','+userid);
      
        RestContext.request = rr;
        
            test.stopTest();
    }
}