public class createOpportunity {
    @AuraEnabled
    public static String saveMethod(String oppRecords){
        system.debug(oppRecords);
        OpportunityN__c opp = (OpportunityN__c) JSON.deserialize(oppRecords, OpportunityN__c.class);
        opp.Stage__c = 'Identification';
        String profileName = [ SELECT Profile.Name FROM User  WHERE Id = :UserInfo.getUserId()].Profile.Name;   
        
        if(opp.Price_Master__c != null){
            Price_Master__c priceMaster = [SELECT Id,CurrencyIsoCode FROM Price_Master__c WHERE Id =: opp.Price_Master__c];
            opp.CurrencyIsoCode = priceMaster.CurrencyIsoCode;
        }

        Account acc = [ SELECT Id, AccountStatus__c FROM Account WHERE Id = :opp.Account__c limit 1];        
        opp.Closure_probablity__c = (profileName == 'Monster - Sales Ops/LM' || profileName == 'Monster - Service/CR') ? 'Lead' : 'Prospect';     
        
        //system.debug(acc.AccountStatus__c);
        
        if(profileName=='Monster - Sales Ops/LM' && (acc.AccountStatus__c == 'Lead' || acc.AccountStatus__c == 'Unpromoted')) {  
            acc.AccountStatus__c = 'Need Validation'; update acc;
        }
        insert opp; 
        //  system.debug(opp);
        return opp.Id;
    }
}