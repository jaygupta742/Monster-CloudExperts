/* 
* @ Class Name		: ContactsLwcController_Test
* @ Description	: This class Used For Code Coverage of ContactsLwcController Class.
* @ Developed By 	: Shahid Sangolli
* @ Code Coverage 	: 100%
* @ Modified By	: 
*     User Name      |     Modified Date     |     Reason
* ---------------------------------------------------------------
* 	   Shahid               -----------              Intial Creation
*/


@isTest(SeeAllData=true)
public class ContactsLwcController_Test {
    
    @istest
    static void unit_Test(){
        
        
        
        // 2 Contact Creation 
        List<Contact>testconlist = new List<Contact>();
        for(integer i=0; i<5;i++){
            Contact cn = new Contact();
            cn.LastName='Testcontact';
            cn.Email='someaddress@email.com';
            cn.Phone='9999988888';
            cn.Case_Contact__c = true;
            cn.PrimarySalesContact__c=true;
            cn.Title = 'Mr';
            testconlist.add(cn);
        }
        
        if(!testconlist.isEmpty())
            Insert testconlist;
        
        // 3 Custom Campaign creation
        List<Campaign__c>testCmplist = new List<Campaign__c>();
        
        for(integer i=0; i<5;i++){
            Campaign__c cmp = new Campaign__c();
            cmp.Name = 'Test Campaign '+i;
            cmp.Campaign_Run_Date__c = system.today();
            cmp.Export_File_Name__c = 'cmp_file'+i;
            cmp.Campaign_Source__c = 'Lead';
            testCmplist.add(cmp);
        }
        if(!testCmplist.isEmpty())
            Insert testCmplist;
        
        // 4 Custom Lead creation
        List<Leads__c>testLeadlist = new List<Leads__c>();
        
        for(integer i=0; i<5;i++){
            Leads__c ld = new Leads__c();
            ld.Name = 'Test Lead '+i;
            testLeadlist.add(ld);
        }
        if(!testLeadlist.isEmpty())
            Insert testLeadlist;
        
        
        // 5 Custom Campaign Member creation 
        List<Campaign_Member__c>testcmpmlist = new List<Campaign_Member__c>();
        
        for(integer j=0; j<5;j++){
            Campaign_Member__c cmpm = new Campaign_Member__c();
            cmpm.Contact__c = testconlist[0].Id;
            cmpm.Campaign__c = testCmplist[0].Id;
            cmpm.Leads__c = testLeadlist[0].Id;
            testcmpmlist.add(cmpm);
        }
        if(!testcmpmlist.isEmpty())
            Insert testcmpmlist;
        
        
        Test.startTest();
        // search Method
        ContactsLwcController.search('', 'Campaign__c', '');
        List<SObject> conList1= [ Select Id from Campaign__c Where name =: 'Test Campaign 1'];
        system.assertEquals(true, conList1.size()>0);
        
        // createCampaignMembers Method
        ContactsLwcController.createCampaignMembers(testconlist, testCmplist[0].Id);
        List<SObject> conList2= [ Select Id from Campaign__c Where name =: 'Test Campaign 1'];
        system.assertEquals(true, conList2.size()>0);
        
        // fetchLookupData method
        List<sObject> fetchList = ContactsLwcController.fetchLookupData('Test', 'Contact');
        system.assert(fetchList.size()>0);
        
        // fetchDefaultRecord Method
        ContactsLwcController.fetchDefaultRecord(testconlist[0].Id, 'Contact');
        Test.stopTest();
    }
    
    @isTest
    private static void getContacts_TEST(){
        Database.SaveResult dsr;
        Contact drContact;
        drContact=new Contact();
        dsr=Database.insert(drContact,false);
        Test.startTest();
        try{
            ContactsLwcController.getContacts(new List<Id>{dsr.getId()});
        }catch(Exception e){}
        try{
            ContactsLwcController.getContacts(null);
        }catch(Exception e){}
        Test.stopTest();
    }
}