/*Last Modified by : Abdul Aziz , Date : 19/07/2023, Mapped Fields for rest resource*/
public class AmeyoautodiallerExotel {
    @AuraEnabled
    public static string fetchOpportunity(Date rId){
        try {
            system.debug('date'+rId);
            user uu=[select id,name,Ameyo_Lead_Id__c from user where id=:userinfo.getUserId()];
            list<Account> acc=new list<Account>();
            acc=[select id,name,Phone,ownerid,createddate,Lead_Score__c,lastmodifieddate,Disposition_Count__c,Last_Disposition__c,Last_Disposition_Date_Time__c,Last_Disposition_in_Days__c,Dispositions__c from Account where ownerid=:uu.id AND Phone!=null AND lastmodifieddate>:rId AND lastmodifieddate<:rId+1   ];
            system.debug('amitdate '+acc.size());
            fromJSON crec=new fromJSON();
            list<fromJSON.customerRecord> vgtlist=new list<fromJSON.customerRecord>();
            string finalstring='';
            for(integer i=0;i<acc.size();i++) {
                system.debug('inside for');
                system.debug('Last Disposition-'+acc[i].Last_Disposition__c);
                system.debug('Disposition Days-'+acc[i].Last_Disposition_in_Days__c);
                acc[i].Last_Disposition__c='ss';
                //if((acc[i].Last_Disposition__c!='Not Interested') && (acc[i].Last_Disposition_in_Days__c>7 || acc[i].Last_Disposition_in_Days__c==0 ) ) {
                if(acc[i].Dispositions__c!='Pitched' && acc[i].Dispositions__c!='Call Back – Spoke but did not pitch' ) {    
                    system.debug('inside if');
                    fromJSON.customerRecord vgt=new fromJSON.customerRecord();
                    vgt.lead_score=acc[i].lead_score__c;
                    vgt.phone1=acc[i].Phone;
                    string ddf='{customerRecord:'+JSON.serialize(vgt)+'}';
                    if(i==0) {
                        finalstring+=ddf;     
                    }
                    else{
                        finalstring+=','+ddf;    
                    }
                }
            }
            crec.customerRecord=vgtlist;
            string cct=JSON.serialize(crec);
            string cct2=finalstring.replaceAll('lead_score', 'lead_score__c');
            String payLoad ='data={"campaignId":"163","customerAndCallbackRecords":['+cct2+'],"leadId":'+uu.Ameyo_Lead_Id__c+',"properties":{"update.customer":true,"migrate.customer":true},"attempts":"0","status":"NOT_TRIED"}';
            HttpRequest req = new HttpRequest();
            
            req.setEndpoint('https://emergeapp6.ameyoemerge.in:8443/ameyowebaccess/command?command=uploadContactAndAddCallback');   
            req.setTimeout(120000);
            req.setMethod('POST'); 
            
            req.setHeader('Content-Type','application/x-www-form-urlencoded');
            req.setHeader('hash-key','fecace70bf6ea0c450c5b2071dtfhfr2');
            req.setHeader('host','foundit.ameyoemerge.in');
            req.setHeader('policy-name','token-based-authorization-policy');
            req.setHeader('requesting-host','foundit.ameyoemerge.in');
            req.setHeader('Cookie','JSESSIONID=372C9FA28EAD3C6278491156714CB223; __METADATA__=1465b04d-7be8-490d-adb0-c8448ce472c3');
            //req.setbody('data={"campaignId":"175","customerAndCallbackRecords":[{"customerRecord":{"phone1":"6206982243","lead_score__c":"1"}},{"customerRecord":{"phone1":"9718785288","lead_score__c":"5"}}],"leadId":"258","properties":{"update.customer":true,"migrate.customer":true},"attempts":"0","status":"NOT_TRIED"}');
            req.setbody(payLoad);
            Http h = new Http();
            System.debug('qqqqqqqqq');
            
            HTTPResponse res = h.send(req);
            System.debug(res.getBody());
            System.debug(req.getBody());
            system.debug(crec.customerRecord);
            system.debug('response status code is  **  '+res.getStatusCode());
            system.debug('final'+cct);
            return null;
        }
        catch(exception ex){
            system.debug('In Exception: '+ex.getMessage());
            system.debug('getLineNumber: '+ex.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
    }
}