public class ReprocessedQuoteNew {

    @AuraEnabled
    public static string ReProcessedQuoteSent(String ids){ 
        
       QuotesN__c qq=[select id,name,Re_Process_Stage__c,Send_Back__c,ownerId,Send_Back_Reason__c,Send_Back_Reason_Text__c from QuotesN__c where id=:ids];
        system.debug('quote:'+qq);
        id st=UserInfo.getUserId();
      User u= new User();
      u=[select id,name,email,User.Manager.Email,User.Manager.FirstName,User.Manager.LastName from user where id=:qq.OwnerId];
        
         QuotesN__c pp= new QuotesN__c();
      pp.id=qq.id;
      //pp.RecordTypeId=rtid;
      pp.Re_Processed_DateTime__c=system.now();
      pp.Re_Processor_Name__c=u.name;
      pp.Send_Back__c=false;
      //pp.Sent_Back_Reason__c=null;
      pp.Re_Process_Stage__c='Re-processed';
      pp.Level_of_Approval_Done__c=null;
      pp.Approval_Status_Overall__c=null;
      
      pp.Level_of_Approval_Required__c=null;
      pp.Validated__c=false;
     
      pp.Approver_1__c=null;
      pp.Approver_2__c=null;
      pp.Approver_3__c=null;
      pp.Approver_4__c=null;
        pp.Level_1_Approval_Done__c=false;
                pp.Level_2_Approval_Done__c=false;
        pp.Level_3_Approval_Done__c=false;
        pp.Level_4_Approval_Done__c=false;
       // pp.Level_of_Approval_Done__c=null;
        
        system.debug('quote updated:'+pp);
      
      try{
      	  update pp;
          return 'Success';
      }
      catch(Exception ex){
          return ''+ex;
      }
        

    }
}