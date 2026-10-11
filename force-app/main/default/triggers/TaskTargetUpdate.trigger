trigger TaskTargetUpdate on Task (before insert, after insert, after Update, before update) {
    string upid = userinfo.getProfileId();
    If(Trigger.isBefore) {
        for(Task t : Trigger.new) {
            if(upid == '00e7F000000uSShQAM'&& t.Subject__c != null) t.Subject = t.Subject__c;

            System.debug('MY before ID '+t.ID);
            System.debug('MY before Task Sub Type '+t.tasksubtype);
        }
    }  
    
    If(Trigger.isInsert && Trigger.isAfter){
        String AccountPrefix = Account.SObjectType.getDescribe().getKeyPrefix();
        List<Target_JN_Task__c> LTJT = new List<Target_JN_Task__c>();
        set<id> accid = new set<id>();

        for(Task t : Trigger.new){
            System.debug('MY After ID '+t.ID);
            System.debug('MY After Task Sub Type '+t.tasksubtype);
            if(t.whatId != null && string.valueOf(t.whatId).startsWith(AccountPrefix) ){
                accid.add(t.WhatId);
            }
        }
        List<Account> LACC = new List<Account>([select id,Last_Target_Activity_Date__c from Account where id=:accid]);
        
        for(Task t : Trigger.new){
            System.debug('@@ Task Subject : ' + t.Subject);
            if(t.whatId != null && string.valueOf(t.whatId).startsWith(AccountPrefix) ){
                for(Account a : LACC){
                    if(a.Last_Target_Activity_Date__c != null){
                        if(a.Last_Target_Activity_Date__c.month() != system.today().month() && (a.Id == t.WhatId && (t.Subject == 'Meeting' || t.Subject == 'Fresh Telecall' ||  t.Subject == 'Follow-up Telecall' || t.Subject =='Telecall'))){
                            a.Last_Target_Activity_Date__c = system.today();
                            Target_JN_Task__c tjt = new Target_JN_Task__c();
                            tjt.Account__c = t.whatId;
                            tjt.Monthly__c = true;
                            tjt.Date__c = t.ActivityDate;
                            tjt.Status__c = t.Status;
                            tjt.Task_Subject__c = t.Subject;
                            tjt.TaskID__c = t.Id;
                            LTJT.add(tjt);
                        }
                        else if(a.Id == t.WhatId && (t.Subject == 'Meeting' || t.Subject == 'Fresh Telecall' ||  t.Subject == 'Follow-up Telecall'|| t.Subject =='Telecall')){
                            a.Last_Target_Activity_Date__c = system.today();
                            Target_JN_Task__c tjt = new Target_JN_Task__c();
                            tjt.Account__c = t.whatId;
                            tjt.Regular__c = true;
                            tjt.Date__c = t.ActivityDate;
                            tjt.Status__c = t.Status;
                            tjt.Task_Subject__c = t.Subject;
                            tjt.TaskID__c = t.Id;
                            LTJT.add(tjt);
                        }
                    }
                    else if(a.Id == t.WhatId && (t.Subject == 'Meeting' || t.Subject == 'Fresh Telecall' ||  t.Subject == 'Follow-up Telecall' || t.Subject == 'Telecall')){
                        a.Last_Target_Activity_Date__c = system.today();
                        Target_JN_Task__c tjt = new Target_JN_Task__c();
                        tjt.Account__c = t.whatId;
                        tjt.Monthly__c = true;
                        tjt.Regular__c = true;
                        tjt.Date__c = t.ActivityDate;
                        tjt.Status__c = t.Status;
                        tjt.Task_Subject__c = t.Subject;
                        tjt.TaskID__c = t.Id;
                        LTJT.add(tjt);
                    }
                }
            }
        }
        insert LTJT;
        Database.Update(LACC,false);
    }
    
    If(Trigger.isUpdate && Trigger.isafter){
        set<id> tid = new set<id>();
        set<id> aid = new set<id>();
        for(Task t : Trigger.new){
            tid.add(t.Id);
            aid.add(t.whatId);
        }
        List<Target_JN_Task__c> LTJT = new List<Target_JN_Task__c>();
        LTJT =[select Account__c,Date__c,Status__c,Task_Subject__c,TaskID__c from Target_JN_Task__c where TaskID__c=:tid and Account__c =: aid];
        if(LTJT.size()>0){
            for(Task t : Trigger.new){
                for(Target_JN_Task__c t1 : LTJT){
                    if(t.Id == t1.TaskID__c){
                        t1.Account__c = t.whatId;
                        t1.Date__c = t.ActivityDate;
                        t1.Status__c = t.Status;
                        t1.Task_Subject__c = t.Subject;
                    }
                }
            }
            Update LTJT;
        }
    }
    
    If(Trigger.isUpdate && Trigger.isbefore){
        for(Task t : Trigger.new){
            Task t1 = Trigger.oldmap.get(t.Id);           
            if(upid == '00e7F000000uSShQAM' && t1.Status == 'Completed') t.adderror('You cannot edit Closed Activity');
        }   
    }
    
    if(Trigger.isInsert && Trigger.isAfter || Trigger.isUpdate && Trigger.isAfter){
        set<id> acId = new set<id>();
        String AccPrefix = Account.SObjectType.getDescribe().getKeyPrefix();
        for(Task t : Trigger.new){
            if(t.whatId != null && string.valueOf(t.whatId).startsWith(AccPrefix) ){
                acId.add(t.WhatId);
            }
        }  
        map<id,Account> LTask = new map<id,Account>();
        List<Account> LOpp = new List<Account>([select id,LastMeetingDate__c from Account where id=:acId]);
        for(Task t : Trigger.new){       
            for(Account op : LOpp){
                if(op.Id == t.WhatId && (t.Subject == 'Meeting' || t.Subject == 'Fresh Telecall' ||  t.Subject == 'Follow-up Telecall'|| t.Subject =='Telecall')){  
                    op.LastMeetingDate__c = t.CreatedDate;
                    LTask.put(op.id,op);
                }
            }
        }
        Update LTask.values();
    }
    
    if (Trigger.isUpdate&&Trigger.isbefore || Trigger.isInsert && Trigger.isbefore) {
        
        Set<ID> setConIds = new Set<ID>();
        for(task te : trigger.new) {
            If(te.Name_For_Sales__c != null) {
                setConIds.add(te.Name_For_Sales__c);
                System.debug('This is the contact id --------------------->'+setConIds);
            }
            
        }
        List<contact> loc = new List<contact>();
        
        loc = [select id,name,phone,email from contact where id =:setConIds];
        
        String currentUserId = UserInfo.getUserId();
        User currentUser = [SELECT Id, Name, ProfileId, Profile.Name FROM User WHERE Id =: currentUserId];
        
        for(task tt1 : trigger.new) {
            if(currentUser.Profile.Name == 'Seeker-Edsales') continue;
            if(( tt1.Subject__c == 'Telecall'|| tt1.Subject__c == 'Meeting') && tt1.Name_For_Sales__c == null) {
                //tt1.WhoId == null
                tt1.adderror('When the subject is Telecall/Meeting please fill the "Name" by choosing the existing contact from the account..or create a new contact');
            }
            for(contact c : loc) {
                if(tt1.Name_For_Sales__c == c.id) {
                    tt1.Name1__c = c.Name;
                    tt1.Mobile_Task_sales__c = c.phone;
                    System.debug('This is the c phoen -->'+c.phone);
                    System.debug('This is the tt1 phoen -->'+tt1.Mobile_Task_sales__c);
                    
                    tt1.Email_Task_sales__c = c.Email;
                    System.debug('This is the c phoen -->'+c.email);
                    System.debug('This is the tt1 phoen -->'+tt1.Email_Task_sales__c);
                }
            }
        }
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        set<id> acId = new set<id>();
        String AccPrefix = Account.SObjectType.getDescribe().getKeyPrefix();
        for(Task t : Trigger.new){
            if(t.whatId != null && string.valueOf(t.whatId).startsWith(AccPrefix) ){
                acId.add(t.WhatId);
                
            }
        } 
        List<Account> LOpp = new List<Account>([select id,Name,Integration__c,Person_Account__c,createdById from Account where id=:acId]);
        List<account> aco = new List<account>();
        User usr = [select id from User where name='Cloud Experts Salesforce'];
        for(Account ac: LOpp){
            if(ac.Integration__c == true && ac.CreatedById == usr.id){
                ac.Used__c = true;
            }
            aco.add(ac); 
        }
        update aco;
    }
    
}