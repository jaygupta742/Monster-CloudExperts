/*
* Created By : Suraj 
* Created date : 06/10/2023
* Created For : This Is apex class using in Contact valid Email for  ValidContactEmail LWC Cmp
*/ 
public class ValidContactEmail {    
    @AuraEnabled
    public static String validemail(String recordId) {
        try {
            Contact contacts = [SELECT Id, FirstName, ZeroBounce_Status__c, ZeroBounce_SubStatus__c, Validated_Email__c, LastName, Active_in_Days__c, Email, Email_Validation_Date__c 
                                FROM Contact WHERE Id =: recordId]; 

            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint(system.label.Email_ValidEndpoint + 'api_key=' + system.label.Email_validate_apikey + '&email=' + contacts.email + '&ip_address=');
            req.setTimeout(120000);
            HTTP http = new Http();
            HttpResponse res = http.send(req); 
            
            System.debug('Get Response ' + res.getStatus());
            System.debug('Get Response code ' + res.getStatusCode());

            String getdate = res.getBody(); 
            Map<String, Object> getres = (Map<String, Object>) JSON.deserializeUntyped(getdate); 
            contacts.ZeroBounce_Status__c = (String)getres.get('status');
            contacts.ZeroBounce_SubStatus__c = (String)getres.get('sub_status');
            contacts.Validated_Email__c = false;
            contacts.Email_Validation_Date__c = Datetime.now();
            
            if ((String)getres.get('status') == 'valid') contacts.Validated_Email__c = true; 
			
            if(getres.get('domain_age_days') != null) contacts.Active_in_Days__c = Decimal.valueOf((String)getres.get('domain_age_days')); 

            update contacts;  
            return (String)getres.get('status');
        } catch (Exception e) {
            System.debug('Exception Line Number: ' + e.getLineNumber());
            System.debug('Exception Message: ' + e.getMessage()); 
            throw new AuraHandledException('An error occurred: ' + e.getMessage());
        }
    }
}