trigger forescalation on Case__c (before insert, after insert, before update) {
    
    Trigger__c t = Trigger__c.getValues('Case');
    
   system.debug('customSetting------->'+t);
    if(t.Active__c == true){
        
      
        //used to send email template by @imRam
     List<OrgWideEmailAddress> OWEA = [SELECT Address,DisplayName,Id FROM OrgWideEmailAddress WHERE Address='customerservice@monsterindia.com'];
          system.debug('owea--->'+owea);
        /*  List<Messaging.SingleEmailMessage> multipleM = new List<Messaging.SingleEmailMessage>();
        EmailTemplate temp = [SELECT id, name,Description  FROM EmailTemplate WHERE Description ='RajSurveyMonkeyEmployer'];
      System.debug('tmp size-->'+temp);*/
        
        
        
     BusinessHours bh1 = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
      
    if(trigger.isinsert&&trigger.isbefore){
    for(Case__c c : trigger.new){
  

        c.X1st_Escalation__c = BusinessHours.add(bh1.id,system.now(),(4*60*60*1000));
        c.X2nd_Escalation__c = BusinessHours.add(bh1.id,system.now(),(12*60*60*1000));
        c.X3rd_Escalation__c = BusinessHours.add(bh1.id,system.now(),(24*60*60*1000));
        if(!c.isClosed__c){
        BusinessHours bh;
        c.Escalated_Time__c = BusinessHours.add(bh1.id,system.now(),(4*60*60*1000));
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
    for(Case__c c : trigger.new){
    
        if(!c.isClosed__c){
        Map<String, Object> params = new Map<String, Object>();
            Case_Escalation__c ce1 = Case_Escalation__c.getValues('1stescalation');
            params.put('caseid',c.id);
            params.put('ownerid',ce1.UID__c); 
            params.put('toaddress',ce1.Email__c);
            params.put('CaseName',c.Name);
            params.put('waittime',c.Escalated_Time__c);
            Flow.Interview.Case_Escalation esc = new Flow.Interview.Case_Escalation(params);
            esc.start();
        System.debug('After adding '+c.Escalated_Time__c);
        }
       
    }
    }
   
   
   
   
   if(trigger.isupdate&&trigger.isbefore){
   
    for(Case__c c : trigger.new){
        
      
        
        Case__c co = Trigger.oldMap.get(c.id);
        /*datetime d24 = c.CreatedDate.addHours(24);
        datetime d48 = c.CreatedDate.addHours(48);
        datetime now = system.now();*/
      /*  datetime d24 = c.CreatedDate.addMinutes(4);
        datetime d48 = c.CreatedDate.addMinutes(7);*/
        
        datetime d24 = c.CreatedDate.addHours(12);
        datetime d48 = c.CreatedDate.addHours(24);
        system.debug('Now '+system.now());
        system.debug('24 '+d24);
        system.debug('48 '+d48);
        datetime now = system.now();
        if(now <= d24 || now <= d48 )
        if(co.Ownerid != c.Ownerid && (!c.isClosed__c)){
        BusinessHours bh;
        /*if(now <= d24)
        c.Escalated_Time__c = BusinessHours.add('01m7F0000006oo6',c.CreatedDate,(24*60*60*1000));
        else if(now <= d48)
        c.Escalated_Time__c = BusinessHours.add('01m7F0000006oo6',c.CreatedDate,(48*60*60*1000));*/
        if(now <= d24)
        c.Escalated_Time__c = BusinessHours.add(bh1.id,c.CreatedDate,(12*60*60*1000));
        else if(now <= d48)
        c.Escalated_Time__c = BusinessHours.add(bh1.id,c.CreatedDate,(24*60*60*1000));
        Long milliseconds = c.Escalated_Time__c.getTime() - system.now().getTime();
        Long seconds = milliseconds / 1000;
        Long minutes = seconds / 60;
        Long hours = minutes / 60;
        c.Hours__c = hours ;
            Case_Escalation__c ce2 = Case_Escalation__c.getValues('2ndescalation');
           // Case_Escalation__c ce3 = Case_Escalation__c.getValues('3rdescalation');
        Map<String, Object> params = new Map<String, Object>();
            params.put('caseid',c.id);
            if(now <= d24){
                params.put('ownerid',ce2.UID__c);
                params.put('toaddress',ce2.Email__c);
            }
           /* else if(now <= d48){
                params.put('ownerid',ce3.UID__c);
                params.put('toaddress',ce2.Email__c);
            } */
            params.put('waittime',c.Escalated_Time__c);
            params.put('CaseName',c.Name);
            Flow.Interview.Case_Escalation esc = new Flow.Interview.Case_Escalation(params);
            esc.start();
        System.debug('After adding '+c.Escalated_Time__c);
    }
        
        string emailStr = c.SuppliedEmail__c;
          boolean monEmail = false; 
        
        if(emailStr!= NULL){
          //  monEmail = emailStr.containsIgnoreCase('@monster');
             monEmail = emailStr.containsIgnoreCase('@foundit');  //19-dec-2022 replaced monster to foundit
        }
        
        system.debug('---monster email ---'+monEmail);
        
                if(c.Status__c == 'Closed' && c.Category__c =='Employer' && C.Keyword_Search__c == TRUE && monEmail == false){
                    //19-dec-2022 added 'MSJ / Foundit Social Job
                    if(c.Issue__c == 'Job posting Issue' ||  c.Issue__c == 'Login Issue' || c.Issue__c == 'Resume Search Issue' || c.Issue__c == 'Excel Download' ||  c.Issue__c == 'Mass mailing' || c.Issue__c == 'Recruiter Profile' || c.Issue__c == 'Technical Issue' || c.Issue__c == 'Site Issue' || c.Issue__c == 'Compliance (Inventory related)' || c.Issue__c == 'Branding' || c.Issue__c == 'Training Request' || c.Issue__c == 'Account activation / E-Com Orders' || c.Issue__c == 'TalentBin' || c.Issue__c == 'MSJ / Monster Social Job' ||  c.Issue__c == 'MSJ / Foundit Social Job' || c.Issue__c == 'SMS Service' || c.Issue__c == 'SMS Service' || c.Issue__c == 'Other Employer Queries' ){
                      
                        string m1 = string.valueOf(c.Employer_Mail_Sent_Date__c); //get surveymonkeydate__c for employeer & Seeker1
              system.debug('m1 --->'+m1);
              string m11 ;
              if(m1 != NULL){m11 = m1.substring(0,7);}
              
              string m2 = string.valueof(system.today());
              string m22 = m2.substring(0,7);
              
                system.debug('m11 --->'+m11);
                system.debug('m22 --->'+m22);
                        
              /*  if(m11 != m22 || m1 == NULL ){
                    
                Messaging.SingleEmailMessage singleM = new Messaging.SingleEmailMessage();
                            
                     singleM.setTemplateId(temp.id);
                     singleM.setTargetObjectId(c.Contact__c); //tt.RelationId
                    // singleM.setSaveAsActivity(true);
                     singleM.setSaveAsActivity(true);
                    // singleM.setSenderDisplayName('Monster Customer Service Team');
                     SingleM.setOrgWideEmailAddressId(OWEA[0].id);
                    
                     multipleM.add(singleM);
                          system.debug('if employeer added------');               
                      c.Employer_Mail_Sent_Date__c = system.today();      
                        }   */  
                    }
                }  
    		}
      //   Messaging.sendEmail(multipleM);
       }
    }

}