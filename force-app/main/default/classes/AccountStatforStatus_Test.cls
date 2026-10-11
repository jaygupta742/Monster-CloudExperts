@istest
public class AccountStatforStatus_Test {
    
    @isTest static void myTestPa(){
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
        
        ProductM__c m1=new ProductM__c();
        m1.name='Premium Resume Search';
        m1.Active__c=true;
        m1.Discount_Threshold__c=80;
        m1.Price_List1__c = 'INR; ';
        
        insert m1;
        ProductM__c m11=new ProductM__c();
        m11.name='Premium job Search';
        m11.Active__c=true;
        m11.Discount_Threshold__c=80;
        m11.Price_List1__c = 'INR; ';
        
        insert m11;
        
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
        pe.DiscountLimit__c=true;
        pe.MaxDiscount__c=80;
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
        a.Segment__c='ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingCountry='India' ; 
        a.BillingState='Karnataka';
        a.BillingStreet ='Test Address';
        a.BillingCity ='bangalore' ;
        a.BillingPostalCode='560076';
        a.ShippingCountry='India';
        a.ShippingCity='Test';
        a.ShippingPostalCode='56000';
        a.ShippingState ='Test Address';
        a.ShippingStreet='Jssttts';
        a.Suspect_Prospect__c='Prospect';
        insert a;
        AccountStatforStatus.getPickListValuesIntoList();
        AccountStatforStatus.getAccountStat(a.id);
        a.Suspect_Prospect__c='';
        update a;
        AccountStatforStatus.getAccountStat(a.id);
        AccountStatforStatus.updateAccountStat(a.id,'Prospect');
        AccountStatforStatus.updateAccountStat(a.id,'null');
        
        
        
        
    }
    
}