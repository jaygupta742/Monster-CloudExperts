/* 
* @ Class Name	: Leads_AddToCampaign_Page_Controller(leadsController)
* @ Objective	: This class is an extension  for VF Page Leads_AddToCampaig_Page
* @ Developer	: Shahid Sangolli 
* @ Test Class 	: Leads_AddToCampaign_Page_Controller_Test
* @ Modified By	: 
*     User Name      |     Modified Date     |     Reason
* ---------------------------------------------------------------
* 	   Shahid               ----------              Intial Creation
*/

public class Leads_AddToCampaign_Page_Controller {
    
    public Leads_AddToCampaign_Page_Controller(ApexPages.StandardController controller) {
        
    }
    
    public List<Leads__c>leads {get;set;}
    public List<String> string_cons {get;set;}
    public String json_val {get;set;}
    
    private ApexPages.StandardSetController standardController;
    private Set <Id> leadIds = new Set <Id>();
    public  Boolean renderMe {get;set;}
    
    //purpose : Passing Selected Lead Ids to LWC Component
    //from where you are calling
    // Start of Leads_AddToCampaign_Page_Controller
    public Leads_AddToCampaign_Page_Controller( ApexPages.StandardSetController standardController ) {
        
        this.standardController = standardController;
        leads = new List<Leads__c>();
        string_cons = new List<String>();
        
        
        for (Leads__c Lead : ( List <Leads__c> )standardController.getSelected() ){
            leadIds.add( Lead.Id );
        }
        
        leads = [ SELECT Id FROM Leads__c WHERE Id IN: leadIds ];
        for(Leads__c c : leads)
        {
            string_cons.add(c.Id);
        }
        json_val= Json.serialize(leads);
        if(string_cons.isEmpty())
        {
            // If Contact Not Selected System show this Message
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Select at least one record and try again.')); 
            
        }
        else{
            renderMe=true;
            
        }
        
    } //EO Leads_AddToCampaign_Page_Controller
}