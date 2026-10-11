trigger AcountUpdatecrHoldbycrholdate on Account (before insert,before update) {   
    //Developer Name [Rajaprashanth]
    //This trigger will update the cr holdby and crhold date based on the credit status and if the lead account status is active 
    //then it will update the lead account active date and if the Account owner [Account owner department will be updated to segment]
    //and the update should  skip for admin and {[Change_Segment__c == false this check box access is only given to swapna] and [Account segment and rec owner deparment !=(then update segment)] 
    /* Trigger__c t = new Trigger__c(); 
    commedted by @imRam
    t = [select id,name,Active__c FROM Trigger__c WHERE name='Account' LIMIT 1];*/
    
    Trigger__c t =trigger__c.getvalues('Account');
    system.debug('t.Active__c--->'+t.Active__c);
    system.debug('t.name--->'+t.name);
    
    if(t.Active__c == true && MonsterB2CIntegration.runTrigger == true){   
        // To filter the Account owner ids
        set<id> ownrids = new set<id>();    
        // iterate and add all the account owner ids to set to filter  
        for(Account a:trigger.new){
           ownrids.add(a.ownerid); 
        }   
        // key is user id[account owner id] and user is my value 
        map<id,user> mapusers = new map<id,user>([SELECT id,department,user_channel__c from user where id IN:ownrids]);
        user swap =[select id,name from user where id='0057F000003ST4Y'];
       /* for(Account acnt:trigger.new){      
            user u =mapusers.get(acnt.ownerid);
            Id uid = userinfo.getUserId();
            if(mapusers.containsKey(acnt.OwnerId) && mapusers.get(acnt.ownerid).department != null  ){
                if(acnt.Change_Segment__c == false && acnt.Segment__c != mapusers.get(acnt.ownerid).department && uid!='0057F000003RvIZ'){
                    acnt.Segment__c = mapusers.get(acnt.ownerid).department;            
                }
            }
        }*/
        
         //Nag
        for(Account acc: Trigger.new){
           user u =mapusers.get(acc.ownerid);
            Id uid = userinfo.getUserId();
            if(mapusers.containsKey(acc.OwnerId) && mapusers.get(acc.ownerid).user_channel__c != null ){
                if(Trigger.isUpdate){
                    if(acc.SalesChannel__c != mapusers.get(acc.ownerid).user_channel__c && uid!='0057F000003RvIZ' && Trigger.oldMap.get(acc.Id).OwnerId != acc.OwnerId){
                        acc.SalesChannel__c = mapusers.get(acc.ownerid).user_channel__c;            
                    } 
                }else{
                    if(acc.SalesChannel__c != mapusers.get(acc.ownerid).user_channel__c && uid!='0057F000003RvIZ'){
                        acc.SalesChannel__c = mapusers.get(acc.ownerid).user_channel__c;            
                    } 
                }
            } 
        }
          //Nag
    for(Account Acc:trigger.new){        
        if(trigger.isupdate){
            Account oldaccount = new Account();
            oldaccount = trigger.oldmap.get(Acc.id);        
            if(oldaccount.CreditStatus__c !=Acc.CreditStatus__c ){            
                Acc.CrHoldDate__c = system.today();
                Acc.CrHoldBy__c = userinfo.getName();
                system.debug('uuuuuuuuuu'+userinfo.getName());                                                        }
                if(Acc.Lead_Account_Status__c =='Active'&& Acc.Lead_Account_Active_Date__c==null) {      
                    Acc.Lead_Account_Active_Date__c = system.today();
                }  
            }
                                                   
     }    
   }
}