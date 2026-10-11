global class DNCBatchClass implements Database.Batchable<sObject>,Database.Stateful
{
     global string accountQuery;
     global string lastRecord;
    
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
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
           // dndMap.put(d.Name, d.Name);
        }
        //B2B accounts 
        List<contact> con = [SELECT id,lastname,firstname,Phone,MobilePhone,HomePhone,OtherPhone,updated__c,HomePhoneDoNotCall__c,DoNotCall,MobilePhoneDoNotCall__c,Other_Phone_Do_Not_Call__c FROM contact WHERE (Phone like :dndPhone OR MobilePhone like :dndPhone OR HomePhone like :dndPhone OR OtherPhone like :dndPhone) AND account.Case_Accounts__c = false];
        List<contact> updateCon = new list<contact>();
      
        for(contact c : con)
        {
          string cm = c.Phone;
          boolean a = false;
          if(cm != NULL)
          { 
            system.debug('len--> '+cm.length());
            string a1 = cm.right(10);
			system.debug('sub-->'+a1);
            a = dndPhoneList.contains(a1);
            }
          string cp = c.MobilePhone;
          boolean b =false;
          if(cp != NULL)
          {
            system.debug('len--> '+cp.length());
			string b1 = cp.right(10);
			system.debug('sub-->'+b1);
            b = dndPhoneList.contains(b1);
          }
          
          string chp = c.HomePhone;
          boolean cb = false;
          if(chp != NULL)
          {   
           system.debug('len--> '+chp.length());
		   string c1 = chp.right(10);
		   system.debug('sub-->'+c1);
           cb = dndPhoneList.contains(c1);
          }
          
          string cop = c.OtherPhone;
          boolean d = false;
          if(cop != NULL) 
          {
            system.debug('len--> '+cop.length());
			string d1 = cop.right(10);
			system.debug('sub-->'+d1);
            d = dndPhoneList.contains(d1);
          }
          
            system.debug('ac-->'+a);
            system.debug('cb-->'+b);
            system.debug('ccb-->'+cb);
            system.debug('cd-->'+d);
            
            if(a)
            {
                c.DoNotCall = true;
                c.DNC_Date__c=system.now();
               
            }
            if(b)
            {
                c.MobilePhoneDoNotCall__c = true; 
                c.DoNotCall = true;
                c.DNC_Date__c=system.now();
            }
            if(cb){
                c.HomePhoneDoNotCall__c = true;
                c.DoNotCall = true;
                c.DNC_Date__c=system.now();
             }
            if(d)
            {
                c.Other_Phone_Do_Not_Call__c = true;
                c.DoNotCall = true;
                c.DNC_Date__c=system.now();
            }
            
            if(a==true || b == true || cb == true || d == true)
            {
              if(c.updated__c ==  NULL)
              c.updated__c = 'updated';
              updateCon.add(c);
            }
        }
        
        
           database.update(updateCon) ;
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
        
        
     /*   
        list<Messaging.Emailfileattachment> matInsert = new List<Messaging.Emailfileattachment>();
         Messaging.SingleEmailMessage m1 = new  Messaging.SingleEmailMessage();
        system.debug('final updatedAccId --->'+updatedAccId);
        if(String.isNotBlank(updatedAccId)){
             system.debug('inside account attachments');
              Messaging.Emailfileattachment mat = new Messaging.Emailfileattachment();
             
            
            string finalAccReport = accHeader + updatedAccId;
             blob ofile = Blob.valueOf(finalAccReport); 
            string myf= 'AccountsUpdated.csv';
             mat.setFileName(myf);
             mat.setBody(ofile);
            matInsert.add(mat);
        }
        system.debug('final updatedConId --->'+updatedConId);
        if(String.isNotBlank(updatedConId)){
            
            system.debug('inside contact attachments');
         string finalConReport = conHeader + updatedConId;
             Messaging.Emailfileattachment mat1 = new Messaging.Emailfileattachment();
             
            
         //   string finalAccReport = accHeader + updatedAccId;
             blob ofile = Blob.valueOf(finalConReport); 
            string myf= 'ContactUpdated.csv';
             mat1.setFileName(myf);
             mat1.setBody(ofile);
            matInsert.add(mat1);
            
        }
        
         m1.setSubject(' Report of Account & contact DND updated on '+system.today().format());
            m1.setSaveAsActivity(false);
           m1.setFileAttachments(matInsert);
        m1.setToAddresses(new string[]{'crm@cloudexpertsindia.com','seetaramatest@gmail.com'});
           m1.setPlainTextBody('Dear Swapna Please Find the attachment for Account & contact DND Results');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {m1});
      */