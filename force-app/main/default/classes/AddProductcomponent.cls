//Last Modified By : Abdul Aziz  Date : 10/11/2023 , Description : If product type is custom then end date shoud be editable
public class AddProductcomponent {
    @AuraEnabled
    public static OpportunityN__c fetchOpportunity(String rId){
        system.debug('rId:'+rId);
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Opportunity_Type__c from OpportunityN__c where Id=:rId];
        system.debug('opp:'+opp);
        return opp;
    }
    
    @AuraEnabled
    public static String getAccountStatusApex(String recId){
        System.debug('Account Statis is:');
        OpportunityN__c Opportunity = new OpportunityN__c();
        Opportunity = [Select Id,Name,Account_Credit_Status__c,Account__c,Xcode__c,Price_Master__c,Opportunity_Type__c,CurrencyIsoCode,Contact__c from OpportunityN__c where Id =: recId];
        Account acc=[select id,name,AccountStatus__c from Account where id=:Opportunity.Account__c limit 1];
        System.debug('Account Statis is:'+acc.AccountStatus__c);
        return acc.AccountStatus__c;
    }
    
    
    @AuraEnabled
    public static Date todaysdate(){
        return system.today();
    }
    
    @AuraEnabled
    public static Date previousdate(){
        return system.today()-1;
    }
    
    @AuraEnabled
    public static Quote_Line_Items__c getoplitenure(String opId){
        // system.debug('opId:'+opId);
        Quote_Line_Items__c opli = new Quote_Line_Items__c();
        opli = [Select Id,Name,Sku_Type1__c,Product_Type1__c,SKU_Type__c,Product_Code__c,Tenure_Months__c,End_Date__c,Unit_Price__c,Product__c,Product_Selling_Country__c,Product_Type__c,Product_Industry__c,
                Product_Geo_Scope__c,Product_Country__c,Product_Category__c,SKU_Code__c,Adjusted_Value__c,Adjustment_Type__c from Quote_Line_Items__c where Id=:opId];
        // system.debug('opp:'+opp);
        return opli;
    }
    
    @AuraEnabled
    public static Opp_Line_Item__c getoplitenure1(String opId){
        // system.debug('opId:'+opId);
        Opp_Line_Item__c opli = new Opp_Line_Item__c();
        opli = [Select Id,Name,SKU_Type__c,Sku_Type1__c,Product_Type1__c,Tenure_Months__c,Start_Date__c,End_Date__c,Unit_Price__c,Product__c,Product_Selling_Country__c,Product_Type__c,DB_Type_Industry__c,
                DB_Scope_Geography__c,Product_Country__c,SKU_Code__c,Discount_Value__c,Discount_Type__c from Opp_Line_Item__c where Id=:opId];
        // system.debug('opp:'+opp);
        return opli;
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
            // return edate;
            
        }
        if(tenure=='1 Month'){
            tm=1;
            system.debug('tm:'+tm);
            edate=dt.addMonths(tm).adddays(-1);
            //  oli.End_Date__c=edate;
            system.debug('enddate 1:'+edate);
            // return edate;
        }
        if(tenure=='1 Week'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(6);
            //    oli.End_Date__c=edate;
            system.debug('enddate 1 week:'+edate);
            //return edate;
        }
        if(tenure=='0.1 Months'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(2);
            //    oli.End_Date__c=edate;
            system.debug('enddate 0.1 days:'+edate);
            //return edate;
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if(tenure=='1 Day'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(0);
            //oli.End_Date__c=edate;
            //system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='2 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(1);
            // oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        
        if(tenure=='3 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(2);
            // oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='4 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(3);
            //  oli.End_Date__c=edate;
            //system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='5 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(4);
            //  oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='6 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(5);
            //   oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='7 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(6);
            // oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='14 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(13);
            // oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='15 days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(14);
            // oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        if(tenure=='60 Days'){
            //tm=1;
            //system.debug('tm:'+tm);
            edate=dt.adddays(59);
            //    oli.End_Date__c=edate;
            // system.debug('enddate:'+oli.End_Date__c);
        }
        
        if(tenure=='2 Months'){
            tm=2;
            edate=dt.addMonths(tm).adddays(-1);
        }
        if(tenure=='4 Months'){
            tm=4;
            edate=dt.addMonths(tm).adddays(-1);
        }
        if(tenure=='13 Months'){
            tm=13;
            edate=dt.addMonths(tm).adddays(-1);
        }
        if(tenure=='9 Months'){
            tm=9;
            edate=dt.addMonths(tm).adddays(-1);
        }
        return edate;   
    }
    
    @AuraEnabled
    public static User usrdetails(String recid) {
        system.debug(recId);
        system.debug(UserInfo.getUserId());
        User uu=[Select Id,Name,Profile.name,Profile_Name__c,Email,MobilePhone from User where id=:UserInfo.getUserId()];
        system.debug(uu);
        return uu;
    }
    
    @AuraEnabled
    public static String fetchProducts(String rId){
        //Fetch Opportunity Related Price List
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Opportunity_Type__c,Price_Master__c,Price_Master__r.CurrencyIsoCode,CurrencyIsoCode,Account__c,User_Channel__c from OpportunityN__c where Id=:rId];
        
        
        List<ProductC__c> proPL2 = new List<ProductC__c>();
        
        System.debug('this is opportunity '+opp.Opportunity_Type__c);
        
        if(opp.Opportunity_Type__c == 'Free Trial') {
            proPL2=[SELECT Active_From__c,TPS_Unit_Price__c,TPS_Value_Type__c,TPS_Value__c,Product_Type__c,Active_to__c,Active__c,Gross_Total__c,Discount_Amount__c,bt__c,Bin__c,Channel__c,
                    CreatedById,CreatedDate,CurrencyIsoCode,DB_Scope_Geography__c,DB_Type_Industry__c,Discount_Cap_Amount__c,
                    Discount_Cap__c,From__c,Id,List_Price__c,Location__c,Main_Product_Type__c,Name,OwnerId,Price_Master__c,
                    Primary_Selling_Country__c,of_Master_Login__c,Product_category__c,Service_Fee__c,Product_Code__c,Product_Country__c,Product_Description__c,
                    Product_Name__c,Product_SKU_Code__c,Upsell_Inv_Count__c,SKU_Type__c,Tenure_Months__c,Top_Up_Count__c,To__c,Unit_List_Price_Value__c,
                    UOM__c FROM ProductC__c where Price_Master__c=:opp.Price_Master__c AND Active__c=true AND Channel__c=:opp.User_Channel__c AND Product_Type__c='Free Trial'];
            
        }
        if(opp.Opportunity_Type__c != 'Free Trial') {
            proPL2=[SELECT Active_From__c,TPS_Unit_Price__c,TPS_Value_Type__c,TPS_Value__c,Product_Type__c,Active_to__c,Active__c,Gross_Total__c,Discount_Amount__c,bt__c,Bin__c,Channel__c,
                    CreatedById,CreatedDate,CurrencyIsoCode,DB_Scope_Geography__c,DB_Type_Industry__c,Discount_Cap_Amount__c,
                    Discount_Cap__c,From__c,Id,List_Price__c,Location__c,Main_Product_Type__c,Name,OwnerId,Price_Master__c,
                    Primary_Selling_Country__c,of_Master_Login__c,Product_category__c,Service_Fee__c,Product_Code__c,Product_Country__c,Product_Description__c,
                    Product_Name__c,Product_SKU_Code__c,Upsell_Inv_Count__c,SKU_Type__c,Tenure_Months__c,Top_Up_Count__c,To__c,Unit_List_Price_Value__c,
                    UOM__c FROM ProductC__c where Price_Master__c=:opp.Price_Master__c AND Active__c=true AND Channel__c=:opp.User_Channel__c and Product_Type__c!='Free Trial'];
        }
        system.debug('fetched product size : '+proPL2.size());
        
        //Preparing Wrapper List to set in the Component Attribute
        List<oppItemWrapper> owrap = new List<oppItemWrapper>();
        
        for(ProductC__c pp : proPL2){
            Opp_Line_Item__c oli = new Opp_Line_Item__c();
            oli.Product__c = pp.id;
            oli.Price_Master__c = opp.Price_Master__c;
            oli.CurrencyIsoCode=opp.CurrencyIsoCode;
            if(pp.TPS_Value_Type__c=='%' || pp.TPS_Value_Type__c==null){
                oli.Unit_price__c = pp.Unit_List_Price_Value__c;
            }
            oli.Unit_price__c = pp.Unit_List_Price_Value__c;
            if(pp.TPS_Value_Type__c=='Amount'){
                oli.Unit_Price__c=pp.TPS_Value__c;
            }
            oli.Account__c=opp.Account__c;
            oli.Product_Country__c =pp.Product_Country__c;
            oli.Product_Selling_Country__c=pp.Primary_Selling_Country__c;
            oli.SKU_Code__c=pp.Product_SKU_Code__c;
            oli.DB_Type_Industry__c=pp.DB_Type_Industry__c;
            oli.DB_Scope_Geography__c=pp.DB_Scope_Geography__c; 
            oli.Tenure_Months__c=pp.Tenure_Months__c; 
            //oli.Discount_Value__c=pp.Discount_Cap__c;
            oli.Discount_Value__c=0;
            
            oli.Quantity_Unit__c=pp.From__c;
            oli.Base_Total__c=pp.bt__c;
            oli.Discount_Amount_1__c=pp.Discount_Amount__c;
            oli.Gross_Total__c=pp.Gross_Total__c;
            oli.of_Master_Login__c=pp.of_Master_Login__c;
            
            oli.Start_Date__c = date.today();
            oli.Sku_Type1__c=pp.SKU_Type__c;
            Date dt=system.today();
            string ten=pp.Tenure_Months__c;
            system.debug('tenure:'+ten);
            Integer tm;
            if(pp.Tenure_Months__c=='12 Months'){
                tm=12;
                system.debug('tm 12:'+tm );
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='6 Months'){
                tm=6;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='3 Months'){
                tm=3;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='1 Month'){
                tm=1;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='1 Week'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(6);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='0.1 Months'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(2);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='1 Day'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(0);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='2 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='3 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(2);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='4 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(3);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='5 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(4);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='6 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(5);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='7 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(6);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='14 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(13);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='15 days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(14);
                oli.End_Date__c=edate;
                // system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='60 Days'){
                //tm=1;
                //system.debug('tm:'+tm);
                Date edate=dt.adddays(59);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='2 Months'){
                tm=2;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='9 Months'){
                tm=9;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='4 Months'){
                tm=4;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if(pp.Tenure_Months__c=='13 Months'){
                tm=13;
                system.debug('tm:'+tm);
                Date edate=dt.addMonths(tm).adddays(-1);
                oli.End_Date__c=edate;
                system.debug('enddate:'+oli.End_Date__c);
            }
            if((pp.Tenure_Months__c=='Tenure') || (pp.Tenure_Months__c=='Per Month') || (pp.Tenure_Months__c=='As per Balance Original Contract')){
                //tm=1;
                //system.debug('tm:'+tm);
                //Date edate=dt.adddays(6);
                oli.End_Date__c=null;
                system.debug('enddate:'+oli.End_Date__c);
            }
            
            oppItemWrapper oo = new oppItemWrapper(oli);
            oo.Product_Name = pp.Product_Name__c;
            oo.todaydate = date.today(); 
            oo.channel = pp.Channel__c;
            oo.servicefee = pp.Service_Fee__c;
            oo.tenure = tm == null ? 0 : tm;
            oo.category = pp.Product_category__c;
            oo.prodtenure = pp.Tenure_Months__c;
            oo.priceRate = pp.Unit_List_Price_Value__c;
            oo.prodID = pp.Name;
            oo.sku = pp.Product_SKU_Code__c;
            oo.dbindustry = pp.DB_Type_Industry__c;
            oo.proocountry = pp.Product_Country__c;
            oo.proscountry = pp.Primary_Selling_Country__c;
            oo.discap = pp.Discount_Cap__c;
            oo.disamt = pp.Discount_Cap_Amount__c;
            oo.skutype = pp.SKU_Type__c;
            oo.prodname = pp.Product_Name__c;
            oo.uom = pp.UOM__c;
            oo.procode = pp.Product_Code__c;
            oo.prodesc = pp.product_description__c;
            oo.progeo = pp.DB_Scope_Geography__c;
            oo.channel = pp.Channel__c;
            oo.bin = pp.Bin__c;
            oo.typeProd = pp.Product_Type__c;
            oo.to = integer.valueOf(pp.To__c);
            oo.fromqty = integer.valueOf(pp.From__c);
            oo.invcount = pp.Upsell_Inv_Count__c;
            oo.Masterlogin = pp.of_Master_Login__c;            
            oo.tpo = pp.TPS_Value__c;
            oo.tpotype = pp.TPS_Value_Type__c;
            owrap.add(oo); 
        }        
        
        return json.serialize(owrap);
    }
    
    @AuraEnabled
    public static String fetchAccessories(String rId){
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,User_Channel__c,Price_Master__c,CurrencyIsoCode,Account__c from OpportunityN__c where Id=:rId];
        
        set<Id> pid=new set<Id>();
        List<ProductC__c> proPL2 = new List<ProductC__c>();
        proPL2=[SELECT Active_From__c,Product_Type__c,Active_to__c,Active__c,Gross_Total__c,Discount_Amount__c,bt__c,Bin__c,Channel__c,
                CreatedById,CreatedDate,CurrencyIsoCode,DB_Scope_Geography__c,DB_Type_Industry__c,Discount_Cap_Amount__c,
                Discount_Cap__c,From__c,Id,List_Price__c,Location__c,Main_Product_Type__c,Name,OwnerId,Price_Master__c,
                Primary_Selling_Country__c,of_Master_Login__c,Product_category__c,Product_Code__c,Product_Country__c,Product_Description__c,
                Product_Name__c,Product_SKU_Code__c,Upsell_Inv_Count__c,SKU_Type__c,Tenure_Months__c,Top_Up_Count__c,To__c,Unit_List_Price_Value__c,
                UOM__c FROM ProductC__c where Price_Master__c=:opp.Price_Master__c AND Active__c=true AND Channel__c=:opp.User_Channel__c ];
        
        
        List<TopUps__c> oplAcc =[Select Id,Name,UOM__c,Quantity__c,Product__r.Tenure_Months__c,Top_Up_Type__c,Inventory_Quota_Tenure__c,Unit_Price__c,
                                 Product_Name__c,Product_SKU_Code__c,Product__r.Name from TopUps__c where Price_Master__c=:opp.Price_Master__c];
        List<oppItemWrapper1> owrap = new List<oppItemWrapper1>();
        for(TopUps__c pp : oplAcc){
            OPLI_Accessories__c oli = new OPLI_Accessories__c();
            oli.Product__c = pp.Product__C;
            //oli.Top_Ups__c=pp.Top_Ups__c;
            oli.Price_Master__c = opp.Price_Master__c;
            oli.CurrencyIsoCode= opp.CurrencyIsoCode;
            oli.Account__c=opp.Account__c;
            oli.Quantity_Unit__c=pp.Quantity__c;
            oli.Quantity__c=pp.Quantity__c;
            
            oppItemWrapper1 oo = new oppItemWrapper1(oli);
            oo.prodtenure = pp.Product__r.Tenure_Months__c;
            oo.invtenure = pp.Inventory_Quota_Tenure__c;
            oo.prodName = pp.Name;
            
            oo.AccessId=pp.Id;
            
            owrap.add(oo); 
        }
        system.debug(owrap);
        return json.serialize(owrap);    
    }
    
    @AuraEnabled
    public static string saveOpli(string strWrap, string RecordId,string ptypes){
        system.debug('strWrap: '+strWrap);
        system.debug('RecordId: '+RecordId);
        system.debug('ptypes: '+ptypes);
        OpportunityN__c bopp=[select id,name,Price_Master__c,Account__c,Opportunity_Type__c from OpportunityN__c where id=:RecordId];
        set<string> accIds = new set<string>();
        List<OPLI_Accessories__c> insertAcc = new List<OPLI_Accessories__c>();
        try{
            list<oppItemWrapper> oppWrap=(list<oppItemWrapper>)Json.deserialize(strWrap, list<oppItemWrapper>.class);
            List<Opp_Line_Item__c> oplii = new List<Opp_Line_Item__c>();
            for(oppItemWrapper oo : oppWrap) {
                //oo.opli.OPLI__c=oo.opli.OpliId__c;
                if(bopp.Opportunity_Type__c=='Upsell') {
                    if(ptypes=='Upsell') {
                        //  oo.opli.QULI__c=oo.opli.OpliId__c;
                        //Quote_Line_Items__c qq=[Select Id,Name,Tenure_Months__c,End_Date__c,Unit_Price__c,Product__c  from Quote_Line_Items__c where Id=:oo.opli.OpliId__c];
                    }
                }
                
                accIds.add(oo.opli.Product__c);
                if(oo.opli.Quantity_Unit__c!=null&&oo.ckb==true){
                    oo.opli.Opportunities__c = RecordId;
                    //oo.opli.IGST__c=oo.gstValue;
                    /////////////////////////////////////////////////////////Monthly calculation///////////////////////////////////////////////
                    decimal monn;
                    if(ptypes!='Upsell'){
                        if(oo.opli.Tenure_Months__c=='12 Months'){
                            monn=12;
                        }
                        if(oo.opli.Tenure_Months__c=='6 Months'){
                            monn=6;
                        }
                        if(oo.opli.Tenure_Months__c=='3 Months'){
                            monn=3;
                        }
                        if(oo.opli.Tenure_Months__c=='1 Month'){
                            monn=1;
                        }
                        if(oo.opli.Tenure_Months__c=='0.1 Months'){
                            monn=0.1;
                        }
                        if(oo.opli.Tenure_Months__c=='1 Week'){
                            monn=6/30;
                        }
                        
                        if(oo.opli.Tenure_Months__c=='1 Day'){
                            monn=1/30;
                        }
                        if(oo.opli.Tenure_Months__c=='2 Days'){
                            monn=1/30;
                        }
                        if(oo.opli.Tenure_Months__c=='3 Days'){
                            monn=2/30;
                        }
                        if(oo.opli.Tenure_Months__c=='4 Days'){
                            monn=3/30;
                        }
                        if(oo.opli.Tenure_Months__c=='5 Days'){
                            monn=4/30;
                        }
                        if(oo.opli.Tenure_Months__c=='6 Days'){
                            monn=5/30;
                        }
                        if(oo.opli.Tenure_Months__c=='7 Days'){
                            monn=6/30;
                        }
                        
                        if(oo.opli.Tenure_Months__c=='14 Days'){
                            monn=13/30;
                        }
                        if(oo.opli.Tenure_Months__c=='15 days'){
                            monn=14/30;
                        }
                        if(oo.opli.Tenure_Months__c=='60 Days'){
                            monn=59/30;
                        }
                        
                        if(oo.opli.Tenure_Months__c=='2 Months'){
                            monn=2;
                        }
                        if(oo.opli.Tenure_Months__c=='9 Months'){
                            monn=9;
                        }
                        if(oo.opli.Tenure_Months__c=='4 Months'){
                            monn=4;
                        }
                        if(oo.opli.Tenure_Months__c=='13 Months'){
                            monn=13;
                        }
                    }
                    
                    if(ptypes=='Upsell'){
                        if(oo.opli.End_Date__c!=null){
                            Decimal dd=oo.opli.Start_Date__c.daysbetween(oo.opli.End_Date__c);
                            monn=dd/30;
                        }
                    }
                    if(oo.uom=='Per Month'){
                        system.debug('entered intpo opli per month');
                        Decimal months=oo.opli.Start_Date__c.monthsbetween(oo.opli.End_Date__c);
                        Decimal days=oo.opli.Start_Date__c.daysbetween(oo.opli.End_Date__c);
                        if(days>360 && days<365){
                            days=360;
                        }
                        if(days==29){
                            days=30;
                        }
                        decimal mon=days/30;
                        system.debug('total months opli:'+months);
                        system.debug('total months opli new:'+monn);
                        
                        oo.opli.Unit_Price__c=oo.opli.Unit_Price__c*monn;
                        
                        // oo.opli.Unit_Price__c=oo.opli.Unit_Price__c*mon;
                        
                    }
                    
                    if(oo.prodName == 'Sprynt'){
                        oo.opli.Service_Fee__c = oo.servicefee * oo.tenure; 
                    }
                    
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    oplii.add(oo.opli);
                }
            }
            
            if(oplii.size()>0){
                insert oplii; 
            } 
            List<TopUps__c> accList = new List<TopUps__c>();
            accList = [Select Id,Name,UOM__c,Top_Up_Type__c,Quantity__c,Product__c,Inventory_Quota_Tenure__c,Mandatory__c,Price_Master__c,Unit_Price__c 
                       from TopUps__c where Product__c=:accIds AND Mandatory__c=true];
            system.debug('topups: '+accList);
            
            
            for(Opp_Line_Item__c oli : oplii){
                for(TopUps__c aa : accList){
                    if(aa.Product__c==oli.Product__c){
                        OPLI_Accessories__c opa = new OPLI_Accessories__c();
                        opa.Top_Ups__c=aa.id;
                        opa.Opportunities__c=RecordId;
                        opa.Account__c=oli.Account__c;
                        opa.Opp_Line_Item__c=oli.id;
                        opa.Price_Master__c=oli.Price_Master__c;                        
                        opa.Quantity_Unit__c=aa.Quantity__c;
                        opa.Quantity__c=aa.Quantity__c;
                        
                        opa.Product__c=oli.Product__c;
                        opa.Adjustment_Type__c=oli.Discount_Type__c;
                        opa.Adjustment_Value__c=oli.Discount_Value__c;
                        if(aa.Top_Up_Type__c=='Master Login') {
                            opa.Unit_Price__c=oli.Unit_Price__c;  
                        }
                        if(aa.Top_Up_Type__c!='Master Login') {
                            opa.Unit_Price__c=aa.Unit_Price__c;  
                        }
                        
                        opa.Mandatory__c=aa.Mandatory__c;
                        opa.CurrencyIsoCode=oli.CurrencyIsoCode;
                        opa.Quantity_Unit__c=aa.Quantity__c*oli.Quantity_Unit__c;
                        opa.Quantity__c=aa.Quantity__c*oli.Quantity_Unit__c;
                        
                        ////////////////////////////////////////////////////Duration///////////////////////////////////////////
                        decimal monn;
                        if(ptypes!='Upsell'){
                            if(oli.Tenure_Months__c=='12 Months') {
                                monn=12;
                            }
                            if(oli.Tenure_Months__c=='6 Months') {
                                monn=6;
                            }
                            if(oli.Tenure_Months__c=='3 Months') {
                                monn=3;
                            }
                            if(oli.Tenure_Months__c=='1 Month') {
                                monn=1;
                            }
                            if(oli.Tenure_Months__c=='0.1 Months') {
                                monn=0.1;
                            }
                            if(oli.Tenure_Months__c=='1 Week') {
                                monn=6/30;
                            }
                            
                            if(oli.Tenure_Months__c=='1 Day') {
                                monn=1/30;
                            }
                            if(oli.Tenure_Months__c=='2 Days') {
                                monn=1/30;
                            }
                            if(oli.Tenure_Months__c=='3 Days') {
                                monn=2/30;
                            }
                            if(oli.Tenure_Months__c=='4 Days') {
                                monn=3/30;
                            }
                            if(oli.Tenure_Months__c=='5 Days') {
                                monn=4/30;
                            }
                            if(oli.Tenure_Months__c=='6 Days') {
                                monn=5/30;
                            }
                            if(oli.Tenure_Months__c=='7 Days') {
                                monn=6/30;
                            }
                            if(oli.Tenure_Months__c=='14 Days') {
                                monn=13/30;
                            }
                            if(oli.Tenure_Months__c=='15 days') {
                                monn=14/30;
                            }
                            if(oli.Tenure_Months__c=='60 Days') {
                                monn=59/30;
                            }
                            
                            if(oli.Tenure_Months__c=='2 Months') {
                                monn=2;
                            }
                            if(oli.Tenure_Months__c=='9 Months') {
                                monn=9;
                            }
                            if(oli.Tenure_Months__c=='4 Months') {
                                monn=4;
                            }
                            if(oli.Tenure_Months__c=='13 Months') {
                                monn=13;
                            }
                        }
                        if(ptypes=='Upsell') {
                            if(oli.End_Date__c!=null) {
                                Decimal dd=oli.Start_Date__c.daysbetween(oli.End_Date__c);
                                monn=dd/30;
                            }
                        }
                        system.debug('months anup:'+monn);
                        
                        if(oli.End_Date__c!=null) {
                            Decimal months=oli.End_Date__c.monthsbetween(oli.Start_Date__c);
                            Decimal days=oli.Start_Date__c.daysbetween(oli.End_Date__c);
                            if(days>360 && days<365) {
                                days=360;
                            }
                            if(days==29){
                                days=30;
                            }
                            decimal mon=days/30;
                            system.debug('total months new:'+mon);
                            system.debug('total days:'+days);
                            
                            
                            system.debug('total months:'+months);
                            if(aa.Inventory_Quota_Tenure__c=='Per Month') {
                                // if(opa.Inventory_Quota_Tenure__c.contains('Per Month')){
                                opa.Total_Qty__c=aa.Quantity__c*monn*oli.Quantity_Unit__c;
                                // opa.Total_Qty__c=aa.Quantity__c*mon*oli.Quantity_Unit__c;
                                
                                system.debug('eneted into per month oqqty:'+aa.Quantity__c+'months:'+mon+'opli qty:'+oli.Quantity_Unit__c);
                            }
                            if(aa.Inventory_Quota_Tenure__c!='Per Month') {
                                opa.Total_Qty__c=aa.Quantity__c*oli.Quantity_Unit__c;
                            }
                        }
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        insertAcc.add(opa);
                    }
                    
                }
            }
            system.debug('insertAcc size:'+insertAcc.size());
            
            if(insertAcc.size()>0) {
                insert insertAcc;  
            }
        }
        catch(exception ex) {
            system.debug('In Exception: ' + ex.getMessage());
            system.debug('getLineNumber: ' + ex.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
        return RecordId;
    }
    
    @AuraEnabled
    public Static List<String> getproductnames(){
        List<String> allOptions = new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get('ProductC__c') ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get('Product_Name__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            //  System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            allOptions.add(pickListVal.getValue());
        }    
        // system.debug('allOptions:'+allOptions.size());
        return allOptions;
    }
    
    @AuraEnabled
    public Static List<String> getskutype(){
        List<String> allOptions = new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get('ProductC__c') ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get('SKU_Type__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            //    System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            allOptions.add(pickListVal.getValue());
        }    
        //   system.debug('allOptions:'+allOptions.size());
        return allOptions;
    }
    
    @AuraEnabled
    public Static List<String> getptype(){
        List<String> allOptions = new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get('ProductC__c') ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get('Product_Type__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            //  System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            allOptions.add(pickListVal.getValue());
        }    
        //   system.debug('allOptions:'+allOptions.size());
        return allOptions;
    }
    
    @AuraEnabled
    public Static List<String> gettenure(String recId){
        List<String> allOptions = new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get('ProductC__c') ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get('Tenure_Months__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            //  System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            allOptions.add(pickListVal.getValue());
        }    
        // system.debug('allOptions:'+allOptions);
        return allOptions;
    }
    
    @AuraEnabled
    public Static List<String> getCountry(String recId){
        List<String> allOptions = new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get('ProductC__c') ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get('Product_Country__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            //  System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            allOptions.add(pickListVal.getValue());
        }    
        //  system.debug('allOptions for product country/////:'+allOptions);
        return allOptions;
    }
    
    @AuraEnabled
    public Static List<String> getchannels(String recId){
        List<String> allOptions = new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get('ProductC__c') ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get('Channel__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            //  System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            allOptions.add(pickListVal.getValue());
        }    
        //   system.debug('allOptions:'+allOptions);
        return allOptions;
    }
    
    @AuraEnabled
    public static string saveOplit(string strWrap,string strWrapt, string RecordId){
        
        set<string> accIds = new set<string>();
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Price_Master__c,CurrencyIsoCode,Account__c from OpportunityN__c where Id=:RecordId];
        List<OPLI_Accessories__c> insertAcc = new List<OPLI_Accessories__c>();
        try{
            list<oppItemWrapper> oppWrap=(list<oppItemWrapper>)Json.deserialize(strWrap, list<oppItemWrapper>.class);
            List<Opp_Line_Item__c> oplii = new List<Opp_Line_Item__c>();
            
            for(oppItemWrapper oo : oppWrap){
                oo.opli.OPLI__c=oo.opli.OpliId__c;
                accIds.add(oo.opli.Product__c);
                if(oo.opli.Quantity_Unit__c!=null&&oo.ckb==true){
                    oo.opli.Opportunities__c = RecordId;
                    
                    //oo.opli.IGST__c=oo.gstValue;
                    oplii.add(oo.opli);
                }
                system.debug('oplii: '+oplii);
                
            }
            if(oplii.size()>0){
                insert oplii; 
            } 
            list<string> ssr=new list<string>();
            
            for(Opp_Line_Item__c ff:oplii) {
                if(ff.OPLI__c!=null) {
                    ssr.add(ff.id);
                }   
            }
            list<Opp_Line_Item__c> mpl=[select id,name,DB_Type_Industry__c,DB_Scope_Geography__c,Product_Country__c from Opp_Line_Item__c where id IN:ssr];
            for(Opp_Line_Item__c ff:oplii) {
                system.debug('hjyuu'+ff.OpliId__c);
                ff.OPLI__c=string.valueof(ff.OpliId__c);    
            }
            update oplii;
            
            for(Opp_Line_Item__c ff:oplii) {
                for(Opp_Line_Item__c fft:mpl) {
                    if(ff.OPLI__c!=null && ff.OPLI__c==fft.id) {
                        ff.DB_Type_Industry__c=fft.DB_Type_Industry__c;
                        ff.DB_Scope_Geography__c=fft.DB_Scope_Geography__c;
                        ff.Product_Country__c=fft.Product_Country__c;
                        
                    }
                    
                }
            } 
            update oplii;
            List<PL_Accessories__c> accList2 = [select id,Product_PL_ID__c,name,Price_Master__c,Top_Ups__c,Mandatory__c,Product__c,Price__c from PL_Accessories__c where Product__c=:accIds AND Mandatory__c=true AND Price_Master__c=:opp.Price_Master__c]; 
            for(Opp_Line_Item__c oli : oplii){
                for(PL_Accessories__c aa : accList2){
                    if(aa.Product__c==oli.Product__c){
                        OPLI_Accessories__c opa = new OPLI_Accessories__c();
                        opa.Top_Ups__c=aa.Top_Ups__c;
                        opa.Opportunities__c=RecordId;
                        opa.Account__c=oli.Account__c;
                        opa.Opp_Line_Item__c=oli.id;
                        opa.Quantity_Unit__c = oli.Quantity_Unit__c;
                        opa.Price_Master__c=oli.Price_Master__c;  
                        opa.CurrencyIsoCode=opp.CurrencyIsoCode;
                        opa.PL_Accessories__c=aa.id;
                        opa.Product__c=oli.Product__c;
                        opa.Product_PL__c=aa.Product_PL_ID__c;
                        //opa.Qty__c=1;
                        opa.Unit_price__c=aa.price__c;
                        //opa.Discount_Type__c=oli.Discount_Type__c;
                        //opa.Discount_Value__c=oli.Discount_Value__c;
                        insertAcc.add(opa);
                    }
                    
                }
            }
            list<oppItemWrapper1> oppWrapt=(list<oppItemWrapper1>)Json.deserialize(strWrapt, list<oppItemWrapper1>.class);
            //system.debug(oppWrapt.size());
            //for(Opp_Line_Item__c oli : oplii){
            if(oppWrapt!=null){
                for(oppItemWrapper1 aa : oppWrapt){
                    if(aa.ckb==true){
                        OPLI_Accessories__c opa = new OPLI_Accessories__c();
                        opa.Top_Ups__c=aa.opli.Top_Ups__c;
                        opa.Opportunities__c=RecordId;
                        opa.Account__c=opp.Account__c;
                        //opa.Opp_Line_Item__c=oli.id;
                        opa.Price_Master__c=opp.Price_Master__c;
                        opa.PL_Accessories__c=aa.AccessId;
                        opa.Product__c=aa.opli.Product__c;
                        opa.Quantity_Unit__c = aa.opli.Quantity_Unit__c;
                        opa.Unit_price__c=aa.opli.unit_price__c;
                        opa.CurrencyIsoCode=opp.CurrencyIsoCode;
                        //opa.Discount_Type__c=aa.opli.Discount_Type__c;
                        // opa.Discount_Value__c=aa.opli.Discount_Value__c;
                        //opa.GST_Percent__c=aa.gst;
                        insertAcc.add(opa);
                    }
                    
                }
            }
            //}
            
            for(Opp_Line_Item__c oli : oplii){
                for(OPLI_Accessories__c aa : insertAcc){
                    if(aa.Product__c==oli.Product__c){
                        aa.Opp_Line_Item__c=oli.id;
                    }
                    
                }
            }
            if(insertAcc.size()>0){
                insert insertAcc;  
            }
            
        }
        catch(exception ex){
            system.debug('In Exception: '+ex.getMessage());
            system.debug('getLineNumber: '+ex.getLineNumber());
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
        return RecordId;
    }
    
    /*@AuraEnabled
public static string fetchOppli(String rId){
system.debug('rId:'+rId);
OpportunityN__c opp = new OpportunityN__c();
opp = [Select Id,Name,Opportunity_Type__c,Account__c from OpportunityN__c where Id=:rId];
system.debug('opp:'+opp);
list<Opp_Line_Item__c> opli=[select id,name,Account__c,Tenure_Months__c,Product__r.Product_SKU_Code__c from Opp_Line_Item__c where Account__c=:opp.Account__c ];
list<oppliWrapper> wroppp=new list<oppliWrapper>();
for(Opp_Line_Item__c tt:opli) {
oppliWrapper uu=new oppliWrapper();
// uu.name=tt.name+'('+tt.Product__r.Product_SKU_Code__c+')';
uu.name=tt.name+'('+tt.Tenure_Months__c+')';
uu.oplitenure=tt.Tenure_Months__c;
uu.recordid=tt.id;
wroppp.add(uu);
}
return json.serialize(wroppp);
}*/
    @AuraEnabled
    public static string fetchOppli(String rId,String skutyeInput,String proNameInput){
        system.debug('rId:'+rId);
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Opportunity_Type__c,Account__c from OpportunityN__c where Id=:rId];
        system.debug('opp:'+opp);
        list<Quote_Line_Items__c> opli;
        
        if(proNameInput=='PC Pack' || proNameInput=='OC Pack' || proNameInput=='Login Pack'){
            opli=[select id,name,Order_Created__c,Order_Status_Verified_For_Upsell__c,Start_Date__c,End_Date__c,Account__c,Tenure_Months__c,Product__r.Product_SKU_Code__c,Active__c,Quote_Type__c,Opportunities__c from Quote_Line_Items__c
                  where SKU_Type__c=:skutyeInput  and Account__c=:opp.Account__c  AND  Active__c=:true AND Order_Created__c=:true AND Order_Status_Verified_For_Upsell__c=:true AND Quote_Type__c!=:'Free Trial'];
            
        }
        else{
            opli=[select id,name,Order_Created__c,Order_Status_Verified_For_Upsell__c,Start_Date__c,End_Date__c,Account__c,Tenure_Months__c,Product__r.Product_SKU_Code__c,Active__c,Quote_Type__c,Opportunities__c from Quote_Line_Items__c
                  where  Account__c=:opp.Account__c  AND  Active__c=:true AND Order_Created__c=:true AND Order_Status_Verified_For_Upsell__c=:true AND Quote_Type__c!=:'Free Trial'];
            
        }
        list<oppliWrapper> wroppp=new list<oppliWrapper>();
        for(Quote_Line_Items__c tt:opli) {
            oppliWrapper uu=new oppliWrapper();
            // uu.name=tt.name+'('+tt.Product__r.Product_SKU_Code__c+')';
            uu.name=tt.name+'('+tt.Tenure_Months__c+')';
            uu.oplitenure=tt.Tenure_Months__c;
            uu.recordid=tt.id;
            wroppp.add(uu);
        }
        return json.serialize(wroppp);
    }
    
    /*
Fetch opportunity line items for upsell
*/
    @AuraEnabled
    public static string fetchOpplii(String rId,String skutyeInput, String proNameInput) {
        System.debug('Fetch opportunity line items for upsell');
        OpportunityN__c opp = new OpportunityN__c();
        opp = [Select Id,Name,Opportunity_Type__c,Account__c from OpportunityN__c where Id=:rId];
        List<Opp_Line_Item__c> opli;
        if(proNameInput=='PC Pack' || proNameInput=='OC Pack' || proNameInput=='Login Pack'){
            opli=[select id,name,Opportunities__c,SKU_Type__c,Product_Type1__c,Start_Date__c,End_Date__c,Account__c,Tenure_Months__c,Product__r.Product_SKU_Code__c 
                  from Opp_Line_Item__c 
                  where Opportunities__c=:opp.Id AND SKU_Type__c=:skutyeInput AND Product_Type1__c=:'Core-Std']; 
        }
        else{
            opli=[select id,name,Opportunities__c,SKU_Type__c,Product_Type1__c,Start_Date__c,End_Date__c,Account__c,Tenure_Months__c,Product__r.Product_SKU_Code__c 
                  from Opp_Line_Item__c 
                  where Opportunities__c=:opp.Id AND Product_Type1__c=:'Core-Std']; 
        }
        //  system.debug('opp fetched linked//////////////////////////////////////////////////;'+opli.size());
        list<oppliWrapper1> wroppp=new list<oppliWrapper1>();
        for(Opp_Line_Item__c tt:opli) {
            oppliWrapper1 uu=new oppliWrapper1();
            // uu.name=tt.name+'('+tt.Product__r.Product_SKU_Code__c+')';
            uu.name=tt.name+'('+tt.Tenure_Months__c+')';
            uu.oplitenure=tt.Tenure_Months__c;
            uu.recordid=tt.id;
            wroppp.add(uu);
        }
        return json.serialize(wroppp);
    }
    
    public class oppliWrapper{
        @AuraEnabled
        public string name{get;set;}
        public string recordid{get;set;}  
        public string oplitenure{get;set;}    
    }
    
    public class oppliWrapper1{
        @AuraEnabled
        public string name{get;set;}
        public string recordid{get;set;}  
        public string oplitenure{get;set;}    
    }
    
    public class oppItemWrapper{
        public String category, principal, typeProd, sku, prodtenure, prodName, dbindustry, proocountry, proscountry, skutype, prodID, procode, uom, channel, prodesc, progeo, bin, tpotype, Product_Name, Masterlogin;
        public Boolean ckb;
        public Decimal priceRate, gstValue, discap, disamt, grosstotal, basetotal, to, fromqty, invcount, ctc, tpo,servicefee;
        public Date todaydate;
        public Integer tenure;
        public Opp_Line_Item__c opli;
        public oppItemWrapper(Opp_Line_Item__c li){
            opli = li;
            ckb = false;
        }
        
        
    }
    
    public class oppItemWrapper1{
        @AuraEnabled
        public OPLI_Accessories__c opli{get;set;}
        public string category{get;set;}
        public string principal{get;set;}
        public string typeProd{get;set;}
        public String AccessId{get;set;}
        public Boolean ckb{get;set;}
        public string prodtenure{get;set;}
        public decimal priceRate{get;set;}
        public string prodName{get;set;}
        public decimal gst{get;set;}
        public string dbindustry{get;set;}
        public string proocountry{get;set;}
        public string invtenure{get;set;}
        
        // public string mlogin{get;set;}
        
        public oppItemWrapper1(OPLI_Accessories__c li){
            opli = new OPLI_Accessories__c();
            opli = li;
            ckb = false;
        }
        
    }
}