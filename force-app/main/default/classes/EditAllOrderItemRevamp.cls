public class EditAllOrderItemRevamp {
    
    @AuraEnabled
    public static string getstatus(string rid){
        Order__c qq=[select id,name,Order_Status__c from Order__c where id=:rid];
        
        return qq.Order_Status__c;
    }
    @AuraEnabled
    public static Date getenddate(string wroppp,string stdate,string ten){
        system.debug('tenure months:////////////////////////////////'+ten);
        system.debug('start date://///////////////////'+stdate);
        
        Date dt=Date.valueOf(stdate);
        string tenure=ten;
        Integer tm;
        Date edate;
        // Integer tm;
        if(tenure=='12 Months'){
            tm=12;
            system.debug('tm 12:'+tm );
            edate=dt.addMonths(tm).adddays(-1);
            // oli.End_Date__c=edate;
            system.debug('enddate 12:'+edate);
            // return edate;
        }
        if(tenure=='6 Months'){
            tm=6;
            system.debug('tm:'+tm);
            edate=dt.addMonths(tm).adddays(-1);
            // oli.End_Date__c=edate;
            system.debug('enddate 6:'+edate);
            // return edate;
            
        }
        if(tenure=='3 Months'){
            tm=3;
            system.debug('tm:'+tm);
            edate=dt.addMonths(tm).adddays(-1);
            // oli.End_Date__c=edate;
            system.debug('enddate 3:'+edate);
        }
        if(tenure=='1 Month'){
            tm=1;
            system.debug('tm:'+tm);
            edate=dt.addMonths(tm).adddays(-1);
            //  oli.End_Date__c=edate;
            system.debug('enddate 1:'+edate);
        }
        if(tenure=='1 Week'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(6);
            //    oli.End_Date__c=edate;
            system.debug('enddate 1 week:'+edate);
        }
        if(tenure=='0.1 Months'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(2);
            //    oli.End_Date__c=edate;
            system.debug('enddate 0.1 days:'+edate);
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           if(tenure=='1 Day'){
            //tm=1;
            //system.debug('tm:'+tm);
         edate=dt.adddays(0);
               //  oli.End_Date__c=edate;
        //system.debug('enddate:'+oli.End_Date__c);
        }
            if(tenure=='2 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
         edate=dt.adddays(1);
               //  oli.End_Date__c=edate;
       // system.debug('enddate:'+oli.End_Date__c);
        }
            if(tenure=='4 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
         edate=dt.adddays(3);
             //    oli.End_Date__c=edate;
        //system.debug('enddate:'+oli.End_Date__c);
        }
            if(tenure=='5 Days'){
            
          edate=dt.adddays(4);
                // oli.End_Date__c=edate;
        //system.debug('enddate:'+oli.End_Date__c);
        }
            if(tenure=='6 Days'){
         edate=dt.adddays(5);
        }
            if(tenure=='7 Days'){
         edate=dt.adddays(6);
        }
            if(tenure=='14 Days'){ 
         edate=dt.adddays(13);    
        }
            if(tenure=='60 Days'){
            //tm=1;
         edate=dt.adddays(59);
               
        }
        
        if(tenure=='2 Months'){
            tm=2;
            system.debug('tm:'+tm);
         edate=dt.addMonths(tm).adddays(-1);
                // oli.End_Date__c=edate;
        system.debug('enddate 2:'+edate);
        }
        if(tenure=='9 Months'){
            tm=9;
            system.debug('tm:'+tm);
         edate=dt.addMonths(tm).adddays(-1);
                // oli.End_Date__c=edate;
        system.debug('enddate 9:'+edate);
        }
        return edate;
        
    }
    @AuraEnabled
    public static string getAllLineItem(String rId)
    {
        system.debug('rId:'+rId);
        List<Order_Item__c> oppli = new List<Order_Item__c>();
        oppli = [Select Account__c, Actual_Disount_Cap__c, Adjustment_Type__c, Adjustment_Value__c, Base_Total__c, CreatedById,
            CreatedDate, CurrencyIsoCode, Discount_Amount__c, End_Date__c, Gross_Total__c, Id, Inventory_Count__c, IsDeleted,
           Master_login__c, Name,
            Opportunities__c, Order__c, Price_Master__c, Product_Country__c, Product_Geo_Scope__c, Product_Industry__c, Product_Name__c,
            Product_SKU__c, Product__c, Quantity__c, Quote_Line_Items__c, SKU_Nature__c, SKU_Type__c, Start_Date__c, SystemModstamp,
            Tenure_Months__c,Product__r.name, Total_Discount_Amount__c, UOM__c, Unit_Price__c, of_Master_Login__c
                 FROM Order_Item__c  
                 where Order__c=:rId];
        List<itemWrap> wrapList = new List<itemWrap>();
        for(Order_Item__c oo:oppli){
            itemWrap ii = new itemWrap(oo);
            ii.prodname=oo.Product__r.name;
            //ii.delAcc=oo.Delete_Acceories__c;
            wrapList.add(ii);
        }
        
        //return json.serialize(oppli);
        //return oppli;
        return json.serialize(wrapList);
        //return oppli;
    }
    
    @AuraEnabled
    public static String lineItemDel(String recId,string chklist){
        Order_Item__c kkl=[select id,name,Order__c from Order_Item__c where id=:recId];
        list<Order_Item_Services__c> opliAcc = new list<Order_Item_Services__c>();
        system.debug('recId: '+recId);
        system.debug('checklist: '+chklist);
        opliAcc = [Select Id,Name,Order_Item__c from Order_Item_Services__c where Order_Item__c=:recId ];
        system.debug(opliAcc);
        //if(opliAcc.size()>0&&chklist=='true'){
        if(opliAcc.size()>0){
            delete opliAcc;
        }
        
        Order_Item__c oplii = new Order_Item__c();
        oplii.Id=recId;
        delete oplii;
        
        List<Order_Item__c> oppli = new List<Order_Item__c>();
        oppli = [Select Account__c, Actual_Disount_Cap__c, Adjustment_Type__c, Adjustment_Value__c, Base_Total__c, CreatedById,
            CreatedDate, CurrencyIsoCode, Discount_Amount__c, End_Date__c, Gross_Total__c, Id, Inventory_Count__c, 
           Master_login__c, Name,
            Opportunities__c, Order__c, Price_Master__c, Product_Country__c, Product_Geo_Scope__c, Product_Industry__c, Product_Name__c,
            Product_SKU__c, Product__c, Quantity__c, Quote_Line_Items__c, SKU_Nature__c, SKU_Type__c, Start_Date__c, SystemModstamp,
            Tenure_Months__c,Product__r.name, Total_Discount_Amount__c, UOM__c, Unit_Price__c, of_Master_Login__c
                 FROM Order_Item__c 
                 where Order__c=:kkl.Order__c];
        system.debug('tyyu'+oppli);
        List<itemWrap> wrapList = new List<itemWrap>();
        for(Order_Item__c oo:oppli){
            itemWrap ii = new itemWrap(oo);
            ii.prodname=oo.Product__r.name;
            //ii.delAcc=oo.Delete_Acceories__c;
            wrapList.add(ii);
        }
        return json.serialize(wrapList);
    }
    
    @AuraEnabled
    public static string onsave(String listItem)
    {
        List<itemWrap> listlineItem = new List<itemWrap>();
        listlineItem = (list<itemWrap>)Json.deserialize(listItem, list<itemWrap>.class);
        list<Order_Item__c> ff=new list<Order_Item__c>();
        list<Order_Item_Services__c> opliAcclist=new list<Order_Item_Services__c>();
        Set<String> oplid = new Set<String>();
        try{
            for(itemWrap llo:listlineItem) 
            {
                ff.add(llo.opli);
                oplid.add(llo.opli.id);
                system.debug('updateAccQty: '+llo.updateAccQty);             
            }
            
            
            for(Order_Item__c gg:ff) {
                integer inte=0;
                if(gg.Order__c !=null){
                    Order__c qu=[select id,name,Order_Type__c from Order__c where id=:gg.Order__c];
                  
                } 
                
            }
            update ff; 
            opliAcclist = [Select id,Name,Quote_Line_Items__c from Order_Item_Services__c where Order_Item__c=:oplid];
            
            for(itemWrap llo:listlineItem){
                for(Order_Item_Services__c oac:opliAcclist){
                    if(llo.opli.Id==oac.Quote_Line_Items__c&&llo.updateAccQty){
                        oac.Quantity__c=llo.opli.Quantity__c;
                        
                                            }
                    
                }
            }
            update opliAcclist;
            return 'Sucessfully updated records!!!!';
        }
        catch(Exception ex){
            system.debug('ex.getmsg():'+ex.getMessage()); 
            system.debug('ex.getline():'+ex.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+ex.getMessage());
        }
    }
    
    public class itemWrap
    {
        @AuraEnabled
        public boolean delAcc{get;set;}
        public string prodname{get;set;}
        public Order_Item__c opli{get;set;}
        public boolean updateAccQty{get;set;}
        
        public itemWrap(Order_Item__c	li){
            opli = new Order_Item__c();
            opli = li;
            updateAccQty = false;  
        }
    }
}