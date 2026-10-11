public class MeDubaiAddNewClass{
    public list<QuotesN__c> takeall{get;set;}
    public string recid{get;set;}
    public list<APAC_Payments__c> ap{get;set;}
    
    public user ss{get;set;}
    public integer slno{get;set;}
    public list<Quote_Line_Items__c> pl {get;set;}
    public QuotesN__c QuotesN{get;set;}
    
    public string imgsrc{get;set;}
    public string a{get;set;}
    public MeDubaiAddNewClass(ApexPages.StandardController controller) {
        /*Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
a=URL.getSalesforceBaseUrl().getHost();
a=a.substring(0, 5);
imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00D7F000007CaXU';*/
        
        takeall=new list<QuotesN__c> ();
        ss= new User();
        QuotesN=new QuotesN__c();
        recid=apexPages.CurrentPage().getParameters().get('id');
        /*     takeall=[select id, name,PostingContact__c ,Account__c,OwnerId,Posting_Street__c,Posting_Country__c,Posting_City__c,Posting_Pin_Code__c,Posting_State__c,
Billing_Account__c,Billing_State__c ,Billing_Pin_code__c,Billing_Country__c,APTS_Billing_Contact_Email_Address__c,BillContact__c,
Billing_Street__c,Billing_City__c
,Gross_Total__c,Tax_Amount__c,Net_Total__c,Payment_Net_Total__c,Special_Terms__c,(select id,name,Product__c,Quantity__c,Product_Start_Date__c,
Product_End_Date__c from Quote_Line_Item__r),(select id,name,Due_Date__c from APAC_Payments__r)  
from apttus_proposal_proposal__c where id=:recid];
*/
        QuotesN= [select id, Tax__c,name , Bill_Contact__r.Account.name,Bill_Contact__r.AccountId,Bill_Contact__c,createddate,Posting_Contact__r.name,Posting_Contact__c,OwnerID,Quote_Value__c,Quote_Value_Converted__c,
                  Account__r.Name,Account__r.Name_as_per_PAN__c,Account__C,Account__r.TAN__c,Account__r.RegistrationNumber__c,Posting_Contact__r.Phone,Posting_Contact__r.email,Posting_Contact__r.Fax,Posting_Street__c,
                  Posting_City__c,Posting_State__c,Posting_Country__c,Posting_Pin_Code__c,Bill_Contact__r.name,Bill_Contact__r.Email,Bill_Contact__r.Phone,Billing_Street__c,
                  Billing_City__c,Billing_State__c,Billing_Country__c,Billing_Pin_code__c,Price_Master__c,Price_Master__r.CurrencyIsoCode,Price_Master__r.name,Contact__r.name,Contact__r.Title,
                  Account__r.PrimarySalesManager__c,Posting_Contact__r.Title,Posting_Contact__r.Account.name,Account__r.PAN__c,Account__r.GST_ID__c,Posting_Contact__r.MobilePhone,Bill_Contact__r.MobilePhone,Bill_Contact__r.Fax
                  ,Contact__c,Contact__r.Email, Selling_Country__c, Tax_Percentage__c, Tax_Amount__c, Net_Total__c
                  
                  from QuotesN__C where id=:recid];                 
        
        
        
        pl = new list<Quote_Line_Items__c>([ SELECT id,Product__r.SKU_Type__c,name, of_Master_Login__c, Product__r.Primary_Selling_Country__c,Product__r.Tenure_Months__c,Product__r.Product_Country__c,     Account__c,     Active__c,      Actual_Disount_Cap__c,  Adjusted_Value__c,      Adjustment_Type__c,     Base_Total__c,  Comment__c,     CreatedById,
                                            CurrencyIsoCode,   DB_Scope_Geography__c,  DB_Type_Industry__c,    Discount_Value__c,      Discount_Cap__c,Discount_Type__c,       End_Date__c,Gross_Total__c,
                                            Inventory_Count__c,Master_login__c,        Opp_Line_Item__c,Opportunities__c,      Parent_OPLI__c,Price_Master__c, Product__c,
                                            Product_PL_ID__c,product_Category__c,      Product_Country__c,     Product_Geo_Scope__c,   Product_Industry__c,    Product_Name__c,product_Name_Text__c,
                                            Product_Selling_Country__c,Product_Type__c,Quantity_Unit__c,Quotes__c,SKU_Code__c, SKU_Nature__c,SKU_Type__c,Start_Date__c,
                                            Tenure_Months__c,  Top_Ups__c,Total_Discount_Amount__c,    Total_Gross_Value__c,   Total_Top_Up_Price__c,Unit_Price__c,UOM__c,
                                            Quotes__r.ownerid ,Product__r.name, Product__r.Product_Name__c,Service_Name__c,(select id,Top_Ups__r.name,name,End_Date__c,Start_Date__c,Unit_Price__c,Quantity_Unit__c,Product_Tenure_Months__c,Product_SKU_Type__c  from QULI_Accessories__r )
                                            FROM Quote_Line_Items__c  WHERE Quotes__c = :recid]);  
        
        
        ap = new list<APAC_Payments__c> ();
        
        ss= [SELECT id, firstname, lastname,name,fax,username,city,country,CompanyName,Title,Location__c,Email,Phone,Location1__c from user where Id=:QuotesN.ownerId];                  
        try{                 
            ap=[select id,name,currencyisocode,Due_Date__c,Payment_Amount__c,TDS_Payment_Amount__c from APAC_Payments__c where Quotes__c=:recid];
        }
        catch(Exception e){}
        
        
    }
    
    
}