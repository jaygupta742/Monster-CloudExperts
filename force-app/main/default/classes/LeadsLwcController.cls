/* 
		 * @ Class Name		: leadsLwcController
		 * @ Objective		: This class Used For Custom Campaign and Lead Controller for LWC Component.
		 * @ Developed By	: Shahid Sangolli
		 * @ Code Coverage 	: 100%
		 * @ Test Class 	: LeadsLwcController_Test
		 * @ Modified By	: 
		 *     User Name      |     Modified Date     |     Reason
		 * ---------------------------------------------------------------
		 * 	   Shahid               -----------              Intial Creation
*/

public class LeadsLwcController {

    
    @AuraEnabled(cacheable=true)
    public static list<Leads__c> getLeads(list<Id> leads) 
    {
        return [SELECT Id from Leads__c where Id IN : leads];
    } //EO getLeads
    
   
    @AuraEnabled
    public static String  createCampaignMembers(list<Leads__c> leads,Id camp) 
    {
        List<Campaign_Member__c> DuplicateLeadList = new List<Campaign_Member__c>();
        for(Leads__c ld : leads){
            DuplicateLeadList = [ SELECT Id FROM Campaign_Member__c WHERE 
                                 Campaign__c =: camp AND Leads__c =: ld.Id];
        }
        list<Campaign_Member__c> insertlist=new list<Campaign_Member__c>();
        if(DuplicateLeadList.isEmpty()){
            
            for(Leads__c ld : leads){
                Campaign_Member__c member=new Campaign_Member__c();
                member.Campaign__c=camp;
                member.Leads__c = ld.Id;
                insertlist.add(member);
            }

            insert insertlist;
            System.debug('camp......'+insertlist);
        }else{
            system.debug('Duplicate Found');
        }
        return insertlist[0].Id;              
    } // EO createCampaignMembers
}