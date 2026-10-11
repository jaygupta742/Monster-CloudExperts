public class AddAccessoriesLineItem {
    
    @AuraEnabled
    public static string getRelatedAccessories(string recId){
        system.debug('recId in addAccessoriesLineItem : '+recId);
        
        Opp_Line_Item__c oplItem = [Select Id,Name,Opportunities__c,Account__c,Price_Master__c,Discount_Type__c,Discount_Value__c,CurrencyIsoCode,
                                            Quantity_Unit__c,Tenure_Months__c,Unit_Price__c,Product__c from Opp_Line_Item__c where id=:recId];
        List<TopUps__c> oplAcc =[Select Id,Name,UOM__c,Quantity__c,Additonal_Top_Up__c,Top_Up_Type__c,Inventory_Quota_Tenure__c,Unit_Price__c,
                                 Product_Name__c,Product_SKU_Code__c,Product__r.Name from TopUps__c where Price_Master__c=:oplItem.Price_Master__c
                                 AND Product__c=:oplItem.Product__c AND Top_Up_Type__c!=:'Master Login'];
        

        //list<OPLI_Accessories__c> opplac=[Select Id,Top_Up_Name__c,Name,Top_Ups__c,Inventory_Quota_Tenure__c,Unit_Price__c,Product__r.Name from OPLI_Accessories__c where Price_Master__c=:oplItem.Price_Master__c AND Product__c=:oplItem.Product__c AND Top_Up_Name__c=:'Master Login'];
        system.debug('oplAcc : '+oplAcc);
        List<accWrap> itemWrap = new List<accWrap>();
         
        for(TopUps__c pp : oplAcc){
            
          OPLI_Accessories__c oli = new OPLI_Accessories__c();
          oli.Top_Ups__c = pp.id;
          oli.Opp_Line_Item__c=recId;
          oli.Product__c = pp.Product__C;
          oli.Account__c=oplItem.Account__c;
          oli.Price_Master__c = oplItem.Price_Master__c;
          oli.CurrencyIsoCode=oplItem.CurrencyIsoCode; 
                      system.debug(pp.Quantity__c);

           oli.Quantity_Unit__c=pp.Quantity__c;
            oli.Adjustment_Type__c=oplItem.Discount_Type__c;
            oli.Adjustment_Value__c=oplItem.Discount_Value__c;
           
           if(pp.Top_Up_Type__c=='User Login'||pp.Top_Up_Type__c=='Inventory Login'||pp.Top_Up_Type__c=='Power Login')
           {
            oli.Unit_Price__c = oplItem.Unit_Price__c;
           }
            if(oplItem.Tenure_Months__c=='1 Month'&&pp.Inventory_Quota_Tenure__c=='Per Month')
            {
          oli.Quantity__c=1;
            }
             else if(oplItem.Tenure_Months__c=='3 Months'&&pp.Inventory_Quota_Tenure__c=='Per Month')
            {
          oli.Quantity__c=3;
            }
             else if(oplItem.Tenure_Months__c=='6 Months'&&pp.Inventory_Quota_Tenure__c=='Per Month')
            {
          oli.Quantity__c=6;
            }
            else if(oplItem.Tenure_Months__c=='12 Months'&&pp.Inventory_Quota_Tenure__c=='Per Month')
            {
          oli.Quantity__c=12;
            }
            else if(pp.Inventory_Quota_Tenure__c=='Tenure')
            {
          oli.Quantity__c=1;
            }
            
                
            
          accWrap aa = new accWrap(oli);
            aa.accName = pp.Name;
            aa.prodsku=pp.Product_SKU_Code__c;
            aa.prodName = pp.Product_Name__c;
            aa.priceRate = pp.Unit_Price__c;            
            aa.invtenure = pp.Inventory_Quota_Tenure__c;
            aa.topuptype=pp.Top_Up_Type__c;
            aa.additop=pp.Additonal_Top_Up__c;
            aa.uom=pp.UOM__c;
            aa.invcount=pp.Quantity__c;
            
            //aa.gst=pp.Accessories__r.GST__c;
            
          itemWrap.add(aa);
            
        }
        return JSON.serialize(itemWrap);
    }
    
    @AuraEnabled
    public static void saveOpli(string strWrap, string RecordId){
        system.debug('strWrap: '+strWrap);
        system.debug('RecordId: '+RecordId);
        List<OPLI_Accessories__c> insertAcc = new List<OPLI_Accessories__c>();
     Opp_Line_Item__c oplItem = [Select Id,Name,Opportunities__c,Account__c,Price_Master__c,Discount_Type__c,Discount_Value__c,CurrencyIsoCode,
                                            Quantity_Unit__c,Product__c from Opp_Line_Item__c where id=:RecordId];
         try{
            list<accWrap> oppWrap=(list<accWrap>)Json.deserialize(strWrap, list<accWrap>.class);
            List<OPLI_Accessories__c> oplii = new List<OPLI_Accessories__c>();
            for(accWrap oo : oppWrap){
                if(oo.opli.Quantity_Unit__c!=null&&oo.ckb==true){
                    oo.opli.Opportunities__c = oplItem.Opportunities__c;
                   
                    //oo.opli.Discount_Type__c=oo.dtype;
                     //oo.opli.Discount_Value__c=oo.dvalue;
                    //oo.opli.GST_Percent__c=oo.gst;
                    oplii.add(oo.opli);
                }
                system.debug('oplii: '+oplii);
                
            }
            if(oplii.size()>0){
                   insert oplii; 
                } 
        }
        catch(exception ex){
            system.debug('In Exception: '+ex.getMessage());
            system.debug('getLineNumber: '+ex.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
    }

    public class accWrap{
        public OPLI_Accessories__c opli{get;set;}
        public string prodName{get;set;}
        public string accName{get;set;}
        public string topuptype{get;set;}
        public string barCode{get;set;}
        public string typeAcc{get;set;}
        public Boolean ckb{get;set;}
        public string prodsku{get;set;}
        public decimal priceRate{get;set;}
        public decimal invcount{get;set;} 
        public string invtenure{get;set;}
        public string uom{get;set;}
        public decimal gst{get;set;}
        public boolean additop{get;set;}
        
        public accWrap(OPLI_Accessories__c li){
            opli = new OPLI_Accessories__c();
            opli = li;
            ckb = false;
        }
    }
}