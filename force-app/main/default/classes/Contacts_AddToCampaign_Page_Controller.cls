/* 
    * @ Class Name	: Contacts_AddToCampaign_Page_Controller(contactController)
    * @ Objective	: This class is an extension  for VF Page Contacts_AddToCamp_VFPage
    * @ Developer	: Shahid Sangolli 
    * @ Test Class  : Contacts_AddToCampaign_Page_Cntrl_Test
    * @ Modified By	: 
    *     User Name      |     Modified Date     |     Reason
    * ---------------------------------------------------------------
    * 	   Shahid               ----------              Intial Creation
*/


public class Contacts_AddToCampaign_Page_Controller {
    
    public Contacts_AddToCampaign_Page_Controller(ApexPages.StandardController controller) {
    }
    
    public List<Contact>cons {get;set;}
    public List<String> string_cons {get;set;}
    public String json_val {get;set;}
    
    private ApexPages.StandardSetController standardController;
    private Set <Id> contactIds = new Set <Id>();
    public  Boolean renderMe {get;set;}
    
    //purpose : Passing Selected Contact Ids to LWC Component
    //from where you are calling
    // Start of Contacts_AddToCampaign_Page_Controller
    public Contacts_AddToCampaign_Page_Controller( ApexPages.StandardSetController standardController ) {
        
        this.standardController = standardController;
        cons = new List<Contact>();
        string_cons = new List<String>();
        
        
        for (Contact contact : ( List <Contact> )standardController.getSelected() ){
            contactIds.add( contact.Id );
        }
        
        cons = [ SELECT Id, LastName FROM Contact WHERE Id IN: contactIds ];
        for(Contact c : cons){
            string_cons.add(c.Id);
        }
        json_val= Json.serialize(cons);
        System.debug('contacts.......'+json_val);
        
        if(string_cons.isEmpty()){
            // If Contact Not Selected System show this Message
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Select at least one record and try again.')); 
            
        }
        else{
            renderMe=true;
        }
        
    }// EO Contacts_AddToCampaign_Page_Controller
    
}