public class AccountTeamMemberTriggerHandler {  
    //AccountTeamMemberTriggerHandler_Test
    //private boolean m_isExecuting = false;
    //public AccountTeamMemberTriggerHandler(){
    //m_isExecuting = isExecuting;
    //}
    
    public void OnBeforeInsert(Account_Team_Member__c[] newObjects){
        // EXECUTE BEFORE INSERT LOGIC
    }

    public void OnAfterInsert(Account_Team_Member__c[] newObjects)
    {
 
       /* list<Opportunity__share> shared=new list<Opportunity__share>();
        for(Account_Team_Member__c n:newObjects)
        {
            if(n.opportunity__c!=null)
            {
        Opportunity__share jo = new Opportunity__share();
        jo.AccessLevel='Read';
        jo.UserOrGroupId=n.UserId__c;
        jo.ParentID=n.Opportunity__c;
        //jo.Account=n.AccountId__c;
        shared.add(jo);
         }   
        }
        
        insert shared;*/

    }

    public void OnBeforeUpdate(Account_Team_Member__c[] oldObjects, Account_Team_Member__c[] updatedObjects,Map<ID, Account_Team_Member__c>  MapObjectMap){
        // BEFORE UPDATE LOGIC
    }

    public void OnAfterUpdate(Account_Team_Member__c[] oldObjects, Account_Team_Member__c[] updatedObjects,Map<ID, Account_Team_Member__c> MapObjectMap){
        // AFTER UPDATE LOGIC
    }
    
        public void onBeforeDelete(Account_Team_Member__c[] triggerObject)
        {/*
            for(Account_Team_Member__c atm : triggerobject){
                if(atm.UserId__c == atm.AccountOwnerID__c){
                 atm.AccountId__c.addError('You cannot delete this Team Member');  
                }
        }*/
    }
    
        
    
  /*   public void OnAfterDelete(Account_Team_Member__c[] deletedObjects,Map<ID, Account_Team_Member__c> MapObjectMap){
        // AFTER DELETE LOGIC
    }*/

   // public void OnUndelete(Account_Team_Member__c[] restoredObjects){
        // AFTER UNDELETE LOGIC
   // }

   // public boolean IsTriggerContext{
     //   get{ return m_isExecuting;}
   // }

}