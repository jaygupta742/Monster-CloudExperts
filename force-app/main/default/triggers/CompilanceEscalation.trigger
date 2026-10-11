trigger CompilanceEscalation on Compliance__c (before insert, after insert, before update) {
    
    trigger__c t = [SELECT id,name,Active__c FROM trigger__c WHERE name='Compliance'];
    system.debug('customSetting------->'+t);
    if(t.Active__c == true){
        
        BusinessHours bh1 = [SELECT Id,name FROM BusinessHours WHERE name = 'Compliance'];
        System.debug('Business Hours--->'+bh1);
        
        DateTime myDateTime = system.now();
        DateTime newDateTime = myDateTime.addHours(5);
        DateTime FinalDateTime = newDateTime.addMinutes(30);
        
        system.debug('myDateTime----> '+myDateTime);
        system.debug('newDateTime---> '+newDateTime);
        system.debug('FinalDateTime---> '+FinalDateTime);
        
        
        if(trigger.isinsert&&trigger.isbefore){
            for(Compliance__c c : trigger.new){
                 
                // c.X1st_Contact_Resolution_SLA__c = BusinessHours.add(bh1.id,system.now(),(24*60*60*1000)); //24 Hours
                c.X1st_Contact_Resolution_SLA__c = BusinessHours.add(bh1.id,system.now(),(18*60*60*1000)); //18 Hours
                // c.X1st_Contact_Resolution_SLA__c = BusinessHours.add(bh1.id,system.now(),(5*60*1000));
                
                
                // c.X2nd_Escalation__c= BusinessHours.add(bh1.id,system.now(),(36*60*60*1000)); // 36 Hours
                c.X2nd_Escalation__c= BusinessHours.add(bh1.id,system.now(),(27*60*60*1000));
                //   c.X2nd_Escalation__c= BusinessHours.add(bh1.id,system.now(),(10*60*1000));
                
                
                if(!c.isClosed__c){
                    BusinessHours bh;
                    c.Escalated_Time__c = BusinessHours.add(bh1.id,system.now(),(18*60*60*1000)); //24 Hours
                    //  c.Escalated_Time__c = BusinessHours.add(bh1.id,system.now(),(5*60*1000));
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
            for(Compliance__c c : trigger.new){
                
                if(!c.isClosed__c){
                    Map<String, Object> params = new Map<String, Object>();
                    Compliance_Escalation__c ce1 = Compliance_Escalation__c.getValues('1stescalation');
                    params.put('caseid',c.id);
                    params.put('ownerid',ce1.UID__c); 
                    params.put('toaddress',ce1.Email__c);
                    params.put('CaseName',c.Name);
                    params.put('waittime',c.Escalated_Time__c);
                    Flow.Interview.Compilance_Escalation esc = new Flow.Interview.Compilance_Escalation(params);
                    esc.start();
                    System.debug('After adding '+c.Escalated_Time__c);
                }
                
            }
        }
        
        
        
        
        if(trigger.isupdate&&trigger.isbefore){
            
            for(Compliance__c c : trigger.new){
                
                /*Always update closed date if case is closed first time*/
                if(Trigger.oldMap.get(c.Id).Status__c != c.Status__c && c.Status__c == 'Closed' && c.ReOpened__c==false)
                {
                    c.Case_Closed_By__c = userinfo.getUserId();
                }
                /*Always update ReOpen date and checkbox ReOpened__c true if case is ReOpen*/
                if(Trigger.oldMap.get(c.Id).Status__c != c.Status__c && c.Status__c == 'Reopen')
                {
                    c.ReOpened__c=true;
                }
                /*Always update ReClosed time if case is closed more than one time*/
                if(Trigger.oldMap.get(c.Id).Status__c != c.Status__c && c.Status__c == 'Closed' && c.ReOpened__c==true)
                {
                    c.Reopen_Case_Closed_By__c = userinfo.getUserId();
                }

                
                
                Compliance__c co = Trigger.oldMap.get(c.id);
                datetime d36 = c.CreatedDate.addHours(36);
                
                datetime now = system.now();
                /*  datetime d24 = c.CreatedDate.addMinutes(4);*/
                system.debug('Now '+system.now());
                system.debug('36 ---> '+d36);
                //  datetime now = system.now();
                
                if(now <= d36 )
                    if(co.Ownerid != c.Ownerid && (!c.isClosed__c)){
                        BusinessHours bh;
                        /*if(now <= d24)
c.Escalated_Time__c = BusinessHours.add('01m7F0000006oo6',c.CreatedDate,(24*60*60*1000));
else if(now <= d48)
c.Escalated_Time__c = BusinessHours.add('01m7F0000006oo6',c.CreatedDate,(48*60*60*1000));*/
                        
                        if(now <= d36)
                            c.Escalated_Time__c = BusinessHours.add(bh1.id,c.CreatedDate,(27*60*60*1000)); // 36 Hours
                        //  c.Escalated_Time__c = BusinessHours.add(bh1.id,c.CreatedDate,(10*60*1000)); 
                        Long milliseconds = c.Escalated_Time__c.getTime() - system.now().getTime();
                        Long seconds = milliseconds / 1000;
                        Long minutes = seconds / 60;
                        Long hours = minutes / 60;
                        c.Hours__c = hours ;
                        
                        Compliance_Escalation__c ce2 = Compliance_Escalation__c.getValues('2ndescalation');
                        
                        Map<String, Object> params = new Map<String, Object>();
                        params.put('caseid',c.id);
                        if(now <= d36){
                            params.put('ownerid',ce2.UID__c);
                            params.put('toaddress',ce2.Email__c);
                        }
                        params.put('waittime',c.Escalated_Time__c);
                        params.put('CaseName',c.Name);
                        Flow.Interview.Compilance_Escalation esc = new Flow.Interview.Compilance_Escalation(params);
                        esc.start();
                        System.debug('After adding '+c.Escalated_Time__c);
                    }
            }
            
        }
        
    }
    
}