trigger SendBackTrigger on QuotesN__c (after update) {

    if(trigger.isupdate){
        for(QuotesN__c q:trigger.new){
            if(q.Send_Back__c==true){
                SendBackEmail tt=new SendBackEmail();
                tt.SendToUsers(q.Id);
            }
        }
    }
}