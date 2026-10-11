global class LapsedAccountOnOrderExpired implements Database.Batchable<Sobject>, Database.Stateful{
      public  string last_record;
      public String activeAccountNotCandidate;
      public String InActiveAccount;
      public String rejectedAccount;
      public String noStatusAccount;
      public String rec1;
      public String rec2;
      public String rec3;
      public String rec4;
    
   global Database.QueryLocator start(Database.BatchableContext BC){
          
      String  query='select id,name,AccountStatus__c,Lead_Account_Status__c,AccountID__c,(select id,Name,Order_Service_End_Date__c,Net_Total__c,QuoteProposal__r.name,Order_Start_Date__c,CreatedBy.name,PrimarySalesRep__r.name,Owner.name,CreatedDate from Orders__r where createdDate>2018-07-01T00:00:00.000+0000 Order By Order_Service_End_Date__c DESC LIMIT 1),(select id from contacts limit 10),(select id from Opportunities__r limit 10),(select id,Name from Quotes_Proposals2__r limit 10) from Account where Accountid__c> =:last_record AND Person_Account__c=false AND Case_Accounts__c=false And Integration__c=false  order by accountid__c asc limit 100000';  
          
          
          return Database.getQueryLocator(query);
      }
   global void execute(Database.BatchableContext BC, List<Account> odc){
           
            
   ActiveAccountNotCandidate='ID,AccountID,Status,Lead Account Status\n';
   InActiveAccount='ID,AccountID,Status,Lead Account Status,OrderId,Order No,Quote No,Order Start Date,Order End Date,Createdby,Quote Owner,Order Owner,Created Date, Net Total\n';
   rejectedAccount='ID,AccountID,Status,Lead Account Status,OrderId,Order No,Quote No,Order Start Date,Order End Date,Createdby,Quote Owner,Order Owner,Created Date, Net Total\n';
   noStatusAccount='ID,AccountID,Status,Lead Account Status,OrderId,Order No,Quote No,Order Start Date,Order End Date,Createdby,Quote Owner,Order Owner,Created Date, Net Total\n';
     
            List<Account>lac= new List<Account>();
            List<Account>lac1= new List<Account>();
            for(Account ac:odc){
        
          last_record = ac.Accountid__c;
              
if(ac.Lead_Account_Status__c=='Active'  && ac.contacts.size()>0 &&ac.Orders__r.size()==0 && ac.Opportunities__r.size()!=0 && ac.AccountStatus__c!='Candidate'){
                    
  rec1=rec1+ac.id+','+ac.AccountID__c+','+ac.AccountStatus__c+','+ac.Lead_Account_Status__c+'\n';      
                    
                }
                
                if(ac.Lead_Account_Status__c=='Active' && ac.Orders__r.size()>0){
            for(OrderC__C cc:ac.Orders__r){
                
                system.debug('@@@@@@@@@@@'+cc.Order_Service_End_Date__c+'AAAAAAAAAAAAA'+ac.Orders__r.size());
                if(cc.Order_Service_End_Date__c<system.today() &&   ac.AccountStatus__c!='Lapsed Customer'){
                    ac.id=ac.id;
                  
                    ac.Old_Account_Status__c=ac.AccountStatus__c;
                    
                    ac.AccountStatus__c='Lapsed Customer';
                    lac.add(ac);
                }
                system.debug('AAAAAAAAAA'+cc.Net_Total__c);
                if(cc.Order_Service_End_Date__c>system.today() && cc.Net_Total__c>1 && ac.AccountStatus__c!='Customer'){
                     ac.id=ac.id;
                   
                    ac.Old_Account_Status__c=ac.AccountStatus__c;
                    
                    ac.AccountStatus__c='Customer';
                     lac.add(ac);
                    
                    Map<String, Object> mp= new  Map<String,Object>();
                       mp.put('OrderId',cc.id);
            
            
                     flow.Interview fp= new flow.Interview.Call_Account_Updator_Class(mp);
                        fp.start();
                }
                 if(cc.Order_Service_End_Date__c>system.today() && cc.Net_Total__c<1 && ac.AccountStatus__c!='Candidate'){
                    ac.id=ac.id;
                   
                    ac.Old_Account_Status__c=ac.AccountStatus__c;
                    
                    ac.AccountStatus__c='Candidate';
                     lac.add(ac);
                }
            }
      }
               
                
                
                
    if(ac.Lead_Account_Status__c=='Inactive' && ac.Orders__r.size()>0){
              system.debug('Inactive'+ac.name);       
            for(OrderC__C cc:ac.Orders__r){
                system.debug('Inactive'+cc.name);     
 rec2=+rec2 + ac.id+','+ac.Accountid__c+','+ac.AccountStatus__c+','+ac.Lead_Account_Status__c+','+cc.id+','+cc.name+','+cc.QuoteProposal__r.name+','+cc.Order_Start_Date__c+','+cc.Order_Service_End_Date__c+','+cc.CreatedById+','+cc.PrimarySalesRep__r.name+','+cc.Owner.name+','+cc.CreatedDate+','+cc.Net_Total__c+'\n';      
           system.debug('PAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+rec2);         
            }
      }
              
                    
             
                
                
            if(ac.Lead_Account_Status__c=='Rejected' && ac.Orders__r.size()>0){
            for(OrderC__C cc:ac.Orders__r){
      
 rec3=rec3+ac.id+','+ac.Accountid__c+','+ac.AccountStatus__c+','+ac.Lead_Account_Status__c+','+cc.id+','+cc.name+','+cc.QuoteProposal__r.name+','+cc.Order_Start_Date__c+','+cc.Order_Service_End_Date__c+','+cc.CreatedById+','+cc.PrimarySalesRep__r.name+','+cc.Owner.name+','+cc.CreatedDate+','+cc.Net_Total__c+'\n';      

                
            }
      }
                if((ac.Lead_Account_Status__c==''||ac.Lead_Account_Status__c==NULL) && ac.Orders__r.size()>0){
            for(OrderC__C cc:ac.Orders__r){
 rec4=rec4+ac.id+','+ac.Accountid__c+','+ac.AccountStatus__c+','+ac.Lead_Account_Status__c+','+cc.id+','+cc.name+','+cc.QuoteProposal__r.name+','+cc.Order_Start_Date__c+','+cc.Order_Service_End_Date__c+','+cc.CreatedById+','+cc.PrimarySalesRep__r.name+','+cc.Owner.name+','+cc.CreatedDate+','+cc.Net_Total__c+'\n';      

            }
          }
        }
         
           
           database.update(lac,false);
       ActiveAccountNotCandidate=ActiveAccountNotCandidate+rec1;
       InActiveAccount=InActiveAccount+rec2;
       rejectedAccount=rejectedAccount+rec3;
       noStatusAccount =noStatusAccount+rec4;
        }
global void finish(Database.BatchableContext BC){
    system.debug('FINALLLLLLLLLLLLLLLLLLLLLLLLL'+InActiveAccount);
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<string> {'support@cloudexpertsindia.com','crm@cloudexpertsindia.com'};
            String subject ='Last Updated Account Record'+last_record;
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody('Last Updated Account Record'+last_record);
         
          Blob bn = blob.valueOf(activeAccountNotCandidate);
    	Messaging.EmailFileAttachment bnefa = new Messaging.EmailFileAttachment();
        bnefa.setFileName('ActiveAccountNoCandidate.csv');
        bnefa.setBody(bn);
    	Blob san = blob.valueOf(InActiveAccount);
    	Messaging.EmailFileAttachment sanefa = new Messaging.EmailFileAttachment();
        sanefa.setFileName('InactiveAccount.csv');
        sanefa.setBody(san);
    	Blob ban = blob.valueOf(rejectedAccount);
    	Messaging.EmailFileAttachment banefa = new Messaging.EmailFileAttachment();
        banefa.setFileName('RejectedAccount.csv');
        banefa.setBody(ban);
    	Blob nbn = blob.valueOf(noStatusAccount);
    	Messaging.EmailFileAttachment nbnefa = new Messaging.EmailFileAttachment();
        nbnefa.setFileName('WithoutStatusAccount.csv');
        nbnefa.setBody(nbn);
    	List<Messaging.EmailFileAttachment> lefa = new List<Messaging.EmailFileAttachment>();
    	lefa.add(bnefa);
        lefa.add(sanefa);
        lefa.add(banefa);
    	lefa.add(nbnefa);
    	
        email.setFileAttachments(lefa);
           
           
           
           
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
           
           
       }
}