public class CreateQuotePdf {
    public list<Quote_Line_Items__c> pli {get;set;}
    public id recid;
    public list<APAC_Payments__c> aap{get;set;}
    public QuotesN__c QuotesN{get;set;}
    public user u{get;set;}
    public String recordId {get; set;}      //record id
    
    
    //image for doc
    public string imgsrc{get;set;}
    public string a{get;set;}
    
    public CreateQuotePdf(ApexPages.StandardController controller) {
        
        recid = ApexPages.currentPage().getParameters().get('id');
        //recid = 'a177200000D3M4XAAV';
        recordId = ApexPages.currentPage().getParameters().get('id');
        pli = [SELECT id,name,Service_Name__c,Product__r.SKU_Type__c, Product__r.Primary_Selling_Country__c,Product__r.Tenure_Months__c,Product__r.Product_Country__c, of_Master_Login__c,     Account__c,     Active__c,      Actual_Disount_Cap__c,  Adjusted_Value__c,      Adjustment_Type__c,     Base_Total__c,  Comment__c,     CreatedById,
                   CurrencyIsoCode,     DB_Scope_Geography__c,  DB_Type_Industry__c,    Discount_Value__c,      Discount_Cap__c,Discount_Type__c,       End_Date__c,Gross_Total__c,
                   Inventory_Count__c,Master_login__c,  Opp_Line_Item__c,Opportunities__c,      Parent_OPLI__c,Price_Master__c, Product__c,
                   Product_PL_ID__c,product_Category__c,        Product_Country__c,     Product_Geo_Scope__c,   Product_Industry__c,    Product_Name__c,product_Name_Text__c,
                   Product_Selling_Country__c,Product_Type__c,Quantity_Unit__c,Quotes__c,SKU_Code__c,   SKU_Nature__c,SKU_Type__c,Start_Date__c,
                   Tenure_Months__c,    Top_Ups__c,Total_Discount_Amount__c,    Total_Gross_Value__c,   Total_Top_Up_Price__c,Unit_Price__c,UOM__c,
                   Quotes__r.ownerid ,Product__r.name, Product__r.Product_Name__c,(select id,Top_Ups__r.name,name,End_Date__c,Start_Date__c,Unit_Price__c,Quantity_Unit__c,Product_Tenure_Months__c,Product_SKU_Type__c  from QULI_Accessories__r)       
                   FROM Quote_Line_Items__c
                   WHERE Quotes__c = :recordId
                  ];        
        //try{
        aap=[select id,name,currencyisocode,Due_Date__c,Payment_Amount__c,TDS_Payment_Amount__c from APAC_Payments__c where Quotes__c=:recordId];   // }
        //catch(exception e){}
        
        QuotesN= [select id,Tax__c,Gross_Total1__c,Net_Total__c, name , Bill_Contact__r.Account.name,Bill_Contact__r.AccountId,Bill_Contact__c,createddate,Posting_Contact__r.name,Posting_Contact__c,OwnerID,Quote_Value__c,Quote_Value_Converted__c,
                  Account__r.Name,Account__r.Name_as_per_PAN__c,Account__C,Account__r.TAN__c,Account__r.RegistrationNumber__c,Posting_Contact__r.Phone,Posting_Contact__r.email,Posting_Contact__r.Fax,Posting_Street__c,
                  Posting_City__c,Posting_State__c,Posting_Country__c,Posting_Pin_Code__c,Bill_Contact__r.name,Bill_Contact__r.Email,Bill_Contact__r.Phone,Billing_Street__c,
                  Billing_City__c,Billing_State__c,Billing_Country__c,Billing_Pin_code__c,Price_Master__c,Price_Master__r.CurrencyIsoCode,Price_Master__r.name,Contact__r.name,Contact__r.Title,
                  Account__r.PrimarySalesManager__c,Posting_Contact__r.Account.name,Account__r.PAN__c,Account__r.GST_ID__c,Posting_Contact__r.MobilePhone,Bill_Contact__r.MobilePhone,Bill_Contact__r.Fax,
                  Selling_Country__c, Tax_Percentage__c
                  
                  
                  from QuotesN__C where id =: recordId    
                 ];
        
        u = [SELECT id,name,LastName,CompanyName ,Location__c ,Location1__c ,Email,phone,Title ,City,Country,CreatedById,PostalCode,State,Street,fax from User WHERE ID =:QuotesN.OwnerID ];      
        
        //doc
        
        // Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
        a=URL.getSalesforceBaseUrl().getHost();
        a=a.substring(0, 5);
        //imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00D7F000007CaXU';      
        
        
    }
    
}