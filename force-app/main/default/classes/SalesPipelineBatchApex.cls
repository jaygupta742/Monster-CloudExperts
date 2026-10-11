global  class SalesPipelineBatchApex implements Database.Batchable<sObject> {
    
    global static list<Messaging.Emailfileattachment> matInsert = new List<Messaging.Emailfileattachment>();
    global static list<Messaging.SingleEmailMessage> mailS= new  list<Messaging.SingleEmailMessage>();  
    global String query;
    global id profid = [SELECT Id FROM Profile WHERE Name = 'Monster-Sales'].id;
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
       /* return Database.getQueryLocator(
            'SELECT ID,name from user WHERE isactive = TRUE'
        );*/
          if(!Test.isRunningTest())
        query = 'SELECT Id,Name,email, (SELECT id,name FROM ManagedUsers WHERE isactive = true) FROM User WHERE isactive = true AND profileid =:profid';
        else{
         query = 'SELECT Id,Name,email, (SELECT id,name FROM ManagedUsers WHERE isactive = true) FROM User WHERE isactive = true AND profileid =:profid limit 10';    
        }
        return Database.getQueryLocator(query);
      
            
    }
    global void execute(Database.BatchableContext bc, List<user> usr){
        set<id> muid = new set<id>();
        id AdminId = UserInfo.getUserId();
        id richardid = [SELECT id from user where N_ExternalID__c = '00516000006mc3KAAQ'].id;
        for(user u : usr){
            
            
system.debug('id--->'+AdminId);
  system.debug('richardid--->'+richardid);

            
            for(user uu : u.ManagedUsers){muid.add(uu.id);}

//List<user> ur = [select id,name,managerid FROM user WHERE isactive = TRUE AND (managerid =:u.id or id=:u.id)];

 Messaging.Emailfileattachment mat = new Messaging.Emailfileattachment();
          Messaging.SingleEmailMessage m1= new  Messaging.SingleEmailMessage();
            
          id usrid =  u.id;
        
      //  list<Opportunity__c> opp = [SELECT id,name,Absorption_Fee__c,owner.name FROM Opportunity__c WHERE (ownerid = :muid OR ownerid = :usrid) AND ownerid !=:AdminId limit 50000];
        
      list<Opportunity__c> opp =  [SELECT lastmodifieddate,Account__r.name,name,Account__r.APAC_Industry__c,Sales_Channel__c,Account__r.Segment__c,Branch_City__c,owner.name,Product_Detail_Offered__c,Close_Date__c,Stage__c,Probability__c,CreatedDate,CurrencyIsoCode,Amount__c FROM opportunity__c WHERE (ownerid = :muid OR ownerid = :usrid) AND ownerid !=:AdminId  AND ownerid !=:richardid AND createddate = this_month limit 50000];
      //  string headr = 'id,name,Absorption Fee, Owner'+'\n';
         string headr = 'Last Modified Date,Account: Account Name,Opportunity No,Account: APAC Industry	Region,	Sales Channel	,Account: Segment	,Branch / City	,Owner: Full Name,Product Detail Offered,Close Date,Stage,Probability,Created Date,Currency,Estimated Revenue (APAC)'+'\n';
        string Opval = '' ;
		
		for(Opportunity__c o : opp){
		// opval = Opval +o.id +','+o.name +','+ o.Absorption_Fee__c+','+o.owner.name+'\n'; 
		opval = Opval +o.lastmodifieddate+','+o.Account__r.name+','+o.name+','+o.Account__r.APAC_Industry__c+','+o.Sales_Channel__c+','+o.Account__r.Segment__c+','+o.Branch_City__c+','+o.owner.name+','+o.Product_Detail_Offered__c+','+o.Close_Date__c+','+o.Stage__c+','+o.Probability__c+','+o.CreatedDate+','+o.CurrencyIsoCode+','+o.Amount__c+'\n';
		}
		
		  string FinalReport = headr + Opval;
        
        
       
        
         blob ofile = Blob.valueOf(FinalReport); 
            string myf= 'SalesPipeline.csv';
             mat.setFileName(myf);
             mat.setBody(ofile);
        
        //matInsert.add(mat);
           m1.setSubject('Report: My Daily Report run at '+system.now());
            m1.setSaveAsActivity(false);
           m1.setFileAttachments(new Messaging.EmailFileAttachment[]{mat});
            system.debug('user mail--->'+u.email);
        m1.setToAddresses(new string[]{u.email});
           m1.setPlainTextBody('Please Find the attachment for your Sales Pipeline Report Of Yesterday');
            mailS.add(m1);

          Messaging.sendEmail(mailS);

}
      
       
    }    
    global void finish(Database.BatchableContext bc){
        
       
        system.debug('user report completed');
      
    }    


}