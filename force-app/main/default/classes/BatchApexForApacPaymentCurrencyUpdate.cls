global class BatchApexForApacPaymentCurrencyUpdate implements Database.Batchable  <sObject>{

  
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //String s='';
        String cc='select id,CurrencyIsoCode,Proposal__r.CurrencyIsoCode,Proposal__c from APTS_APAC_Payment__c';
       return  Database.getQueryLocator(cc); 
   }  
    global void execute(Database.BatchableContext bc, List<APTS_APAC_Payment__c> scope){
               
        List<APTS_APAC_Payment__c> qp= new LIst<APTS_APAC_Payment__c>();
        
        for(APTS_APAC_Payment__c dd:scope){
            //system.debug('Apac Payment'+dd.APAC_Payments__r.size());
            //system.debug('Price List Wala Ji'+dd.PriceList__c);
            //for(Product_PriceList__c aa:pp){
               
                    APTS_APAC_Payment__c ee= new APTS_APAC_Payment__c();
                    ee.id=dd.id;
                    //ee.PriceList__c=aa.id;
                    ee.CurrencyIsoCode=dd.Proposal__r.CurrencyIsoCode;
                    qp.add(ee);
                    
                   
                
                
            }
          
        system.debug('Yahan pe hu'+qp.size());
      database.update(qp,false);
        
    
    }
    global void finish(Database.BatchableContext bc){     
   } 
}