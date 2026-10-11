trigger UpdatePrimContnSer on Contact (before insert, before update) {

    if (UpdatePrimContnSerHandler.isTriggerExecuted) {
        return; 
    }
    
    UpdatePrimContnSerHandler.isTriggerExecuted = true;
    
    Trigger__c t = Trigger__c.getvalues('Contact');
    
    if (t.Active__c == true) {
        Set<Id> accountIds = new Set<Id>();
        Set<Id> contactIds = new Set<Id>();

        for (Contact c : Trigger.new) {
            accountIds.add(c.AccountId);
            contactIds.add(c.Id);
        }

        List<Contact> existingPrimarySalesContacts = [
            SELECT Id, AccountId, PrimarySalesContact__c, Linkedin_URL__c 
            FROM Contact 
            WHERE AccountId IN :accountIds AND PrimarySalesContact__c = true AND Id NOT IN :contactIds
        ];

        List<AggregateResult> contactCountPerAccount = [
            SELECT AccountId, COUNT(Id) countContacts
            FROM Contact 
            WHERE AccountId IN :accountIds 
            GROUP BY AccountId
        ];

        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();

        for (AggregateResult result : contactCountPerAccount) {
            contactCountMap.put((Id)result.get('AccountId'), (Integer)result.get('countContacts'));
        }

        Map<Id, Contact> primarySalesMap = new Map<Id, Contact>();

        for (Contact contact : existingPrimarySalesContacts) {
            primarySalesMap.put(contact.AccountId, contact);
        }

        List<Contact> contactsToUpdate = new List<Contact>();

        for (Contact newContact : Trigger.new) {

            // If it's the first contact for this account, automatically set it as Primary Sales Contact
            if (!contactCountMap.containsKey(newContact.AccountId) || contactCountMap.get(newContact.AccountId) == 0) {
                newContact.PrimarySalesContact__c = true;
                newContact.PrimaryServiceContact__c = true;
                newContact.PrimaryBillingContact__c = true;
                newContact.Contact_Type__c = 'Primary Sales';
            } 

            // Remove the existing primary sales contact if the new contact takes the place
            if (newContact.PrimarySalesContact__c == true && primarySalesMap.containsKey(newContact.AccountId)) {
                Contact oldPrimary = primarySalesMap.get(newContact.AccountId);
                if (oldPrimary.Id != newContact.Id && oldPrimary.PrimarySalesContact__c == true) {
                    oldPrimary.PrimarySalesContact__c = false;
                    oldPrimary.Linkedin_URL__c = oldPrimary.Linkedin_URL__c == null ? 'N/A' : oldPrimary.Linkedin_URL__c;
                    contactsToUpdate.add(oldPrimary);  // Update the old primary sales contact
                }
            }
        }

        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}