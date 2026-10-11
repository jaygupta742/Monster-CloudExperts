global class BatchApexForProposalLineItem implements Database.Batchable  <sObject>{

    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //String s='';
        String cc='select id,CurrencyIsoCode,Proposal_Locked__r.CurrencyIsoCode,Proposal_Locked__c from Proposal_Line_Item__c';
       return  Database.getQueryLocator(cc); 
   }  
    global void execute(Database.BatchableContext bc, List<Proposal_Line_Item__c> scope){
               
        List<Proposal_Line_Item__c> qp= new LIst<Proposal_Line_Item__c>();
        
        for(Proposal_Line_Item__c dd:scope){
            //system.debug('Apac Payment'+dd.APAC_Payments__r.size());
            //system.debug('Price List Wala Ji'+dd.PriceList__c);
            //for(Product_PriceList__c aa:pp){
               
                    Proposal_Line_Item__c ee= new Proposal_Line_Item__c();
                    ee.id=dd.id;
                    //ee.PriceList__c=aa.id;
                    ee.CurrencyIsoCode=dd.Proposal_Locked__r.CurrencyIsoCode;
                    qp.add(ee);
                    
                   
                
                
            }
          
        system.debug('Yahan pe hu'+qp.size());
       database.update(qp,false);
        
    
    }
    global void finish(Database.BatchableContext bc){     
   } 
}