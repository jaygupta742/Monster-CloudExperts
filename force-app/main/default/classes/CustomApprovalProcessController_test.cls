@istest

public class CustomApprovalProcessController_test
{
    public static testmethod void mine()
    {
    
        ProductM__c m=new ProductM__c();
    m.name='classic resume search';
     m.Active__c=true;
    insert m;
    
    ProductM__c m1=new ProductM__c();
    m1.name='branding';
     m1.Active__c=true;
    insert m1;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
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
          sobj.Product__c = m.id;  
          sobj.Max_Value__c = 20.00;               
          sobj.Adjustment_Type__c = '% Discount';
    
          insert sobj;
          
         /*   Discount_Attributes__c sobj6 = new Discount_Attributes__c();
          sobj6.Product__c = m1.id;  
          sobj6.Max_Value__c = 20.00;               
          sobj6.Adjustment_Type__c = '% Discount';
    
          insert sobj6;*/
          
            apttus_proposal_proposal__c klo=new apttus_proposal_proposal__c();
            klo.PriceList__c=pl.id;
            insert klo;
            
            
            Proposal_Line_Item__c sobj1 = new Proposal_Line_Item__c(
              Product__c = m.id,           // Product
              Adjustment_Amount__c = 50.00,               
              Adjustment_Type__c = '% Discount',          
              Quantity__c = 1,                           
              Proposal_Locked__c = klo.id,    
              Status__c = 'Pending',                      
              Start_Date__c = system.today(), 
              End_Date__c = system.today(),    
              Price__c = 20.0000                        
            );
            insert sobj1;
            
            
               Proposal_Line_Item__c sobj12 = new Proposal_Line_Item__c(
              Product__c = m.id,           // Product
              Adjustment_Amount__c = 5.00,               
              Adjustment_Type__c = '% Discount',          
              Quantity__c = 1,                           
              Proposal_Locked__c = klo.id,    
              Status__c = 'Pending',                      
              Start_Date__c = system.today(), 
              End_Date__c = system.today(),    
              Price__c = 20.0000                        
            );
            insert sobj12;
            
            
             Proposal_Line_Item__c sobj2 = new Proposal_Line_Item__c(
              Product__c = m1.id,          
              Adjustment_Amount__c = 5.00,               
              Adjustment_Type__c = '% Discount',          
              Quantity__c = 1,                           
              Proposal_Locked__c = klo.id,    
              Status__c = 'Pending',                      
              Start_Date__c = system.today(), 
              End_Date__c = system.today(),    
              Price__c = 20.0000                        
            );
            insert sobj2;
            
             string userid=userinfo.getuserid();
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
          req1.setComments('Submitting request for approval As Discount Value is high');
        req1.setObjectId(klo.id);
        req1.setSubmitterId(userid); 

          req1.setProcessDefinitionNameOrId('Discount_Approval_Process');
        req1.setSkipEntryCriteria(true);
        
     
        Approval.ProcessResult result = Approval.process(req1);   
      
        
            
            
            PageReference tpageRef = Page.CustomApprovalProcessController;
              Test.setCurrentPage(tpageRef);
            
              ApexPages.currentPage().getParameters().put('Id', klo.Id);
              ApexPages.StandardController controller= new ApexPages.StandardController(klo );
              CustomApprovalProcessController jo=new CustomApprovalProcessController(controller);
              
            
    
    
    }


}