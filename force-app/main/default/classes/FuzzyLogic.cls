global class FuzzyLogic {
	@AuraEnabled
    webservice static string generatecsv(id cvrid){
        try{
        Client_Validation_Request__c newrecord = new Client_Validation_Request__c();
        Account ActualAccount = new Account();
        List<Client_Validation_Request__c> matchingCvrs = new List<Client_Validation_Request__c>();
        List<Account> MacthingAccounts = new List<Account>();
        Set<Id> kycSet = new Set<Id>();
        
        
        newrecord = [SELECT Id, OwnerId, Name, CreatedById, LastModifiedById, Account__c, CIN_Number__c, Registered_Company_Name__c, Company_liability_is__c, Contact_Email_Address__c, Client_State__c, Client_City_Metro__c, HQ_Branch_Locations__c, Tel_Number__c, CRM_Account_ID__c, Contact__c, Stage__c, Status__c, Registration_Number__c, GST_ID__c, VAT_Number__c, PAN_Number__c, Aadhaar_Number__c, Voter_ID__c, Ration_ID__c, Passport_Number__c, Other_ID_Number__c, Related_Accounts__c FROM Client_Validation_Request__c WHERE Id =: cvrid limit 1]; 
        ActualAccount = [select Name,AccountID__c,Phone,Website/*(select Address1__c from Addresses1__r) {commenting for address -renu}*/,(select Email,MobilePhone from contacts) from Account where id =: newrecord.Account__c limit 1];
            kycSet.add(newrecord.Id);
            String accId = newrecord.Account__c;
            String cinNo;
            String regComp;
            String conEmail;
            String telNum;
            String regNo;
            String vatNo;
            String gstNo;
            String aadNo;
            String voterNo;
            String passNo;
            String panNo;
            String rationNo;
            String otherNo;
        String kycquery = 'Select Id,Name,Owner.Name,Status__c,Stage__c,Account__r.Name,Account__r.Accountid__c from Client_Validation_Request__c where Id !=: kycSet AND (Account__c =: accId';
            If(newrecord.CIN_Number__c!=NULL){
                 cinNo = newrecord.CIN_Number__c;
                 kycquery = kycquery + ' OR CIN_Number__c =: cinNo'; 
            }
           If(newrecord.Registered_Company_Name__c!=NULL){
               regComp = newrecord.Registered_Company_Name__c;
                 kycquery = kycquery + ' OR Registered_Company_Name__c =: regComp'; 
            }
             If(newrecord.Contact_Email_Address__c!=NULL){
                 conEmail = newrecord.Contact_Email_Address__c;
                 kycquery = kycquery + ' OR Contact_Email_Address__c =: conEmail'; 
            }
             If(newrecord.Tel_Number__c!=NULL){
                 telNum = newrecord.Tel_Number__c;
                 kycquery = kycquery + ' OR Tel_Number__c =: telNum'; 
            }
            If(newrecord.Registration_Number__c!=NULL){
                 regNo = newrecord.Registration_Number__c;
                 kycquery = kycquery + ' OR Registration_Number__c =: regNo'; 
            }
            If(newrecord.VAT_Number__c!=NULL){
                 vatNo = newrecord.VAT_Number__c;
                 kycquery = kycquery + ' OR VAT_Number__c =: vatNo'; 
            }
            If(newrecord.GST_ID__c!=NULL){
                 gstNo = newrecord.GST_ID__c;
                 kycquery = kycquery + ' OR GST_ID__c =: gstNo'; 
            }
            If(newrecord.Aadhaar_Number__c!=NULL){
                 aadNo = newrecord.Aadhaar_Number__c;
                 kycquery = kycquery + ' OR Aadhaar_Number__c =: aadNo'; 
            }
            If(newrecord.Voter_ID__c!=NULL){
                 voterNo = newrecord.Voter_ID__c;
                 kycquery = kycquery + ' OR Voter_ID__c =: voterNo'; 
            }
            If(newrecord.Ration_ID__c!=NULL){
                 rationNo = newrecord.Ration_ID__c;
                 kycquery = kycquery + ' OR Ration_ID__c =: rationNo'; 
            }
            If(newrecord.PAN_Number__c!=NULL){
                 panNo = newrecord.PAN_Number__c;
                 kycquery = kycquery + ' OR PAN_Number__c =: panNo'; 
            }
            If(newrecord.Passport_Number__c!=NULL){
                 passNo = newrecord.Passport_Number__c;
                 kycquery = kycquery + ' OR Passport_Number__c =: passNo'; 
            }
            If(newrecord.Other_ID_Number__c!=NULL){
                 otherNo = newrecord.Other_ID_Number__c;
                 kycquery = kycquery + ' OR Other_ID_Number__c =: otherNo'; 
            }
            kycquery = kycquery + ' )'; 
            system.debug('kycquery : '+kycquery);
            matchingCvrs = Database.query(kycquery);
        
        /*matchingCvrs = [select id,Name,Owner.Name,Status__c,Stage__c,Account__r.Name,Account__r.Accountid__c from Client_Validation_Request__c where id !=: newrecord.id AND (Account__c =: newrecord.Account__c OR (CIN_Number__c =: newrecord.CIN_Number__c AND CIN_Number__c!=NULL) OR (Registered_Company_Name__c =: newrecord.Registered_Company_Name__c AND Registered_Company_Name__c!=NULL ) OR (Contact_Email_Address__c =: newrecord.Contact_Email_Address__c AND Contact_Email_Address__c!=NULL) OR (Tel_Number__c =: newrecord.Tel_Number__c AND Tel_Number__c!=NULL) OR (Registration_Number__c =: newrecord.Registration_Number__c AND Registration_Number__c!=NULL) 
        //OR (VAT_Number__c =: newrecord.VAT_Number__c AND VAT_Number__c!=NULL) OR (GST_ID__c =: newrecord.GST_ID__c AND GST_ID__c!=NULL) OR (Aadhaar_Number__c =: newrecord.Aadhaar_Number__c AND Aadhaar_Number__c!=NULL)
        // OR (Voter_ID__c =: newrecord.Voter_ID__c AND Voter_ID__c!=NULL) OR (Ration_ID__c =: newrecord.Ration_ID__c AND Ration_ID__c!=NULL) OR (PAN_Number__c =: newrecord.PAN_Number__c AND PAN_Number__c!=NULL)
        //  OR (Passport_Number__c =: newrecord.Passport_Number__c AND Passport_Number__c!=NULL) OR (Other_ID_Number__c =: newrecord.Other_ID_Number__c AND Other_ID_Number__c!=NULL))];*/
        system.debug('matchingCvrs size : '+matchingCvrs.size());    
        //Account
        String AccountName = '%'+ActualAccount.Name.left(6)+'%';
        String accquery =  'select id,Name,Accountid__c,Owner.Name from Account where Name like :AccountName';
        String AccountPhone;
        String AccountWebsite;
        if(ActualAccount.Phone.length()>8){
            AccountPhone = '%'+ActualAccount.Phone.right(8)+'%';
            accquery = accquery+' OR Phone like :AccountPhone ';
        }
        if(ActualAccount.Website.contains('.')){
            AccountWebsite = '%'+ActualAccount.Website.substringAfter('.').substringBefore('.')+'%';
            accquery = accquery+' OR Website like :AccountWebsite';
        }
        accquery = accquery+' limit 1000';
        MacthingAccounts = Database.query(accquery);
        
            System.debug('Matching account'+MacthingAccounts);
        //Contact
        List<Contact> MacthingContact = new List<Contact>();
        List<String> likeEmail = new List<String>();
        List<String> likePhone = new List<String>();
        for(Contact c : ActualAccount.Contacts){
            if(c.Email != null)
                likeEmail.add('%'+c.Email.substringBefore('@')+'%');
            if(c.MobilePhone != null && c.MobilePhone.length()>8)
                likePhone.add('%'+c.MobilePhone.right(8)+'%');
        }
        String conquery;
        conquery = 'select Id,Name,Accountid,Account.Name,Owner.Name,Account.Accountid__c from contact';
        if(likeEmail.size()>0)
            conquery = conquery+' where Email like :likeEmail';
        if(likePhone.size()>0 && likeEmail.size()>0)
            conquery = conquery+' OR MobilePhone Like :likePhone';
        if(likeEmail.size()==0 && likePhone.size()>0)
            conquery = conquery+' where MobilePhone Like :likePhone';
        if(conquery.contains('where'))
        conquery = conquery+' limit 1000';
        MacthingContact = Database.query(conquery);
         system.debug('Size MacthingContact : '+MacthingContact.size());
      /*  
        //Address
        List<Address1__c> MatchingAddress = new List<Address1__c>();
        List<String> streetlist = new List<String>();
        for(Address1__c ad : ActualAccount.Addresses1__r){
            if(ad.Address1__c != null){
                streetlist.add('%'+ad.Address1__c+'%'); 
            }
    }
        
        if(streetlist.size()>0)
        MatchingAddress = [select Name,Owner.Name,Account__r.Name,Account__r.Accountid__c from Address1__c where Address1__c like :streetlist];
        
        */  //renu commented for address removal
            
        String attbody;
        if(matchingCvrs.size()>0){
            attbody = 'Matching Client Validation\nName,Owner,Account,AccountID,Status,Stage\n';
        for(Client_Validation_Request__c cvr : matchingCvrs){
            attbody = attbody+cvr.Name+','+cvr.Owner.Name+','+cvr.Account__r.Name+','+cvr.Account__r.Accountid__c+','+cvr.Status__c+','+cvr.Stage__c+'\n';
        }
        }
        else{
                attbody= 'No Matching CVR\n';
        }
        if(MacthingAccounts.size()>0){
            attbody = attbody+'\nMacthing Accounts\nName,Owner,AccountID\n';
        for(Account a : MacthingAccounts){
            attbody = attbody+a.Name+','+a.owner.Name+','+a.Accountid__c+'\n';
        }
        }
        else{
            attbody= attbody+'\nNo Matching Account\n';
        }
            
        if(MacthingContact.size()>0){
            attbody = attbody+'\nMatching Contacts\nName,Owner,Account,AccountID\n';
        for(Contact c : MacthingContact){
            attbody = attbody+c.Name+','+c.owner.Name+','+c.Account.Name+','+c.Account.Accountid__c+'\n';
        }
        }
        else{
            attbody= attbody+'\nNo Matching Contact\n';
        }
       /* if(MatchingAddress.size()>0){
            attbody = attbody+'\nMatching Addresses\nName,Owner,Account,AccountID\n';
        for(Address1__c ad : MatchingAddress){
            attbody = attbody+ad.Name+','+ad.owner.Name+','+ad.Account__r.Name+','+ad.Account__r.Accountid__c+'\n';
        }
        }
        else{
            attbody= attbody+'\nNo Matching Address\n';
        }
             
       */  //renu commented for address removal

        Validation_Review__c vr = new Validation_Review__c();
        vr.Client_Validation_Request__c = cvrid;
        insert vr;
        Attachment att = new Attachment();
        att.Body = blob.valueOf(attbody);
        att.ParentId = vr.Id;
        att.Name = newrecord.Name+' | FuzzyLogic.csv';
        insert att;
        return 'Success';
    }
        catch(Exception e){
            return ''+e;
        }
    }
}