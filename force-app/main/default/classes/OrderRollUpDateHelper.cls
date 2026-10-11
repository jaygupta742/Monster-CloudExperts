/*Created By : Abdul Aziz , Created Date : 25/08/2023 , Description : Helper Class for OrderJobApexSharing Trigger*/
//Contract Start Date : Revised_Service_End_Date__c
//Contract End Date : Order_Service_End_Date__c
public class OrderRollUpDateHelper {
    public static Boolean isFirstRun = true;
    public static void updateAccountServiceStartDate(List<OrderC__c> newOrders) {
        Set<Id> setOfOrderIds = new Set<Id>();
        Set<Id> setOfAccountIds = new Set<Id>();
        for (OrderC__c ord : newOrders) {
            setOfOrderIds.add(ord.id);
        }  
        for (OrderC__c ord : newOrders) {
            setOfAccountIds.add(ord.Account__c);
        }  
        //Account With Order Minimum Start Date
        List<Account> listOfAccountsStartDate=[select id,name,Account_onboarding_date__c,Account_Expiration_Date__c,
                                               (select id,name,Account__c,Order_Start_Date__c from Orders__r order by Order_Start_Date__c asc limit 1)
                                               from Account where id in :setOfAccountIds];
        List<Account> listOfAccount1=new  List<Account>();
        for(Account acc : listOfAccountsStartDate){
            for(OrderC__c order :acc.Orders__r){
                if((order.Account__c==acc.Id && acc.Account_onboarding_date__c==null) || (order.Account__c==acc.Id && acc.Account_onboarding_date__c>order.Order_Start_Date__c)){
                    acc.Account_onboarding_date__c=order.Order_Start_Date__c;
                    listOfAccount1.add(acc);
                }
            }
        }
        try{Database.update(listOfAccount1,false);}   catch(Exception e){}
        
    }
    public static void updateAccountServiceEndDate(List<OrderC__c> newOrders) {
        Set<Id> setOfOrderIds = new Set<Id>();
        Set<Id> setOfAccountIds = new Set<Id>();
        for (OrderC__c ord : newOrders) {
            setOfOrderIds.add(ord.id);
        }  
        for (OrderC__c ord : newOrders) {
            setOfAccountIds.add(ord.Account__c);
        }  
        //Account With Order Maximum End Date 
        List<Account> listOfAccountsEndDate=[select id,name,Account_onboarding_date__c,Account_Expiration_Date__c,
                                             (select id,name,Account__c,Order_Service_End_Date__c from Orders__r order by Order_Service_End_Date__c desc limit 1)
                                             from Account where id in :setOfAccountIds];
        List<Account> listOfAccount2=new  List<Account>();
        for(Account acc : listOfAccountsEndDate){
            for(OrderC__c order :acc.Orders__r){
                if((order.Account__c==acc.Id && acc.Account_Expiration_Date__c==null) || (order.Account__c==acc.Id && acc.Account_Expiration_Date__c<order.Order_Service_End_Date__c)){
                    acc.Account_Expiration_Date__c=order.Order_Service_End_Date__c;
                    listOfAccount2.add(acc);
                }
            }
        }
        try{Database.update(listOfAccount2,false);}   catch(Exception e){}
    }
}