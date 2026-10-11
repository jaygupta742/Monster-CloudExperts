trigger SeekerEscalation on Seeker__c (before insert, after insert, before update) {
    
 Trigger__c t = Trigger__c.getValues('Seeker');
    
   system.debug('customSetting------->'+t);
    if(t.Active__c == true){
     BusinessHours bh1 = [SELECT Id,name FROM BusinessHours WHERE name = 'Seeker'];
      System.debug('Business Hours--->'+bh1);
    if(trigger.isinsert&&trigger.isbefore){
    for(Seeker__c c : trigger.new){
    
    string str = c.Email__c;
    
    boolean b = str.containsIgnoreCase('@foundit'); // 19-dec-2022 replaced monster to foundit
    system.debug('--keyword boolean---'+c.IsKeyword__c);
     
     if(b){
     c.IsKeyword__c = true;
     system.debug('--for monster keyword true from SeekerEscalation trigger---'+c.IsKeyword__c);
     }
  

        c.X1st_Contact_Resolution_SLA__c = BusinessHours.add(bh1.id,system.now(),(18*60*60*1000)); //(18*60*60*1000
        c.X2nd_Escalation__c = BusinessHours.add(bh1.id,system.now(),(27*60*60*1000)); //(27*60*60*1000)
        c.X3rd_Escalation__c = BusinessHours.add(bh1.id,system.now(),(36*60*60*1000)); //(36*60*60*1000
        if(!c.isClosed__c){
        BusinessHours bh;
        c.Escalated_Time__c = BusinessHours.add(bh1.id,system.now(),(18*60*60*1000)); //(18*60*60*1000)
        Long milliseconds = c.Escalated_Time__c.getTime() - system.now().getTime(); 
        Long seconds = milliseconds / 1000;
        Long minutes = seconds / 60;
        Long hours = minutes / 60;
        c.Hours__c = hours ;
        system.debug('Now '+system.now());
        }
    }
    }
    if(trigger.isinsert&&trigger.isAfter){
    for(Seeker__c c : trigger.new){
    
        if(!c.isClosed__c){
        Map<String, Object> params = new Map<String, Object>();
            Seeker_Escalation__c ce1 = Seeker_Escalation__c.getValues('1stescalation');
            params.put('caseid',c.id);
            params.put('ownerid',ce1.UID__c); 
            params.put('toaddress',ce1.Email__c);
            params.put('CaseName',c.Name);
            params.put('waittime',c.Escalated_Time__c);
            Flow.Interview.Seeker_Escalation esc = new Flow.Interview.Seeker_Escalation(params);
            esc.start();
        System.debug('After adding '+c.Escalated_Time__c);
        }
       
    }
    }
   
   
   
   
   if(trigger.isupdate&&trigger.isbefore){
   
    for(Seeker__c c : trigger.new){
        Seeker__c co = Trigger.oldMap.get(c.id);
        datetime d24 = c.CreatedDate.addHours(27);
        datetime d48 = c.CreatedDate.addHours(36); 
        datetime now = system.now();
      /*  datetime d24 = c.CreatedDate.addMinutes(27);
        datetime d48 = c.CreatedDate.addMinutes(36);*/
        system.debug('Now '+system.now()); 
        system.debug('24 '+d24);
        system.debug('48 '+d48);
       
        if(now <= d24 || now <= d48 )
        if(co.Ownerid != c.Ownerid && (!c.isClosed__c)){
        BusinessHours bh;
        if(now <= d24)
        c.Escalated_Time__c = BusinessHours.add(bh1.id,c.CreatedDate,(27*60*60*1000)); //(27*60*60*1000)
        else if(now <= d48)
        c.Escalated_Time__c = BusinessHours.add(bh1.id,c.CreatedDate,(36*60*60*1000)); //(36*60*60*1000)
        Long milliseconds = c.Escalated_Time__c.getTime() - system.now().getTime();
        Long seconds = milliseconds / 1000;
        Long minutes = seconds / 60;
        Long hours = minutes / 60;
        c.Hours__c = hours ;
            Seeker_Escalation__c ce2 = Seeker_Escalation__c.getValues('2ndescalation');
            Seeker_Escalation__c ce3 = Seeker_Escalation__c.getValues('3rdescalation');
        Map<String, Object> params = new Map<String, Object>();
            params.put('caseid',c.id);
            if(now <= d24){
                params.put('ownerid',ce2.UID__c);
                params.put('toaddress',ce2.Email__c);
            }
            else if(now <= d48){
                params.put('ownerid',ce3.UID__c);
                params.put('toaddress',ce3.Email__c);
            }
            params.put('waittime',c.Escalated_Time__c);
            params.put('CaseName',c.Name);
            Flow.Interview.Seeker_Escalation esc = new Flow.Interview.Seeker_Escalation(params);
            esc.start();
        System.debug('After adding '+c.Escalated_Time__c);
    }
    }
    
    }
   }
}