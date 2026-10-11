global class updateAccountLapsed implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext context) {
        if (Test.isRunningTest()) {
            return Database.getQueryLocator('SELECT Id, Name, AccountStatus__c, Account_Expiration_Date__c, Slippage_End_Date__c FROM Account WHERE Account_Expiration_Date__c < THIS_Quarter AND Account_Expiration_Date__c != null AND AccountStatus__c != \'Lapsed Customer\' AND Slippage_End_Date__c = null LIMIT 1');
        } else {
            return Database.getQueryLocator('SELECT Id, Name, AccountStatus__c, Account_Expiration_Date__c, Slippage_End_Date__c FROM Account WHERE Account_Expiration_Date__c < THIS_Quarter AND Account_Expiration_Date__c != null AND AccountStatus__c != \'Lapsed Customer\' AND Slippage_End_Date__c = null');
        }
    }
    
    global void execute(Database.BatchableContext context, List<Account> personAccounts) {
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : personAccounts) {
            acc.AccountStatus__c = 'Lapsed Customer';
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                Database.update(accountsToUpdate, false); 
            } catch (DmlException e) {
                System.debug('Error during update: ' + e.getMessage());
            }
        }
    }
    
    global void finish(Database.BatchableContext context) {
        System.debug('Batch processing to update Account Status to "Lapsed Customer" is complete.');
    }
}