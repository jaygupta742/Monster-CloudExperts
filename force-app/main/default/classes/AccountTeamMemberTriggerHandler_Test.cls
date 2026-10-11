@isTest 
public class AccountTeamMemberTriggerHandler_Test {
    @isTest public static void mytest(){
 String ids=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Monster In-Active Account').getRecordTypeId();
        
user u = new user();
  u =  [SELECT id from user where IsActive=true and Alias!= 'ZThom' and profile.name='Monster-Sales' limit 1];
        system.debug('user'+u.id);
        Account a = new Account();
        a.RecordTypeId= ids;
        a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='Philippines';
        a.Website='www.asdfert.com';
        a.Phone= '+7878787878';
        a.OtherPhone__c = '+78787878782';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.Segment__c='ECOMM';
        a.Lead_Source1__c = 'ECOMM';
    //  a.OwnerId = u.id;
        insert a;
       
         Account_Team_Member__c atm1=[select id from  Account_Team_Member__c where AccountId__c=:a.id];
     
        try{delete atm1;}
        catch(Exception e)
        {
            Boolean excep =  e.getMessage().contains('You cannot delete this Team Member') ? true : false;
		System.assertEquals(excep, true);
            
        }
    
        Opportunity__c opp = new Opportunity__c();
        opp.Name__c=a.Name;
        opp.Account__c= a.id;
        opp.Close_Date__c= System.today()+5;
        opp.OpportunityType__c='International';
        opp.Amount__c=5000000;
        opp.Organization__c = 'Europe';
        opp.Stage__c='Identification';
        // opp.OwnerId = u.id;
        Insert opp;
        
         Account_Team_Member__c atm= new Account_Team_Member__c();
        atm.AccountId__c= a.id;
        atm.CurrencyIsoCode= 'USD';
        atm.Sales_Channel__c ='ECOMM';
        atm.Segment__c='ECOMM';
       atm.Opportunity__c=opp.id;
        atm.UserId__c=u.id;
        insert atm;
        
       update atm;
 
        //undelete atm;
        
       //  Opportunity__share jo = new Opportunity__share();
       // jo.AccessLevel='Read';
       // jo.UserOrGroupId=atm.UserId__c;
      //  jo.ParentID=atm.Opportunity__c;
        
      //  insert jo;
        
        Map<ID, Account_Team_Member__c> m = new Map<ID, Account_Team_Member__c>();       
        List<Account_Team_Member__c> acctm = [select id,AccountId__c,UserId__c,AccountOwnerID__c from Account_Team_Member__c where AccountId__c = :a.Id];
        AccountTeamMemberTriggerHandler handler = new AccountTeamMemberTriggerHandler();
        

    }

}