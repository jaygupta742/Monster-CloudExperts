@isTest
public class QuoteINStdReport_test {
    public static testmethod void mine(){
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        insert tk;
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
         Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        insert t1k;
        
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        insert t2k;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        insert t4;
        
       
       
        
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
        insert a;
        
        Xcode__c  x= new Xcode__c();
        x.Created_For_Account__c=a.id;
        x.Name='testacc';
        insert x;
        
        Xcode_Account__c ca=[select id from Xcode_Account__c where Account__c=:a.id ];
        Xcode_Account__c  xc= new Xcode_Account__c();
        xc.id=ca.id;
       // xc.Account__ca.id;
        xc.Is_Primary__c=true;
        update xc;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='tcon@gmail.com';
        c.Phone='9999988888';
        c.PrimarySalesContact__c=true;
        insert c;
    
    
     Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Rejected';
        insert o;
    
   /* Address1__c addr= new Address1__c();
        addr.Account__c=a.id;
        addr.Country__c='Singapore';
        addr.Type__c='Billing';
        addr.Address1__c='Singapore Street';
        addr.City__c='Singapore City';
        addr.PinCode__c='114477225588';
        insert addr;*/
    
    a.Lead_Account_Status__c='Active';
        Update a;
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
    
    apttus_proposal_proposal__c qp = new apttus_proposal_proposal__c();
        qp.Account__c=a.id;
        qp.OwnerId=u.id;
        qp.Opportunity__c=o.id;
        qp.APTS_Quote_Type__c='PFC';
        qp.Order_Type__c='PFC';
        qp.Channel__c='PFC';
        qp.Primary_Contact__c=c.id;
        qp.Selling_Country__c='India';
        qp.BillContact__c=c.id;
        qp.PostingContact__c=c.id;
        qp.PriceList__c = pl.Id; 
        //qp.Billing_Address__c=addr.id;
        //qp.Posting_Address__c= addr.id;
        insert qp;
  
        Proposal_Line_Item__c   p= new Proposal_Line_Item__c();
        p.Quantity__c=1.00;
        p.APTS_Tax_Amount__c=12.00;
        p.APTS_Tax_Code__c='testCode';
        p.APTS_Tax_Rate__c=3;
        //p.APTTS_Tax_Amount__c=1000;
        //p.APTTS_Tax_Rate__c=3;
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
        p.Product_Family__c = 'Resume';
        p.Product_Name_Foreign__c = 'test';
        p.Product_SubCategory__c = 'Banner';
        p.ResumeFamilyCount__c = 22;
        p.Rev_Share_Type__c = 'Gross';
        p.Proposal_Locked__c=qp.id;
        insert p;
        
        
         PageReference pageRef = Page.PH_Std_Report;
        pageRef.getParameters().put('id',qp.id);
        Test.setCurrentPage(pageRef);
       
         ApexPages.StandardController sc = new ApexPages.standardController(qp);
         QuoteINRenewalReport ap= new QuoteINRenewalReport(sc);
        QuoteINStdReport psrd = new QuoteINStdReport(sc);
        QuotePrefilledCartReport pad = new QuotePrefilledCartReport(sc);
       
        
        
    }

}