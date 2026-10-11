public class CreateNewKYC {

    /* @AuraEnabled
    Public static string createnewcvr(id accId){
        Account a = new Account();
        a = [select id,name,AccountStatus__c,Person_Account__c,ClientValidationCheck__c,RegistrationNumber__c,PostCountry__c,GST_ID__c,PAN__c,AccountID__c,Lead_Account_Status__c,(select id,lastname,Phone,Email,PrimarySalesContact__c from contacts where  PrimarySalesContact__c= true),(select id,name,Stage__c,Status__c,Account__r.ClientValidationCheck__c,Account__r.AccountStatus__c from Client_Validation_Requests__r) from Account where id =: accId];
        if(a.Lead_Account_Status__c != 'Active'){
        	return 'Please Activate the Account ';
        }  
        else if(a.contacts.size()>0){
        	for(contact kon : a.contacts){
            	if(kon.email == null || kon.Email=='' || kon.Phone == null || kon.Phone==''){ 
                	return 'Please enter Email and Phone at Contact level '+kon.lastname; 
                } 
            }
        }
        else if(a.contacts.size() == 0){
        	return 'Please select Atleast One Primary Sales Contact True  At '+a.AccountID__c; 
        }
        else{
            Return 'Success Quote';
        }
        return 'Success Quote';
	}*/
    @AuraEnabled
    Public static string createnewkyc(id accId){
        Account a = new Account();
        a = [select id,name,AccountStatus__c,ShippingCountry,Person_Account__c,ClientValidationCheck__c,RegistrationNumber__c,PostCountry__c,GST_ID__c,PAN__c,AccountID__c,Lead_Account_Status__c,(select id,lastname,Phone,Email,PrimarySalesContact__c from contacts where  PrimarySalesContact__c= true),(select id,name,Stage__c,Status__c,Account__r.ClientValidationCheck__c,Account__r.AccountStatus__c from Client_Validation_Requests__r) from Account where id =: accId];
        if(a.Lead_Account_Status__c != 'Active'){
        	return 'Please Activate the Account ';
        }  
         system.debug('EEEEEEEE  '+a.contacts.size());
        if(a.ShippingCountry == 'India' && a.Person_Account__c == false){
            if(a.contacts.size()>0){
                for(contact kon : a.contacts){
                    if(kon.email == null || kon.Email=='' || kon.Phone == null || kon.Phone==''){ 
                        return 'Please enter Email and Phone at Contact level '+kon.lastname; 
                    } 
                }
            }
            else{
            	return 'Please select Atleast One Primary Sales Contact True  At '+a.AccountID__c; 
            }
            
            if(a.Client_Validation_Requests__r.size()>0 ){
                for(Client_Validation_Request__c cv : a.Client_Validation_Requests__r){
					system.debug('CVR Status Account  '+cv.Account__r.ClientValidationCheck__c+'  CV Stage  '+cv.Stage__c +' Status Appro '+ cv.Status__c);
                    if(cv.Stage__c != 'Closed'){
                        //Changes as per parag request https://mail.google.com/mail/u/1/?tab=wm&ogbl#inbox/FMfcgxwDqnhfrSQWMtpjDRdwLGBwCwhM
						return 'You have validation Request '+cv.name+' with stage '+cv.Stage__c;
						//return 'Success Quote';
                    }
                    else if(cv.Account__r.ClientValidationCheck__c == false && cv.Stage__c =='Closed' && cv.Status__c =='Approved'){
						return 'Success Quote';
                    } else if(cv.Account__r.AccountStatus__c == 'Lapsed Customer' && cv.Account__r.ClientValidationCheck__c == true && cv.Stage__c=='closed'){
						return 'Success KYC';                                                               
					}
				}
            }  else {
                Return 'Success KYC';
            }   
		}
        else{
            Return 'Success Quote';
        }
        return 'Error ';
	}
	@AuraEnabled
    Public static string getRecord(id recordId){
        OpportunityN__c opp = [select id,Name,Account__c,Account__r.Name,Account__r.Person_Account__c,Opportunity_Type__c,Contact__c,Contact__r.Name,Contact__r.Phone,Account__r.GST_ID__c,Account__r.RegistrationNumber__c,Account__r.PAN__c,Contact__r.Email from OpportunityN__c where id =: recordId];
        wrape ww=new wrape(opp);
        ww.accId=opp.Account__c;
        ww.phone=opp.Contact__r.Phone;
        ww.email=opp.Contact__r.Email;
        return JSON.serialize(ww);
    } 
    public class wrape{
        @AuraEnabled
        public OpportunityN__c li{get;set;}
        public String accid{get;set;}
        public string phone{get;set;}
        public string email{get;set;}
        
        public wrape(OpportunityN__c oo){
           li=new OpportunityN__c();
            li=oo;
        }
    }
}