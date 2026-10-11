@istest
public class EditAPACPayments_cls_test {
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
        Trigger__c t1kk = new Trigger__c(name ='OpportunityN__c',Active__c = true);
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
        
        pc.of_Master_Login__c='5';
        pc.Unit_List_Price_Value__c=500;
        pc.Product_Code__c='JPOS1SE00N';         
        insert pc;
        
        ProductC__c pc1 = new ProductC__c();
        pc.Product_Name__c='Social Job Ads';
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
        pc1.Tenure_Months__c='6 Months';
        pc1.Bin__c='vghvgh';
        //  pc1.Product_Type__c='Upsell'; 
        insert pc1;
        
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
        
        
        List<Opp_Line_Item__c> oplilist= new List<Opp_Line_Item__c>();
        Opp_Line_Item__c opli = new Opp_Line_Item__c();
        opli.Opportunities__c= op.id;
        opli.Account__c= a.id;
        opli.Product__c=pc.id;
        opli.Price_Master__c=pm.id;
        opli.Quantity_Unit__c=1;
        opli.DB_Scope_Geography__c='All';
        opli.DB_Type_Industry__c='Full';
        opli.CurrencyIsoCode='INR';
        opli.Unit_Price__c=500;
        opli.Product_Country__c='India';
        opli.Product_Selling_Country__c='India';
        opli.SKU_Code__c='RDAS1ME01M00BN1';
        opli.Tenure_Months__c= '12 Months';
        opli.Discount_Value__c=12;
        //  opli.Quantity_Unit__c=pc.From__c;
        opli.Base_Total__c=200;
        opli.Discount_Amount_1__c=200;
        opli.Gross_Total__c=100;
        opli.of_Master_Login__c='5';
        oplilist.add(opli);
        
        Opp_Line_Item__c opli1 = new Opp_Line_Item__c();
        opli1.Opportunities__c= op.id;
        opli1.Account__c= a.id;
        opli1.Product__c=pc1.id;
        opli1.Price_Master__c=pm.id;
        //opli.Quantity_Unit__c=100;
        opli1.DB_Scope_Geography__c='All';
        opli1.DB_Type_Industry__c='Full';
        oplilist.add(opli1);
        insert oplilist;
        
        Xcode__c xc = new Xcode__c();
        xc.Name='12345';
        xc.Created_For_Account__c= a.id;
        insert xc;
        
        OPLI_Accessories__c plia = new OPLI_Accessories__c();
        // plia.Top_Ups__c= tc.id;
        plia.Account__c=a.id;
        plia.Opp_Line_Item__c=opli.id;
        plia.Opportunities__c=op.id;
        plia.Product__c=pc.id;
        
        insert plia;
        
        QuotesN__c qc = new QuotesN__c();
        qc.Quote_Type__c='Free Trial';
        qc.Xcode__c=xc.id;
        qc.Account__c=a.id;
        qc.Contact__c=c.id;
        qc.Opportunities__c=op.id;
        qc.Price_Master__c=pm.id;
        qc.CurrencyIsoCode ='INR';
        qc.Active__c=false;
        qc.Selling_Country__c = 'INDIA'; 
        qc.Finalised__c = true;
        qc.Approval_Status_Overall__c = 'Pending';
        qc.Billing_Address__c = 'Account Billing Address';
        qc.Posting_Address__c = 'Account Billing Address';
        qc.Validated__c = true;
        qc.Tax_Percentage__c=18;
        insert qc;
        
        
        List<Quote_Line_Items__c> quliList = new List<Quote_Line_Items__c>();
        Quote_Line_Items__c qli = new Quote_Line_Items__c();
        qli.Quotes__c = qc.Id;
        qli.Account__c = a.id;
        qli.Opportunities__c = op.id;
        qli.Product__c = pc.Id;
        qli.Opp_Line_Item__c = opli.Id;
        qli.Price_Master__c = pm.Id;
        qli.Product_Industry__c = 'Full';
        qli.Product_Geo_Scope__c ='All';
        qli.Product_Country__c = 'APAC without India';
        qli.Tenure_Months__c = '12 Months';
        qli.Discount_Value__c = 511000.00;
        qli.Gross_Total__c = 766500.00;
        qli.Adjusted_Value__c = 40;
        qli.Unit_Price__c = 1277500.00;
        qli.Quantity_Unit__c = 4;
        qli.Base_Total__c = 1277500.00;
        qli.Start_Date__c = system.today();
        // qli.Active__c = true;
        
        quliList.add(qli);
        
        Quote_Line_Items__c qli2 = new Quote_Line_Items__c();
        qli2.Quotes__c = qc.Id;
        qli2.Account__c = a.id;
        qli2.Opportunities__c = op.id;
        qli2.Product__c = pc1.Id;
        qli2.Price_Master__c = pm.Id;
        qli2.Opp_Line_Item__c = opli1.Id;
        qli2.Product_Industry__c = 'Full';
        qli2.Product_Geo_Scope__c ='All';
        qli2.Product_Country__c = 'APAC without India';
        qli2.Tenure_Months__c = '6 Months';
        qli2.Discount_Value__c = 511000.00;
        qli2.Gross_Total__c = 766500.00;
        qli2.Adjusted_Value__c = 40;
        qli2.Unit_Price__c = 1277500.00;
        qli2.Quantity_Unit__c = 4;
        qli2.Base_Total__c = 1277500.00;
        qli2.Start_Date__c = system.today();
        
        quliList.add(qli2);
        
        insert quliList;
        
        Quote_Line_Items__c qli1 = new Quote_Line_Items__c();
        qli1.Quotes__c = qc.Id;
        qli1.Account__c = a.id;
        qli1.Opportunities__c = op.id;
        qli1.Opp_Line_Item__c = opli.Id;
        //  qli.Parent_OPLI__c = opli.p;
        qli1.Product__c = pc.Id;
        qli1.Price_Master__c = pm.Id;
        qli1.Product_Industry__c = 'Full';
        qli1.Product_Geo_Scope__c ='All';
        qli1.Product_Country__c = 'APAC without India';
        qli1.Tenure_Months__c = '3 Months';
        qli1.Discount_Value__c = 511000.00;
        qli1.Gross_Total__c = 766500.00;
        qli1.Adjusted_Value__c = 40;
        qli1.Unit_Price__c = 1277500.00;
        qli1.Quantity_Unit__c = 4;
        qli1.Base_Total__c = 1277500.00;
        qli1.Start_Date__c = system.today(); 
        insert qli1;
       
        
        List<QULI_Accessories__c> quliAcc= new List<QULI_Accessories__c>();
        QULI_Accessories__c quliA = new QULI_Accessories__c();
        quliA.Account__c= a.id;
        quliA.CurrencyIsoCode='INR';
        quliA.of_Master_Login__c='5';
        
        quliA.Quotes__c= qc.id;
        quliA.Quote_Line_Items__c = qli1.Id;        
        quliA.Price_Master__c=pm.id;
        quliA.Product__c=pc.id;
        
        quliAcc.add(quliA);
        insert quliAcc;
        quliA.Quantity_Unit__c = qli1.Quantity_Unit__c;
        update  quliAcc;
          
        list<APAC_Payments__c> appc=new list<APAC_Payments__c>();
        APAC_Payments__c app=new APAC_Payments__c();
        app.APAC_Payment_Name__c='Single Shot';
        app.Due_Date__c=system.today();
        app.Quotes__c=qc.id;
        app.Payment_Amount__c=55000;
        app.TDS_Payment_Amount__c=0;
         appc.add(app);
       // insert appc;        
        
        
        
        
        
        
        
        
        
        
        EditAPACPayments_cls.getAPACPayments(string.valueOf(qc.Id)); 
        EditAPACPayments_cls.getstatus(qc.Id);
                EditAPACPayments_cls.getvalidated(qc.Id);

        EditAPACPayments_cls.gettotal(qc.Id);
        
        try{
                    EditAPACPayments_cls.onsave(string.valueOf(qli.Id), appc); 
        }
        catch(Exception e){
            
        }
        
        
       
        
        
    }
}