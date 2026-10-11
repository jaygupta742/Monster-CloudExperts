public class Foundit_UAE_Renewal {
    public list<wraperService> wraplist {get;set;}
    public integer intvalue;
    public String recordId {get; set;}      //record id
    public QuotesN__c quoteObj {get; set;}  //this quote details
    public date todate {get; set;}          //to store date
    public List<String> ba{get; set;}       //billing addresss list
    public List<Quote_Line_Items__c> quoteLineItem {get;set;}       //hold all the quote line items
    public List<Account> account {get; set;}
    public Decimal total {get; set;}
    public List<String> dec {get; set;}
    public Integer basize {get; set;}
    public List<APAC_Payments__c> app{get;set;}
    public user ss{get;set;}
    
    public String showAccessories {get; set;}
    public List<QULI_Accessories__c> lstAccessories {get; set;}
    public string showcomentandservice {get; set;} 
    
    //Guideline Properties
    public String guidelinename {get; set;} 
    public Guidelines__c guidelines {get;set;}
    public Boolean showGuideLine {get; set;}
    
    public string Quote_Value {get;set;}
    public string Tax_Amount {get;set;} 
    public string Net_Total {get;set;}
    
    
    public Foundit_UAE_Renewal (ApexPages.StandardController controller) {
        intvalue=1;
        wraplist=new  list<wraperService>();
        app=new List<APAC_Payments__c>();
        recordId = ApexPages.currentPage().getParameters().get('id');
        showAccessories = ApexPages.currentPage().getParameters().get('showAccessories');
        
        //  recordId = 'a1Q72000000BXThEAO';
        quoteObj = [SELECT Id,Tax__c,Show_Comment__c,Show_Services__c, Account__c, Account_Type__c, Active__c, Bill_Contact__c, Billing_Address__c, Billing_City__c,Price_Master__r.name,Quote_Value__c,
                    Billing_Country__c, Billing_Pin_Code__c, Billing_State__c, Billing_Street__c, CurrencyIsoCode, 
                    Opportunities__c, Order_Type__c, Posting_Address__c, Posting_City__c, Posting_Contact__c,Posting_Contact__r.email,Posting_Contact__r.Phone,Bill_Contact__r.Account.Name,Bill_Contact__r.Phone,
                    Posting_Contact__r.Name, Posting_Country__c, Posting_Pin_Code__c, Posting_State__c, Posting_Street__c, 
                    Price_Master__c, Contact__c, Contact__r.Name, Contact__r.Email, Name, Quote_Type__c, Contact__r.Phone,Contact__r.MobilePhone,
                    Special_Terms__c, Xcode__c, OwnerId, createddate, Account__r.GST_ID__c,Account__r.Name,Account__r.Industry,
                    Bill_Contact__r.name, Bill_Contact__r.Email, Bill_Contact__r.MobilePhone, Contact__r.Role__c, Account__r.PA_City__c,Account__r.BillState__c,
                    Bill_Contact__r.Fax, Account__r.RegistrationNumber__c, Account__r.PAN__c,Account__r.Type,Account__r.Sales_Rep_Email__c, Tax_Percentage__c,
                    Account__r.Primary_Sales_Rep__c,Gross_Total1__c,Account__r.PrimarySalesManager__c,Xcode__r.Name,Contact__r.Title,Account__r.APAC_Industry__c, Selling_Country__c,Tax_Amount__c,Net_Total__c
                    FROM QuotesN__c WHERE Id =: recordId    
                   ];
        
        Quote_Value = quoteObj.Quote_Value__c == null ? '' : quoteObj.Quote_Value__c.format(); 
        Tax_Amount = quoteObj.Tax_Amount__c == null ? '' : quoteObj.Tax_Amount__c.format(); 
        Net_Total = quoteObj.Net_Total__c == null ? '' : quoteObj.Net_Total__c.format(); 
        
        ss = [SELECT id,Name,LastName,Firstname,CompanyName ,Location__c ,Location1__c ,Email,phone,Title ,City,Country,CreatedById,PostalCode,State,Street,fax,
              Manager.Name,Manager.Email,Manager.phone,Manager.Fax,Manager.Title,Manager.Street,Manager.City,Manager.State,Manager.Country,Manager.PostalCode
              from User WHERE ID =:quoteObj.OwnerID ];      
        todate = system.today();
        
        quoteLineItem = [SELECT id,name,Service_Name__c,Product__r.Product_SKU_Code__c,Product__r.SKU_Type__c,Product__r.Text__c, Product__r.Primary_Selling_Country__c,Product__r.Tenure_Months__c,Product__r.Product_Country__c, of_Master_Login__c,     Account__c,     Active__c,      Actual_Disount_Cap__c,  Adjusted_Value__c,      Adjustment_Type__c,     Base_Total__c,  Comment__c,     CreatedById,
                         CurrencyIsoCode,     DB_Scope_Geography__c,  DB_Type_Industry__c,    Discount_Value__c,      Discount_Cap__c,Discount_Type__c,       End_Date__c,Gross_Total__c,
                         Inventory_Count__c,Master_login__c,  Opp_Line_Item__c,Opportunities__c,      Parent_OPLI__c,Price_Master__c, Product__c,Product__r.Location__c,
                         Product_PL_ID__c,product_Category__c,        Product_Country__c,     Product_Geo_Scope__c,   Product_Industry__c,    Product_Name__c,product_Name_Text__c,
                         Product_Selling_Country__c,Product_Type__c,Quantity_Unit__c,Quotes__c,SKU_Code__c,   SKU_Nature__c,SKU_Type__c,Start_Date__c,
                         Tenure_Months__c,    Top_Ups__c,Total_Discount_Amount__c,    Total_Gross_Value__c,   Total_Top_Up_Price__c,Unit_Price__c,UOM__c,
                         Quotes__r.ownerid ,Product__r.name, Product__r.Product_Name__c,  Product__r.Classification__c, Product__r.DB_Type_Industry__c, Product__r.DB_Scope_Geography__c, Product__r.Product_Description__c,
                         (select id,Top_Ups__r.name,name,End_Date__c,Start_Date__c,Unit_Price__c,Quantity_Unit__c,Product_Tenure_Months__c,Product_SKU_Type__c,
                          Top_Ups__r.Product__r.Product_Country__c,Product_Country__c,Display_Order__c,Top_Ups__r.Display_Order__c,Product__c,Top_Ups__r.Inventory_Quota_Tenure__c,
                          Product__r.Product_Country__c ,Inventory_Quota_Tenure__c from QULI_Accessories__r order by Top_Ups__r.Display_Order__c)       
                         FROM Quote_Line_Items__c
                         WHERE Quotes__c = :recordId
                        ];     
        
        lstAccessories = [SELECT Id, Name, Quotes__c,Top_Ups__r.name, Inventory_Quota_Tenure__c,Top_Up_Name__c, Quantity_Unit__c, Start_Date__c, End_Date__c 
                          FROM QULI_Accessories__c WHERE Quotes__c =: recordId];
        
        
        app=[select id,name,currencyisocode,Due_Date__c,Payment_Amount__c,TDS_Payment_Amount__c from APAC_Payments__c where Quotes__c=:recordId];
        
        for(Quote_Line_Items__c qi :quoteLineItem){
            for(QULI_Accessories__c qa : qi.QULI_Accessories__r)
            {
                wraperService ws=new wraperService(qa);
                if(qi.Product__c==qa.Product__c){ ws.srno=intvalue;}
                wraplist.add(ws);  
            }
            intvalue++;
        }
        
        showGuideLine = false;
        for(Quote_Line_Items__c qi :quoteLineItem){
            String productName = qi.Product__r.Product_Name__c;
            String productDescription = qi.Product__r.Product_Description__c;
            String productCountry = qi.Product__r.Product_Country__c;
            
            if(productName.containsIgnoreCase('PPI') && productCountry.containsIgnoreCase('India')) {
                guidelinename = 'India';
                showGuideLine = true;
                break;
            } else if(productName.containsIgnoreCase('Custom') && productDescription.containsIgnoreCase('PPI') && productCountry.containsIgnoreCase('India')) {
                guidelinename = 'India';
                showGuideLine = true;
                break;
            } else if(productName.containsIgnoreCase('PPI') && productCountry.containsIgnoreCase('Singapore') || productCountry.containsIgnoreCase('Malaysia') || productCountry.containsIgnoreCase('Philippines') || productCountry.containsIgnoreCase('Hong Kong')) {
                guidelinename='SEA';
                showGuideLine = true;
                break;
            }
        }
        
        if(showGuideLine) {
            guidelines = [SELECT Id, Name, GuideLine_Details__c FROM Guidelines__c WHERE Name =: guidelinename LIMIT 1];
        }
    }
    public class wraperService {
        public QULI_Accessories__c service{get;set;}
        public integer srno{get;set;}
        public wraperService(QULI_Accessories__c item) {
            service = new QULI_Accessories__c();
            service = item;
        }
    }
    
}