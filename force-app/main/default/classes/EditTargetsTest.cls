@istest
public class EditTargetsTest{
    
    @istest
    public static void editmethod(){
    
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    /*User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', 
    LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', 
    UserName='standarduseratcei@testorg.com');
    insert u; */
    
    User u1 = new User(Alias = 'standt1', Email='standarduser1@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing1', 
    LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', 
    UserName='standarduseratcei1@testorg.com',Managerid=UserInfo.getUserId());
    insert u1;
    
    
    Target__c t = new Target__c();
    t.name = 'Test';
    t.User__c = u1.id;
    t.Start_Date__c = system.today();
    t.End_Date__c = system.today()+3;
    t.Opportunity_Won_Target__c = 100;
    insert t;
   
    
    
        
        PageReference pageRef = Page.EditTarget;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', String.valueOf(t.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        EditTargets ett= new EditTargets(sc);
        
       
        ett.save();
    

}

}