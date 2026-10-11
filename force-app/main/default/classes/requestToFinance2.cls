global class requestToFinance2 {
 @AuraEnabled
    webservice static string myMethod(string recid)
    {
        String ret;
       	system.debug('HelloWorldofDream!-->'+recid);
        user logged=[select id,name,email from user where id=:userinfo.getuserid()];
        user receiver=[select id,name,email,Manager.email from user where id=:logged.id];
        Reversal_Bad_Debt_Requests__c ap=[select id,name,Reversal_Amount__c,Reversal_Bad_Debt_Type__c,Reversal_Bad_Debt_Reason__c,Account__r.name,Order__r.name,Final_Approval_Status__c,Request_To_Finance__c,Order_Date__c,Order_Number__c from Reversal_Bad_Debt_Requests__c where id=:recid];
     
        if(ap.Request_To_Finance__c == false&& ap.Final_Approval_Status__c == 'Approved'){          
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
	        mail.setSubject('Please refer the Credit Request -'+ap.name+' for Order '+ap.Order__r.name);
	        mail.setHtmlBody(           
            '<b>Please refer the following Credit Request details</b> <br/><br/><br/> Account Name: '+ap.Account__r.name /* +ap.Account__r.AccountID__c */
            +'<br/>Order Number: '+ap.Order__r.name
            +'<br/>Credit Reason: '+ap.Reversal_Bad_Debt_Reason__c
            +'<br/>Credit Type: '+ap.Reversal_Bad_Debt_Type__c
            +'<br/>Credit Amount - '+ap.Reversal_Amount__c
            +'<br/><br/>Regards,<br/>Team Finance'
            +'<br/><br/><b>Please click on the record link below for more details<br/>'+link           
        );       
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });        
            update ap;
            ret = 'Success';
     	}       
  		else if(ap.Request_To_Finance__c == false && ap.Final_Approval_Status__c != 'Approved'){ 
        	ret = 'Please get approval before you Request to Finance';
        }
        else if(ap.Request_To_Finance__c == true){
            ret = 'Already requested to Finance';    
        }          
        return ret;
    }
    @AuraEnabled
    Public static Reversal_Bad_Debt_Requests__c getRecord(id recordId){
        Reversal_Bad_Debt_Requests__c ap=[select id,name,Reversal_Amount__c,Reversal_Bad_Debt_Type__c,Reversal_Bad_Debt_Reason__c,Account__r.name,Order__r.name,Final_Approval_Status__c,Request_To_Finance__c,Order_Date__c,Order_Number__c from Reversal_Bad_Debt_Requests__c where id=:recordId];       
        return ap;
    }
}