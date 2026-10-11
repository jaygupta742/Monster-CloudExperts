@isTest(seeAllData=true)
public class AccountOwnerChange_Test {
@isTest
    public static void praxownchng(){
        Account a = new account();
        a.Integration__c = true;
        a.Name = 'pramodh';
        insert a;
        list<String> la = new List<String>();
        la.add(a.Id);
        AccountOwnerChange.ownerchange(la,'0057F000003SQ1N');
    }
}