trigger CountRollup on OrderC__c (before insert,after delete, after insert, after update, after undelete) {
   Trigger__c t = Trigger__c.getValues('Order');
    if(t.active__c == true){
        
    list<OrderC__c>    b=new list<OrderC__c>(); 
    LIst<id> d= new list<id>();

     if(trigger.Isinsert && Trigger.IsBefore){
         for(OrderC__c cc:trigger.new){
        
        d.add(cc.QuoteProposal__c);
       
             }
         
         system.debug('@@@@@@@@@@@@@@@@@@@@@@Here I m Test');
        LIst<apttus_proposal_proposal__c> qp= [select CurrencyIsoCode, id from apttus_proposal_proposal__c where id=:d];
         
         for(apttus_proposal_proposal__c cc:qp){
             for(OrderC__c od:trigger.new){
                 if(od.QuoteProposal__c==cc.id){
             od.CurrencyIsoCode= cc.CurrencyIsoCode;
            // b.add(od);
            System.debug('@@@@@@@@@@Me Inside'+cc.CurrencyIsoCode);
                 }
         }
         }
        System.debug('@@@@@@@@@@Me'+b.size());
       // insert b;
    }
    
    if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
         
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('COUNT', 'ID', 
            'Number_of_Orders__c')
        };
         
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, trigger.new, 
        'OrderC__c', 'Account__c', 'Account', '');
    }   
    
    if(trigger.isDelete){
         
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('COUNT', 'ID', 
            'Number_of_Orders__c')
        };
         
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, trigger.old, 
        'OrderC__c', 'Account__c', 'Account', '');
    }  
    if(trigger.isupdate && Trigger.isAfter){
        for(OrderC__c cc:trigger.new){
        
        d.add(cc.id);
       
             }
        LIst<Order_Line_Item__c> odt = new LIst<Order_Line_Item__c>();
     LIst<Order_Line_Item__c> qp= [select CurrencyIsoCode,Order__r.CurrencyIsoCode, id from Order_Line_Item__c where Order__c=:d];
        for(Order_Line_Item__c cc: qp){
            Order_Line_Item__c o= new Order_Line_Item__c();
            o.id=cc.id;
            o.CurrencyIsoCode=cc.Order__r.CurrencyIsoCode;
            odt.add(o);
        }
        update odt;
              system.debug('QQQQQQQQQQ About to call');
        for(Orderc__C cc:trigger.new){
           
            Orderc__c oldcc=trigger.oldmap.get(cc.id);
             system.debug(cc.Flow_Trigger_Time__c+'QQQQQQQQQQ  About to call'+oldcc.Flow_Trigger_Time__c);
            if(cc.Flow_Trigger_Time__c!=oldcc.Flow_Trigger_Time__c){
                 system.debug('QQQQQQQQQQ About to call');
        Send_to_Order.CallFlowAccpuntStatusUpdate(cc.id);
            }
        }
    //}
        
    }
if(Trigger.Isbefore && Trigger.Isupdate){}
       
    }
}