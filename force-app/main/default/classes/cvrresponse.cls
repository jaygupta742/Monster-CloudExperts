global class cvrresponse {
    @AuraEnabled
    webservice static String cvrmeth(Id IDD)
    {
         list<Account> ak = new list<Account>();
     list<Client_Validation_Request__c>  cvrr;
     
    OrgWideEmailAddress   owea = [select Id,address from OrgWideEmailAddress where address='kyc@monsterindia.com'];
        cvrr = new list<Client_Validation_Request__c>();
        cvrr =[select id,name,Response__c,Status__c,CC_Address__c,Stage__c,Owner_mail_id__c,KYC_type__c,Reference__c,ownerID ,Owner.lastname,owner.Email,Account__c,Account__r.CrRefComment__c from Client_Validation_Request__c where id=:IDD];
        list<Messaging.SingleEmailMessage>  listofmails = new list<Messaging.SingleEmailMessage>();
        
        for(Client_Validation_Request__c cv:cvrr ){
            if(cv.Stage__c !='Submitted' && cv.Status__c !='open' && cv.Response__c !=''){
                cv.Validated_BY__c = userinfo.getName();
                cv.Validated_Date_Time__c = system.now();
                Account a = new Account();
                a.id = cv.Account__c;
                a.CrRefComment__c = cv.name +' |'+cv.Stage__c+' |'+cv.Status__c+' |'+cv.KYC_type__c;
                a.CreditCheckReferenceNumber__c = cv.Reference__c;
                a.ClientValidationCheck__c = false;
                ak.add(a);
                
                Messaging.SingleEmailMessage resmail = new Messaging.SingleEmailMessage();
             resmail.setOrgWideEmailAddressId(owea.id);
                resmail.setSubject(cv.Name+'|'+ cv.Stage__c +'|'+ cv.Status__c+'|'+  cv.KYC_type__c);
      
                string tab = 'Dear '+cv.Owner.lastname+'<br/><br/>'+'Greetings!!!!!'+'<br/><br>'+'Your Client Validation Request :'+'<b>'+cv.Name+'</b>'+ ' is '+'<b>'+cv.Status__c+'</b> '+' the following Note :<br/><b> '+cv.Response__c+'</b><br/><br/>Regards,<br/><b>'+userinfo.getFirstName()+userinfo.getLastName()+'</b>';
               resmail.setHtmlBody(tab);
               
                if(cv.CC_Address__c != null ){
                 list<string> ccad = cv.CC_Address__c.split(',');
                resmail.setCcAddresses(ccad);
                    }
                
               string[] toad = new list<String>();
                  toad.add(cv.owner.Email);
                system.debug('owner email '+cv.owner.Email);
                resmail.setToAddresses(toad);
                 listofmails.add(resmail);      
            }
        }
        try{
            update cvrr;
            update ak;
            Messaging.sendEmail(listofmails);
            return 'Success';
        }
        catch(Exception e){
            return 'Error:'+e;
        }
    }
    @AuraEnabled
    Public static Client_Validation_Request__c getRecord(id recordId){
        return [select id,name,Response__c,Stage__c,Status__c from Client_Validation_Request__c where id =: recordId];
    }

}