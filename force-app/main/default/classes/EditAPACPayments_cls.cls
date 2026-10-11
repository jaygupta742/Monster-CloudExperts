public class EditAPACPayments_cls {
    @AuraEnabled
    public static List<APAC_Payments__c> getAPACPayments(String recordId) {
        List<APAC_Payments__c> li;
        
        li = [SELECT Id, APAC_Payment_Name__c, CurrencyIsoCode, Due_Date__c, DueDateWithoutTime__c, Finance_Reference__c, GST__c,
              N_ExternalID__c, N_external_ownerid__c, Name, Net_Total__c, Old_Created_By__c, Old_Created_Date__c, Old_Created_User__c,
              Old_Last_Modified_By__c, Old_Last_Modified_Date__c, Old_Last_Modified_User__c, Old_Owner__c, Owner__c, Payment_Amount__c,
              Payment_Date__c, Payment_Received_Amount__c, Quotes__c, Quotes__r.Name, Revised_Due_Date__c,TDS_Amount__c, TDS_Payment_Amount__c
              
              FROM APAC_Payments__c WHERE Quotes__c =: recordId
             ];
        
        return li;
    }
     @AuraEnabled
    public static string getstatus(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        return qq.Approval_Status_Overall__c;
    }
    @AuraEnabled
    public static boolean getvalidated(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c,Validated__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        return qq.Validated__c;
    }
    @AuraEnabled
    public static decimal gettotal(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c,Net_Total__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        return qq.Net_Total__c;
    }
    
    @AuraEnabled 
    public static void onsave(String recordId, List<APAC_Payments__c> apac) {
        
        try {
            List<APAC_Payments__c> li;
            
            li = [SELECT Id, APAC_Payment_Name__c, CurrencyIsoCode, Due_Date__c, DueDateWithoutTime__c, Finance_Reference__c, GST__c,
                  N_ExternalID__c, N_external_ownerid__c, Name, Net_Total__c, Old_Created_By__c, Old_Created_Date__c, Old_Created_User__c,
                  Old_Last_Modified_By__c, Old_Last_Modified_Date__c, Old_Last_Modified_User__c, Old_Owner__c, Owner__c, Payment_Amount__c,
                  Payment_Date__c, Payment_Received_Amount__c, Quotes__c, Quotes__r.Name, Revised_Due_Date__c,TDS_Amount__c, TDS_Payment_Amount__c
                  
                  FROM APAC_Payments__c WHERE Quotes__c =: recordId
                 ];
            
            Map<Id, APAC_Payments__c> mapli = new Map<Id, APAC_Payments__c> ();
            for(APAC_Payments__c item: apac) {
                mapli.put(item.Id, item);
            } 
            List<APAC_Payments__c> todelete=new List<APAC_Payments__c>();
            for(APAC_Payments__c item : li) {
                if(!mapli.containsKey(item.Id)){
                    system.debug('apac name: '+ item.Name);
                 	todelete.add(item);
                }
            }
              delete todelete;

            update apac;
        }        
        catch(Exception e) {
            system.debug('error in : '+e.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+E.getMessage());
        }
    }
}