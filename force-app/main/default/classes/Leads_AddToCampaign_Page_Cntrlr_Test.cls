/* 
                 * @ Test Class Name: Leads_AddToCampaign_Page_Cntrlr_Test
                 * @ Objective		: This class is used cover code coverage of Leads_AddToCampaign_Page_Controller Class
                 * @ Developer		: Shahid Sangolli 
                 * @ apex Class 	: Leads_AddToCampaign_Page_Controller
                 * @ Modified By	: 
                 *     User Name      |     Modified Date     |     Reason
                 * ---------------------------------------------------------------
                 * 	   Shahid               		              Intial Creation
*/

@isTest
public class Leads_AddToCampaign_Page_Cntrlr_Test {
    
    //Global variables
    private static Leads__c objSavings;
    private static List<Leads__c> slist = new List<Leads__c>();
    
    //test data setup method
    @testsetup public static void testData(){
        
        objSavings = new Leads__c(Name = 'Test Lead ',
                                               //Last_Name__c = 'Lead ',
                                               Company__c = 'Test Com '
                                 			  // Lead_Status__c = 'New'
                                              );


        insert objSavings;
		
	}
    
    public static testmethod void validateGlobalApprovalPageExtensionOne(){
        testData();

        slist.add(objSavings);

        //Instance of class
        ApexPages.StandardSetController standardController = new ApexPages.StandardSetController(slist);
        standardController.setSelected(slist);
        standardController.getSelected();
        ApexPages.StandardController sc = new ApexPages.StandardController(objSavings); 
        Leads_AddToCampaign_Page_Controller objPageExtension = new Leads_AddToCampaign_Page_Controller(sc); 
        Leads_AddToCampaign_Page_Controller objstd = new  Leads_AddToCampaign_Page_Controller(standardController);
       
    }
    
}