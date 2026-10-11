public class KYC_Creation_From_Opp_Class {
    
    
    @AuraEnabled
    public static void savekyc(OpportunityN__c opp1)
    {
        Client_Validation_Request__c c = new Client_Validation_Request__c();
        c.Account__c = opp1.Account__c;
        c.Contact__c = opp1.Contact__c;
        c.Contact_Email_Address__c = opp1.Contact__r.Email;
        c.Tel_Number__c = opp1.Contact__r.Phone;
        c.GST_ID__c = opp1.Account__r.GST_ID__c;
        //   c.PAN_Number__c = opp1.Account__r.PAN__c;
        c.Account_Registration_Number__c = opp1.Account__r.RegistrationNumber__c;
        insert c;
        
    }
    @AuraEnabled
    Public static OpportunityN__c getRecord(id recordId){
        System.debug('The id is  '+recordId);
        OpportunityN__c opp = [select id,Name,Account__c,Account__r.Name,Account__r.Person_Account__c,Opportunity_Type__c,Contact__c,Contact__r.Name,Contact__r.Phone,Account__r.GST_ID__c,Account__r.RegistrationNumber__c,Account__r.PAN__c,Contact__r.Email from OpportunityN__c where id =: recordId];
        System.debug('Returning Opp '+opp);
        return opp;
    } 
    @AuraEnabled
    public static String create_new_kyc(Id accid)
    {
        Account a = new Account();
        a = [select id,name,AccountStatus__c,ShippingCountry,Person_Account__c,ClientValidationCheck__c,RegistrationNumber__c,PostCountry__c,GST_ID__c,PAN__c,AccountID__c,Lead_Account_Status__c,(select id,lastname,Phone,Email,PrimarySalesContact__c from contacts where  PrimarySalesContact__c= true),(select id,name,Stage__c,Status__c,Account__r.ClientValidationCheck__c,Account__r.AccountStatus__c from Client_Validation_Requests__r) from Account where id =: accId];
		System.debug('a.Lead_Account_Status__c : '+ a.Lead_Account_Status__c );
        if(a.Lead_Account_Status__c != 'Active')
        {
            return 'Please Activate The Account ';
        }
        System.debug('After Checking activation-----1');
        if(a.ShippingCountry == 'India' && a.Person_Account__c == false)
        {
            if(a.contacts.size()>0)
            {
                for(Contact kon : a.contacts)
                {
                    if(kon.email == null || kon.Email=='' || kon.Phone == null || kon.Phone=='')
                    { 
                        return 'Please enter Email and Phone at Contact level '+kon.lastname; 
                    } 
                }
            }
            else
            {
                return 'Please select Atleast One Primary Sales Contact True  At '+a.AccountID__c; 
            }
            System.debug('After Checking activation-----2');
            if(a.Client_Validation_Requests__r.size()>0 )
            {
                for(Client_Validation_Request__c cv : a.Client_Validation_Requests__r)
                {
                    if(cv.Stage__c != 'Closed')
                    {
                        //Changes as per parag request https://mail.google.com/mail/u/1/?tab=wm&ogbl#inbox/FMfcgxwDqnhfrSQWMtpjDRdwLGBwCwhM
                        System.debug('SUCCESS KYC 45-----1');
                        return 'You have validation Request '+cv.name+' with stage '+cv.Stage__c;
                        //return 'Success Quote';
                    }
                    else if(cv.Account__r.ClientValidationCheck__c == false && cv.Stage__c =='Closed' && cv.Status__c =='Approved')
                    {
                        System.debug('SUCCESS QUOTE 50-----1');
                        return 'Success Quote';
                    } 
                    else if(cv.Account__r.AccountStatus__c == 'Lapsed Customer' && cv.Account__r.ClientValidationCheck__c == true && cv.Stage__c=='closed')
                    {
                        System.debug('SUCCESS KYC 54-----1');
                        return 'Success KYC'; 
                        
                    }
                }
            }
            else 
            {
                System.debug('SUCCESS KYC 61-----1');
                return 'Success KYC';
            }
        }
        else
        {
            System.debug('SUCCESS  70-----1');
            return 'Success Quote';
            
        }
        return 'Error';
        
    }
}