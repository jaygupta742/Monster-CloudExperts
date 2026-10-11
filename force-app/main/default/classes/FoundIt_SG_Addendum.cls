public class FoundIt_SG_Addendum {
    public list<wraperService> wraplist {get;set;}
    public integer intvalue;
    public String recordId {get; set;}      //record id
    public QuotesN__c QuotesN {get; set;}  //this quote details
    public date todate {get; set;}          //to store date
    public List<String> ba{get; set;}       //billing addresss list
    public List<Quote_Line_Items__c> pli {get;set;}       //hold all the quote line items
    public List<Account> account {get; set;}
    public string showcomentandservice {get; set;}
    public Decimal total {get; set;}
    public List<String> dec {get; set;}
    public Integer basize {get; set;}
    public List<APAC_Payments__c> aap{get;set;}
    public user u{get;set;} 
    public List<QULI_Accessories__c> lstAccessories {get; set;}
    public String showAccessories {get; set;}
    
    //Guideline Properties
    public String guidelinename {get; set;} 
    public Guidelines__c guidelines {get;set;}
    public Boolean showGuideLine {get; set;}
    
     public string Quote_Value {get;set;}
    public string Tax_Amount {get;set;} 
    public string Net_Total {get;set;}
    
    
    public FoundIt_SG_Addendum (ApexPages.StandardController controller) { 
        intvalue=1;
        wraplist=new  list<wraperService>();
        aap=new List<APAC_Payments__c>();
        recordId = ApexPages.currentPage().getParameters().get('id');
        showAccessories = ApexPages.currentPage().getParameters().get('showAccessories');
        // recordId = 'a1Q72000000Lx3WEAS';
        QuotesN = [select id, name ,Tax__c,Show_Comment__c,Show_Services__c, Bill_Contact__r.Account.name,Bill_Contact__r.AccountId,Bill_Contact__c,createddate,Posting_Contact__r.name,Posting_Contact__c,OwnerID,Quote_Value__c,
                   Account__r.Name,Account__C,Account__r.RegistrationNumber__c,Posting_Contact__r.Phone,Posting_Contact__r.email,Posting_Contact__r.Fax,Posting_Street__c,
                   Posting_City__c,Posting_State__c,Posting_Country__c,Posting_Pin_Code__c,Bill_Contact__r.name,Bill_Contact__r.Email,Bill_Contact__r.Phone,Billing_Street__c,
                   Billing_City__c,Billing_State__c,Billing_Country__c,Billing_Pin_code__c,Price_Master__r.name,Contact__r.name,Contact__r.Title,Account__r.PrimarySalesManager__c,
                   Tax_Amount__c, Selling_Country__c, Tax_Percentage__c,Net_Total__c 
                   from QuotesN__C where id =: recordId    
                  ];
        
        Quote_Value = QuotesN.Quote_Value__c == null ? '' : QuotesN.Quote_Value__c.format(); 
        Tax_Amount = QuotesN.Tax_Amount__c == null ? '' : QuotesN.Tax_Amount__c.format(); 
        Net_Total = QuotesN.Net_Total__c == null ? '' : QuotesN.Net_Total__c.format(); 
        
        if(QuotesN.Show_Comment__c == true && QuotesN.Show_Services__c == true){
            showcomentandservice  = '1';
            //  system.debug('get showcomentandservice '+showcomentandservice);
        }
        else if (QuotesN.Show_Comment__c == false && QuotesN.Show_Services__c == false){
            showcomentandservice = '2';
            // system.debug('get showcomentandservice '+showcomentandservice);
        }
        else if (QuotesN.Show_Comment__c == true && QuotesN.Show_Services__c == false){
            showcomentandservice = '3';
            // system.debug('get showcomentandservice '+showcomentandservice);
        }
        else if (QuotesN.Show_Comment__c == false && QuotesN.Show_Services__c == true){
            showcomentandservice = '4';
            // system.debug('get showcomentandservice '+showcomentandservice);
        }
        
        u = [SELECT id,Name,LastName,CompanyName ,Location__c ,Location1__c ,Email,phone,Title ,City,Country,CreatedById,PostalCode,State,Street,fax,
             Manager.Name,Manager.Email,Manager.phone,Manager.Fax,Manager.Title,Manager.Street,Manager.City,Manager.State,Manager.Country,Manager.PostalCode
               from User WHERE ID =:QuotesN.OwnerID ];      
        todate = system.today();
        
        pli = [SELECT id,name,Service_Name__c,Product__r.Product_SKU_Code__c, Product__r.SKU_Type__c,Product__r.Text__c, Product__r.Primary_Selling_Country__c,Product__r.Tenure_Months__c,Product__r.Product_Country__c, of_Master_Login__c,     
               Account__c,     Active__c,      Actual_Disount_Cap__c,  Adjusted_Value__c,      Adjustment_Type__c,     Base_Total__c,  Comment__c,     CreatedById,
               CurrencyIsoCode,     DB_Scope_Geography__c,  DB_Type_Industry__c,    Discount_Value__c,      Discount_Cap__c,Discount_Type__c,       End_Date__c,Gross_Total__c,
               Inventory_Count__c,Master_login__c,  Opp_Line_Item__c,Opportunities__c,      Parent_OPLI__c,Price_Master__c, Product__c,Product__r.Location__c,
               Product_PL_ID__c,product_Category__c, Product_Country__c, Product_Geo_Scope__c,   Product_Industry__c,    Product_Name__c,product_Name_Text__c,
               Product_Selling_Country__c,Product_Type__c,Quantity_Unit__c,Quotes__c,SKU_Code__c,   SKU_Nature__c,SKU_Type__c,Start_Date__c,
               Tenure_Months__c,    Top_Ups__c,Total_Discount_Amount__c,    Total_Gross_Value__c,   Total_Top_Up_Price__c,Unit_Price__c,UOM__c,
               Quotes__r.ownerid ,Product__r.name, Product__r.Product_Name__c, Product__r.Classification__c, Product__r.DB_Type_Industry__c, Product__r.DB_Scope_Geography__c, Product__r.Product_Description__c,
               (select id,Top_Ups__r.name,name,End_Date__c,Start_Date__c,Unit_Price__c,Quantity_Unit__c,Product_Tenure_Months__c,Product_SKU_Type__c,
                Top_Ups__r.Product__r.Product_Country__c,Display_Order__c,Top_Ups__r.Display_Order__c,Product__c,Product_Country__c,
                Product__r.Product_Country__c ,Inventory_Quota_Tenure__c ,Top_Ups__r.Inventory_Quota_Tenure__c
                from QULI_Accessories__r order by Top_Ups__r.Display_Order__c)       
               FROM Quote_Line_Items__c
               WHERE Quotes__c = :recordId
              ];
        
        aap=[select id,name,currencyisocode,Due_Date__c,Payment_Amount__c,TDS_Payment_Amount__c from APAC_Payments__c where Quotes__c=:recordId];
        
        lstAccessories = [SELECT Id,Top_Ups__r.name, Name, Quotes__c, Inventory_Quota_Tenure__c,Top_Up_Name__c, Quantity_Unit__c, Start_Date__c, End_Date__c 
                          FROM QULI_Accessories__c WHERE Quotes__c =: recordId];            
        /* Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
d=URL.getSalesforceBaseUrl().getHost();
d=d.substring(0, 5);
imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00D7F000007CaXU';   */
        
        for(Quote_Line_Items__c qi :pli){
            for(QULI_Accessories__c qa : qi.QULI_Accessories__r)
            {
                wraperService ws=new wraperService(qa);
                if(qi.Product__c==qa.Product__c){ ws.srno=intvalue;}
                wraplist.add(ws);  
            }
            intvalue++;
        }
        
        showGuideLine = false;
        for(Quote_Line_Items__c qi :pli){
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