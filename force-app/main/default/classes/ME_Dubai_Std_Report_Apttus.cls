//Pankaj
public class ME_Dubai_Std_Report_Apttus {
public list<apttus_proposal_proposal__c> takeall{get;set;}
public string recid{get;set;}
public list<APTS_APAC_Payment__c> ap{get;set;}

public user ss{get;set;}
public integer slno{get;set;}
public list<Proposal_Line_Item__c> pl {get;set;}
public apttus_proposal_proposal__c qp{get;set;}

public string imgsrc{get;set;}
    public string a{get;set;}
    public ME_Dubai_Std_Report_Apttus (ApexPages.StandardController controller) {
     Document d=[SELECT Id,name FROM Document where name='Monster Logo' limit 1];
       a=URL.getSalesforceBaseUrl().getHost();
       a=a.substring(0, 5);
        imgsrc='https://'+a+'.content.force.com/servlet/servlet.ImageServer?id='+d.id+'&oid=00D7F000007CaXU';
    
    takeall=new list<apttus_proposal_proposal__c> ();
ss= new User();
qp=new apttus_proposal_proposal__c();
recid=apexPages.CurrentPage().getParameters().get('id');
 /*     takeall=[select id, name,PostingContact__c ,Account__c,OwnerId,Posting_Street__c,Posting_Country__c,Posting_City__c,Posting_Pin_Code__c,Posting_State__c,
                    Billing_Account__c,Billing_State__c ,Billing_Pin_code__c,Billing_Country__c,APTS_Billing_Contact_Email_Address__c,BillContact__c,
                    Billing_Street__c,Billing_City__c
                    ,Gross_Total__c,Tax_Amount__c,Net_Total__c,Payment_Net_Total__c,Special_Terms__c,(select id,name,Product__c,Quantity__c,Product_Start_Date__c,
                    Product_End_Date__c from Quote_Line_Item__r),(select id,name,Due_Date__c from APAC_Payments__r)  
                    from apttus_proposal_proposal__c where id=:recid];
    */
   qp=[select id,name,ownerId from apttus_proposal_proposal__c where id=:recid];                 
  

  
       pl = new list<Proposal_Line_Item__c>([ SELECT id,name, APTPS_Job_Title__c, APTS_Attribute_Display__c, APTS_Extended_List_Price__c, Is_Agency_Commission_Different__c, 
                                                    APTS_Tax_Amount__c, APTS_Tax_Code__c, APTS_Tax_Rate__c, APTTS_Tax_Amount__c, APTTS_Tax_Rate__c, AgencyCommission__c,
                                                    Agency_Commission_Amount__c, CityTaxAmount__c, CityTaxRate__c, CountyTaxAmount__c, CountyTaxRate__c, Custom_Job_Template__c,
                                                    Earliest_Product_Start_Date__c, Media_Type__c, Net_Total_from_Line_Item__c, Order_Quota_Type__c,Product_Start_Date__c, 
                                                    Organization_based_on_OSD__c, Owner_on_Start_Date_OSD__c, Payment_Amount__c, PostingLocation__c, Primary_Rep_Manager__c, 
                                                    Product_Cateogry__c, Product_Family__c, Product_Name_Foreign__c,Comment__c, Product_SubCategory__c, Proposal_Locked__c, 
                                                    ResumeFamilyCount__c, Rev_Share_Type__c, Rev_Share__c, Revenue_Share_Percent__c, Sales_Channel_based_on_OSD__c, 
                                                    Sales_Credit_Amount__c, Sales_Credit__c, Select_if_Country_Other__c, SpecialTaxJurisdictionAmount1__c,Product_End_Date__c, 
                                                    SpecialTaxJurisdictionAmount2__c, SpecialTaxJurisdictionAmount3__c, SpecialTaxJurisdictionAmount4__c,Quantity__c, 
                                                    SpecialTaxJurisdictionAmount__c, SpecialTaxJurisdictionRate__c, SpecialTaxJurisdictionRate1__c,Product__c,Product__r.name, 
                                                    SpecialTaxJurisdictionRate2__c, SpecialTaxJurisdictionRate3__c, SpecialTaxJurisdictionRate4__c, StateProvinceTaxAmount__c, 
                                                    StateTaxRate__c, StateProvinceTaxRate__c, StateTaxAmount__c, Terms_and_Condition_Term_Text__c, TotalStateProvinceTaxAmount__c,
                                                    TotalTaxAmount__c, VATNationalTaxAmount__c, VATNationalTaxCode__c, VATNationalTaxRate__c FROM Proposal_Line_Item__c
                                                    WHERE Proposal_Locked__c = :recid]);  
  
    
    ap = new list<APTS_APAC_Payment__c> ();
    
    ss= [SELECT id, firstname, lastname,name,fax,username,city,country,CompanyName,Title,Location__c,Email,Phone,Location1__c from user where Id=:qp.ownerId];                  
   try{                 
      ap=[SELECt id,APAC_Payment_Type__c,Due_Date__c,Net_Total__c,Payment_Amount__c,TDS_Amount_c__c,Proposal__c FRom APTS_APAC_Payment__c where Proposal__c=:recid];
    }
     catch(Exception e){}
    

    }

}