/* 
        * @ Class Name	: 	CampaignMemberWrapper
        * @ Objective	: 	This class is wrapper class for RESTCampMemUpdateProcess class
        * @ Developer	: 	Sudhir  
        * @ Test Class : 	REST_CampMem_Update_Process_Test
        * @ Modified By: 
        *     User Name      |     Modified Date     |     Reason
        * ---------------------------------------------------------------
        * 	   Sudhir               ----------            Intial Creation
*/


public class CampaignMemberWrapper {
    public String campaignMemberID;
	public String sentDate;
    public String openDate;
    public String clickDate;
    public String bounceDate;
    public String bounceCategory;  
    public String unsubscribedDate;
    public String reason;

	//purpose	: converts json string data to list and returns list
	//parameters: json string data
	//Example	: {"campaignMemberID": "a1I9H0000001ehqUAA__a1K9H0000000CafUAE__0039H000000qwCnQAI", "sentDate": "07-06-2022 23:19", "bounceDate": "01-06-2022 23:19", "bounceCategory": "Soft Bounce", "openDate": "03-06-2022 23:19", "clickDate": "null", "unsubscribedDate": "03-06-2022 23:19"}	
	//			  converts above json string to list of wrapper class
	public static List<CampaignMemberWrapper> parse(String json) {
		return (List<CampaignMemberWrapper>) System.JSON.deserialize(json, List<CampaignMemberWrapper>.class);
	} //EO parse

}