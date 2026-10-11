/*
* Created By : Suraj 
* Created date : 05/10/2023
* Created For : This Is apex class using in "Contact valid Email" Id Created flow to valid contact email address
*/ 
Public class ContactDataRetriever {
    @InvocableMethod(label='Get Contact Data') 
    public static void getContactData(List<Id> contactIds) {
        set<Id> contactsToProcess = new set<Id>(); 
        for (Id contactId : contactIds) {
            system.debug(' contactId '+contactId);
            contactsToProcess.add(contactId);
            
        }
        
        // Call the asynchronous method from outside the @future context
        if (!contactsToProcess.isEmpty()) {
            system.debug('Inside ');
            processContactsAsync(contactsToProcess);
        }
        return;
    }
    
    @future(callout=true)
    public static void processContactsAsync(set<Id> ids) {
        try{  
            List<Contact> contactsl = [SELECT Id, FirstName, ZeroBounce_Status__c, ZeroBounce_SubStatus__c, Validated_Email__c, LastName, Active_in_Days__c, Email, Email_Validation_Date__c  
                                       FROM Contact WHERE Id IN :ids];
            system.debug('contactsl '+contactsl);
            contact[] conlis = New Contact[]{};
                for (Contact contacts : contactsl) {
                    httpRequest req=New HttpRequest();
                    req.setMethod('GET');
                    req.setEndpoint(system.label.Email_ValidEndpoint+'api_key='+system.label.Email_validate_apikey+'&email='+contacts.email+'&ip_address=');
                    HTTP http=New Http();
                    HttpResponse res=http.send(req);
                    
                    system.debug('Get Reposnse '+res.getStatus());
                    system.debug('Get Reposnse code '+res.getStatusCode());
                    string getdate = res.getBody();
                    // system.debug('getdate '+getdate);
                    Map<String, Object> getres=( Map<String, Object>)json.deserializeUntyped(getdate);
                    system.debug('getres '+getres);
                    
                    contacts.ZeroBounce_Status__c =(string)getres.get('status');
                    contacts.ZeroBounce_SubStatus__c =(string)getres.get('sub_status');
                    if((string)getres.get('status') =='valid')contacts.Validated_Email__c = true;
                    if((string)getres.get('status') =='invalid')contacts.Validated_Email__c = false;
                    contacts.Active_in_Days__c = decimal.valueOf((string)getres.get('domain_age_days'));
                    contacts.Email_Validation_Date__c = Datetime.now(); 
                    conlis.add(contacts);
                }
            
            update conlis;
           }
        catch(Exception e){
            system.debug('get line '+e.getLineNumber());
            system.debug(' get msg '+e.getMessage());
        }
    }
}