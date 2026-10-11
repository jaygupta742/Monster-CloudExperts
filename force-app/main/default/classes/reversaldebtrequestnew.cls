public class reversaldebtrequestnew {
 @AuraEnabled
    public static Reversal_Bad_Debt_Requests__c getOrderObj(String recId){
        Order__c opp = new Order__c();
        opp = [Select Id,Name,Account__c,Xcode__c,Opportunities__c,Price_Master__c,CurrencyIsoCode,Contact__c, Selling_Country__c,
               Account_Type__c,Tax_Percentage__c,Order_Date__c,Gross_Total__c
               from Order__c
               where Id =: recId];
        
        Reversal_Bad_Debt_Requests__c qq = new Reversal_Bad_Debt_Requests__c();
        
        qq.Account__c=opp.Account__c;
       qq.Order__c=opp.id;
        qq.CurrencyIsoCode=opp.CurrencyIsoCode;
        qq.Order_Date__c=opp.Order_Date__c;
        qq.Order_Number__c=opp.Name;
        qq.Order_Value__c=opp.Gross_Total__c;
        qq.Reversal_Amount__c=opp.Gross_Total__c;
       
        return qq;
    }
    @AuraEnabled
    public static string saveQuote(String recId, Reversal_Bad_Debt_Requests__c quo){
        try {
            insert quo;
            
            return recId;
        }
        catch(Exception e) {
            throw new AuraHandledException('Something Went Wrong : '+e.getMessage());
        }
    }
}