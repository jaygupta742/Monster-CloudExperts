global class BatchApexToChangeOwner implements Database.Batchable<sObject>, Database.Stateful{
   
 public  string last_record;
     
    global Database.QueryLocator start(Database.BatchableContext BC){
      
      
        String query = 'SELECT id,Accountid__c,ownerid,(select id,ownerid,Owner_History__c from Opportunities__r order by createddate desc limit 200 ),(select id,ownerid,Owner_History__c from Quotes_Proposals2__r order by createddate desc limit 200 ),(select id,ownerid,Owner_History__c from Orders__r order by createddate desc limit 200 ) FROM Account where Accountid__c> =:last_record AND Person_Account__c= False order by accountid__c asc limit 100000';
       
        return Database.getQueryLocator(query);
        
    }
    
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        List<Opportunity__share> slop = new List<Opportunity__share>();
        List<apttus_proposal_proposal__share> slqt = new List<apttus_proposal_proposal__share>();
        List<OrderC__share> slodr = new List<OrderC__share>();
        List<Opportunity__c> lop = new List<Opportunity__c>();
        List<apttus_proposal_proposal__c> lqt = new List<apttus_proposal_proposal__c>();
        List<OrderC__c> lodr = new List<OrderC__c>();
        for(Account ac : scope){
           last_record= ac.AccountID__c;
            for(Opportunity__c op : ac.Opportunities__r){
                Opportunity__share os = new Opportunity__share();
                System.debug('userxx opp bef'+op.Owner_History__c);
                if(op.Owner_History__c == null || op.Owner_History__c == '')
                	op.Owner_History__c = op.OwnerId;
                else
                    op.Owner_History__c = op.Owner_History__c+','+ac.OwnerId;
                System.debug('userxx axcc'+ac.OwnerId);
                System.debug('userxx opp'+op.Owner_History__c);
                os.ParentId = op.id;
                os.UserOrGroupId = ac.OwnerId;
                os.AccessLevel = 'Read';
                slop.add(os);
                lop.add(op);
            }
            for(apttus_proposal_proposal__c qt : ac.Quotes_Proposals2__r){
                apttus_proposal_proposal__share sqt = new apttus_proposal_proposal__share();
                if(qt.Owner_History__c == null || qt.Owner_History__c == '')
                	qt.Owner_History__c = qt.OwnerId;
                else
                    qt.Owner_History__c = qt.Owner_History__c+','+ac.OwnerId;
                sqt.ParentId = qt.id;
                sqt.UserOrGroupId = ac.OwnerId;
                sqt.AccessLevel = 'Read';
                slqt.add(sqt);
                lqt.add(qt);
            }
            for(OrderC__c odr : ac.Orders__r){
                OrderC__share sodr = new OrderC__share();
                OrderC__c or1 = new OrderC__c();
                if(odr.Owner_History__c == null || odr.Owner_History__c == '')
                	or1.Owner_History__c = odr.OwnerId;
                else
                    or1.Owner_History__c = odr.Owner_History__c+','+ac.OwnerId;
                sodr.ParentId = odr.id;
                sodr.UserOrGroupId = ac.OwnerId;
                sodr.AccessLevel = 'Read';
                slodr.add(sodr);
                or1.id = odr.Id;
                lodr.add(odr);
            }
         }
        Database.insert(slop,false); 
        Database.insert(slqt,false); 
        Database.insert(slodr,false); 
        Database.update(lop,false); 
        Database.update(lqt,false); 
        Database.update(lodr,false); 
    }
        
    global void finish(Database.BatchableContext BC)
        {
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<string> {'support@cloudexpertsindia.com','crm@cloudexpertsindia.com'};
            String subject ='Owner Last Record';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody(' Owner Last Record '+last_record);
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
}