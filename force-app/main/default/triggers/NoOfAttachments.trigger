trigger NoOfAttachments on Attachment (after delete, after insert, after undelete)  {
   
    Trigger__c t = trigger__c.getvalues('Attachment');
    
    if(t.active__c == TRUE)
    {
	Set<ID> setOfCVRId = new Set<ID>();

    String cvrPrefix = Client_Validation_Request__c.SObjectType.getDescribe().getKeyPrefix();
   
    {
    if (Trigger.isInsert || Trigger.isUndelete) 
    {
        for (Attachment attachment : Trigger.new) 
        {
             if (attachment.parentId != null && string.valueOf(attachment.parentId).startsWith(cvrPrefix ) ) 
             {
                setOfCVRId.add(attachment.parentid);
             }
      }
   }
    
    if (Trigger.isDelete) {
    for (Attachment attachment : Trigger.old) {
     if (attachment.parentId != null && string.valueOf(attachment.parentId).startsWith(cvrPrefix ) ) 
             {
                setOfCVRId.add(attachment.parentid);
             }
      }
   }
    
    if(setOfCVRId.size()>0){
      
           List<Client_Validation_Request__c> cvrAttachmentCount = new List<Client_Validation_Request__c>();
            cvrAttachmentCount =  [select id,No_of_Attachments__c,(Select id from Attachments ) from Client_Validation_Request__c where Id = :setOfCVRId];
			for(Client_Validation_Request__c cvr :cvrAttachmentCount)
            {
                cvr.No_of_Attachments__c= cvr.Attachments.size();
  
            }
         update cvrAttachmentCount;
    }

}
    }
}