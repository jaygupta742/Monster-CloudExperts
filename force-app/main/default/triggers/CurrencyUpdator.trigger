trigger CurrencyUpdator on Order_Line_Item__c (before Insert,before update,after insert,after update,before delete,after undelete) {

 If((trigger.isbefore && trigger.isInsert)||(trigger.isbefore && trigger.isUpdate))
 {
     list<Order_Line_Item__c >    b=new list<Order_Line_Item__c >(); 
    LIst<id> d= new list<id>();
              for(Order_Line_Item__c cc:trigger.new){
        
        d.add(cc.Order__c);
        
             }
         
         system.debug('@@@@@@@@@@@@@@@@@@@@@@Here I m Test');
        LIst<OrderC__c> qp= [select CurrencyIsoCode, id from OrderC__c where id=:d];
     if(trigger.Isinsert && Trigger.IsBefore){

         
         for(OrderC__c cc:qp){
             for(Order_Line_Item__c od:trigger.new){
                 if(cc.id==od.Order__c){
             od.CurrencyIsoCode= cc.CurrencyIsoCode;
            
                 }
            System.debug('@@@@@@@@@@Me Inside'+cc.CurrencyIsoCode);
         }
         }
       
    }
    /*
    if(trigger.Isupdate && Trigger.IsBefore){
        
         for(OrderC__c cc:qp){
             for(Order_Line_Item__c od:trigger.new){
                 if(cc.id==od.Order__c){
                  Order_Line_Item__c pp=new Order_Line_Item__c();
                  pp.id=od.id;
                  pp.CurrencyIsoCode= cc.CurrencyIsoCode;
                  b.add(pp);
                 }
         }
         }
        update b;
        
    }
*/ 
 }
 /*added by yamini*/
    
    if((trigger.isAfter && trigger.isInsert)||(trigger.isAfter && trigger.isUpdate)||(trigger.isAfter && trigger.isdelete)||(trigger.isAfter && trigger.isUndelete))
    { 
        //String lpd;
        date latestproddate;
        String aid;
       // List<Order_Line_Item__c> lorli = new List<Order_Line_Item__c>();
        //lorli = [select id,Name,Order__c,Order__r.Name,Order__r.Account__r.Name,End_Date__c,Product__r.name from Order_Line_Item__c where id=:trigger.new];
        set<id> oid = new set<id>();
        for(Order_Line_Item__c ol : Trigger.new){
            oid.add(ol.Order__c);
        }
        List<Order_Line_Item__c> lorl = new List<Order_Line_Item__c>();
        lorl = [select id,Name,Order__c,Order__r.Name,Order__r.Account__r.Name,End_Date__c,Product__r.name from Order_Line_Item__c where Order__c=:oid];
        
        
        for(Order_Line_Item__c oo :lorl)
        { 
            if(latestproddate==null)
            {
               latestproddate=oo.end_Date__c; 
            }    
            if(oo.end_Date__c >latestproddate && latestproddate!=null)
            {
                latestproddate = oo.end_Date__c; 
            }
            aid = oo.Order__r.Account__r.id;
        }
         System.debug('Account id->'+aid);
        	Account aa = new Account();
            aa.Latest_Product_End_Date__c = latestproddate ;
        	aa.id = aid;
      		update aa;
    }
}