// Moodified by Ram for Sending mail to Collection team based on credit status on 13/02/2019
trigger UpdateDateforstage on Opportunity__c (before insert, before update,after insert) {
  Trigger__c t = trigger__c.getValues('Opportunity');  
  //  t = [select id,name,Active__c FROM Trigger__c WHERE name='Opportunity' LIMIT 1];
    
    set<id> aid = new set<id>(); 
    
    if(t.Active__c==true){
    
    if(Trigger.isBefore){
    
    If(Trigger.Isinsert&&Trigger.IsBefore){
        for(Opportunity__c o : trigger.new){
            o.Probability__c = '0';
        }    
    }
    for(Opportunity__c o : trigger.new){
    
        if(o.Opportunity_Lost_deferred__c){
            o.Stage__c = 'Closed Lost';
            o.Probability__c = '0';
            o.Close_Date__c = system.today();
        }
        
        if(o.Stage__c == 'Identification'){
            o.Identification_Date__c = system.today();
        }
        else if(o.Stage__c == 'Need Analysis'){
            o.Qualification_Date__c = system.today();
        }
        else if(o.Stage__c == 'Proposal Sent'){
            o.Proposal_Date__c = system.today();
        }
        else if(o.Stage__c == 'Negotiation Complete'){
            o.Negotiation_Date__c = system.today();
        }
        else if(o.Stage__c == 'Quote / Agreement Stage'){
            o.Quote_Agreement_Stage__c = system.today();
        }
        else if(o.Stage__c == 'Closed Won'){
            o.Closed_Won_for_Target__c = system.now();
            o.Closed_Won_Date__c = system.today();
        }
        else if(o.Stage__c == 'Closed Lost'){
            o.Closed_Lost_for_Target__c = system.now();
            o.Closed_Lost__c = system.today();
            }
        
        }
    }
    if(trigger.IsAfter){
    
     for(Opportunity__c o : trigger.new){
         aid.add(o.Account__c);
     }
     
     map<id,Account> OpportunityAccount = new map<id,Account>([SELECT id,CreditStatus__c,name FROM Account WHERE id=:aid]);
    list<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
   /* EmailTemplate Mailtemp = [SELECT id, name,Description  FROM EmailTemplate WHERE Description ='opportunityOnInactiveAccount' limit 1];
      System.debug('tmp size-->'+Mailtemp);*/
      
    for(Opportunity__c o : trigger.new){
     
    if(OpportunityAccount.get(o.Account__c) != NULL && (OpportunityAccount.get(o.Account__c).CreditStatus__c == 'On Hold - Finance' || OpportunityAccount.get(o.Account__c).CreditStatus__c == 'On Hold - Compliance' || OpportunityAccount.get(o.Account__c).CreditStatus__c == 'On Hold - Both' || OpportunityAccount.get(o.Account__c).CreditStatus__c == 'Suspend')){
    
    Messaging.SingleEmailMessage smail = new Messaging.SingleEmailMessage();
        //smail.setToAddresses(new string[]{'crm@cloudexpertsindia.com'});
        smail.setToAddresses(new string[]{'Apprsalesexp@Monsterindia.com'});
        smail.setSenderDisplayName('Salesforce Support');
        smail.setSubject(' Opportunity '+o.Name+' created upon negative Account');
        smail.setHTMLBody('Opportunity Name:'+o.Name+'<BR/>'+
                               'Account Name:'+OpportunityAccount.get(o.Account__c).name+'<br/><br/><br/>'+
                               'Thanks & Regards'+'<br/>'+'Salesforce Support');
      /*  smail.setTemplateId(Mailtemp.id);
        smail.setTargetObjectId(o.Contact__C);*/
        listMail.add(smail);
    
    }
    
    }
    Messaging.sendEmail(listMail);
    }
    
    }
   if( (trigger.isbefore && trigger.isupdate) )
   {
       
       for(Opportunity__c ee : Trigger.new){
       Opportunity__c eold =  Trigger.oldMap.get(ee.Id);
       ee.Previous_Stage__c = eold.Stage__c ;
       System.debug('Tis is the old value of ee'+ ee.Previous_Stage__c);
      
   }
    
 }
}