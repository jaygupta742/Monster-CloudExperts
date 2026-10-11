trigger UpdateOppStage on Event (before insert,before update) {
    
    string upid = userinfo.getProfileId();
    //User u =[select Id,Name,ProfileId from User where ProfileId='00e7F000000uSSh' limit 1];
    //system.debug('The user isssssssssss'+u)
    System.debug('User id isssssssssssssssssssssssssssss'+upid);
    
    
    set<id> oppid = new set<id>();
    String OpportunityPrefix = Opportunity__c.SObjectType.getDescribe().getKeyPrefix();
    for(Event e : Trigger.new){
        if (e.whatId != null && string.valueOf(e.whatId).startsWith(Opportunityprefix) && e.Subject=='Demonstration' && e.EventStatus__c == 'Completed' ) {
            oppid.add(e.WhatId);
        }
    }
  
    //Pramodh
    if(Trigger.isInsert){
    for(Event e : Trigger.new){
        if(upid == '00e7F000000uSShQAM')
            e.Subject = e.Subject__c;
    }
    }
    //Pramodh
    for(Event e : Trigger.new){
      if(Trigger.isInsert){
        if ((e.whatId == null || !string.valueOf(e.whatId).startsWith(Opportunityprefix)) && e.Subject=='Demonstration'&& upid =='00e7F000000uSShQAM' ) {
            e.whatId.adderror('Please Choose the opportunity for which demonstration is being created');
        }
        }
    }

   List<Opportunity__c> lopp = new List<Opportunity__c>([select id,Stage__c from Opportunity__c where id =: oppid]);
    /*for(Opportunity__c o : lopp){ -- Nag(Opp enhancement)
        o.Stage__c = 'Need Analysis';
        o.Probability__c = '10';
    }*/
    database.update(lopp,false);
    
    If(Trigger.isUpdate&&Trigger.isbefore){
        for(Event t : Trigger.new){
            Event t1 = Trigger.oldmap.get(t.Id);
            string upid = userinfo.getProfileId();
            if(upid == '00e7F000000uSShQAM' && t1.EventStatus__c == 'Completed')
                t.adderror('You cannot edit Closed Activity');
            
            
        }   
    }
 //added @yam
   if(Trigger.isInsert&&Trigger.isbefore)
   {
       for(Event te : trigger.new)
       {
           string s1 = string.valueof(te.StartDateTime);
           System.debug('This is S1------>'+s1);
           string s2 = s1.substring(0,10);
           System.debug('This is S2------>'+s2);
           string s3 = string.valueof(system.today());
           System.debug('This is S3----->'+s3);
           
          string e1 = string.valueOf(te.EndDateTime);
           System.debug('This is e1------>'+e1);
           string e2 = e1.substring(0,10);
           System.debug('This is e2------>'+e2);
           
          if(s2 < s3 || e2 < s3)
          {
              te.adderror('Start And End Date Cannot Be Less Than Today..');
          }
        
       }
   }
}