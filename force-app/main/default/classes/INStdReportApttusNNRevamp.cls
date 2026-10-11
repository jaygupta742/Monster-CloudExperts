public class INStdReportApttusNNRevamp {
public list<Quote_Line_Items__c> pli {get;set;}
public id recid;
public list<APAC_Payments__c> aap{get;set;}
public QuotesN__c qp{get;set;}
public user u{get;set;}

//image for doc
public string imgsrc{get;set;}
public string a{get;set;}

    public INStdReportApttusNNRevamp(ApexPages.StandardController controller) {
    
    recid = ApexPages.currentPage().getParameters().get('id');
     //   recid = 'a177200000D3M4XAAV';

 pli = new list<Quote_Line_Items__c>([ Select Account__c, Active__c, Actual_Disount_Cap__c, Adjusted_Value__c, Product__r.Product_Country__c,Product__r.Tenure_Months__c,
                                    Adjustment_Type__c, Base_Total__c, Category1__c, Category__c, Comment__c, CreatedById,
                                      CreatedDate, CurrencyIsoCode, DB_Scope_Geography__c, DB_Type_Industry__c, Discount_Cap1__c,
                                      Discount_Cap__c, Discount_Type__c, Discount_Value__c, End_Date__c, Gross_Total__c, Id,
                                      Inventory_Count__c, IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate,
                                      LastReferencedDate, LastViewedDate, Level_of_Approval_Required__c, Master_login__c, Name,
                                      Opp_Line_Item__c, Opportunities__c, Order_Created__c, Order_Status_Verified_For_Upsell__c,
                                      Parent_OPLI__c, Price_Master__c, Product_Category__c, Product_Code__c, Product_Country__c,
                                      Product_Geo_Scope__c, Product_Industry__c, Product_Name_Text__c, Product_Name__c,
                                      Product_PL_ID__c, Product_Selling_Country__c, Product_Type1__c, Product_Type__c, Product__c,
                                      Quantity_Unit__c, Quote_Type__c, Quotes__c, Real_Discount__c, SKU_Code__c, SKU_Nature__c,
                                      SKU_Type__c, Service_Name__c, Start_Date__c, SystemModstamp, Tenure_Months__c, Top_Ups__c,
                                      Total_Discount_Amount__c, Total_Gross_Value__c, Total_Top_Up_Price__c, UOM__c, Unit_Price__c,
                                      of_Master_Login__c,Product__r.name
                                       FROM Quote_Line_Items__c 
                                      WHERE Quotes__c=:recid]);    
                                                    
       //try{
           aap=[Select APAC_Payment_Name__c, CreatedById, CreatedDate, CurrencyIsoCode, DueDateWithoutTime__c, Due_Date__c,
                Finance_Reference__c,GST__c, Id, IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate,
                N_ExternalID__c, N_external_ownerid__c, Name, Net_Total__c, Old_Created_By__c, Old_Created_Date__c,
                Old_Created_User__c, Old_Last_Modified_By__c, Old_Last_Modified_Date__c, Old_Last_Modified_User__c, Old_Owner__c,
                Order__c, Owner__c, Payment_Amount__c, Payment_Date__c, Payment_Received_Amount__c, Quotes__c,
                Revised_Due_Date__c, SystemModstamp, TDS_Amount__c, TDS_Payment_Amount__c FROM APAC_Payments__c
              
                where Quotes__c=:recid];
   // }
        //catch(exception e){}
    
    qp=[Select Account_Entity_Use_Code1__c, Account_Entity_Use_Code__c, Account_Type__c, Account__c, Active__c, Agency_ID__c,
        Approval_Status_Overall__c, Approver_1__c, Approver_2__c, Approver_3__c, Approver_4__c, Attach_Prefilled_Cart_Report__c,
        Attach_Service_Agreement__c, Base_Total__c, Bill_Contact__c, Billing_Address__c, Billing_City__c, Billing_Country__c, 
        Billing_Pin_Code__c, Billing_State__c, Billing_Street__c, Contact__c, CreatedById, CreatedDate, CurrencyIsoCode,
        Finalised__c, Gross_Total__c, Id, IsDeleted, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate,
        Level_1_Approval_Done__c, Level_2_Approval_Done__c, Level_3_Approval_Done__c, Level_4_Approval_Done__c,
        Level_of_Approval_Done__c, Level_of_Approval_Required__c, Level_of_Approval_maxima_from_QLI__c, Name, Net_Total__c,
        Opportunities__c, Order_Created__c, Order_Status_Verified_For_Upsell__c, Order_Type__c, OwnerId, Owner_Channel__c,
        Payment_count__c, Posting_Address__c, Posting_City__c, Posting_Contact__c, Posting_Country__c, Posting_Pin_Code__c,
        Posting_State__c, Posting_Street__c, Price_Master__c, Quote_Finalize_Date_Time__c, Quote_Type__c,
        Quote_Value_Converted__c, Quote_Value__c, Selling_Country__c, Special_Terms__c, SystemModstamp, Tax_Amount__c, 
        Tax_Percentage__c, Tax_Type__c, Tax__c, Total_Discount_Amount__c, Total_Discount__c, Validated__c, Xcode__c,
          Sales_Manager_Designation__c,Sales_Manager_Email__c,Sales_Manager_Phone__c 
        FROM QuotesN__c  WHERE id =:recid];
    
    u = [SELECT id,name,LastName,CompanyName ,Location__c ,Location1__c ,Email,phone,Title ,City,Country,CreatedById,PostalCode,State,Street,fax from User WHERE ID =:qp.OwnerID ];      
     
     //doc
    
   // Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
   a=URL.getSalesforceBaseUrl().getHost();
   a=a.substring(0, 5);
   //imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00D7F000007CaXU';      
                                          

    }

}