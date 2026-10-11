Global class ReProcessedQuote {
    
@AuraEnabled
  webservice static String ReProcessedQuoteSent(String ids){
       apttus_proposal_proposal__c ac =new apttus_proposal_proposal__c(); 
           ac=[select id,name,OwnerId,recordtypeid,Re_Process_Stage__c,Sent_Back_Reason__c,SentBackReasonText__c from apttus_proposal_proposal__c where id=:ids];
       String rtid=schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('before finalize').getRecordtypeid();
      id st=UserInfo.getUserId();
      User u= new User();
      u=[select id,name,email,User.Manager.Email,User.Manager.FirstName,User.Manager.LastName from user where id=:ac.OwnerId];
      apttus_proposal_proposal__c pp= new apttus_proposal_proposal__c();
      pp.id=ac.id;
      pp.RecordTypeId=rtid;
      pp.Re_Process_DateTime__c=system.now();
      pp.Re_Processor_Name__c=u.name;
      pp.SentBack__c=false;
      //pp.Sent_Back_Reason__c=null;
      pp.Re_Process_Stage__c='Re-processed';
      pp.Level_of_Approval_Done__c=null;
      pp.Approval_Status__c=null;
      pp.Level_of_Approval__c=null;
      pp.Validated__c=false;
      pp.Manager1__c=null;
      pp.Manager2__c=null;
      pp.Manager3__c=null;
      pp.Manager4__c=null;
      
      try{
      	  update pp;
          return 'Success';
      }
      catch(Exception ex){
          return ''+ex;
      }
      
   
        
    }
     public void sendItToUSer(String ids){
         
           apttus_proposal_proposal__c ac =new apttus_proposal_proposal__c(); 
           ac=[select id,name,OwnerId,recordtypeid,Re_Process_Stage__c,Sent_Back_Reason__c,SentBackReasonText__c from apttus_proposal_proposal__c where id=:ids];
       String rtid=schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('before finalize').getRecordtypeid();
      id st=UserInfo.getUserId();
      User u= new User();
      u=[select id,name,email,User.Manager.Email,User.Manager.FirstName,User.Manager.LastName from user where id=:ac.OwnerId];
         String sendername = UserInfo.getname();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      
      List<String> cc= new List<String>();
      if(u.Manager.Email!=null){
       cc.add(u.Manager.Email);
      }
      cc.add(u.email);
     // mail.setCcAddresses(cc);
     String st1;
      if(ac.SentBackReasonText__c!='' || ac.SentBackReasonText__c!=null){
                      System.debug('NUlllllll'+ac.Sent_Back_Reason__c);
           st1=ac.Sent_Back_Reason__c+ac.SentBackReasonText__c;
                      
          System.debug('STTTTTTTTT1'+st1);
                    }
                   if(ac.SentBackReasonText__c=='' || ac.SentBackReasonText__c==null){
                        st1=ac.Sent_Back_Reason__c;
                   
                       System.debug('STTTTTTTTT1ELSE'+st1);  
                    } 
     
     
     
      
      mail.setToAddresses(cc);
      mail.setSubject('Proposal Rejection Notifications'+ac.name);
      String ebody='Dear '+ u.name+' / ' +u.Manager.FirstName+' '+u.Manager.LastName +',<br/><br/>'
          +'Your quote has been reject for the following reason below.'+'<br/>'+
          st1+'<br/><br/>'
          +'Thanks And Regards,'+'<br/>'
          +sendername;
       mail.setHtmlBody(ebody);
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  }

}