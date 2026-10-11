public class editalleventsswapnaapex {


public string rid{get;set;}
public string uid{get;set;}
//public account op{get;set;}
public List<event> events{get;set;}
//public list<ID> checkid{get;set;}
//public integer numberOfRowToRemove{get;set;}
//public string rownumber{get;set;}


public editalleventsswapnaapex (){


        rid = ApexPages.Currentpage().getParameters().get('id');
        uid = UserInfo.getUserId();

 //op = [Select id,name from account where id =:rid];
  
  // events =[SELECT Id,subject,Ownerid,WhatId,WhoId,IsAllDayEvent,IsPrivate,StartDateTime,CreatedById,EndDateTime,ActivityDate,Type,location FROM event where CreatedById=:'0057F000003ST4YQAW' and whatId =:rid];
   events =[SELECT Id,subject,Ownerid,WhatId,WhoId,Description,ShowAs,IsAllDayEvent,feedback__c,Description__c,lastmodifiedbyId,Task_Created_by_s_Manager__c,Products__c,EventStatus__c,Remarks__c,ActivityGroup__c,N_ExternalID__c,Assigned_To_C__c,IsPrivate,StartDateTime,CreatedById,EndDateTime,ActivityDate,Type,location FROM event where id =:rid];


}
 public PageReference Save() {
 


         try
         {
             update events;
             System.debug('Saved success');
             return new PageReference('/'+rid);
             
         }
         catch(exception e)
         {
         System.debug('Saved failed'+e.getmessage());
             return null;
             
         }
            
}

public PageReference cancel() {
        return new PageReference('/lightning/r/Event/'+rid);
    }
    
     /*public PageReference removeNewObject()
             {
   
             
             delete events [numberOfRowToRemove];
             //opli.remove(numberOfRowToRemove);
             system.debug('SSSSSSSSSSSSSSS' + numberOfRowToRemove);  
             
             PageReference pr = new PageReference('/apex/editalleventsswapna?id='+rid);   
             pr.setRedirect(true);       
             return pr;  
             
             }*/



}