public class CloneInOpportunityClass {

    @AuraEnabled
    public static OpportunityN__c fetchopp(String rid)
    {
        System.debug('Inside fetchopp');
        OpportunityN__c op = new OpportunityN__c();
        
        op = [select Id,Name,Price_Master__c,Account__c,Expected_Revenue__c,Closure_probablity__c,Probability__c,Opportunity_Source__c,Opportunity_Type__c,contact__c,Xcode__c from OpportunityN__c where Id=:rid];
        op.Probability__c = '0%';
        op.Stage__c = 'Identification';
        op.Opportunity_Type__c='Upsell';
        System.debug('Opportunity is  : '+op);
        return op;
    }
    
    @AuraEnabled
    public static list<Opp_Line_Item__c> fetchopli(String rid)
    {
        System.debug('Inside fetchopli');
        
        list<Opp_Line_Item__c> opli = new list<Opp_Line_Item__c>();
        
        opli = [select Id,Name,Product_Name__c,Product__c,Product_Type__c,Price_Master__c,Quantity_Unit__c,
                SKU_Type__c,Unit_Price__c,Product_Country__c,DB_Scope_Geography__c,UOM__c,Tenure_Months__c,CurrencyIsoCode,DB_Type_Industry__c,
               Discount_Type__c,Discount_Value__c from Opp_Line_Item__c where Opportunities__c=:rid];
        System.debug('The list is  :  '+ opli);
         System.debug('The list size is  :  '+ opli.size());
        return opli;

    }
     @AuraEnabled
    public static list<OPLI_Accessories__c> fetchoplia(String rid)
    {
        System.debug('Inside fetchoplia');
        
        list<OPLI_Accessories__c> oplia = new list<OPLI_Accessories__c>();
        
        oplia = [select Id,Name,Quantity_Unit__c,Top_Ups__c,Product__c,Price_Master__c,Quantity__c,Unit_Price__c,Top_Up_Name__c,Inventory_Quota_Tenure1__c from OPLI_Accessories__c where Opportunities__c=:rid and Top_Up_Name__c=:'Master Login'];
        System.debug('The list is  :  '+ oplia);
         System.debug('The list size is  :  '+ oplia.size());
        return oplia;

    }
    
    @AuraEnabled
    public static String saveopp(String rid,OpportunityN__c op,list<Opp_Line_Item__c> opli,list<OPLI_Accessories__c> oplia)   
    {
        
        OpportunityN__c opp = new OpportunityN__c();
        opp.Account__c = op.Account__c;
        opp.Probability__c = '0%';
        opp.Stage__c = 'Identification';
        opp.Opportunity_Type__c='Upsell';
        opp.Contact__c = op.Contact__c;
        opp.Opportunity_Source__c =  op.Opportunity_Source__c;
        opp.Closure_probablity__c=op.Closure_probablity__c;
        opp.Opportunity_Type__c=op.Opportunity_Type__c;
        opp.Price_Master__c=op.Price_Master__c;
        
        System.debug('Old op is ____:__________________'+op.Id);
        System.debug('New Opp is   : __________________________='+opp.Id);
        String AccountName = op.Account__c;
        try{
            insert opp;
            System.debug('New Opp is   : __________________________='+opp.Id);
            list<Opp_Line_Item__c> opliinsert = new list<Opp_Line_Item__c>();
            for(Opp_Line_Item__c o : opli)
            {
                Opp_Line_Item__c o1 = new Opp_Line_Item__c();
                
                    o1.Opportunities__c = opp.Id;
                    o1.Account__c = AccountName;
                    o1.Price_Master__c=o.Price_Master__c;
                    o1.Product__c=o.Product__c;
                    o1.Quantity_Unit__c=0;
                    o1.Tenure_Months__c=o.Tenure_Months__c;
                    o1.Discount_Type__c=o.Discount_Type__c;
                    o1.Discount_Value__c=o.Discount_Value__c;
                    o1.CurrencyIsoCode=o.CurrencyIsoCode;
                    o1.DB_Scope_Geography__c=o.DB_Scope_Geography__c;
                    o1.DB_Type_Industry__c=o.DB_Type_Industry__c;
                    o1.Product_Country__c=o.Product_Country__c;
                opliinsert.add(o1);
            }
            insert opliinsert;
            
             list<OPLI_Accessories__c> opliaa = new list<OPLI_Accessories__c>();
            for(Opp_Line_Item__c opliii:opliinsert)
            {
            for(OPLI_Accessories__c o : oplia)
            {
                OPLI_Accessories__c o2 = new OPLI_Accessories__c();
                
                    o2.Opportunities__c = opp.Id;
                    o2.Account__c = AccountName;
                    o2.Price_Master__c=o.Price_Master__c;
                    o2.Top_Ups__c=o.Top_Ups__c;
                    o2.Opp_Line_Item__c=opliii.id;
                    o2.Quantity_Unit__c=0;
                    o2.Quantity__c=o.Quantity__c;
                    o2.Product__c=o.Product__c;
                    o2.Discount_Amount__c=o.Discount_Amount__c;
                    o2.Adjustment_Type__c=o.Adjustment_Type__c;
                    o2.Adjustment_Value__c=o.Adjustment_Value__c;
                    

                
                    
                
                opliaa.add(o2);
            }
            }
            insert opliaa;
            
            
            System.debug('The New inserted op is  : '+opp);
            System.debug('The New inserted opline item is  : '+opliinsert);
            System.debug('The New inserted opline item size is  : '+opliinsert.size());
            return opp.Id;
        }
        catch(Exception e)
        {
             system.debug('Error Occured:'+e.getMessage());
            system.debug('Line Number:'+e.getLineNumber());
            return 'Something Went Wrong';
        }
       
    } 
}