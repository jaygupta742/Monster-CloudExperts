/* 
    * @ Class Name 		: ContactsLwcController
    * @ Objective 		: This class Used For Contact and Contact Controller for LWC Component.
    * @ Developed By 	: Shahid Sangolli
    * @ Code Coverage 	: 92%
    * @ Test Class 		: ContactsLwcController_Test
    * @ Modified By 	: 
    *     User Name      |     Modified Date     |     Reason
    * ---------------------------------------------------------------
    * 	   Shahid               -----------              Intial Creation
*/

public class ContactsLwcController {
    
    @AuraEnabled(cacheable=true)
    public static List<sObject> search(String searchTerm, string myObject, String filter) {
        String myQuery = null;
        if(filter != null && filter != ''){
            myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchTerm + '%\' AND '+filter+' LIMIT  5';
        }
        else {
            if(searchTerm == null || searchTerm == ''){
                myQuery = 'Select Id, Name from '+myObject+' Where CreatedDate != NULL ORDER BY CreatedDate DESC LIMIT  5';
            }
            else {
                myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchTerm + '%\' LIMIT  5';
            }
        }
        List<sObject> lookUpList = database.query(myQuery);
        return lookUpList;
    } // EO search
    
    // This Method Return Contact FirstName and LastName
    @AuraEnabled(cacheable=true)
    public static list<Contact> getContacts(list<Id> cons) 
    {
        return [select FirstName,LastName from Contact where Id IN : cons];
    } // EO getContacts
    
    // This Method Will create Campaign Members in Org
    @AuraEnabled
    public static String  createCampaignMembers(list<Contact> cons,Id camp) 
    {
        List<Campaign_Member__c> DuplicateConList = new List<Campaign_Member__c>();
        for(Contact con : cons){
            DuplicateConList = [ SELECT Id FROM Campaign_Member__c WHERE 
                                Campaign__c =: camp AND Contact__c =: con.Id];
        }
        list<Campaign_Member__c> insertlist=new list<Campaign_Member__c>();
        if(DuplicateConList.isEmpty()){
            for(Contact con : cons)
            {
                Campaign_Member__c member=new Campaign_Member__c();
                member.Campaign__c=camp;
                member.Contact__c = con.Id;
                insertlist.add(member);
            }
            insert insertlist;
            System.debug('camp......'+insertlist);
        }else{
            system.debug('Duplicate Found');
        }
        
        
        return insertlist[0].Id;
    } // EO createCampaignMembers    
    
    // This Method for Lookup data fetching
    @AuraEnabled(cacheable=true)
    public static list<sObject> fetchLookupData(string searchKey , string sObjectApiName) {    
        List < sObject > returnList = new List < sObject > ();
        string sWildCardText = '%' + searchKey + '%';
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Name Like : sWildCardText order by createdDate DESC LIMIT 5';
        for (sObject obj: database.query(sQuery)) {
            returnList.add(obj);
        }
        return returnList;
    }//EO fetchLookupData
    
    // Method to fetch lookup default value 
    @AuraEnabled
    public static sObject fetchDefaultRecord(string recordId , string sObjectApiName) {
        string sRecId = recordId;    
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Id = : sRecId LIMIT 1';
        for (sObject obj: database.query(sQuery)) {
            return obj;
        }
        return null;
    }//EO fetchDefaultRecord
    
}