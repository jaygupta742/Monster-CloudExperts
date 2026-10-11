public without sharing class Newcreatequoteclasss {
    
    @AuraEnabled
    public static String getoppinfo(String recId){
        OpportunityN__c Opportunity = new OpportunityN__c();
        Opportunity = [Select Id,Name,Account_Credit_Status__c,Account__c,Xcode__c,Price_Master__c,Opportunity_Type__c,CurrencyIsoCode,Contact__c from OpportunityN__c where Id =: recId];

        List<Opp_Line_Item__c> lstOpportunityItems = new List<Opp_Line_Item__c>();
        lstOpportunityItems = [SELECT Id, Name, Product_Name__c, Product__c, Start_Date__c, End_Date__c, Comment__c, Quantity_Unit__c, Unit_Price__c, Discount_Type__c, Discount_Value__c 
        FROM Opp_Line_Item__c WHERE Opportunities__c =: recid];

        List<OPLI_Accessories__c> lstOpportunityServices = new List<OPLI_Accessories__c>();
        lstOpportunityServices = [SELECT Id, Name, Product__c, Product_Name__c, Top_Ups__c, Top_Ups__r.Name, Quantity__c, Unit_Price1__c, Inventory_Quota_Tenure1__c
        FROM OPLI_Accessories__c WHERE Opportunities__c =: recid];


        Map<String, Object> mapResponse = new Map<String, Object> ();
        mapResponse.put('Opportunity', Opportunity);
        mapResponse.put('Products', lstOpportunityItems);
        mapResponse.put('Services', lstOpportunityServices);
        return JSON.serialize(mapResponse);
    }
    @AuraEnabled
    public static String getAccountStatusApex(String recId){
        System.debug('Account Statis is:');
        OpportunityN__c Opportunity = new OpportunityN__c();
        Opportunity = [Select Id,Name,Account_Credit_Status__c,Account__c,Xcode__c,Price_Master__c,Opportunity_Type__c,CurrencyIsoCode,Contact__c from OpportunityN__c where Id =: recId];
        Account acc=[select id,name,AccountStatus__c from Account where id=:Opportunity.Account__c limit 1];
          System.debug('Account Statis is:'+acc.AccountStatus__c);
        return acc.AccountStatus__c;
    }
    
    @AuraEnabled
    public static List<QuotesN__c> GetQuotesForRecontract(String recordId) {
        OpportunityN__c EOpportunity = [SELECT Id, Name, Account__c FROM OpportunityN__c WHERE Id =: recordId];
        List<QuotesN__c> lstQuotes = [SELECT Id, Name FROM QuotesN__c WHERE Account__c =: EOpportunity.Account__c];
        return lstQuotes;
    }

    @AuraEnabled
    public static string getcon(String recId){
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Account__c,Xcode__c,Price_Master__c,Opportunity_Type__c,CurrencyIsoCode,Contact__c from OpportunityN__c where Id =: recId];
        list<wraper> wrap = new list<wraper>(); 
        list<Contact> conlist = [SELECT Id, Name,CreatedDate, AccountId FROM Contact WHERE AccountId=:opp.Account__c ORDER BY Name DESC]; 
        //  system.debug('contact list'+ conlist.size());
        for(Contact con:conlist){
            wraper w=new wraper(con.Id , con.Name);
            wrap.add(w);
        }
        return JSON.serialize(wrap);
        
    }
    @AuraEnabled
    public static string fetchpostingcontact(string rid){
        OpportunityN__c opp = [Select Id,Name,Account__c,Xcode__c,Price_Master__c,Opportunity_Type__c,CurrencyIsoCode,Contact__c from OpportunityN__c where Id =: rid];
        List<Contact> conli=[select id,name from Contact where Accountid=:opp.Account__c];
        List<wrape> wrlist=new List<wrape>();
        for(contact c:conli){
            wrape ww=new wrape(c.Name,c.Id);
            wrlist.add(ww);
        }
        return JSON.serialize(wrlist);
        
    }
    @AuraEnabled
    public static QuotesN__c getQuoteObj(String recId){
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Base_Order_ID__c,Account__c,Xcode__c,Price_Master__c,Opportunity_Type__c,CurrencyIsoCode,Contact__c from OpportunityN__c where Id =: recId];
        
        list<Contact> cc = [SELECT Id, Name,CreatedDate, AccountId FROM Contact WHERE AccountId=:opp.Account__c ORDER BY Name DESC]; 
        
        QuotesN__c qq = new QuotesN__c();
        qq.Quote_Type__c=opp.Opportunity_Type__c;
        qq.Xcode__c=opp.Xcode__c;
        qq.Account__c=opp.Account__c;
        // qq.Contact__c=opp.Contact__c;
        qq.Opportunities__c=opp.id;
        qq.Price_Master__c=opp.Price_Master__c;
        qq.CurrencyIsoCode=opp.CurrencyIsoCode;
        qq.Active__c=True;
        qq.Base_Order_ID__c=opp.Base_Order_ID__c;
        
        qq.Contact__c=cc[0].Id;
        qq.Bill_Contact__c=cc[0].Id;
        qq.Posting_Contact__c=cc[0].Id;
        return qq;
    }
    
    @AuraEnabled
    public static List<Quote_Line_Items__c> getQuoteLine(String recId){
        system.debug('recId:'+recId);
        List<Opp_Line_Item__c> opliList = new List<Opp_Line_Item__c>();
        List<Quote_Line_Items__c> quliList = new List<Quote_Line_Items__c>();
        opliList = [SELECT Account__c,Sku_Type1__c,Product__r.Product_Name__c,Actual_Disount_Cap__c,Approval_Status__c,Base_Total__c,Comment__c,Start_Date__c,End_Date__c,
                    Bundle_Quantity1__c,Bundle_Quantity__c,Category__c,CreatedById,CreatedDate,CurrencyIsoCode,DB_Scope_Geography__c,DB_Type_Industry__c,
                    Discounted_Price__c,Discount_Amount_1__c,Discount_Amount__c,Discount_Cap__c,Discount_Type__c,Discount_Value__c,Gross_Total__c,Id,
                    Inventory_Count__c,IsDeleted,LastModifiedById,LastModifiedDate,Master_Login_percent__c,Name,of_Master_Login__c,OpliId__c,OPLI__c,Opportunities__c,
                    Opportunity_Type__c,Price_Junction__c,Price_Master__c,Product_Country__c,Product_Name__c,Product_Selling_Country__c,Product_Type__c,Product__c,
                    Quantity_Unit__c,SKU_Code__c,Sku_Nature__c,SKU_Type__c,SystemModstamp,Tenure_Months__c,Total_Amount__c,Total_cost__c,Unit_Price_Tenure__c,Unit_Price__c,
                    UOM__c,User_Profile__c FROM Opp_Line_Item__c where Opportunities__c=:recid];
        system.debug(opliList[0].Product_Name__c);
        List<quwrape> wrlist=new List<quwrape>();
        for(Opp_Line_Item__c oo:opliList){
            // if(oo.Tenure_Months__c!='12 Months') {
            Quote_Line_Items__c qq = new Quote_Line_Items__c();
            qq.Account__c=oo.Account__c;
            qq.Product_Name_Text__c=oo.Product_Name__c; 
            qq.CurrencyIsoCode=oo.CurrencyIsoCode;
            qq.Quantity_Unit__c=oo.Quantity_Unit__c;
            qq.Price_Master__c = oo.Price_Master__c;
            qq.Product__c = oo.Product__c;
            qq.of_Master_Login__c=oo.of_Master_Login__c;
            qq.Parent_OPLI__c=oo.OPLI__c;
            qq.Adjustment_Type__c=oo.Discount_Type__c;
            qq.Adjusted_Value__c=oo.Discount_Value__c;
            //qq.Discount_Cap__c=oo.Discount_Value__c;
            qq.Discount_Value__c=oo.Discount_Amount_1__c;
            qq.Unit_Price__c = oo.Unit_Price__c;
            qq.Opportunities__c=oo.Opportunities__c;
            qq.Opp_Line_Item__c=oo.id;
            qq.Sku_Type1__c=oo.Sku_Type1__c;
            
            qq.Gross_Total__c=oo.Gross_Total__c;
            qq.Base_Total__c=oo.Base_Total__c;
            qq.Product_Industry__c=oo.DB_Type_Industry__c;
            qq.Product_Geo_Scope__c=oo.DB_Scope_Geography__c;
            qq.Product_Country__c=oo.Product_Country__c;
            qq.Tenure_Months__c=oo.Tenure_Months__c;
            qq.Start_Date__c = oo.Start_Date__c;
            qq.End_Date__c =oo.End_Date__c;
            qq.Comment__c = oo.Comment__c;
            qq.OPLI_No__c=oo.Name;
            quliList.add(qq);
            
            quwrape wr=new quwrape(qq);
            wr.pname=oo.Product_Name__c;
            wr.oname=oo.Name;
            wr.opliname=oo.Name;
            wr.sdate=oo.Start_Date__c;
            wr.edate=oo.End_Date__c;
            wr.otype=oo.Discount_Type__c;
            wr.ovalue=oo.Discount_Value__c;
            wr.comments=oo.Comment__c;
            wrlist.add(wr);
            system.debug('quliList:'+wr.oname);
        }
        system.debug('quliList:'+quliList.size());
        return quliList;
    }
    
    @AuraEnabled
    public static List<QULI_Accessories__c> getQuoteLineAccessories(String recId){
        system.debug('recId:'+recId);
        
        
        List<OPLI_Accessories__c> opliAccList = new List<OPLI_Accessories__c>();
        List<QULI_Accessories__c> quliAccList = new List<QULI_Accessories__c>();
        opliAccList = [SELECT Account__c,Start_Date__c,End_Date__c,Opp_Line_Item__r.Quantity_Unit__c,Opp_Line_Item__r.Tenure_Months__c,Adjustment_Type__c,Adjustment_Value__c,CreatedById,CreatedDate,CurrencyIsoCode,Discount_Amount__c,Id,Inventory_Quota_Tenure1__c,Inventory_Quota_Tenure__c,IsDeleted,LastActivityDate,LastModifiedById,LastModifiedDate,Mandatory__c,Name,of_Master_Login__c,Opportunities__c,Opp_Line_Item__c,PL_Accessories__c,Price_Master__c,Product_Geo_Scope__c,Product_Industry__c,Product_Name__c,Product_PL__c,Product_Selling_Country__c,Product_SKU_Type__c,Product_SKU__c,Product_Tenure_Months__c,Product__c,Quantity_Unit__c,Quantity__c,SystemModstamp,Top_Ups__c,Top_Up_Name__c,Unit_Price1__c,Unit_Price__c FROM OPLI_Accessories__c where Opportunities__c=:recid];
        
        List<swrape> wrlist=new List<swrape>();
        for(OPLI_Accessories__c oo:opliAccList){
            QULI_Accessories__c qq = new QULI_Accessories__c();
            //qq.Name=oo.Name;
            qq.Top_Ups__c = oo.Top_Ups__c;
            qq.CurrencyIsoCode = oo.CurrencyIsoCode;
            qq.OPLI_Services__c = oo.id;
            qq.Price_Master__c = oo.Price_Master__c;
            qq.Product__c = oo.Product__c;
            qq.Quantity_Unit__c = oo.Quantity_Unit__c;
            qq.Unit_Price__c = oo.Unit_Price__c;
            qq.Mandatory__c=oo.Mandatory__c;
            qq.Inventory_Quota_Tenure__c=oo.Inventory_Quota_Tenure__c;
            qq.Inventory_Count__c=oo.Quantity_Unit__c;
            qq.Account__c=oo.Account__c;
            qq.Opportunities__c=oo.Opportunities__c;
            qq.Opp_Line_Item__c=oo.Opp_Line_Item__c;
            qq.of_Master_Login__c=oo.of_Master_Login__c;
            qq.Product_Name_Text__c=oo.Product_Name__c;
            qq.Top_Up_Name_Text__c=oo.Top_Up_Name__c;
            
            
            // qq.OPLI_Acceessories__c=oo.id;
            quliAccList.add(qq);
            
            swrape ww=new swrape(qq);
            ww.sname=oo.Name;
            ww.ten=oo.Inventory_Quota_Tenure__c;
            ww.pname=oo.Product_Name__c;
            ww.sdate=oo.Start_Date__c;
            ww.edate=oo.End_Date__c;
            wrlist.add(ww);
        }
        
        
        system.debug('quliAccList:'+quliAccList.size());
        
        return quliAccList;
    }
    
    @AuraEnabled
    public static string saveQuote(String recId, QuotesN__c quo, List<Quote_Line_Items__c> quli, List<QULI_Accessories__c> quacli) {
        try {
            Date StartDate = null, EndDate = null;
            Set<Id> setProductIds = new Set<Id> ();
            for (Quote_Line_Items__c item : quli) {
                // Check and update the smallest StartDate
                if (item.Start_Date__c != null) {
                    if (StartDate == null || item.Start_Date__c < StartDate) {
                        StartDate = item.Start_Date__c;
                    }
                }
            
                // Check and update the largest EndDate
                if (item.End_Date__c != null) {
                    if (EndDate == null || item.End_Date__c > EndDate) {
                        EndDate = item.End_Date__c;
                    }
                }

                if(item.Product__c != null) setProductIds.add(item.Product__c);
            }
            List<ProductC__c> lstProduct = [SELECT Id, Name, Product_Name__c FROM ProductC__c WHERE Id IN: setProductIds];

            for(ProductC__c product : lstProduct) {
                System.debug('Product Name : ' + product.Product_Name__c);
                if(product.Product_Name__c != null && product.Product_Name__c.toLowerCase().contains('additional')) quo.Free_Trial_Product__c = true;
            }
            quo.Start_Date__c = StartDate;
            quo.End_Date__c = EndDate;
            Insert quo;
            
            for(Quote_Line_Items__c item : quli){
                item.Quotes__c = quo.Id;
            }
            if(quli.size()>0) Insert quli;
            
            for(Quote_Line_Items__c item : quli) {
                for(QULI_Accessories__c qal : quacli){
                    qal.Quotes__c = quo.id;
                    if(qal.Opp_Line_Item__c == item.Opp_Line_Item__c) {
                        qal.Quote_Line_Items__c = item.Id;
                    }
                }
            }

            if(quacli.size() > 0) Insert quacli;
        
            return quo.Id;
            
        } catch(Exception e) {
            System.debug('@@ error in Save Quote');
            System.debug('error message : ' + e.getMessage());
            System.debug('error line number : ' + e.getLineNumber());
            
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    Public Class wraper{
        public string label;
        public string value;
        public wraper(string i, string n ){
            
            value = i;
            label = n;
        }
    }
    
    public class quwrape{
        @AuraEnabled
        public Quote_Line_Items__c li{get;set;}
        public string pname{get;set;}
        public string opliname{get;set;}
        public date sdate{get;set;}
        public date edate{get;set;}
        public string oname{get;set;}
        public string otype{get;set;}
        public decimal ovalue{get;set;}
        public string comments{get;set;}
        
        public quwrape(Quote_Line_Items__c ll){
            li=new Quote_Line_Items__c();
            li=ll;
        }
    }
    
    public class swrape{
        @AuraEnabled
        public QULI_Accessories__c li{get;set;}
        public string sname{get;set;}
        public date sdate{get;set;}
        public date edate{get;set;}
        public string otype{get;set;}
        public decimal ovalue{get;set;}
        public string ten{get;set;}
        public string pname{get;set;}
        
        public swrape(QULI_Accessories__c s1){
            li=new QULI_Accessories__c();
            li=s1;
        }
    }
    public class wrape{
        public string label{get;set;}
        public string value{get;set;}
        
        public wrape(string ll,string vv){
            label=ll;
            value=vv;
        }
    }
    
    
}