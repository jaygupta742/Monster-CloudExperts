/* 
    * @ Test Class Name	: Contacts_AddToCampaign_Page_Cntrl_Test
    * @ Objective		: This class is used cover code coverage of Contacts_AddToCampaign_Page_Controller Class
    * @ Developer		: Shahid Sangolli 
    * @ apex Class 		: Contacts_AddToCampaign_Page_Controller
    * @ Modified By		: 
    *     User Name      |     Modified Date     |     Reason
    * ---------------------------------------------------------------
	* 	   Shahid               		              Intial Creation
*/

@isTest(SeeAllData=true)
public class Contacts_AddToCampaign_Page_Cntrl_Test {
    
    //Global variables
    private static contact objSavings;
    private static List<contact> slist = new List<contact>();
    
    public static testmethod void validateGlobalApprovalPageExtensionOne(){
        
        objSavings = new contact(Lastname='224883',
                                 firstname='aaa',
                                 leadsource='web'
                                );
        insert objSavings;        
        slist.add(objSavings);
        //Instance of class
        ApexPages.StandardSetController standardController = new ApexPages.StandardSetController(slist);
        standardController.setSelected(slist);
        standardController.getSelected();
        ApexPages.StandardController sc = new ApexPages.StandardController(objSavings); 
        Contacts_AddToCampaign_Page_Controller objPageExtension = new Contacts_AddToCampaign_Page_Controller(sc); 
        Contacts_AddToCampaign_Page_Controller objstd = new  Contacts_AddToCampaign_Page_Controller(standardController);
        
    }
}