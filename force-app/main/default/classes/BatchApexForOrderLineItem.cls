global class BatchApexForOrderLineItem implements Database.Batchable  <sObject>{

  
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //String s='';
        String cc='select id,CurrencyIsoCode,Order__r.CurrencyIsoCode,Order__c from Order_Line_Item__c ';
       return  Database.getQueryLocator(cc); 
   }  
    global void execute(Database.BatchableContext bc, List<Order_Line_Item__c> scope){
               
        List<Order_Line_Item__c> qp= new LIst<Order_Line_Item__c>();
        
        for(Order_Line_Item__c dd:scope){
            //system.debug('Apac Payment'+dd.APAC_Payments__r.size());
            //system.debug('Price List Wala Ji'+dd.PriceList__c);
            //for(Product_PriceList__c aa:pp){
               
                    Order_Line_Item__c ee= new Order_Line_Item__c();
                    ee.id=dd.id;
                    //ee.PriceList__c=aa.id;
                    ee.CurrencyIsoCode=dd.Order__r.CurrencyIsoCode;
                    qp.add(ee);
                    
                   
                
                
            }
          
        system.debug('Yahan pe hu'+qp.size());
        update qp;
        
    
    }
    global void finish(Database.BatchableContext bc){     
   } 
}