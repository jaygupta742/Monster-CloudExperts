public class contactTriggerHandler {
    
    public static Boolean handleContactRoolupToAccountRecursion = false;
    
    public static void handleContactRoolupToAccount(List<Contact> contactNewList, List<Contact> contactOldList, Map<Id, Contact> contactMap, String method) {
        Set<Id> accountIds = new Set<Id>();
        
        if (method == 'Delete') {
            for (Contact con : contactOldList) {
                if (con.AccountId != null) {
                    accountIds.add(con.AccountId);
                }
            }
        } else {
            for (Contact con : contactNewList) {
                if (con.AccountId != null) {
                    if (method == 'Update' && contactMap.containsKey(con.Id) && con.ContactStatus__c != contactMap.get(con.Id).ContactStatus__c) {
                        accountIds.add(con.AccountId);
                    } else if (method == 'Insert') {
                        accountIds.add(con.AccountId);
                    }
                }
            }
        }
        
        if (!accountIds.isEmpty()) {
            Map<Id, Integer> activeContactCounts = new Map<Id, Integer>();
            for (AggregateResult ar : [
                SELECT AccountId, COUNT(Id) totalActiveContacts
                FROM Contact
                WHERE AccountId IN :accountIds
                AND (ContactStatus__c = 'Active' OR ContactStatus__c = null)
                GROUP BY AccountId
            ]) {
                activeContactCounts.put((Id)ar.get('AccountId'), (Integer)ar.get('totalActiveContacts'));
            }
            
            List<Account> accountsToUpdate = new List<Account>();
            for (Id accountId : accountIds) {
                Integer count = activeContactCounts.get(accountId);
                Account acc = new Account(Id = accountId);
                acc.Active_Contacts__c = count != null ? count : 0;
                accountsToUpdate.add(acc);
            }
            
            if (!accountsToUpdate.isEmpty()) {
                if (!handleContactRoolupToAccountRecursion) {
                    handleContactRoolupToAccountRecursion = true;
                    try {
                        update accountsToUpdate;
                    } catch (DmlException e) {
                        System.debug('Error updating accounts: ' + e.getMessage());
                    } finally {
                        handleContactRoolupToAccountRecursion = false;
                    }
                }
            }
        }
    }
}