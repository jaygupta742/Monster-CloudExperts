public class CreateApacPayment {
    
    @AuraEnabled
    public static string getstatus(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        return qq.Approval_Status_Overall__c;
    }
     @AuraEnabled
    public static Boolean getValidatedstatus(string rid){
    
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c,Validated__c from QuotesN__c where id=:rid];
     
        return qq.Validated__c;
     
    }
    @AuraEnabled
    public static QuotesN__c getquoteinfo(string rid){
        QuotesN__c qq=[select id,name,Tax__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        return qq;
    }
    
    @AuraEnabled
    public static List<APAC_Payments__c> getsoline(String rid)
    {
        QuotesN__c qq=[select id,name,Tax__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        List<APAC_Payments__c> soli=new List<APAC_Payments__c>();
        APAC_Payments__c ss=new APAC_Payments__c();
        ss.Quotes__c=qq.Id;
        // ss.Quantity__c=1;
        soli.add(ss);
        return soli;
        
    }   
    
    @AuraEnabled
    public static decimal getgross(string rid){
        QuotesN__c qq=[select id,name,Gross_Total__c,Net_Total__c from QuotesN__c where id=:rid];
        system.debug('quote status:'+qq);
        return qq.Net_Total__c;
    }
    
    @AuraEnabled
    public static void onsave(String recordId, List<APAC_Payments__c> task) {
        try {
            QuotesN__c milestone = [SELECT Id, Name,CurrencyIsoCode FROM QuotesN__c WHERE Id =: recordId];
            List<APAC_Payments__c> listtoinsert =new  List<APAC_Payments__c>();
            for(APAC_Payments__c t : task ) {
                
                
                t.Quotes__c = milestone.id;
                t.CurrencyIsoCode=milestone.CurrencyIsoCode;
                listtoinsert.add(t);
                
            }   
            insert listtoinsert;
        }
        catch(Exception e) {
            throw new AuraHandledException('Something went wrong: '+e.getMessage());
        }
        
    }
}