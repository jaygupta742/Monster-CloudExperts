Global class requestToFinance
{
    @AuraEnabled
    webservice static string myMethod(string recid)
    {
        String ret;
       	system.debug('HelloWorldofDream!-->'+recid);
        user logged=[select id,name,email from user where id=:userinfo.getuserid()];
        user receiver=[select id,name,email,Manager.email from user where id=:logged.id];
        Credit_Request__c ap=[select id,name,Account__r.name,Credit_Type__c,Order_Custom__r.name,Approval_Status__c,Request_To_Finance__c,Credit_Amount__c,Billing_Account__c,Credit_Reason__c,CreditType__c,OrderDate__c,Order_Number__c,Credit_Comments__c from Credit_Request__c where id=:recid];
     
        if(ap.Request_To_Finance__c == false&& ap.Approval_Status__c == 'Approved'){          
        	ap.Request_To_Finance__c = true;  
            string link=URL.getSalesforceBaseUrl().toExternalForm() + '/'+ap.id;
        	string Mangrmail = receiver.Manager.email; 
        	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();        
	        List<String> em = new List<String>();
	        String el = 'srinivas.gangisetty@monsterindia.com';        
	        em.add(el);
	        String ell = 'kiran.madas@monsterindia.com';
            em.add(ell);        
        	String e2 = 'kiran.gunti@monsterindia.com';
            em.add(e2);       
        	//String e3 = 'kishorekumar.akkapalli@monsterindia.com';
            //em.add(e3);        
	        //String e4 = 'crm@cloudexpertsindia.com';
	       // em.add(e4);
	        mail.setToAddresses(em);        
	        mail.setSubject('Please refer the Credit Request -'+ap.name+' for Order '+ap.Order_Custom__r.name);
	        mail.setHtmlBody(           
            '<b>Please refer the following Credit Request details</b> <br/><br/><br/> Account Name: '+ap.Account__r.name /* +ap.Account__r.AccountID__c */
            +'<br/>Order Number: '+ap.Order_Custom__r.name
            +'<br/>Credit Reason: '+ap.Credit_Reason__c
            +'<br/>Credit Type: '+ap.Credit_Type__c
            +'<br/>Credit Amount - '+ap.Credit_Amount__c
            +'<br/><br/>Regards,<br/>Team Finance'
            +'<br/><br/><b>Please click on the record link below for more details<br/>'+link           
        );       
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });        
            update ap;
            ret = 'Success';
     	}       
  		else if(ap.Request_To_Finance__c == false && ap.Approval_Status__c != 'Approved'){ 
        	ret = 'Please get approval before you Request to Finance';
        }
        else if(ap.Request_To_Finance__c == true){
            ret = 'Already requested to Finance';    
        }          
        return ret;
    }
    @AuraEnabled
    Public static Credit_Request__c getRecord(id recordId){
        Credit_Request__c ap=[select id,name,Approval_Status__c,Billing_Account__c,Credit_Reason__c,Credit_Amount__c,CreditType__c,OrderDate__c,Order_Number__c,Credit_Comments__c from Credit_Request__c where id=:recordId];       
        return ap;
    }
   
}