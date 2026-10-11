@istest
public class editAllOpportunityLineItem_TEST {
    @istest
    public static void testdata(){
        
        List<Trigger__c> cs= new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        cs.add(t);
        Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
        cs.add(tk);
        Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        cs.add(t1);
        Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
        cs.add(t1k);
        Trigger__c t1kk = new Trigger__c(name ='OpportunityN__c',Active__c = false);
        cs.add(t1kk);
        Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
        cs.add(t2k);
        
        Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        cs.add(t2);
        trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        cs.add(t3);
        Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
        cs.add(t4);
        insert cs;
        
        Account a = new Account();
        a.Name = 'Test2';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='Prospect';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
        a.Person_Account__c = true;
                                a.Team__c='Edtech-Courses';

        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
        
        Price_Master__c pm=new Price_Master__c();
        pm.Name ='INR Price Book'; 
        insert pm;
        
        
        ProductC__c m=new ProductC__c();
        m.Price_Master__c= pm.Id; 
        m.Bin__c = '1-1';
        m.Active__c = true;
        m.to__c = 1;
        m.From__c = 1;
        insert m; 
        
        
        ProductC__c m1=new ProductC__c();
        m1.Price_Master__c= pm.Id; 
        m1.Bin__c = '1-1';
        m1.Active__c = true;
        m1.to__c = 1;
        m1.From__c = 1; 
        insert m1;
        
        OpportunityN__c op = new OpportunityN__c();
            op .Account__c= a.id;
            op.Contact__c=c.id;
            op.Close_Date__c = date.today().adddays(10);
            op.Closure_Week__c ='Week-2';
            op.Closure_probablity__c ='Will';
            op.Expected_Revenue__c=12121222;
            op.Price_Master__c = pm.Id; 
            op.Stage__c = 'Proposal Sent';
            op.Opportunity_Type__c='free trial';
            
            op.Actual_Revenue__c= 12131;
           // op.OwnerId = uu.Id; 
        insert op;
        
        
        list<Opp_Line_Item__c> oplist=new list<Opp_Line_Item__c>();
        Opp_Line_Item__c opl = new Opp_Line_Item__c();
        opl.Opportunities__c = op.Id;
        opl.Product__c = m.Id;
        opl.Quantity_Unit__c = 232;
        opl.Price_Master__c = pm.Id;
        opl.Account__c = a.Id;
        opl.Discount_Type__c ='';
        opl.Discount_Amount_1__c = 511000.00;
        opl.Gross_Total__c = 766500.00;
        opl.Unit_Price__c = 1277500.00;
        opl.Tenure_Months__c ='12 Months';
        opl.Product_Country__c = 'APAC without India'; 
        oplist.add(opl);
        
        
        Opp_Line_Item__c opl1 = new Opp_Line_Item__c();
        opl1.Opportunities__c = op.Id;
        opl1.Product__c = m1.Id;
        opl1.Price_Master__c = pm.Id;
        opl.Quantity_Unit__c = 232;
        opl1.Account__c = a.Id;
        opl1.Discount_Type__c ='';
        opl1.Discount_Amount_1__c = 511000.00;
        opl1.Gross_Total__c = 766500.00;
        opl1.Unit_Price__c = 1277500.00;
        opl1.Tenure_Months__c ='12 Months';
        opl1.Product_Country__c = 'APAC without India'; 
        oplist.add(opl1);
        insert oplist;
        
        Opp_Line_Item__c opl2 = new Opp_Line_Item__c();
        opl2.Opportunities__c = op.Id;
        opl2.Product__c = m1.Id;
        opl2.Price_Master__c = pm.Id;
        opl2.Account__c = a.Id;
        opl2.Discount_Type__c ='';
        opl.Quantity_Unit__c = 232;
        opl2.Discount_Amount_1__c = 511000.00;
        opl2.Gross_Total__c = 766500.00;
        opl2.Unit_Price__c = 1277500.00;
        opl2.Tenure_Months__c ='12 Months';
        opl2.Product_Country__c = 'APAC without India'; 
        insert opl2;
        
        
        
        list<OPLI_Accessories__c> opalist1=new list<OPLI_Accessories__c>();
        OPLI_Accessories__c opa=new OPLI_Accessories__c();
        opa.Mandatory__c = true;
        opa.Opportunities__c = op.Id;
        opa.Opp_Line_Item__c = opl1.Id;
        opa.Price_Master__c = pm.Id ;
        opa.Product__c = m.Id;
        opa.Account__c = a.Id;
        opa.Quantity__c =56;
        opa.Quantity_Unit__c =232;
        opalist1.add(opa);
        insert opalist1;
        
        list<OPLI_Accessories__c> opalist=new list<OPLI_Accessories__c>(); 
        OPLI_Accessories__c opa1=new OPLI_Accessories__c();
        opa1.Mandatory__c = true;
        opa1.Opportunities__c = op.Id;
        opa1.Opp_Line_Item__c = opl2.Id;
        opa1.Price_Master__c = pm.Id ;
        opa1.Product__c = m.Id;
        opa1.Account__c = a.Id; 
        opa1.Quantity__c= 222;
        opa1.Quantity_Unit__c = 232;
        opalist.add(opa1); 
        insert opalist;
        
        
        list<editAllOpportunityLineItem.itemWrap> wrli=new list<editAllOpportunityLineItem.itemWrap>();
        editAllOpportunityLineItem.itemWrap w=new editAllOpportunityLineItem.itemWrap(opl1);
        w.opli = opl1;
        w.bin = '1';
        w.fromqty = 345;
        w.prodname = 'Resume Database Access';
        w.updateAccQty = false;
        w.basetotal = 23456;
        w.delAcc = true;
        w.to = 45;
        w.grosstotal = 45;
        wrli.add(w);  
        
        
        
        
        
        try {    
            editAllOpportunityLineItem.getAllLineItem(op.Id); 
            editAllOpportunityLineItem.lineItemDel(string.valueof(opl.Id), 'true');  
            
             editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','1 Month');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','1 Week');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','12 Months');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','6 Months');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','3 Months');
            
                        editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','1 Day');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','2 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','4 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','5 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','6 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','7 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','14 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','60 Days');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','2 Months');
            editAllOpportunityLineItem.getenddate(Json.serialize(wrli),'2022-05-10','9 Months');

            editAllOpportunityLineItem.onsave(json.serialize(wrli)); 
             editAllOpportunityLineItem.onsave(json.serialize(opalist)); 
            
                   
            
        }
        catch(Exception ex){
            system.debug('ex.getMessage():'+ex.getMessage());
            system.debug('ex.getMessage():'+ex.getLineNumber());
            
        }
    }
    
    
}