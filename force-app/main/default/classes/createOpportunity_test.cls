@isTest
public class createOpportunity_test {
    @isTest
    public static void setData(){
        test.startTest();
        list<Trigger__c> tlist=new list<Trigger__c>();
        Trigger__c t = new Trigger__c(name ='Account',Active__c = false); 
        tlist.add(t);
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = false);
        tlist.add(t2);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = false);
        tlist.add(t1k);
        Trigger__c t41 = new Trigger__c(name ='CVR',Active__c = false);
        tlist.add(t41);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = false);
        tlist.add(tk);
        Trigger__c tshareorder = new Trigger__c(name ='Share Order', Active__c = false);
        tlist.add(tshareorder);
        Trigger__c SharePortfolio = new Trigger__c(name ='Share Portfolio', Active__c = false);
        tlist.add(SharePortfolio);
        Trigger__c QuoteLineItems = new Trigger__c(name ='QuoteLineItems', Active__c = false);
        tlist.add(QuoteLineItems);
        Trigger__c OrderItem = new Trigger__c(name ='OrderItem', Active__c = false);
        tlist.add(OrderItem);
        
        
        insert tlist;
        
        
        User uu=[select id,name,User_Channel__c,Channel__c from User where id=:userinfo.getUserId()];
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        list<user> ulist=new list<user>();
        
        User uu1 = new User(Alias = 'absduu', 
                            EmailEncodingKey='UTF-8', 
                            LastName='sdscuu', 
                            LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', 
                            ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles',
                            username = 'absduu@start.com',
                            email='bapi98deba@gmail.com',
                            Channel__c='EA',
                            ManagerId = userinfo.getUserId()                            
                           );
        
        
        ulist.add(uu1);
        insert ulist;
        
        Account a = new Account();
        a.Name = 'Debasis Das';
        a.SalesChannel__c = 'EA';
        a.Import_Source__c='Import_Source__c';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Internet';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='IT';
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
        a.AccountStatus__c='Lead';
        
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
        a1.AccountStatus__c='Lead';
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
        
        
        
        ProductM__c m=new ProductM__c();
        m.name='branding';
        m.Active__c=true;
        m.Price_List1__c = 'INR';
        m.IsActive__c = true;
        
        m.Trail_Custom_or_Promo__c=true;
        insert m;
        
        Price_Master__c pm = new Price_Master__c();
        pm.Name='INR Price Book';
        pm.CurrencyIsoCode='INR';
        insert pm;
        
        ProductC__c pc = new ProductC__c();
        pc.Main_Product_Type__c='JPO';
        pc.Product_Name__c='Job Posting';
        pc.Active__c=true;
        pc.SKU_Type__c='Bundle-x';
        pc.Product_category__c='Standard';
        pc.Price_Master__c=pm.id;
        pc.Product_SKU_Code__c='JPOS1SE00N';
        
        pc.Product_Description__c='hiuhiuh';
        pc.Product_Country__c='India';
        pc.Primary_Selling_Country__c='India';
        pc.Tenure_Months__c='12 Months';
        pc.Bin__c='vghvgh';
        pc.Product_Type__c='Upsell';
        pc.CurrencyIsoCode='INR';
        pc.Unit_List_Price_Value__c=200;
        pc.DB_Type_Industry__c='Full';
        pc.DB_Scope_Geography__c='All';
        pc.Discount_Cap__c=12;
        pc.From__c=200;
        //  pc.Discount_Amount__c=''
        // pc.Gross_Total__c=500;
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';
        pc.Channel__c=uu.Channel__c;
        
        
        
        insert pc;
        
        ProductC__c pc1 = new ProductC__c();
        //  pc.Product_Name__c='Social Job Ads';
        pc1.Active__c=true;
        pc1.SKU_Type__c='Bundle-x';
        pc1.Product_category__c='Standard';
        pc1.Price_Master__c=pm.id;
        pc1.Product_SKU_Code__c='RDAS1ME01M00BN1';
        pc1.Channel__c = '';
        pc1.Main_Product_Type__c='RDA';
        pc1.Product_Description__c='hiuhiuh';
        pc1.Product_Country__c='India';
        pc1.Primary_Selling_Country__c='India';
        pc1.Tenure_Months__c='12 Months';
        pc1.Bin__c='vghvgh';
        pc1.Product_Type__c='Upsell';
        pc1.Channel__c=uu.Channel__c;
        
        // pc1.Channel__c=	'EA';
        insert pc1;
        
        a.Lead_Account_Status__c = 'Active';
        update a;
        
        OpportunityN__c no = new OpportunityN__c();
        no.Account__c= a.id;
        no.Contact__c=c.id;
        no.Close_Date__c = date.today().adddays(10);
        no.Closure_Week__c ='Week-2';
        no.Closure_probablity__c ='Will';
        no.Expected_Revenue__c=12121222;
        no.Price_Master__c = pm.Id; 
        no.Stage__c = 'Proposal Sent';
        no.Opportunity_Type__c='free trial';
        
        no.Actual_Revenue__c= 12131;
        no.OwnerId = uu.Id; 
        
        // insert no;
        
        createOpportunity.saveMethod(json.serialize(no));
        
    }
}