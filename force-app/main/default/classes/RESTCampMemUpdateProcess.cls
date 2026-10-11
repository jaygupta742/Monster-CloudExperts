/* 
        * @ Class Name	: 	RESTCampMemUpdateProcess
        * @ Objective	: 	This class will provide REST services for Campaign sync process
        * @ Developer	: 	Sudhir  
        * @ Test Class 	: 	REST_CampMem_Update_Process_Test
        * @ test URL  	:   https:/monsterindia--intesbox.my.salesforce.com/services/apexrest/updateCampMem/v1
        * @ Modified By: 
        *     User Name      |     Modified Date     |     Reason
        * ---------------------------------------------------------------
        * 	   Sudhir               ----------              Intial Creation
*/


@RestResource(urlMapping='/updateCampMem/*')
global class RESTCampMemUpdateProcess {
    
    
    // purpose 		: convert JSON came from python to campaign member list and update it's fields 
    // How to call	: RESTCampMemUpdateProcess.convertJsonToSobjectLst()
    @HttpPost
    global static void convertJsonToSobjectLst() {
        try{       
            String requestBody = RestContext.request.requestBody.toString();
            system.debug('requestBody==>'+requestBody);
            string jsn=requestBody;
            
            List<CampaignMemberWrapper> mem_wrpList = CampaignMemberWrapper.parse(jsn);
            List<Campaign_Member__c> memLst= new List<Campaign_Member__c>();
            List<Contact> cntLst= new List<Contact>();
            List<Leads__C> leadLst= new List<Leads__C>();
            
            for(CampaignMemberWrapper mem_wrp: mem_wrpList){
                Campaign_Member__c mem = new Campaign_Member__c();
                
                String id_s =  mem_wrp.CampaignMemberID; // Sample ids a0c720000005FrF__a0d72000000XCDh__00372000008Ek9d [lead id a0B72000000jvtNEAQ]
                List<String> id_ls = id_s.split('__');
                String cmpId = id_ls[0];
                String memId =  id_ls[1];
                String cntORleadId  =  id_ls[2];
                
                mem.Id = memId;
                
                if(mem_wrp.reason == null){
                    if(mem_wrp.SentDate != null){
                        mem.Sent_Date__c = createFormattedDateTime(mem_wrp.SentDate);
                        mem.Status__c = 'Sent';
                    }
                    
                    if(mem_wrp.BounceCategory != null){
                        mem.Bounce_Category__c = mem_wrp.BounceCategory;
                        mem.Status__c = 'Bounced';
                        mem.Bounced_Date__c =   createFormattedDateTime(mem_wrp.BounceDate);
                    }
                    
                    if(mem_wrp.OpenDate != null){
                        mem.Opened_Date__c = createFormattedDateTime(mem_wrp.OpenDate);   
                        mem.Status__c = 'Opened';
                    }
                    
                    if(mem_wrp.ClickDate != null){
                        mem.Clicked_Date__c = createFormattedDateTime(mem_wrp.ClickDate);   
                        mem.Status__c = 'Clicked';
                    }
                    
                    if(createFormattedDateTime(mem_wrp.UnsubscribedDate)!=null){
                        mem.Unsubscribed_Date__c=createFormattedDateTime(mem_wrp.UnsubscribedDate); 
                        mem.Status__c = 'Unsubscribed';
                        String objNm = getObjApiName(cntORleadId);
                        if(objNm == 'Contact'){
                            Contact cnt = new Contact();
                            cnt.ID = cntORleadId;
                            cnt.HasOptedOutOfEmail = true;
                            cntLst.add(cnt);    
                        }else if(objNm.containsIgnoreCase('Leads__c')){
                            Leads__C ld = new Leads__c();
                            ld.ID = cntORleadId;
                            ld.Email_Opt_Out__c = true;
                            leadLst.add(ld);
                        }
                    }
                    
                    memLst.add(mem);
                    
                }else if(mem_wrp.reason != null){
                    mem.Send_Fail_Reason__c = mem_wrp.reason;
                    mem.Status__c = 'Send Failed';
                    memLst.add(mem);
                }
            }
            
            system.debug('cntLst List==>'+cntLst);
            if(!cntLst.isEmpty())
                update cntLst;
            
            system.debug('Lead List==>'+leadLst);
            if(!leadLst.isEmpty())
                update leadLst;
            system.debug('Members List==>'+memLst);
            if(!memLst.isEmpty())
                update memLst;
            
        }catch(exception e){
            system.debug('Error==>'+e.getStackTraceString());
            system.debug('Error==>'+e.getLineNumber());
            system.debug('Error==>'+e.getMessage());
        }
        
    } // EO convertJsonToSobjectLst
    
    
    
    // purpose	: to convert date from string to datetime format to update in record
    // Example	: 01-06-2022 23:19 this string date converted to DateTime format using string splits
    public static DateTime createFormattedDateTime(string inputDate){
        DateTime newDateTime;
        try{
            if(String.isBlank(inputDate))
                return null;
            else{
                
                // input string as - -- 01-06-2022 23:19 OR 25-05-2022 00:49
                String[] fDate = inputDate.split('-'); //fDate[0]=Date, fdate[1]=month, fDate[2]=Year and time 
                string[] fDateDay=fDate[2].split(' ');
                string[] fTime = fDateDay[1].split(':');
                
                Integer yer = Integer.valueof(fDateDay[0].trim());
                Integer mnt =  Integer.valueof(fDate[1].trim());
                Integer dt = Integer.valueof(fDate[0].trim());
                Integer hr = Integer.valueof(fTime[0].trim());
                Integer mns = Integer.valueof(fTime[1].trim());
                
                newDateTime = DateTime.newInstance(yer, mnt, dt, hr, mns,0);

            }
        }catch(Exception e){
            system.debug('Error==>'+e.getLineNumber());
            system.debug('Error==>'+e.getMessage());
        }
        
        return newDateTime;
    } //EO createFormattedDateTime
    
  
   //purpose	: getting object name as contact or lead using id passed
   //parameters	: Id of contact/lead
   //Example	: 00372000008Ek9d -this will return as Contact object
    public static String getObjApiName(Id myId){
        String objNm =  myId.getSObjectType().getDescribe().getName();
        return objNm;
    } //EO getObjApiName
    
}