@istest
public class generateExcelTest {
    public static testmethod void mytest()
    {
        Trigger__c te = new Trigger__c(name ='Account',Active__c = true);
        insert te;
        
        Trigger__c t1qq = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1qq;
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        insert tk;
        Trigger__c t2qq = new Trigger__c(name ='Contact',Active__c = true);
        insert t2qq;
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        insert t1k;
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
        ProductM__c m=new ProductM__c();
    	m.name='branding';
    	m.Active__c=true;
        m.Price_List1__c = 'INR';      
        m.Trail_Custom_or_Promo__c=true;
    	insert m;
    
    	ProductM__c m1=new ProductM__c();
    	m1.name='Premium Resume Search';
     	m1.Active__c=true;
        m1.Price_List1__c = 'INR';     
    	insert m1;
    
    Product_Attribute__c pa=new Product_Attribute__c ();
    pa.Product__c=m1.id;
    pa.Attributes__c='A;B;C;';
    insert pa;
    
        
    Product_PriceList__c pl=new Product_PriceList__c();
    pl.name='INR';
    pl.Active__c=true;
    insert pl;
    
  
        
    Product_Price_Entry__c pe=new Product_Price_Entry__c();
    pe.PriceList__c=pl.id;
    pe.Product__c=m1.id;
    insert pe;
    
    Product_Price_Metrix__c pm=new Product_Price_Metrix__c();
    pm.Currency__c=20;
    pm.Max__c=1;
    pm.Min__c=1;
    pm.Product_Config_Code__c='1';
    pm.Product_Price_Entry__c=pe.id;
    insert pm;
    
    Product_Attribute_Value__c pav=new Product_Attribute_Value__c();
    pav.Get__c='Product:start;';
    pav.Product__c=m1.id;
    pav.Product_PriceList__c=pl.id;
    pav.set__c='A=1,2;';
    insert pav;
        
    Product_Attribute_Value__c pav1=new Product_Attribute_Value__c();
    pav1.Get__c='A=1;';
    pav1.Product__c=m1.id;
    pav1.Product_PriceList__c=pl.id;
    pav1.set__c='A=1;S1;Contract Duration=1 Month;Final';
    insert pav1;
     
        
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
        a.BillCountry__c='India' ; 
        a.BillState__c='Karnataka';
        a.PostCountry__c ='India' ;
        a.PostState__c='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingStreet='street1';
        a.BillingPostalCode='560076';  
        a.ShippingCity='bangalore' ;
        a.ShippingPostalCode ='560076'; 
        a.ShippingStreet= 'shippingstreet';          
        a.Segment__c = 'Commercial';        
        a.Lead_Source1__c= 'Call Inbound';       
        insert a;
        
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        
        Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Identification';
        insert o;
        
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
        qp.PriceList__c = pl.Id; 
        insert qp;
    
        Attachment attachment = new Attachment();
        attachment.Name='Attachment1';
        attachment.ParentId=qp.Id;      
        Blob b=Blob.valueOf('Test Record Body!!');
        attachment.Body=b;       
        insert attachment;
        
    generateExcel ge = new generateExcel();
    ge.genExc(qp.Id);
    }
}