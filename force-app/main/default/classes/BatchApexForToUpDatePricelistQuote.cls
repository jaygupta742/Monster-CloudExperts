global class BatchApexForToUpDatePricelistQuote implements Database.Batchable  <sObject>{
       
     public  string last_record;
     string header1='Record ID'+','+'error'+'\n';
    string finalbody1=header1;
    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //String s='';
        String cc='select id,PriceList__C,CurrencyIsoCode,pricelist__r.CurrencyIsoCode from apttus_proposal_proposal__c where  PriceList__C= \'\' or PriceList__C=null  ';
       return  Database.getQueryLocator(cc); 
   }  
    global void execute(Database.BatchableContext bc, List<apttus_proposal_proposal__c> scope){
        for(apttus_proposal_proposal__c jj:scope){
        for(OrderC__c oid:jj.Orders__r){
            
        }
        }
       //  List<Order_Line_Item__c >ol=[select id,Order__c, CurrencyIsoCode from Order_Line_Item__c  where Order__c=:oid];

          List<OrderC__c> od = new List<OrderC__c>();
          List<Order_Line_Item__c>oli= new  List<Order_Line_Item__c>();
          List<Proposal_Line_Item__c> pl= new list<Proposal_Line_Item__c>(); 
          List<APTS_APAC_Payment__c > py= new list<APTS_APAC_Payment__c >(); 
        
        List<apttus_proposal_proposal__c> qp= new LIst<apttus_proposal_proposal__c>();
        List<Product_PriceList__c> pp=[select id, CurrencyIsoCode from Product_PriceList__c ];
        for(apttus_proposal_proposal__c dd:scope){
            system.debug('Apac Payment'+dd.APAC_Payments__r.size());
            system.debug('Price List Wala Ji'+dd.PriceList__c);
            for(Product_PriceList__c aa:pp){
                if(dd.CurrencyIsoCode==aa.CurrencyIsoCode){
                    apttus_proposal_proposal__c ee= new apttus_proposal_proposal__c();
                    ee.id=dd.id;
                    ee.PriceList__c=aa.id;
                    ee.CurrencyIsoCode=aa.CurrencyIsoCode;
                    qp.add(ee);
                    
                   
                }
                
            }
            
            
            
        }
        system.debug('Yahan pe hu'+qp.size());
        database.update(qp,false);
        
    }
    
    global void finish(Database.BatchableContext bc){    
        
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
    String[] toAddresses = new list<string> {'support@cloudexpertsindia.com'};
    String subject ='Account_auto_create_address  CSV';
    email.setSubject(subject);
    email.setToAddresses( toAddresses );
    email.setPlainTextBody('Account CSV '+last_record);
   
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
        
        
   } 
}