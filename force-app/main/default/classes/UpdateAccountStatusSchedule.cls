/*
Last Modified By		Last Modified Date			Description
Gaurav Parate			05/04/2023					Updated Functionality to Update Account Status as per 2 related Orders Contract Close Date
Abdul Aziz				13/12/2023					Added updateAccountStatusLapsed function
Debasis Das				13/05/2023					Status of an Account will be called "Slippage: if today > Expiration Date and today <= "End Date of Qtr(Account Expiration Date) + 30"
*/

global class UpdateAccountStatusSchedule Implements Schedulable{
    global void execute(SchedulableContext sc) {
        updateAccountStatusLapsed();
    }
    
    public void updateAccountStatusLapsed() {
        List<Account> UpdateToSlippage = new List<Account>();
        UpdateToSlippage = [SELECT Id, Name, AccountStatus__c, Account_Expiration_Date__c, Slippage_End_Date__c
                            FROM Account WHERE Account_Expiration_Date__c =: Date.today().addDays(-1) OR Account_Expiration_Date__c =: Date.today().addDays(-2)];
        
        List<Account> UpdateToLapsed = new List<Account>();
        UpdateToLapsed = [SELECT Id, Name, AccountStatus__c, Account_Expiration_Date__c, Slippage_End_Date__c
                          FROM Account WHERE Slippage_End_Date__c =: Date.today().addDays(-1) OR Slippage_End_Date__c =: Date.today().addDays(-2)];

        for(Account acc : UpdateToSlippage){
            acc.AccountStatus__c = 'Slippage';
            // Calculate the current quarter's end date of Account_Expiration_Date__c
            Date expirationDate = acc.Account_Expiration_Date__c;
            Integer quarter = (Integer)Math.floor((expirationDate.month() - 1) / 3);
            Date quarterEndDate = Date.newInstance(expirationDate.year(), ((quarter + 1) * 3) + 1, 1).addDays(-1);
            
            // Add 30 days to the current quarter's end date
            Date slippageEndDate = quarterEndDate.addDays(30);
            acc.Slippage_End_Date__c = slippageEndDate;
        }
        if(UpdateToSlippage.size() > 0) update UpdateToSlippage;

        for(Account acc : UpdateToLapsed) {
            acc.AccountStatus__c = 'Lapsed Customer';
        }
        if(UpdateToLapsed.size() > 0) update UpdateToLapsed;
    }
}