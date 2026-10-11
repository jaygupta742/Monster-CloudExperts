//@imRam, this survey should work only for Raj-Service Profile, Profile condition has been given in Process Builder (SurveyMonkey)
//Last Modified By : Abdul Aziz , Date : 22/03/2024 , Description : Added condition in Sub Type And Activity Task Type
public class SurveyMonkey {
    
    @InvocableMethod(label='Send Mail' description='If Task Status & Sub Status matching then send mail to contacts')
    public static void insertAccounts(List<id> TIds) {
        // public static void insertAccounts(List<Task> TIds) {
        
        met(TIds);
        
    }
    
    @future
    public static void met(List<id> TIds){
        
        List<OrgWideEmailAddress> OWEA = [SELECT Address,DisplayName,Id FROM OrgWideEmailAddress WHERE Address='customerservice@monsterindia.com' OR Address='jobseeker@monsterindia.com'];
        system.debug('OrgWideEmailAddress---->'+OWEA);
        map<string,id> owmp = new map<string,id>();
        for(OrgWideEmailAddress o : OWEA){
            owmp.put(o.Address,o.id);
            
        }
        
        
        set<id> cid = new set<id>();
        List<TaskWhoRelation> TWR = [ SELECT Id, RelationId, TaskId, Type FROM TaskWhoRelation WHERE TaskId = :TIds];
        
        for(TaskWhoRelation tt : TWR){
            
            string contactid = tt.RelationId;
            Boolean ifcon = contactid.startsWithIgnoreCase('003');
            if(ifcon){ cid.add(tt.RelationId);}
        } // end  TaskWhoRelation For
        system.debug('cid--->'+cid);
        system.debug('TWR--->'+TWR);
        
        List<Messaging.SingleEmailMessage> multipleM = new List<Messaging.SingleEmailMessage>();
        
        string s;
        //   List<contact> Acont = new List<contact>(); // If mail has been sent then to update date field
        set<contact> AScont = new set<contact>();
        Map<string,id> mp = new Map<string,id>(); // to get emailTemplate
        
        Map<id,contact> contMp = new Map<id,contact>(); // based on who id, get contact
        Map<id,string> CMil = new Map<id,string>();  
        Map<id,date> amp = new Map<id,date>();
        Map<id,date> cmp = new Map<id,date>();
        Map<id,date> Smp = new Map<id,date>();
        
        List<EmailTemplate > temp = new List<EmailTemplate >([SELECT id, name,Description  FROM EmailTemplate WHERE Description ='RajSurveyMonkeySeeker1' OR Description ='RajSurveyMonkeyEmployer' OR Description ='RajSurveyMonkeySeeker2']);
        System.debug('tmp size-->'+temp.size());
        for(EmailTemplate et : temp){ // adding email template to map
            mp.put(et.Description , et.id);
        }
        
        List<Task> tas = new List<Task>([SELECT id,Task_Type__c,Activity_Status__c,ActivitySubType__c,createddate,Subject,LastModifiedDate,WhatId,WhoId,TaskWhoIds,ownerid FROM Task WHERE id=:TIds]);
        
        
        set<id> aid = new set<id>();
        FOR(Task t : tas){ //if Task is related to account the only consider
            system.debug('task subjectttt--->'+t.Subject);
            string aa = t.WhatId;
            Boolean acc = aa.startsWithIgnoreCase('001');
            if(acc){
                
                s =  string.valueof(t.TaskWhoIds);
                aid.add(t.WhatId);
                
            }
            
        }
        
        system.debug('s--->'+s);
        
        
        
        List<contact> con = new List<contact>([SELECT id,lastname,SurveyMonkeyDate__c,SurveyMonkeyDate2__c,email FROM contact WHERE id =:cid]);
        system.debug('con --->'+con);
        for(contact aa : con){
            cmp.put(aa.id,aa.SurveyMonkeyDate__c); //Employee & Seeker1
            Smp.put(aa.id,aa.SurveyMonkeyDate2__c);//Seeker2
            contMp.put(aa.id,aa);
            CMil.put(aa.id,aa.email);
            
        }
        
        system.debug('cmp --->'+cmp);
        
        
        FOR(Task t : tas){
            system.debug('task for------');
            string ownr = t.OwnerId;
            string ownr15 = ownr.substring(0,15);
            system.debug('ownr--->'+ownr);
            system.debug('ownr15--->'+ownr15);
            List<SurveyMonkey__c> CS = [SELECT id,name,UserID__c FROM SurveyMonkey__c WHERE UserID__c=:ownr15];
            
            
            system.debug('CustomValues--->'+cs);
            system.debug('size--->'+cs.size());
            
            if(cs.size() <=0)
                for(TaskWhoRelation tt : twr){
                    system.debug('taskwhoRelation for------');
                    system.debug('task--->'+t.id+' TaskWhoRelation--->'+tt.TaskId);
                    if(tt.TaskId == t.id){ //if TaskWhoRelation's Taskid is the task id
                        string accid =  t.WhatId;
                        system.debug('accid --->'+accid);
                        
                        Boolean check = accid.startsWithIgnoreCase('001');
                        system.debug('check --->'+check);
                        
                        if(check ){ // if account then only proceed && t.Status__c == 'Completed'
                            
                            
                            //Employeer & seeker1
                            
                            string m1 = string.valueOf(cmp.get(tt.RelationId)); //get surveymonkeydate__c for employeer & Seeker1
                            system.debug('m1 --->'+m1);
                            string m11 ;
                            if(m1 != NULL){m11 = m1.substring(0,7);}
                            
                            string m2 = string.valueof(system.today());
                            string m22 = m2.substring(0,7);
                            
                            system.debug('m11 --->'+m11);
                            system.debug('m22 --->'+m22);
                            
                            //seeker2
                            
                            String n1 = string.valueOf(Smp.get(tt.RelationId)); //get surveymonkeydate1__c for seeker2
                            string n11 ;
                            if(n1 != NULL){n11 = n1.substring(0,7);}
                            
                            
                            system.debug('Task_Type__c --->'+t.Task_Type__c+' ActivitySubType__c--->'+t.ActivitySubType__c);
                            //Task_Type__c=Activity Task Type
                            if( t.Task_Type__c == 'Call Inbound' || t.Task_Type__c == 'Call Outbound' || t.Task_Type__c == 'Email Inbound' || t.Task_Type__c == 'Visit' || t.Task_Type__c == 'Call' || t.Task_Type__c == 'Foundit2.0' || t.Task_Type__c == 'Customer Event'){
                                
                                
                                if(m11 != m22 || m1 == NULL ){ // employeer & seeker1 logic
                                    system.debug('Inside employeer & seeker1 if'); 
                                    
                                    
                                    /* contact c =  contMp.get(tt.RelationId);
c.SurveyMonkeyDate__c = system.today();
system.debug('contacttttt --->'+c);
AScont.add(c);*/
                                    // Acont.add(c);
                                    
                                    
                                    /* system.debug('Task_Type__c --->'+t.Task_Type__c+' ActivitySubType__c--->'+t.ActivitySubType__c);
if( t.Task_Type__c == 'Call Inbound' || t.Task_Type__c == 'Call Outbound' || t.Task_Type__c == 'Email Inbound' || t.Task_Type__c == 'Visit' ){*/
                                    
                                    //Employeer
                                    //ActivitySubType__c==Sub Type
                                    //Activity_Status__c==Activity Status
                                    if ( t.Activity_Status__c == 'Closed' && (t.ActivitySubType__c == 'Follow Up' || t.ActivitySubType__c == 'Training' || t.ActivitySubType__c == 'Onsite Visit' || t.ActivitySubType__c == 'Recruiter Profile' || t.ActivitySubType__c == 'Job Posting Support'|| t.ActivitySubType__c == 'Mass Mails Support' || t.ActivitySubType__c == 'Saved Searches Support'  || t.ActivitySubType__c == 'SMS Support' || t.ActivitySubType__c == 'eCom Support' || t.ActivitySubType__c == 'Appreciation from Client' || t.ActivitySubType__c == 'Free Trial - CR Driven'|| t.ActivitySubType__c == 'Free Trials'|| t.ActivitySubType__c == 'MSJ' || t.ActivitySubType__c == 'CSS' || t.ActivitySubType__c == 'FTP' || t.ActivitySubType__c == 'IRS'
                                                                              || t.ActivitySubType__c == 'Training - Online' || t.ActivitySubType__c == 'Training - Onsite' || t.ActivitySubType__c == 'Appointment'
                                                                              || t.ActivitySubType__c == 'Product Pitch'  || t.ActivitySubType__c == 'Meeting' || t.ActivitySubType__c == 'Branding'  || t.ActivitySubType__c == 'TalentBin'
                                                                              || t.ActivitySubType__c == '2.0 Migration Walkthru – TA Lead'  || t.ActivitySubType__c == '2.0 – Interested to upgrade' || t.ActivitySubType__c == '2.0 Migration Training – Recruiters'  || t.ActivitySubType__c == '2.0 – VOC'
                                                                              || t.ActivitySubType__c == '2.0 – No Training Required'  || t.ActivitySubType__c == 'Training - Online (foundit2.0)' || t.ActivitySubType__c == 'Training - Onsite (foundit2.0)'  
                                                                             )){
                                                                                 
                                                                                 contact c =  contMp.get(tt.RelationId);
                                                                                 c.SurveyMonkeyDate__c = system.today();
                                                                                 system.debug('contacttttt employeer --->'+c);
                                                                                 AScont.add(c);
                                                                                 
                                                                                 Messaging.SingleEmailMessage singleM = new Messaging.SingleEmailMessage();
                                                                                 
                                                                                 singleM.setTemplateId(mp.get('RajSurveyMonkeyEmployer'));
                                                                                 singleM.setTargetObjectId(tt.RelationId); //tt.RelationId
                                                                                 // singleM.setSaveAsActivity(true);
                                                                                 singleM.setSaveAsActivity(false);
                                                                                 // singleM.setSenderDisplayName('Monster Customer Service Team');
                                                                                 SingleM.setOrgWideEmailAddressId(owmp.get('customerservice@monsterindia.com'));
                                                                                 
                                                                                 multipleM.add(singleM);
                                                                                 system.debug('if employeer added------');     
                                                                                 
                                                                             }   //|| t.ActivitySubType__c == 'Career Booster' || t.ActivitySubType__c == 'VSkills' || t.ActivitySubType__c == 'RR Vendor' || t.ActivitySubType__c == 'General Jobseeker' || t.ActivitySubType__c == 'Jobseeker Career Services (Combo)' 
                                    //Seeker1 
                                    else if(t.Activity_Status__c == 'Closed' &&(t.ActivitySubType__c == 'Resume Highlighter' || t.ActivitySubType__c == 'Express Resume')){
                                        
                                        contact c =  contMp.get(tt.RelationId);
                                        c.SurveyMonkeyDate__c = system.today();
                                        system.debug('contacttttt seeker1--->'+c);
                                        AScont.add(c);
                                        
                                        Messaging.SingleEmailMessage singleM = new Messaging.SingleEmailMessage();
                                        
                                        singleM.setTemplateId(mp.get('RajSurveyMonkeySeeker1'));
                                        singleM.setTargetObjectId(tt.RelationId);
                                        singleM.setSaveAsActivity(true);  
                                        //  singleM.setSenderDisplayName('Monster Customer Service Team');                        
                                        SingleM.setOrgWideEmailAddressId(owmp.get('jobseeker@monsterindia.com'));
                                        multipleM.add(singleM);     
                                        system.debug('else seeker1 added------');       
                                        
                                    }
                                    /*else if(t.Activity_Status__c == 'Closed' &&(t.ActivitySubType__c == 'Career Booster' || t.ActivitySubType__c == 'Right Resume')){

Messaging.SingleEmailMessage singleM = new Messaging.SingleEmailMessage();

singleM.setTemplateId(mp.get('RajSurveyMonkeySeeker2'));
singleM.setTargetObjectId(tt.RelationId);
singleM.setSaveAsActivity(true);          
singleM.setSenderDisplayName('Monster Customer Service Team');

multipleM.add(singleM);     
system.debug('else added------');  
} */
                                    
                                } //end employer & seeker1 logic
                                
                                if(n11 != m22 || n1 == NULL){ //seeker2 logic
                                    system.debug('inside seeker2--->');
                                    if(t.Activity_Status__c == 'Closed' &&(t.ActivitySubType__c == 'Career Booster' || t.ActivitySubType__c == 'Right Resume')){
                                        
                                        contact c =  contMp.get(tt.RelationId);
                                        c.SurveyMonkeyDate2__c = system.today();
                                        system.debug('contacttttt seeker2--->'+c);
                                        AScont.add(c);
                                        
                                        Messaging.SingleEmailMessage singleM = new Messaging.SingleEmailMessage();
                                        
                                        singleM.setTemplateId(mp.get('RajSurveyMonkeySeeker2'));
                                        singleM.setTargetObjectId(tt.RelationId);
                                        singleM.setSaveAsActivity(true);          
                                        //  singleM.setSenderDisplayName('Monster Customer Service Team');
                                        SingleM.setOrgWideEmailAddressId(owmp.get('jobseeker@monsterindia.com'));
                                        multipleM.add(singleM);     
                                        system.debug('seeker2 added------'); 
                                        
                                        
                                    } //end seeker2 if 
                                    
                                } //end seeker2 logic
                                
                            } //end task type if condition
                            
                        } //end if account check logic
                        
                    } //end taskWhoRelation for loop
                    
                }//end task for loop
            
            List<emailmessage> emess = new  List<emailmessage>([SELECT id,Subject,Status FROM emailmessage WHERE Subject ='Email: Your Feedback on Monster Customer Service!']);
            system.debug('emailmessage before delete----->'+emess);
            
            system.debug('send email-----');
            Messaging.sendEmail(multipleM);
            delete emess;
            system.debug('emailmessage after delete----->'+emess); 
            
            List<contact> Acont = new List<contact>(AScont);
            update Acont;
            system.debug('Acont --->'+Acont);
            
        }
    }
}