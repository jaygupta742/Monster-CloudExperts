public class CVRHandler {
    Public void OnBeforeInsertandUpdate(Client_Validation_Request__c[] newrecords){
        
        List<id> accids = new List<id>();
        //Recordtype rid = [select id from recordtype where Name = 'Approved' and Sobjecttype = 'Client_Validation_Request__c' limit 1];
        id defaultrectype = schema.SObjectType.Client_Validation_Request__c.getRecordTypeInfosByName().get('Default').getRecordTypeId();
        id Apprvdtrectyp = schema.SObjectType.Client_Validation_Request__c.getRecordTypeInfosByName().get('Approved').getRecordTypeId();
        
        for(Client_Validation_Request__c cvr : newrecords){
            accids.add(cvr.Account__c);
            if(cvr.RecordTypeId == Apprvdtrectyp && cvr.Stage__c == null && cvr.Status__c == null){
                cvr.Stage__c = 'Submitted';
                cvr.Status__c = 'Open';
            }
            if(cvr.RecordTypeId == Apprvdtrectyp &&  (cvr.Reference__c == 'Unvalidated' || cvr.Reference__c == 'Revoked')){
                //cvr.RecordTypeid = '0120k0000006Lqw';
                cvr.RecordTypeid = defaultrectype;
            }
        }
        List<Account> ActualAccount = new List<Account>();
        List<Account> RelatedAccounts = new List<Account>();
        List<Contact> RelatedContacts = new List<Contact>();
      
        List<String> AccountIDS = new List<String>();
        List<String> EmailIDS = new List<String>();
        List<String> Phone = new List<String>();
        List<String> Mobile = new List<String>();
        List<String> website = new List<String>();
        List<String> AName = new List<String>();
        List<String> Street = new List<String>();
        ActualAccount = [select Name,AccountID__c,Phone,Website/*,(select Address1__c from Addresses1__r)*/,(select Email,MobilePhone from contacts) from Account where id =: accids];
        for(Account a : ActualAccount){
            AccountIDS.add(a.id);
            AName.add(a.Name);
            if(a.Phone != null && a.phone!='+910000000000')
                Phone.add(a.Phone);
            if(a.Website != null && a.website!='na')
                website.add(a.Website);
            for(Contact c : a.contacts){
                if(c.MobilePhone != null)
                    Mobile.add(c.MobilePhone);
                if(c.Email != null)
                    EmailIDS.add(c.Email);
            }
        }
        system.debug('AccountIDS '+AccountIDS);
        system.debug('AName '+AName );
        system.debug('Phone '+Phone );
        system.debug('website'+website);
        RelatedAccounts = [select id,AccountID__c from Account where id !=: AccountIDS AND Person_Account__c = false AND Case_Accounts__c = false AND (Name =: AName OR Phone =: Phone OR website =: website) limit 100 ];
        
        String RAI;
        for(Account a : RelatedAccounts){
            If(RAI == NULL )
                RAI = a.AccountID__c;
            else if(!RAI.contains(a.AccountID__c))
                RAI = RAI+','+a.AccountID__c;
        }
       for(Client_Validation_Request__c cvr : newrecords){
            cvr.Related_Accounts__c = RAI;
        }
 
    } 
}