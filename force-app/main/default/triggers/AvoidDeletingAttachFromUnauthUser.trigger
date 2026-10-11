trigger AvoidDeletingAttachFromUnauthUser on ContentDocument (before delete) {

    
    Trigger__c t = [SELECT id,name,Active__c FROM Trigger__c WHERE name='Attachment' LIMIT 1];
 system.debug('triggerrrr--->'+t.Active__c);
    if(t.Active__c == TRUE){
    List<DeleteAttachment__c> da = new List<DeleteAttachment__c>([SELECT id,name,Granted__c,UserId__c FROM DeleteAttachment__c]);
  
    Map<id,DeleteAttachment__c> mp = new  Map<id,DeleteAttachment__c>();
    for(DeleteAttachment__c d : da){
        mp.put(d.UserId__c, d);  
    } 
    
    for(ContentDocument record : trigger.old){
       
       
     
        
        if(mp.get(userinfo.getUserId()) != NULL){
        system.debug('userid--->'+mp.get(userinfo.getUserId()).UserId__c);
                   
                   system.debug('user mapping--->');
                   system.debug('userGranted--->'+mp.get(userinfo.getUserId()).Granted__c);
                   
                   if(mp.get(userinfo.getUserId()).Granted__c == false ){
                       system.debug('granted false--->');
                       record.adderror('you cannot delete the Attachment');
                   }
               
      
        } else{ system.debug('elseee--->');
            record.adderror('you cannot delete the Attachment');
        }
            
       
        
      }
   }
    
}