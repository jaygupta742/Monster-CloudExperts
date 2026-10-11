@isTest
public class shareopportunity_test {
    public static testmethod void test( ){
        list<Account_Team_Member__c> at= new list<Account_Team_Member__c>();
        
        for(integer i = 0;i<200;i++){
            Account_Team_Member__c a = new Account_Team_Member__c();
            a.Sales_Channel__c = 'ECOMM';
            a.Segment__c = 'ECOMM';
            at.add(a);
        }
        insert at;
    }

}