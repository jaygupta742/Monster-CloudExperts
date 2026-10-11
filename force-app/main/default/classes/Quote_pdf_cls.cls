public class Quote_pdf_cls {
    public String recordId {get; set;}      //record id
    public QuotesN__c quoteObj {get; set;}  //this quote details
    public date todate {get; set;}          //to store date
    public List<String> ba{get; set;}       //billing addresss list
    public List<Quote_Line_Items__c> quoteLineItem {get;set;}       //hold all the quote line items
    public List<Account> account {get; set;}
    public Decimal total {get; set;}
    public List<String> dec {get; set;}
    public Integer basize {get; set;}
    public user u{get;set;}
    
    
    public Quote_pdf_cls(ApexPages.StandardController controller) {
        recordId = ApexPages.currentPage().getParameters().get('id');
        //recordId = 'a1Q72000000BXThEAO';
        quoteObj = [SELECT Id, Account__c, Account_Type__c, Active__c, Bill_Contact__c, Billing_Address__c, Billing_City__c, 
                    Billing_Country__c, Billing_Pin_Code__c, Billing_State__c, Billing_Street__c, CurrencyIsoCode, 
                    Opportunities__c, Order_Type__c, Posting_Address__c, Posting_City__c, Posting_Contact__c,
                    Posting_Contact__r.Name, Posting_Country__c, Posting_Pin_Code__c, Posting_State__c, Posting_Street__c, 
                    Price_Master__c, Contact__c, Contact__r.Name, Contact__r.Email, Name, Quote_Type__c, Contact__r.Phone,Contact__r.MobilePhone,
                    Special_Terms__c, Xcode__c, OwnerId, createddate, Account__r.GST_ID__c,Account__r.Name,Account__r.Industry,
                    Bill_Contact__r.name, Bill_Contact__r.Email, Bill_Contact__r.MobilePhone, Contact__r.Role__c, Account__r.PA_City__c,Account__r.BillState__c,
                    Bill_Contact__r.Fax, Account__r.RegistrationNumber__c, Account__r.PAN__c,Account__r.Type,Account__r.Sales_Rep_Email__c,
                    Account__r.Primary_Sales_Rep__c,Account__r.PrimarySalesManager__c,Xcode__r.Name,Contact__r.Title,Account__r.APAC_Industry__c, Net_Total__c,
                    Selling_Country__c, Tax_Amount__c, Tax_Percentage__c, Gross_Total__c
                    FROM QuotesN__c WHERE Id =: recordId    
                   ];
        
        u = [SELECT id,Name,LastName,CompanyName ,Location__c ,Location1__c ,Email,phone,Title ,City,Country,CreatedById,PostalCode,State,Street,fax from User WHERE ID =:quoteObj.OwnerID ];      
        todate = system.today();
        
        quoteLineItem = [SELECT Id, of_Master_Login__c, Account__c, Actual_Disount_Cap__c, Adjusted_Value__c, Adjustment_Type__c, 
                         Base_Total__c, CreatedById, CurrencyIsoCode, DB_Scope_Geography__c, DB_Type_Industry__c, Discount_Value__c,
                         Discount_Cap__c, Discount_Type__c, End_Date__c, Gross_Total__c, Inventory_Count__c, LastModifiedById, 
                         Master_login__c, Opp_Line_Item__c, Opportunities__c, Parent_OPLI__c, Price_Master__c, Product__c, Product__r.Product_Name__c, 
                         Product_PL_ID__c, Product_Category__c, Product_Country__c, Product_Geo_Scope__c, Product_Industry__c, 
                         Product_Name__c, Product_Selling_Country__c, Product_Type__c, Quantity_Unit__c, Name, Quotes__c, 
                         SKU_Code__c, SKU_Nature__c, SKU_Type__c, Start_Date__c, Tenure_Months__c, Top_Ups__c, Total_Discount_Amount__c,
                         Total_Gross_Value__c, Total_Top_Up_Price__c, Unit_Price__c, UOM__c,Price_Master__r.Name,Comment__c
                         FROM Quote_Line_Items__c
                         WHERE Quotes__c =: recordId
                        ];
        
    }
}