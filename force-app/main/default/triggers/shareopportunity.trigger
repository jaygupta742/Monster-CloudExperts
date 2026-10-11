trigger shareopportunity on Account_Team_Member__c (after insert) {
/*//list<Opportunity__share> shared=new list<Opportunity__share>();
        for(Account_Team_Member__c n:trigger.new)
        {
      /*  
        Opportunity__share jo = new Opportunity__share();
        jo.AccessLevel='Read';
        jo.UserOrGroupId=n.UserId__c;
        jo.ParentID=n.Opportunity__c;
        //jo.Account=n.AccountId__c;
        shared.add(jo);
            
        }
        
        //insert shared;*/
}