global class DNCBatchApexForAccount implements Database.Batchable<sObject>,Database.Stateful
{
   global string accountQuery;
   global string lastRecord;
 
   global Database.QueryLocator start(Database.BatchableContext bc) 
   {
        accountQuery = 'SELECT id,name,DNDId__c,DNC_Phone__c FROM DND_Data__c WHERE DNDId__c >:lastRecord Order by DNDId__c ASC limit 100000';
        return Database.getQueryLocator(accountQuery);
    }
    
    global void execute(Database.BatchableContext BC, list<DND_Data__c> ac){
        
        set<string> dndPhone = new set<string>();
        set<string> dndPhoneList = new set<string>();
        map<string,string> dndMap = new map<string,string>();
        
        for(DND_Data__c d : ac){
        lastRecord = d.DNDId__c;
        System.debug('This is the last record '+lastRecord);
        dndPhoneList.add(d.DNC_Phone__c);
        dndPhone.add('%'+d.DNC_Phone__c+'%');
        }
        //B2B accounts 
        List<account> acc = [SELECT id,name,AccountID__c,Phone,OtherPhone__c,Phone_Do_Not_Call__c,updated__c,Other_Phone_Do_Not_Call__c FROM Account WHERE (phone like :dndPhone OR OtherPhone__c like :dndPhone) AND Case_Accounts__c = false AND Person_Account__c = false AND Integration__c = false];
        List<account> updateAcc = new list<account>();

        for(account a : acc)
        { 
            string ap = a.phone;
			boolean b = false;
            if(ap != NULL)
            {
                system.debug('len--> '+ap.length());
			    string s1= ap.right(10);
			    system.debug('sub-->'+s1);      
                b = dndPhoneList.contains(s1);
               
            }
            string aop = a.OtherPhone__c;
            boolean c  = false;
            if(aop != NULL)
            {
            system.debug('len--> '+aop.length());
			string t1 = aop.right(10);
			system.debug('sub-->'+t1);
            c = dndPhoneList.contains(t1); 
            }
            system.debug('b-->'+b);
            system.debug('c-->'+c);
            
            if(b){
                a.Phone_Do_Not_Call__c = true;
                a.Do_Not_Call__c=true;//added by yam
                a.DNC_Date__c=system.now();
            }
            if(c){
                a.Other_Phone_Do_Not_Call__c = true;
                a.Do_Not_Call__c=true;//
                a.DNC_Date__c=system.now();
            }
            
            if(b == true || c== true){
                if(a.updated__c ==  NULL)
                a.updated__c = 'updated';
                updateAcc.add(a); 
            }   
        }

           database.update(updateAcc) ;
          
    }

    
    global void finish(Database.BatchableContext BC)
    {
    
    Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
    String[] toAddresses = new list<string> {'support@cloudexpertsindia.com'};
    String subject ='DND record '+lastRecord;
    email.setSubject(subject);
    email.setToAddresses( toAddresses );
    email.setPlainTextBody('DND id '+lastRecord);
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});    
        
  }


}