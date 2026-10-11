public class editAllOpportunityLineItem {
    
    @AuraEnabled
    public static string getAllLineItem(String rId){
        system.debug('rId:'+rId);
        List<Opp_Line_Item__c> oppli = new List<Opp_Line_Item__c>();
        oppli = [Select Id,Name,Discount_Type__c,Discount_Value__c,Base_Total__c,
                 Product__c,Product__r.Product_Name__c,Discount_Amount_1__c,Gross_Total__c,Product__r.Bin__c,Product__r.to__c,Product__r.From__c,Quantity_Unit__c,Comment__c,Start_Date__c,End_Date__c,SKU_Code__c,Tenure_Months__c,
                 Product_Selling_Country__c,Unit_Price__c,Opportunities__c from Opp_Line_Item__c where Opportunities__c=:rId];
        List<itemWrap> wrapList = new List<itemWrap>();
        for(Opp_Line_Item__c oo:oppli){
            
            
            itemWrap ii = new itemWrap(oo);
            
            /*if(oo.Discount_Type__c!='Amount' || oo.Discount_Type__c!='Base Price Override' || oo.Discount_Type__c!='Price Override'){
                 ii.damt=((oo.Discount_Value__c*oo.Unit_Price__c)/100);
                ii.grosstotal=((oo.Unit_Price__c*oo.Quantity_Unit__c)-(oo.Discount_Value__c*oo.Unit_Price__c)/100);
            }
            
            if(oo.Discount_Type__c=='Base Price Override'){
                ii.grosstotal=oo.Discount_Value__c;
                ii.damt=oo.Unit_Price__c* oo.Quantity_Unit__c -oo.Discount_Value__c;

            }
            if(oo.Discount_Type__c=='Price Override'){
                ii.grosstotal=oo.Discount_Value__c*oo.Quantity_Unit__c;
                ii.damt=oo.Unit_Price__c* oo.Quantity_Unit__c - oo.Discount_Value__c*oo.Quantity_Unit__c;
            }
            if(oo.Discount_Type__c=='Amount'){
                ii.damt=oo.Discount_Value__c;
                ii.grosstotal=oo.Unit_Price__c*oo.Quantity_Unit__c-oo.Discount_Value__c;

            }*/
            
            ii.prodname=oo.Product__r.Product_Name__c;
            ii.bin=oo.Product__r.Bin__c;
            ii.to=integer.valueOf(oo.Product__r.to__c);
            ii.fromqty=integer.valueOf(oo.Product__r.From__c);
            //ii.delAcc=oo.Delete_Acceories__c;
            wrapList.add(ii);
        }
        
        //return json.serialize(oppli);
        //return oppli;
        return json.serialize(wrapList);
        //return oppli;
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
        
        if(tenure=='3 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
         edate=dt.adddays(2);
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
        if(tenure=='15 days'){ 
         edate=dt.adddays(14);    
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
            
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           
           /*if((tenure=='Tenure') || (tenure=='Per Month') || (tenure=='As per Balance Original Contract')){
            //tm=1;
            //system.debug('tm:'+tm);
         Date edate=null;
                // oli.End_Date__c=null;
        system.debug('enddate null:'+oli.End_Date__c);
            return edate;

        }*/
       return edate;
        
    }
    
    @AuraEnabled
    public static String lineItemDel(String recId, string chklist){
        Opp_Line_Item__c kkl=[select id,name,Opportunities__c from Opp_Line_Item__c where id=:recId];
        list<OPLI_Accessories__c> opliAcc = new list<OPLI_Accessories__c>();
        system.debug('recId: '+recId);
        system.debug('checklist: '+chklist);
        opliAcc = [Select Id,Name,Opportunities__c,Opp_Line_Item__c from OPLI_Accessories__c where Opp_Line_Item__c=:recId ];
        system.debug(opliAcc);
      //  if(opliAcc.size()>0&&chklist=='true'){
        if(opliAcc.size()>0){
            delete opliAcc;
        }
        
        Opp_Line_Item__c oplii = new Opp_Line_Item__c();
        oplii.Id=recId;
        delete oplii;
        
        List<Opp_Line_Item__c> oppli = new List<Opp_Line_Item__c>();
        oppli = [Select Id,Name,Discount_Type__c,Discount_Value__c,Base_Total__c,Discount_Amount_1__c,Gross_Total__c,
                 Product__c,Product__r.Product_Name__c,Product__r.Bin__c,Product__r.to__c,Product__r.From__c,Quantity_Unit__c,Comment__c,Start_Date__c,End_Date__c,SKU_Code__c,Tenure_Months__c,
                 Product_Selling_Country__c,Unit_Price__c,Opportunities__c from Opp_Line_Item__c where Opportunities__c=:kkl.Opportunities__c];
        
        system.debug('tyyu'+oppli);
        List<itemWrap> wrapList = new List<itemWrap>();
        for(Opp_Line_Item__c oo:oppli){
            itemWrap ii = new itemWrap(oo);
            ii.prodname=oo.Product__r.Product_Name__c;
            ii.bin = oo.Product__r.Bin__c;
            //ii.delAcc=oo.Delete_Acceories__c;
            wrapList.add(ii);
        }
        return json.serialize(wrapList);
    }
    
    @AuraEnabled
    public static string onsave(String listItem){
        List<itemWrap> listlineItem = new List<itemWrap>();
        listlineItem = (list<itemWrap>)Json.deserialize(listItem, list<itemWrap>.class);
        list<Opp_Line_Item__c> ff=new list<Opp_Line_Item__c>();
        list<OPLI_Accessories__c> opliAcclist=new list<OPLI_Accessories__c>();
        Set<String> oplid = new Set<String>();
        try{
            for(itemWrap llo:listlineItem) {
                ff.add(llo.opli);
                oplid.add(llo.opli.id);
                system.debug('updateAccQty: '+llo.updateAccQty);             
            }
            
            update ff;
            
            opliAcclist = [Select id,Name,Quantity_unit__c,Opp_Line_Item__c from OPLI_Accessories__c where Opp_Line_Item__c=:oplid];
            
            for(itemWrap llo:listlineItem){
                for(OPLI_Accessories__c oac:opliAcclist){
                    if(llo.opli.Id==oac.Opp_Line_Item__c&&llo.updateAccQty){
                        oac.Quantity_Unit__c=llo.opli.Quantity_Unit__c;
                    }
                }
            }
            update opliAcclist;
            return 'Sucessfully updated records!!!!';
        }
        catch(Exception ex){
            system.debug('ex.getMessage():'+ex.getMessage());
               system.debug('ex.getMessage():'+ex.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+ex.getMessage());
        }
    }
    
    public class itemWrap{
        @AuraEnabled
        public boolean delAcc{get;set;}
        public string prodname{get;set;}
        public Opp_Line_Item__c opli{get;set;}
        public boolean updateAccQty{get;set;}
        public decimal grosstotal{get;set;}
        public decimal basetotal{get;set;}
        public string bin{get;set;}
        public decimal to{get;set;}
        public decimal fromqty{get;set;}
        public decimal damt{get;set;}
        public string uom{get;set;}
        
        public itemWrap(Opp_Line_Item__c li){
            opli = new Opp_Line_Item__c();
            opli = li;
            updateAccQty = false;  
        }
    }
}