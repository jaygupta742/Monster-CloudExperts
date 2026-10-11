/* 
* @ Class Name		: Leads_Lwc_Controller_Test
* @ Description		: This class Used For Code Coverage of Leads_Lwc_Controller Class.
* @ Developed By	: Shahid Sangolli
* @ Code Coverage 	: 100%
* @ Modified By		: 
*     User Name      |     Modified Date     |     Reason
* ---------------------------------------------------------------
* 	   Shahid               -----------              Intial Creation
*/


@isTest(SeeAllData=true)
public class LeadsLwcController_Test {
    @istest
    static void test_Leads(){
        Test.startTest();
        
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
        
        Insert testcmpmlist;
        
        // createCampaignMembers Method
        LeadsLwcController.createCampaignMembers(testLeadlist, testCmplist[0].Id);
        Test.stopTest();
        List<SObject> CmList2= [ Select Id from Campaign_Member__c];
        system.assertEquals(true, CmList2.size()>0);
        
    }
    
}