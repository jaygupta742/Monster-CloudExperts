/*
Last Modified By	Last Modified Date		Case			Description
Abdul Aziz			30/05/2024								Added Comment__c in SOQL of QuoteItems
Debasis Das			01/06/2024				00017719		Recontract Agreement Configuration, Due Amount & Pending Amount is not reflecting
*/

public with sharing class RecontractAgreementController {
    public String RecordId {get; set;}
    public QuotesN__c QuotesN {get; set;}
    public list<Quote_Line_Items__c> QuoteItems {get;set;}
    public list<APAC_Payments__c> lstAPACPayments {get;set;}
    public QuotesN__c BaseQuotesN {get; set;}
    public User SalesRep {get;set;}
    public String QuoteValue {get;set;}
    public String RecontractAmount {get; set;}
    public String RecontractAdjustment {get; set;}
    public String TaxAmount {get; set;}
    public String NetTotal {get; set;}
    public date dateto{get; set;} 
    public String termsUrl { get; private set; }

    
    public RecontractAgreementController(ApexPages.StandardController controller) {        
        RecordId = ApexPages.currentPage().getParameters().get('id');
        dateto = system.today();
        
        QuotesN = [SELECT Id, Tax__c,Base_Order_ID__c, Gross_Total1__c, Show_Comment__c, Net_Total__c, Tax_Amount__c, Name, Show_Services__c, Bill_Contact__r.Account.Name, Bill_Contact__r.AccountId, Bill_Contact__c, CreatedDate,Posting_Contact__r.name,Posting_Contact__c,OwnerID,Quote_Value__c,Quote_Value_Converted__c,
                   Account__r.Name,Account__r.Name_as_per_PAN__c,Account__C,Account__r.TAN__c,Account__r.RegistrationNumber__c,Posting_Contact__r.Phone,Posting_Contact__r.email,Posting_Contact__r.Fax,Posting_Street__c,
                   Posting_City__c,Posting_State__c,Posting_Country__c,Posting_Pin_Code__c,Bill_Contact__r.name,Bill_Contact__r.Email,Bill_Contact__r.Phone,Billing_Street__c, Tax_Type__c,
                   Billing_City__c,Billing_State__c,Billing_Country__c,Billing_Pin_code__c,Price_Master__c,Price_Master__r.CurrencyIsoCode,Price_Master__r.name,Contact__r.name,Contact__r.Title,
                   Account__r.PrimarySalesManager__c,Posting_Contact__r.Account.name,Account__r.PAN__c,Account__r.GST_ID__c,Posting_Contact__r.MobilePhone,Bill_Contact__r.MobilePhone,Bill_Contact__r.Fax,
                   Selling_Country__c, Tax_Percentage__c,Total_Discount_Amount__c,Base_Quote_Id__c, Amount__c, Payment_Type__c, Recontract_Adjustment__c  
                   FROM QuotesN__c WHERE Id =: RecordId];
        
        if (QuotesN.Selling_Country__c == 'Malaysia') {
            termsUrl = 'https://www.foundit.my/info/terms-of-use';
        } else if (QuotesN.Selling_Country__c == 'Singapore') {
            termsUrl = 'https://www.foundit.sg/info/terms-of-use';
        } else if (QuotesN.Selling_Country__c == 'Hong Kong') {
            termsUrl = 'https://www.foundit.hk/info/terms-of-use';
        } else if (QuotesN.Selling_Country__c == 'United Arab Emirates') {
            termsUrl = 'https://www.founditgulf.com/info/terms-of-use';
        } else {
            termsUrl = 'https://www.foundit.in/info/terms-of-use';
        }
        
        QuoteItems = [SELECT Id, Name, Comment__c,Product_Name__c,Product__r.Product_SKU_Code__c, Product_Country__c, Product_Industry__c, Tenure_Months__c, Quantity_Unit__c, Start_Date__c, End_Date__c, Product_Geo_Scope__c, Product__c, Product__r.Name, Product__r.Classification__c, Product__r.Text__c 
                      FROM Quote_Line_Items__c WHERE Quotes__c =: RecordId]; 
        
        SalesRep = [SELECT Id, Name, LastName, CompanyName, Location__c, Location1__c, Email, Phone, Title, City, Country, PostalCode, State, Street, Fax,
                    Manager.Name, Manager.Email, Manager.Phone, Manager.Fax, Manager.Title, Manager.Street, Manager.City, Manager.State, Manager.Country, Manager.PostalCode
                    FROM User WHERE ID =: QuotesN.OwnerID];   
        
        lstAPACPayments = [SELECT Id, Name, CurrencyIsoCode, Due_Date__c, Payment_Amount__c, TDS_Payment_Amount__c FROM APAC_Payments__c WHERE Quotes__c =: RecordId];
        
        if(QuotesN.Base_Quote_Id__c != null) {
            BaseQuotesN = [SELECT Id, Tax__c, Start_Date__c, Gross_Total1__c, Show_Comment__c, Net_Total__c, Tax_Amount__c, Name, Show_Services__c, Bill_Contact__r.Account.Name, 
                           Bill_Contact__r.AccountId, Bill_Contact__c,CreatedDate, Posting_Contact__r.Name, Posting_Contact__c, OwnerID, Quote_Value__c, Quote_Value_Converted__c,
                           Account__r.Name, Account__r.Name_as_per_PAN__c, Account__c, Account__r.TAN__c, Account__r.RegistrationNumber__c, Posting_Contact__r.Phone, 
                           Posting_Contact__r.Email, Posting_Contact__r.Fax, Posting_Street__c, Posting_City__c, Posting_State__c, Posting_Country__c, Posting_Pin_Code__c, 
                           Bill_Contact__r.Name, Bill_Contact__r.Email, Bill_Contact__r.Phone, Billing_Street__c, Billing_City__c, Billing_State__c, Billing_Country__c, 
                           Billing_Pin_code__c, Price_Master__c, Price_Master__r.CurrencyIsoCode, Price_Master__r.Name, Contact__r.Name, Contact__r.Title, Account__r.PrimarySalesManager__c,
                           Posting_Contact__r.Account.Name, Account__r.PAN__c, Account__r.GST_ID__c, Posting_Contact__r.MobilePhone, Bill_Contact__r.MobilePhone, Bill_Contact__r.Fax,
                           Selling_Country__c, Tax_Percentage__c, Total_Discount_Amount__c
                           FROM QuotesN__c WHERE Id =: QuotesN.Base_Quote_Id__c];
        }
        
        QuoteValue = QuotesN.Quote_Value__c == null ? '' : QuotesN.Quote_Value__c.format();
        QuoteValue = !QuoteValue.contains('\\.') ? QuoteValue + '.00' : QuoteValue;
        RecontractAmount = QuotesN.Amount__c == null ? '' : QuotesN.Amount__c.format();
        RecontractAmount = !RecontractAmount.contains('\\.') ? RecontractAmount + '.00' : RecontractAmount;
        RecontractAdjustment = QuotesN.Recontract_Adjustment__c == null ? '' : QuotesN.Recontract_Adjustment__c.format();
        RecontractAdjustment = !RecontractAdjustment.contains('\\.') ? RecontractAdjustment + '.00' : RecontractAdjustment;
        TaxAmount = QuotesN.Tax_Amount__c == null ? '' : QuotesN.Tax_Amount__c.format();
        TaxAmount = !TaxAmount.contains('\\.') ? TaxAmount + '.00' : TaxAmount;
        NetTotal = QuotesN.Net_Total__c == null ? '' : QuotesN.Net_Total__c.format();
        NetTotal = !NetTotal.contains('\\.') ? NetTotal + '.00' : NetTotal;
    }
}