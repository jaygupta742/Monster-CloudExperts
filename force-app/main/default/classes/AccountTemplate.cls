public class AccountTemplate {

public id recid;
public boolean b{get;set;}
public   list<contact> c{get;set;}
//public   list<Address1__c> add{get;set;}

    public AccountTemplate(ApexPages.StandardController controller) {
    b = false;
    recid = ApexPages.currentPage().getParameters().get('id');
  c = [SELECT id from contact WHERE accountid = :recid];
  //add = [SELECT id from Address1__c WHERE Account__c = :recid];  
  
  /*if(c.size() > 0 && add.size() > 0){
  b = true;*/
  }
  

    }