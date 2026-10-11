public class HK_Appendum_Report_Controller_doc {

public list<Proposal_Line_Item__c> pli {get;set;}
public id recid;
public list<APTS_APAC_Payment__c> aap{get;set;}
public user u{get;set;}

//image for doc
public string imgsrc{get;set;}
public string a{get;set;}

    public HK_Appendum_Report_Controller_doc(ApexPages.StandardController controller) {
    
     recid = ApexPages.currentPage().getParameters().get('id');
    
 pli = new list<Proposal_Line_Item__c>([ SELECT id,name, APTPS_Job_Title__c, APTS_Attribute_Display__c, Comment__c,APTS_Extended_List_Price__c, Is_Agency_Commission_Different__c, 
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
                                                    TotalTaxAmount__c, VATNationalTaxAmount__c, VATNationalTaxCode__c, VATNationalTaxRate__c, Proposal_Locked__r.ownerid FROM Proposal_Line_Item__c
                                                    WHERE Proposal_Locked__c = :recid]);
                                                    
        u = [SELECT id, firstname, lastname,username,CompanyName,Title,Location__c,Fax,Email,Phone,Location1__c,Country,PostalCode,City  FROM user WHERE id=:pli[0].Proposal_Locked__r.ownerid];   
        
                try{
                 aap = [SELECT id,name,Due_Date__c,Payment_Amount__c,TDS_Amount_c__c  FROM APTS_APAC_Payment__c WHERE Proposal__c =:recid];  
                 }
                 catch(exception r){
                 }
                 
        //doc
        
        Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
        a=URL.getSalesforceBaseUrl().getHost();
        a=a.substring(0, 5);
        imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00DC4000003ZhbR';        

    }




}