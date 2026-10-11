trigger RollupAttaCountOfKYC on ContentDocumentLink (after insert,after delete,after update,after undelete) {
    system.debug('contentduke');
    
     list<Client_Validation_Request__c> kyclst = new list<Client_Validation_Request__c>(); 
    set<id> kycids = new set<id>();
    
    if(!trigger.isdelete ){
        system.debug('ifaminsert');
    for(ContentDocumentLink cdl : trigger.new){
        kycids.add(cdl.LinkedEntityId);
    }
  }
    
    if(trigger.isdelete){
        
         for(ContentDocumentLink cdl : trigger.old){
        kycids.add(cdl.LinkedEntityId);
    }
       
    }
    
  
    kyclst = [select id,No_of_Attachments__c,(select ContentDocumentId,LinkedEntityId from ContentDocumentLinks  ) from Client_Validation_Request__c where id IN :kycids];
    system.debug('mykycvalues'+kyclst);
    for(Client_Validation_Request__c kyc : kyclst){
        system.debug('cominginforrrrrrrrrr@@@@');
        for(ContentDocumentLink cl : kyc.ContentDocumentLinks){
            system.debug('secforrrrrszeee'+kyc.ContentDocumentLinks.size());
            if(kyc.ContentDocumentLinks.size()>0  ){
                system.debug('lstifffff');
                kyc.No_of_Attachments__c = kyc.ContentDocumentLinks.size();
                
            }
            
        }
    }
update kyclst;
}