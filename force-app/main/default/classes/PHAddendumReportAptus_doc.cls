public class PHAddendumReportAptus_doc {


public list<Proposal_Line_Item__c> pli {get;set;}

public apttus_proposal_proposal__c qp{get;set;}

public User userdetail{get;set;}
public id recid;



public string imgsrc{get;set;}
    public string a{get;set;}

//public APTS_APAC_Payment__c apacpay{get;set;}



    public PHAddendumReportAptus_doc(ApexPages.StandardController controller) {
    
    
    
    
    recid = ApexPages.currentPage().getParameters().get('id');
    
    pli = new list<Proposal_Line_Item__c>([ SELECT id,name, APTPS_Job_Title__c,Comment__c, APTS_Attribute_Display__c, APTS_Extended_List_Price__c, Is_Agency_Commission_Different__c,
     
                                                    APTS_Tax_Amount__c, APTS_Tax_Code__c, APTS_Tax_Rate__c, APTTS_Tax_Amount__c, APTTS_Tax_Rate__c, AgencyCommission__c,
                                                    
                                                    Agency_Commission_Amount__c, CityTaxAmount__c, CityTaxRate__c, CountyTaxAmount__c, CountyTaxRate__c, Custom_Job_Template__c,
                                                    
                                                    Earliest_Product_Start_Date__c, Media_Type__c, Net_Total_from_Line_Item__c, Order_Quota_Type__c,Product_Start_Date__c, 
                                                    
                                                    Organization_based_on_OSD__c, Owner_on_Start_Date_OSD__c, Payment_Amount__c, PostingLocation__c, Primary_Rep_Manager__c, 
                                                    
                                                    Product_Cateogry__c, Product_Family__c, Product_Name_Foreign__c, Product_SubCategory__c, Proposal_Locked__c, 
                                                    
                                                    ResumeFamilyCount__c, Rev_Share_Type__c, Rev_Share__c, Revenue_Share_Percent__c, Sales_Channel_based_on_OSD__c, 
                                                    
                                                    Sales_Credit_Amount__c, Sales_Credit__c, Select_if_Country_Other__c, SpecialTaxJurisdictionAmount1__c,Product_End_Date__c, 
                                                    
                                                    SpecialTaxJurisdictionAmount2__c, SpecialTaxJurisdictionAmount3__c, SpecialTaxJurisdictionAmount4__c,Quantity__c, 
                                                    
                                                    SpecialTaxJurisdictionAmount__c, SpecialTaxJurisdictionRate__c, SpecialTaxJurisdictionRate1__c,Product__c,Product__r.name, 
                                                    
                                                    SpecialTaxJurisdictionRate2__c, SpecialTaxJurisdictionRate3__c, SpecialTaxJurisdictionRate4__c, StateProvinceTaxAmount__c, 
                                                    
                                                    StateTaxRate__c, StateProvinceTaxRate__c, StateTaxAmount__c, Terms_and_Condition_Term_Text__c, TotalStateProvinceTaxAmount__c,
                                                    
                                                    TotalTaxAmount__c, VATNationalTaxAmount__c, VATNationalTaxCode__c, VATNationalTaxRate__c,Start_Date__c,End_Date__c
                                                     FROM Proposal_Line_Item__c
                                                    
                                                    
                                                    
                                                    WHERE Proposal_Locked__c = :recid]);
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                              qp = new apttus_proposal_proposal__c();
                
          qp = [SELECT Id,name,Primary_Contact__c,Primary_Contact__r.Name,Gross_Total__c,Net_Total__c,Account__c,Account__r.name,/*Account__r.AccountID__c,*/
          
                          Account__r.APAC_Industry__c,Primary_Contact__r.Email,Primary_Contact__r.MobilePhone,  Primary_Contact__r.Title,Primary_Contact__r.Phone,Account__r.GST_ID__c,
                          Billing_Street__c,BillingCity__c,
                          Billing_State__c,Billing_Country__c,Billing_Pin_code__c,Order_Type__c,Owner.name,Owner.Email,OwnerID,Owner.phone,
                          
                          Posting_Street__c,Posting_City__c,Posting_State__c,Posting_Country__c,Posting_Pin_Code__c,
                          
                          Quote_Created_Date__c,Earliest_Start_Date__c,Latest_End_Date_EU__c,Billing_Contact_Last_Name__c,
                          
                          Billing_Account__c,Total_Tax_Amount__c,Payment_Due_Date__c,Payment_Amount__c,Due_Date__c,
                          Cust_Account_Gross_Total_Incl_Tax__c,PostingContact__r.name,Tax_Amount__c
                         
                         
                          
                          
                          
                          FROM apttus_proposal_proposal__c WHERE id =:recid];
          
          userDetail = [select Id, Name,Email,Phone,Title,location__c, ManagerId,Manager.name from User  where Id =: qp.OwnerID];  
    
    //doc
    
    Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
    a=URL.getSalesforceBaseUrl().getHost();
    a=a.substring(0, 5);
    imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00D7F000007CaXU';
    
    

    }

}