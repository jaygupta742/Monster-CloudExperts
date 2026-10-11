public class SalesPipeline {
     
    @future
    public static void GenerateExcel(){
        
          list<Messaging.Emailfileattachment> matInsert = new List<Messaging.Emailfileattachment>();
          list<Messaging.SingleEmailMessage> mailS= new  list<Messaging.SingleEmailMessage>();
         id profid = [SELECT Id FROM Profile WHERE Name = 'Monster-Sales'].id;
        id AdminId = UserInfo.getUserId();
        set<id> SetID = new set<id>();
        
      map<id,list<Opportunity__c>> OpportunityMap = new map<id,list<Opportunity__c>>();  
      
      map<id,list<id>> ManagerUserID = new map<id,list<id>>();
        
      list<user> AllUser = [SELECT Id,Name,LastName,email,managerid FROM User WHERE isactive = true AND profileid =:profid];
        
        
     //   list<Opportunity__c> opp =  [SELECT lastmodifieddate,Account__r.name,name,Account__r.APAC_Industry__c,Sales_Channel__c,Account__r.Segment__c,Branch_City__c,owner.name,Product_Detail_Offered__c,Close_Date__c,Stage__c,Probability__c,CreatedDate,CurrencyIsoCode,Amount__c,ownerid,Owner_NExternalID__c FROM opportunity__c WHERE ownerid !=:AdminId  AND Owner_NExternalID__c !='00516000006mc3KAAQ' AND createddate = this_month];
        list<Opportunity__c> opp =  [SELECT lastmodifieddate,Account__r.name,name,Account__r.APAC_Industry__c,Sales_Channel__c,
                                     Account__r.Segment__c,Branch_City__c,owner.name,Product_Detail_Offered__c,Close_Date__c,
                                     Stage__c,Probability__c,CreatedDate,CurrencyIsoCode,Amount__c,ownerid,Owner_NExternalID__c,
                                     Branding_Revenue__c,Custom_International_Sponsorship_Reven__c,
                                     Custom_Job_Template_Revenue__c,Custom_Sponsorship_Revenue__c,Job_Postings_Revenue__c,
                                     Logo_on_Job_Postings_Revenue__c,Monster_Assessments_Revenue__c,Monster_Mirror_Revenue__c,Monster_Widget_Revenue__c,Premium_Resume_Search_Revenue__c,Promotional_Offer_Revenue__c,QHire_Revenue__c,Quinton_Revenue__c,Short_Message_Service_Revenue__c,Social_Job_Ads_Revenue__c,TalentBin_by_Monster_Revenue__c,Target_Mailers_Revenue__c,Walk_in_Pro_Event_Revenue__c FROM opportunity__c WHERE Stage__c !='Closed Lost' AND ownerid !=:AdminId  AND Owner_NExternalID__c !='00516000006mc3KAAQ' AND Close_Date__c = this_month];
        
        for(user u : AllUser){
            list<Opportunity__c> ownrAll = new list<Opportunity__c>();
            for(Opportunity__c o : opp){
                if(o.ownerid == u.id)
                   ownrAll.add(o);
            }
            SetID.add(u.id);
             OpportunityMap.put(u.id,ownrAll);
        }

        system.debug('OpportunityMap-->'+OpportunityMap);
        
        for(user u: AllUser){
            list<id> uuid = new list<id>();
  
            for(user i :AllUser){
                if( u.id == i.managerid){
                   uuid.add(i.id);
                }
                system.debug('uuid--->'+uuid);
            }
            ManagerUserID.put(u.id,uuid);
            system.debug('ManagerUserID--->'+ManagerUserID);
        }
        
        for(user u : AllUser){
            Messaging.Emailfileattachment mat = new Messaging.Emailfileattachment();
          Messaging.SingleEmailMessage m1 = new  Messaging.SingleEmailMessage();
       
            list<opportunity__c> Manageroppr = OpportunityMap.get(u.id); //to get manager records
            list<id> usrid = ManagerUserID.get(u.id); // get list of users under manager
            /*Product Detail Offered,*/
             string headr = 'Last Modified Date,Account: Account Name,Opportunity No,Account: APAC Industry	Region,	Sales Channel	,Account: Segment	,Branch / City	,Owner: Full Name,Close Date,Stage,Probability,Created Date,Currency,Estimated Revenue (APAC),Branding Revenue,Custom International Sponsorship Revenue,Custom Job Template Revenue,Custom Sponsorship Revenue,Job Postings Revenue,Logo on Job Postings Revenue,Monster Assessments Revenue,Monster Mirror Revenue,Monster Widget Revenue,Premium Resume Search Revenue,Promotional Offer Revenue,QHire Revenue,Quinton Revenue,Short Message Service Revenue,Social Job Ads Revenue,TalentBin by Monster Revenue,Target Mailers Revenue,Walk in Pro Event Revenue'+'\n';
        string Opval = '' ;
           
            //to get manager records
             for(opportunity__c o :Manageroppr){
                /*    string OppLastmodifieddate = o.lastmodifieddate.format();
                    string OppCreatedDate = o.CreatedDate.format();
                    string OppCloseDate = o.Close_Date__c.format();*/
                 
                   string accnt =   (o.account__c != NULL && o.Account__r.name != NULL ) ? o.Account__r.name : '';
                  string APACIndustry = (o.account__c != NULL && o.Account__r.APAC_Industry__c != NULL ) ? o.Account__r.APAC_Industry__c : '';
                  string segment =   (o.account__c != NULL && o.Account__r.Segment__c != NULL ) ? o.Account__r.Segment__c : '';
                  string Branch_City =  (o.Branch_City__c != NULL ) ? o.Branch_City__c : '';
                  decimal amount = (o.Amount__c != NULL ) ? o.Amount__c : 0;
                  decimal Branding_Revenue = (o.Branding_Revenue__c != NULL ) ? o.Branding_Revenue__c : 0;
                  decimal Custom_International_Sponsorship_Reven = (o.Custom_International_Sponsorship_Reven__c != NULL ) ? o.Custom_International_Sponsorship_Reven__c : 0;  
                  decimal Custom_Job_Template_Revenue = (o.Custom_Job_Template_Revenue__c != NULL ) ? o.Custom_Job_Template_Revenue__c : 0;    
                  decimal Custom_Sponsorship_Revenue = (o.Custom_Sponsorship_Revenue__c != NULL ) ? o.Custom_Sponsorship_Revenue__c : 0;    
                  decimal Job_Postings_Revenue = (o.Job_Postings_Revenue__c != NULL ) ? o.Job_Postings_Revenue__c : 0;    
                  decimal Logo_on_Job_Postings_Revenue = (o.Logo_on_Job_Postings_Revenue__c != NULL ) ? o.Logo_on_Job_Postings_Revenue__c : 0;    
                  decimal Monster_Assessments_Revenue = (o.Monster_Assessments_Revenue__c != NULL ) ? o.Monster_Assessments_Revenue__c : 0;    
                  decimal Monster_Mirror_Revenue = (o.Monster_Mirror_Revenue__c != NULL ) ? o.Monster_Mirror_Revenue__c : 0;    
                  decimal Monster_Widget_Revenue = (o.Monster_Widget_Revenue__c != NULL ) ? o.Monster_Widget_Revenue__c : 0;    
                  decimal Premium_Resume_Search_Revenue = (o.Premium_Resume_Search_Revenue__c != NULL ) ? o.Premium_Resume_Search_Revenue__c : 0;    
                  decimal Promotional_Offer_Revenue = (o.Promotional_Offer_Revenue__c != NULL ) ? o.Promotional_Offer_Revenue__c : 0;    
                  decimal QHire_Revenue = (o.QHire_Revenue__c != NULL ) ? o.QHire_Revenue__c : 0;    
                  decimal Quinton_Revenue = (o.Quinton_Revenue__c != NULL ) ? o.Quinton_Revenue__c : 0;
                  decimal Short_Message_Service_Revenue = (o.Short_Message_Service_Revenue__c != NULL ) ? o.Short_Message_Service_Revenue__c : 0;    
                  decimal Social_Job_Ads_Revenue = (o.Social_Job_Ads_Revenue__c != NULL ) ? o.Social_Job_Ads_Revenue__c : 0;    
                  decimal TalentBin_by_Monster_Revenue = (o.TalentBin_by_Monster_Revenue__c != NULL ) ? o.TalentBin_by_Monster_Revenue__c : 0;    
                  decimal Target_Mailers_Revenue = (o.Target_Mailers_Revenue__c != NULL ) ? o.Target_Mailers_Revenue__c : 0;    
                  decimal Walk_in_Pro_Event_Revenue = (o.Walk_in_Pro_Event_Revenue__c != NULL ) ? o.Walk_in_Pro_Event_Revenue__c : 0;    
                  
                  opval = Opval +o.lastmodifieddate+','+accnt+','+o.name+','+APACIndustry+','+o.Sales_Channel__c+','+segment+','+Branch_City+','+o.owner.name+','/*+o.Product_Detail_Offered__c+','*/+o.Close_Date__c+','+o.Stage__c+','+o.Probability__c+','+o.CreatedDate+','+o.CurrencyIsoCode+','+amount+','+Branding_Revenue+','+Custom_International_Sponsorship_Reven+','+Custom_Job_Template_Revenue+','+Custom_Sponsorship_Revenue+','+Job_Postings_Revenue+','+Logo_on_Job_Postings_Revenue+','+Monster_Assessments_Revenue+','+Monster_Mirror_Revenue+','+Monster_Widget_Revenue+','+Premium_Resume_Search_Revenue+','+Promotional_Offer_Revenue+','+QHire_Revenue+','+Quinton_Revenue+','+Short_Message_Service_Revenue+','+Social_Job_Ads_Revenue+','+TalentBin_by_Monster_Revenue+','+Target_Mailers_Revenue+','+Walk_in_Pro_Event_Revenue+'\n';
                   
                 
                //  opval = Opval +o.lastmodifieddate+','+o.Account__r.name+','+o.name+','+o.Account__r.APAC_Industry__c+','+o.Sales_Channel__c+','+o.Account__r.Segment__c+','+o.Branch_City__c+','+o.owner.name+','+o.Product_Detail_Offered__c+','+o.Close_Date__c+','+o.Stage__c+','+o.Probability__c+','+o.CreatedDate+','+o.CurrencyIsoCode+','+o.Amount__c+','+o.Branding_Revenue__c+','+o.Custom_International_Sponsorship_Reven__c+','+o.Custom_Job_Template_Revenue__c+','+o.Custom_Sponsorship_Revenue__c+','+o.Job_Postings_Revenue__c+','+o.Logo_on_Job_Postings_Revenue__c+','+o.Monster_Assessments_Revenue__c+','+o.Monster_Mirror_Revenue__c+','+o.Monster_Widget_Revenue__c+','+o.Premium_Resume_Search_Revenue__c+','+o.Promotional_Offer_Revenue__c+','+o.QHire_Revenue__c+','+o.Quinton_Revenue__c+','+o.Short_Message_Service_Revenue__c+','+o.Social_Job_Ads_Revenue__c+','+o.TalentBin_by_Monster_Revenue__c+','+o.Target_Mailers_Revenue__c+','+o.Walk_in_Pro_Event_Revenue__c+'\n';
               //     opval = Opval +OppLastmodifieddate+','+o.Account__r.name+','+o.name+','+o.Account__r.APAC_Industry__c+','+o.Sales_Channel__c+','+o.Account__r.Segment__c+','+o.Branch_City__c+','+o.owner.name+','+o.Product_Detail_Offered__c+','+OppCloseDate+','+o.Stage__c+','+o.Probability__c+','+OppCreatedDate+','+o.CurrencyIsoCode+','+o.Amount__c+','+o.Branding_Revenue__c+','+o.Custom_International_Sponsorship_Reven__c+','+o.Custom_Job_Template_Revenue__c+','+o.Custom_Sponsorship_Revenue__c+','+o.Job_Postings_Revenue__c+','+o.Logo_on_Job_Postings_Revenue__c+','+o.Monster_Assessments_Revenue__c+','+o.Monster_Mirror_Revenue__c+','+o.Monster_Widget_Revenue__c+','+o.Premium_Resume_Search_Revenue__c+','+o.Promotional_Offer_Revenue__c+','+o.QHire_Revenue__c+','+o.Quinton_Revenue__c+','+o.Short_Message_Service_Revenue__c+','+o.Social_Job_Ads_Revenue__c+','+o.TalentBin_by_Monster_Revenue__c+','+o.Target_Mailers_Revenue__c+','+o.Walk_in_Pro_Event_Revenue__c+'\n';
       
                }


            //to get manager's user records
            for(id i : usrid){
                
                list<opportunity__c> oppr = OpportunityMap.get(i);
                
                for(opportunity__c o :oppr){
                  
                  string accnt =   (o.account__c != NULL && o.Account__r.name != NULL ) ? o.Account__r.name : '';
                  string APACIndustry = (o.account__c != NULL && o.Account__r.APAC_Industry__c != NULL ) ? o.Account__r.APAC_Industry__c : '';
                  string segment =   (o.account__c != NULL && o.Account__r.Segment__c != NULL ) ? o.Account__r.Segment__c : '';
                   string Branch_City =  (o.Branch_City__c != NULL ) ? o.Branch_City__c : '';
                  decimal amount = (o.Amount__c != NULL ) ? o.Amount__c : 0;
                  decimal Branding_Revenue = (o.Branding_Revenue__c != NULL ) ? o.Branding_Revenue__c : 0;
                  decimal Custom_International_Sponsorship_Reven = (o.Custom_International_Sponsorship_Reven__c != NULL ) ? o.Custom_International_Sponsorship_Reven__c : 0;  
                  decimal Custom_Job_Template_Revenue = (o.Custom_Job_Template_Revenue__c != NULL ) ? o.Custom_Job_Template_Revenue__c : 0;    
                  decimal Custom_Sponsorship_Revenue = (o.Custom_Sponsorship_Revenue__c != NULL ) ? o.Custom_Sponsorship_Revenue__c : 0;    
                  decimal Job_Postings_Revenue = (o.Job_Postings_Revenue__c != NULL ) ? o.Job_Postings_Revenue__c : 0;    
                  decimal Logo_on_Job_Postings_Revenue = (o.Logo_on_Job_Postings_Revenue__c != NULL ) ? o.Logo_on_Job_Postings_Revenue__c : 0;    
                  decimal Monster_Assessments_Revenue = (o.Monster_Assessments_Revenue__c != NULL ) ? o.Monster_Assessments_Revenue__c : 0;    
                  decimal Monster_Mirror_Revenue = (o.Monster_Mirror_Revenue__c != NULL ) ? o.Monster_Mirror_Revenue__c : 0;    
                  decimal Monster_Widget_Revenue = (o.Monster_Widget_Revenue__c != NULL ) ? o.Monster_Widget_Revenue__c : 0;    
                  decimal Premium_Resume_Search_Revenue = (o.Premium_Resume_Search_Revenue__c != NULL ) ? o.Premium_Resume_Search_Revenue__c : 0;    
                  decimal Promotional_Offer_Revenue = (o.Promotional_Offer_Revenue__c != NULL ) ? o.Promotional_Offer_Revenue__c : 0;    
                  decimal QHire_Revenue = (o.QHire_Revenue__c != NULL ) ? o.QHire_Revenue__c : 0;    
                  decimal Quinton_Revenue = (o.Quinton_Revenue__c != NULL ) ? o.Quinton_Revenue__c : 0;
                  decimal Short_Message_Service_Revenue = (o.Short_Message_Service_Revenue__c != NULL ) ? o.Short_Message_Service_Revenue__c : 0;    
                  decimal Social_Job_Ads_Revenue = (o.Social_Job_Ads_Revenue__c != NULL ) ? o.Social_Job_Ads_Revenue__c : 0;    
                  decimal TalentBin_by_Monster_Revenue = (o.TalentBin_by_Monster_Revenue__c != NULL ) ? o.TalentBin_by_Monster_Revenue__c : 0;    
                  decimal Target_Mailers_Revenue = (o.Target_Mailers_Revenue__c != NULL ) ? o.Target_Mailers_Revenue__c : 0;    
                  decimal Walk_in_Pro_Event_Revenue = (o.Walk_in_Pro_Event_Revenue__c != NULL ) ? o.Walk_in_Pro_Event_Revenue__c : 0;    
                  
                    /* string OppLastmodifieddate = o.lastmodifieddate.format();
                    string OppCreatedDate = o.CreatedDate.format();
                    string OppCloseDate = o.Close_Date__c.format();*/
                  opval = Opval +o.lastmodifieddate+','+accnt+','+o.name+','+APACIndustry+','+o.Sales_Channel__c+','+segment+','+Branch_City+','+o.owner.name+','/*+o.Product_Detail_Offered__c+','*/+o.Close_Date__c+','+o.Stage__c+','+o.Probability__c+','+o.CreatedDate+','+o.CurrencyIsoCode+','+amount+','+Branding_Revenue+','+Custom_International_Sponsorship_Reven+','+Custom_Job_Template_Revenue+','+Custom_Sponsorship_Revenue+','+Job_Postings_Revenue+','+Logo_on_Job_Postings_Revenue+','+Monster_Assessments_Revenue+','+Monster_Mirror_Revenue+','+Monster_Widget_Revenue+','+Premium_Resume_Search_Revenue+','+Promotional_Offer_Revenue+','+QHire_Revenue+','+Quinton_Revenue+','+Short_Message_Service_Revenue+','+Social_Job_Ads_Revenue+','+TalentBin_by_Monster_Revenue+','+Target_Mailers_Revenue+','+Walk_in_Pro_Event_Revenue+'\n';
                   
                 // opval = Opval +o.lastmodifieddate+','+o.Account__r.name+','+o.name+','+o.Account__r.APAC_Industry__c+','+o.Sales_Channel__c+','+o.Account__r.Segment__c+','+o.Branch_City__c+','+o.owner.name+','+o.Product_Detail_Offered__c+','+o.Close_Date__c+','+o.Stage__c+','+o.Probability__c+','+o.CreatedDate+','+o.CurrencyIsoCode+','+o.Amount__c+','+o.Branding_Revenue__c+','+o.Custom_International_Sponsorship_Reven__c+','+o.Custom_Job_Template_Revenue__c+','+o.Custom_Sponsorship_Revenue__c+','+o.Job_Postings_Revenue__c+','+o.Logo_on_Job_Postings_Revenue__c+','+o.Monster_Assessments_Revenue__c+','+o.Monster_Mirror_Revenue__c+','+o.Monster_Widget_Revenue__c+','+o.Premium_Resume_Search_Revenue__c+','+o.Promotional_Offer_Revenue__c+','+o.QHire_Revenue__c+','+o.Quinton_Revenue__c+','+o.Short_Message_Service_Revenue__c+','+o.Social_Job_Ads_Revenue__c+','+o.TalentBin_by_Monster_Revenue__c+','+o.Target_Mailers_Revenue__c+','+o.Walk_in_Pro_Event_Revenue__c+'\n';
                  //   opval = Opval +OppLastmodifieddate+','+o.Account__r.name+','+o.name+','+o.Account__r.APAC_Industry__c+','+o.Sales_Channel__c+','+o.Account__r.Segment__c+','+o.Branch_City__c+','+o.owner.name+','+o.Product_Detail_Offered__c+','+OppCloseDate+','+o.Stage__c+','+o.Probability__c+','+OppCreatedDate+','+o.CurrencyIsoCode+','+o.Amount__c+','+o.Branding_Revenue__c+','+o.Custom_International_Sponsorship_Reven__c+','+o.Custom_Job_Template_Revenue__c+','+o.Custom_Sponsorship_Revenue__c+','+o.Job_Postings_Revenue__c+','+o.Logo_on_Job_Postings_Revenue__c+','+o.Monster_Assessments_Revenue__c+','+o.Monster_Mirror_Revenue__c+','+o.Monster_Widget_Revenue__c+','+o.Premium_Resume_Search_Revenue__c+','+o.Promotional_Offer_Revenue__c+','+o.QHire_Revenue__c+','+o.Quinton_Revenue__c+','+o.Short_Message_Service_Revenue__c+','+o.Social_Job_Ads_Revenue__c+','+o.TalentBin_by_Monster_Revenue__c+','+o.Target_Mailers_Revenue__c+','+o.Walk_in_Pro_Event_Revenue__c+'\n';

                }
                
                
            }
            
            
           system.debug('Opval-->'+Opval);
            boolean SRes = string.isNotBlank(opval);
            system.debug('SRes-->'+SRes);
            if(string.isNotBlank(opval)){
                
              string FinalReport = headr + Opval;
             blob ofile = Blob.valueOf(FinalReport); 
            string myf= 'SalesPipeline.csv';
             mat.setFileName(myf);
             mat.setBody(ofile);
           
           m1.setSubject(' SalesPipeline/Opportunity for '+u.name+' for the current month,as on '+system.today().format());
            m1.setSaveAsActivity(false);
           m1.setFileAttachments(new Messaging.EmailFileAttachment[]{mat});
           // m1.setToAddresses(new string[]{'seetaramatest@gmail.com'});
            m1.setToAddresses(new string[]{u.email});
       //    m1.setPlainTextBody('Dear '+u.name+' Please Find the attachment for your Sales Pipeline Report');
           m1.setHtmlBody('Dear ' +u.name+'<br/>'
                          +'Please find attached your Sales Pipeline/Opportunity Report.<br/><br/>'
                          +'This report is an overview of your plan for this month. It shows Opportunities Closed Won<br/>'
                          +'(Sales Processed with Value), free trials offered (Zero Value) and opportunities in various stages with close<br/>'
                          +'date (approximate sale closure Date).<br/><br/>'
                          +'If Closed Date is expired make sure that you edit the opportunity and update expected Closure date<br/>'
						  +'based on your discussion with customer.<br/><br/>'
                          +'Your report Contains Total Opportunity created by you, but for Management reporting Stage 3 Onwards<br/>'
						  +'will be considerd.<br/>'
                          +'<table border="1px" cellspacing="0px"><tr style="background-color:#F2DAA2;font-size:12px"><th>STAGE</th><th>PERCENTAGE</th><th>STAGE VISIBLE ON SALESFORCE</th><th>ACTION ON SALESFORCE</th></tr>'
                          +'<tr><td>Stage 1</td><td align="center">0%</td><td>Identification</td><td>New Opportunity created by Rep</td></tr>'
                          +'<tr><td>Stage 2</td><td align="center">10%</td><td>Need Analysis</td><td>When Rep Creates a Demonstration (Which is linked with opportunity)</td></tr>'
                          +'<tr><td>Stage 3</td><td align="center">25%</td><td>Proposal Sent</td><td>When Rep Creates a Proposal on Salesforce</td></tr>'
                          +'<tr><td>Stage 3.1</td><td align="center">50%</td><td>Negotiation Complete</td><td>When a Quote is generated on Salesforce</td></tr>'
                          +'<tr><td>Stage 4</td><td align="center">75%</td><td>Quote/Agreement Stage</td><td>When a Ready for validation button is clicked by Rep</td></tr>'
                          +'<tr><td>Stage 5</td><td align="center">100%</td><td>Closed Won</td><td>When the order Number is generated on Salesforce</td></tr>'
                          +'</table><br/><br/>'
                          +'<table border="1px" cellspacing="0px">'
                          +'<tr> <th colspan="2" align="centre">Tabs in Report</th></tr>'
                          +'<tr style="background-color:#E5AF31"><th>Tabs</th><th>Description of Tabs</th></tr>'
                          +'<tr><td>Last Modified Date</td><td>When you modified the Opportunity Last</td></tr>'
                          +'<tr><td>Account Name</td><td>Name of the Account as per the Salesforce</td></tr>'
                          +'<tr><td>Opportunity NO</td><td>Unique Opportunity Number</td></tr>'
                          +'<tr><td>Industry Region</td><td>Industry Category.<b>If you found this incorrect/blank- Get it corrected/Updated</b></td></tr>'
                          +'<tr><td>Sales Channel</td><td>Sales channel is either Fieldsales or Telesales which is updated at time</td></tr>'
                          +'<tr><td>Account:Segment</td><td>Your Channel.(Based on Account Owner channel Account:Segment is updated)</td></tr>'
                          +'<tr><td>Branch/City</td><td>Your Location</td></tr>'
                          +'<tr><td>Owner:Full Name</td><td>Opportunity Owner Name</td></tr>'
                          +'<tr style="background-color:#A0D0A6"><td>Close Date</td><td>Approximate Closure Date(Management consider this date to identify sales<br/> Closure Pipeline Daily)</td></tr>'
                          +'<tr style="background-color:#A0D0A6"><td>Stage/Probability</td><td>Opportunity Stages snapshot above </td></tr>'
                          +'<tr style="background-color:#A0D0A6"><td>Created Date</td><td>Opportunity Created Date.(This should be maximum 3 Months Old. >3 Months<br/> old Opportunities should be closed)</td></tr>'
                          +'<tr><td>Currency</td><td>Your country Currency</td></tr>'
                          +'<tr style="background-color:#A0D0A6"><td>Estimated Revenue (APAC)</td><td>Total Opportunity Value(Which is sum of product you selected)</td></tr>'
                          +'<tr><td>Product wise Break-up</td><td>Break-up of products selected in opportunity</td></tr>'
                          +'</table>'
                          );     
            mailS.add(m1);
        }
        }
        
         system.debug('mail ---->'+mailS);
        if(mailS.size()>0){
         Messaging.sendEmail(mailS);
            system.debug('mail sent successfully');}
        
        
        
        

    } 
 
    
}