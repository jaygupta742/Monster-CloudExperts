global class BatchApexForOrder implements Database.Batchable  <sObject>{

    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //String s='';
        String cc='select id,CurrencyIsoCode,QuoteProposal__r.CurrencyIsoCode,QuoteProposal__c from OrderC__c ';
       return  Database.getQueryLocator(cc); 
   }  
    global void execute(Database.BatchableContext bc, List<OrderC__c> scope){
               
        List<OrderC__c> qp= new LIst<OrderC__c>();
        
        for(OrderC__c dd:scope){
            //system.debug('Apac Payment'+dd.APAC_Payments__r.size());
            //system.debug('Price List Wala Ji'+dd.PriceList__c);
            //for(Product_PriceList__c aa:pp){
               
                    OrderC__c ee= new OrderC__c();
                    ee.id=dd.id;
                    //ee.PriceList__c=aa.id;
                    ee.CurrencyIsoCode=dd.QuoteProposal__r.CurrencyIsoCode;
                    qp.add(ee);
                    
                   
                
                
            }
          
        system.debug('Yahan pe hu'+qp.size());
        database.update(qp,false);        
    
    }
    global void finish(Database.BatchableContext bc){     
   } 
}