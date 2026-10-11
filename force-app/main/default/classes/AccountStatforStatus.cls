/**
* @File Name          : getAccountStat.cls
* @Description        : 
* @Author             : phUser@phDomain.com
* @Group              : 
* @Last Modified By   : phUser@phDomain.com
* @Last Modified On   : 28/2/2019, 2:53:33 PM
* @Modification Log   : 
*==============================================================================
* Ver         Date                     Author      		      Modification
*==============================================================================
* 1.0    18/2/2019, 5:17:06 PM   phUser@phDomain.com     Initial Version
**/
public  without sharing class AccountStatforStatus{
    @AuraEnabled
    public static Boolean getAccountStat(id accountId){
        try{
            Account account = [select Suspect_Prospect__c from Account where id =: accountId];
            system.debug('SP '+account.Suspect_Prospect__c);
            if(account.Suspect_Prospect__c != null){
                return false;
            }
            else{ 
                return true;
            }
        }
        catch(Exception ex){
            return false;
        }
    }
    @AuraEnabled
    public static List<String> getPickListValuesIntoList(){
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get('Account');
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = Account.Suspect_Prospect__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    @AuraEnabled
    public static String updateAccountStat(id accountId,String accountStat){
        System.debug(accountStat);
        System.debug('Accountid '+accountId);
        try{
            Account a = new Account();
            a.id = accountId;
            a.Suspect_Prospect__c = accountStat;
            update a;
            System.debug('success '+a.Suspect_Prospect__c);
            return 'Success';
        }
        catch(Exception ex){
            System.debug('Error '+ex);
            return 'Error'+string.valueof(ex);
        }
    }
}