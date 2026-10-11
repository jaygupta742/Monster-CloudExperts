global class BatchApexForAccount_task implements Database.Batchable<sObject>, Database.Stateful{
    map<id,id> standarduser=new map<id,id>();
    map<id,string> customuser=new map<id,string>();
    
   global Database.QueryLocator start(Database.BatchableContext BC){
    
    for(user u:[select id,N_ExternalID__c from user])
    {
    
        standarduser.put(u.N_ExternalID__c ,u.id);
        
    
    }
    
    for(User__c uu:[select id,First_Name__c,Name,N_ExternalID__c from User__c ])
    {
    string s=uu.First_Name__c+''+uu.name;
    customuser.put(uu.N_ExternalID__c ,s);
    
    }
    
      // String query = 'select id,name,Ownerid,Lead_Account_Status__c,Active__c,LastModifiedById,CreatedById,CreatedDate,BillingCity,BillingCountry,BillingState,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingState,ShippingStreet,ShippingPostalCode,BillingAddress,ShippingAddress from Account where id=\'0010k00000gxFF8\' Order by CreatedDate ASC';
      
       String query = 'select id,ActivityGroup__c,ActivitySubType__c,IsAllDayEvent__c,createddate,lastmodifieddate,Assigned_To_C__c,ArchivalStatus__c,CallDurationInSeconds__c,CallObject__c,CallDisposition__c,CallType__c,Comments__c,CompletionDate__c,ContactJobPosition__c,ContactPhone__c,ContactType__c,IsRecurrence__c,ActivityDate__c,DateAndTimeStamp__c,Description__c,Description1__c,DurationInMinutes__c,Email__c,EndDateTime__c,EventStatus__c,EventSubtype__c,IsEvent__c,Last_Modified_Timestamp__c,Legacy_Activity_ID__c,Location__c,N_ExternalID__c,Old_Created_Date__c,Old_Created_User__c,Old_Last_Modified_Date__c,Phone__c,Priority__c,IsPrivate__c,RecurrenceInterval__c,Reference_Account__c,Remarks__c,IsReminderSet__c,RecurrenceRegeneratedType__c,Result__c,ShowAs__c,StartDateTime__c,Status__c,Subject__c,TaskSubtype__c,Task_Type__c,ActivityDateTime__c,Type__c,Valid_Sales_Activity__c,Valid_Sales_Activity_Owner__c,OwnerId,CreatedByid,Task_Due_Date__c,LastModifiedByid,Who_Contact__c,What_Account__c,ActivityType__c from Events__c WHERE CALENDAR_YEAR(CreatedDate) > 2014';
       return Database.getQueryLocator(query);
   }
   
   global void execute(Database.BatchableContext BC, List<Events__c> scope){
      
  list<task> tt=new list<task>();
       
     
                   for(Events__c e:scope )
                   {
                   task t=new task();
                   //seetharam map substitute
                   
                  // t.Ownerid = e.ownerid;
                    t.CallDurationInSeconds =integer.valueof( e.CallDurationInSeconds__c);
                    t.CallObject = e.CallObject__c;
                    t.CallDisposition = e.CallDisposition__c;
                    t.CallType = e.CallType__c;
                    t.Description = e.Description__c;
                    t.CreatedByid = e.CreatedByid;
                    t.IsRecurrence = e.IsRecurrence__c;
                    t.ActivityDate = date.valueof(e.ActivityDate__c);
                    t.createddate = e.createddate;
                    t.lastmodifieddate = e.lastmodifieddate;
                  //  t.Email = e.Email__c;
                    t.LastModifiedByid = e.LastModifiedByid;
                    t.Whoid = e.Who_Contact__c;
                   // t.Phone = e.Phone__c;
                    t.Priority = e.Priority__c;
                    t.RecurrenceInterval = integer.valueof(e.RecurrenceInterval__c);
                    t.Whatid = e.What_Account__c;
                    t.IsReminderSet = e.IsReminderSet__c;
                    t.RecurrenceRegeneratedType = e.RecurrenceRegeneratedType__c;
                    t.Status = e.Status__c;
                    t.Subject = e.Subject__c;
                    t.TaskSubtype = e.TaskSubtype__c;
                    t.Type = e.Type__c;
                    
                    //Activity Custom fields
                    t.ActivityGroup__c = e.ActivityGroup__c;
                    t.ActivitySubType__c = e.ActivitySubType__c;
                    t.ActivityType__c = e.ActivityType__c;
                    t.ArchivalStatus__c = e.ArchivalStatus__c;
                    t.Comments__c = e.Comments__c;
                    t.CompletionDate__c = e.CompletionDate__c;
                    t.ContactJobPosition__c = e.ContactJobPosition__c;
                    t.ContactPhone__c = e.ContactPhone__c;
                    t.ContactType__c = e.ContactType__c;
                    t.DateAndTimeStamp__c = e.DateAndTimeStamp__c;
                    t.Description__c = e.Description1__c;
                    t.EventStatus__c = e.EventStatus__c;
                    t.Last_Modified_Timestamp__c = e.Last_Modified_Timestamp__c;
                    t.Legacy_Activity_ID__c = e.Legacy_Activity_ID__c;
                    t.N_ExternalID__c = e.N_ExternalID__c;
                    t.Old_Created_Date__c = e.Old_Created_Date__c;
                    t.Old_Created_User__c = e.Old_Created_User__c;
                    t.Old_Last_Modified_Date__c = e.Old_Last_Modified_Date__c;
                    t.ReferenceAccount__c = e.Reference_Account__c;
                    t.Remarks__c = e.Remarks__c;
                    t.Result__c = e.Result__c;
                    t.Task_Type__c = e.Task_Type__c;
                    t.Valid_Sales_Activity__c = e.Valid_Sales_Activity__c;
                    t.Valid_Sales_Activity_Owner__c = e.Valid_Sales_Activity_Owner__c;
                        
                      if(standarduser.get(e.Assigned_To_C__c) !=null)
                      {
                      
                      
                      
                      t.Ownerid=standarduser.get(e.Assigned_To_C__c);
                      
                      }
                      else
                      {
                      
                      t.Assigned_To_C__c=customuser.get(e.Assigned_To_C__c);
                      
                      }
                                    
                   
                   
                   
                   tt.add(t);
                   }
     
           
           
          database.insert(tt,false);
   }

global void finish(Database.BatchableContext BC){
  
  
}

}