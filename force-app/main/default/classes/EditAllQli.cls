/* Last Modified Date : 18/10/2023 , Last Modified by Suraj : Last Modified for Update Opportunity Line ITEM*/
public class EditAllQli {
    
    @AuraEnabled
    public static string getstatus(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c from QuotesN__c where id=:rid];
        return qq.Approval_Status_Overall__c;
    }
    
    @AuraEnabled
    public static Boolean getValidatedstatus(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c,Validated__c from QuotesN__c where id=:rid];
        return qq.Validated__c;
        
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
    public static string getAllLineItem(String rId)
    {
        system.debug('rId:'+rId);
        List<Quote_Line_Items__c> oppli = new List<Quote_Line_Items__c>();
        oppli = [SELECT Account__c,Product__r.name,Actual_Disount_Cap__c,Adjusted_Value__c,Adjustment_Type__c,Base_Total__c,CreatedById,CreatedDate,CurrencyIsoCode,DB_Scope_Geography__c,
                 DB_Type_Industry__c,Discount_Cap__c,Discount_Type__c,Discount_Value__c,End_Date__c,Gross_Total__c,Id,Inventory_Count__c,IsDeleted,LastActivityDate,LastModifiedById,
                 LastModifiedDate,Master_login__c,Name,of_Master_Login__c,Opportunities__c,Opp_Line_Item__c,Parent_OPLI__c,Price_Master__c,Product_Category__c,
                 Product_Country__c,Product_Geo_Scope__c,Product_Industry__c,Product_Name__c,Product_PL_ID__c,Product_Selling_Country__c,Product_Type__c,Product__c,Quantity_Unit__c,
                 Quotes__c,SKU_Code__c,SKU_Nature__c,SKU_Type__c,Start_Date__c,SystemModstamp,Tenure_Months__c,Top_Ups__c,Unit_Price__c,UOM__c,Comment__c FROM Quote_Line_Items__c  where Quotes__c=:rId];
        List<itemWrap> wrapList = new List<itemWrap>();
        for(Quote_Line_Items__c oo:oppli){
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
        Quote_Line_Items__c kkl=[select id,name,Quotes__c from Quote_Line_Items__c where id=:recId];
        list<QULI_Accessories__c> opliAcc = new list<QULI_Accessories__c>();
        system.debug('recId: '+recId);
        system.debug('checklist: '+chklist);
        opliAcc = [Select Id,Name,Quote_Line_Items__c from QULI_Accessories__c where Quote_Line_Items__c=:recId ];
        system.debug(opliAcc);
        //if(opliAcc.size()>0&&chklist=='true'){
        if(opliAcc.size()>0){
            delete opliAcc;
        }
        
        Quote_Line_Items__c oplii = new Quote_Line_Items__c();
        oplii.Id=recId;
        delete oplii;
        
        List<Quote_Line_Items__c> oppli = new List<Quote_Line_Items__c>();
        oppli = [Select Account__c,Quantity_Unit__c,Unit_Price__c,SKU_Nature__c,SKU_Type__c,Tenure_Months__c,Comment__c,Opp_Line_Item__c,
                 End_Date__c,Product__r.name,Actual_Disount_Cap__c,Adjusted_Value__c,Adjustment_Type__c,Base_Total__c,CreatedById,CreatedDate,CurrencyIsoCode,
                 DB_Scope_Geography__c,DB_Type_Industry__c,Discount_Cap__c,Discount_Type__c,Discount_Value__c,Start_Date__c,Gross_Total__c,Id,Inventory_Count__c 
                 from Quote_Line_Items__c where Quotes__c=:kkl.Quotes__c];
        system.debug('tyyu'+oppli);
        List<itemWrap> wrapList = new List<itemWrap>();
        for(Quote_Line_Items__c oo:oppli){
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
        list<Quote_Line_Items__c> ff=new list<Quote_Line_Items__c>();
        list<QULI_Accessories__c> opliAcclist=new list<QULI_Accessories__c>();
        Set<String> oplid = new Set<String>();
        Set<String> oplitemid= new Set<String>();
        try{
            for(itemWrap llo:listlineItem) 
            {
                ff.add(llo.opli);
                oplid.add(llo.opli.id);
                oplitemid.add(llo.opli.Opp_Line_Item__c);
                system.debug('updateAccQty: '+llo.updateAccQty);             
            }
            
            
            /* for(Quote_Line_Items__c gg:ff) {
integer inte=0;
if(gg.Quotes__c !=null){
// QuotesN__c qu=[select id,name,Quote_Type__c from QuotesN__c where id=:gg.Quotes__c];
if(qu.Quote_Type__c!='Upsell') {

if(gg.Tenure_Months__c=='12 Months') {
inte=12;   
}
else if(gg.Tenure_Months__c=='6 Months') {
inte=6;
}
else if(gg.Tenure_Months__c=='3 Months') {
inte=3;
}
else {
inte=1;
}
gg.End_Date__c=gg.Start_Date__c.addMonths(inte).adddays(-1);
}
else {
list<Quote_Line_Items__c> qli=[select id,name,Parent_OPLI__c,Active__c,End_Date__c,Opp_Line_Item__c from Quote_Line_Items__c where Opp_Line_Item__c=:gg.Parent_OPLI__c AND Active__c=:true LIMIT 1] ;   
system.debug('amit'+qli);
if(qli.size()>0) {
gg.End_Date__c=qli[0].End_Date__c;
}
}
} 

} */
            update ff; 
            opliAcclist = [Select id,Name,Quote_Line_Items__c from QULI_Accessories__c where Quote_Line_Items__c=:oplid];
            Opp_Line_Item__c[] opp=[Select Id,Start_Date__c,Unit_Price__c,Quantity_Unit__c, Discount_Value__c , Comment__c,Discount_Type__c  from Opp_Line_Item__c where id =: oplitemid ];
            for(itemWrap llo:listlineItem){
                for(QULI_Accessories__c oac:opliAcclist){
                    if(llo.opli.Id==oac.Quote_Line_Items__c&&llo.updateAccQty){
                        oac.Quantity_Unit__c=llo.opli.Quantity_Unit__c; 
                    }
                    
                }
            }
            update opliAcclist;
            id QoutId =ff[0].Quotes__c;
            Date minStartDate;
            Date maxEndDate;
            for(Quote_Line_Items__c gg:ff) {  
                if (minStartDate == null || gg.Start_Date__c < minStartDate) {
                    minStartDate = gg.Start_Date__c;
                }
                if (maxEndDate == null || gg.End_Date__c > maxEndDate) {
                    maxEndDate = gg.End_Date__c;
                }
                if(gg.Opp_Line_Item__c !=null){
                    for(Opp_Line_Item__c op:opp){
                        if(gg.Opp_Line_Item__c == op.Id){
                            op.Quantity_Unit__c = gg.Quantity_Unit__c;
                            op.Unit_Price__c = gg.Unit_Price__c;
                            op.Discount_Type__c = gg.Adjustment_Type__c;
                            op.Discount_Value__c = gg.Adjusted_Value__c;
                            op.Start_Date__c = gg.Start_Date__c;
                            op.End_Date__c = gg.End_Date__c;
                            op.Comment__c = gg.Comment__c;
                        } 
                    }
                }
            }  
            update opp; 
            //  system.debug('opp @@@@@@@@@@@@@  '+opp);
            SYSTEm.debug('Quotes__c  '+QoutId + ' minStartDate  '+minStartDate+' maxEndDate '+maxEndDate);
            if(QoutId != null){
                try{  QuotesN__c a=[Select id ,Start_Date__c,End_Date__c from QuotesN__c where id=:QoutId];
                    a.Start_Date__c = minStartDate;
                    a.End_Date__c = maxEndDate;
                    update a;
                   }
                catch(exception e){
                    
                }
            }
            return 'Sucessfully updated records!!!!';
        }
        catch(Exception ex){
              system.debug('ex.getline():'+ex.getLineNumber());
            system.debug('ex.getmsg():'+ex.getMessage()); 
          
            throw new AuraHandledException('Something went wrong: '+ex.getMessage());
        }
    }
    
    public class itemWrap
    {
        @AuraEnabled
        public boolean delAcc{get;set;}
        public string prodname{get;set;}
        public Quote_Line_Items__c opli{get;set;}
        public boolean updateAccQty{get;set;}
        
        public itemWrap(Quote_Line_Items__c	li){
            opli = new Quote_Line_Items__c();
            opli = li;
            updateAccQty = false;  
        }
    }
}