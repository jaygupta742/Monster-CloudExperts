public with sharing class EditTargets {
    public Target__c t{get;set;}
    public user u{get;set;}
    public boolean b{get;set;}
    public id recid{get;set;}
    public EditTargets(ApexPages.StandardController controller) {
    
      recid = ApexPages.currentPage().getParameters().get('id');
      t = [SELECT id,name,Start_Date__c,End_Date__c,Unique_Account__c,Free_Trail__c,Demonstration__c,Unique_Opportunity__c,Unique_Connects__c,Unique_Account_Completed__c,Free_Trail_Completed__c,
      Demonstration_Completed__c,Unique_Opportunity_Completed__c,Unique_Connects_Completed__c,Opportunity_Won_Target__c,Opportunity_Created_Achieved__c,Opportunity_Won_Achieved__c,OwnerId
       FROM Target__c WHERE id =:recid];
     
      u = [SELECT id,Lastname,FirstName,ManagerId FROM User where  id = :t.ownerid];
      
      if(u.ManagerId == UserInfo.getUserId()){
          b = true;
      }
     
      
    }

    public pagereference save(){
    
    update t;
    pagereference pf =new pagereference('/'+t.id);
    return pf;
    }
}