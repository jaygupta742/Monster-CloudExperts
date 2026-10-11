public class EditOPLIAccessories 
{
    @AuraEnabled
    public static String fetchlineitem(String rid)
    {
        List<OPLI_Accessories__c> opli=new List<OPLI_Accessories__c>();
        opli=[select id,name,Top_ups__c,Top_Ups__r.Mandatory__c,Top_Ups__r.Quantity__c,Product__r.Discount_Cap__c,Quantity__c,Opportunities__c,Product_SKU__c,Product_Name__c,Top_Up_Name__c,Top_ups__r.Inventory_Quota_Tenure__c,Inventory_Quota_Tenure1__c,Unit_Price__c,Quantity_Unit__c,Opp_Line_Item__c,Product__c,Mandatory__c from OPLI_Accessories__c where Opp_Line_Item__c=:rid AND Top_Up_Name__c!='Master Login'];
         
        
        List<itemWrap> wrapList = new List<itemWrap>();
        for(OPLI_Accessories__c oo:opli){
            itemWrap ii = new itemWrap(oo);
             ii.invtenure=oo.Top_ups__r.Inventory_Quota_Tenure__c;
             ii.mandatory=oo.Top_Ups__r.Mandatory__c;
            ii.invcount=oo.Top_Ups__r.Quantity__c;
          
            wrapList.add(ii);
        }
                return Json.serialize(wraplist);

        
    }
    
    @AuraEnabled
    public static string lineItemDel(String recId)
    {
        List<OPLI_Accessories__c> opliAcc=new List<OPLI_Accessories__c>();
        opliAcc=[select id,Opportunities__c,Opp_Line_Item__c from OPLI_Accessories__c where id=:recId];
        system.debug('opliAcc'+opliAcc);
        if(opliAcc.size()>0)
        {
            
          delete opliAcc;
            
        }
        return 'Success!';
    }
    
   @AuraEnabled
    public static string onsave(String listItem)
    {
        OPLI_Accessories__c listlineItem=new OPLI_Accessories__c();
        listlineItem=(OPLI_Accessories__c)Json.deserialize(listItem, OPLI_Accessories__c.class);
        try
        {
            update listlineItem;
            
            return 'Successfully Updated records!!!';
        }
        catch(Exception e)
        {
            system.debug('Exception e:'+e.getMessage());
            system.debug('Line Number: '+e.getLineNumber());
            throw new AuraHandledException('Something Went Wrong:'+e.getMessage());
        }
        
    }
    public class itemWrap{
        @AuraEnabled
        public boolean delAcc{get;set;}
        public string prodname{get;set;}
        public OPLI_Accessories__c opli{get;set;}
        public boolean updateAccQty{get;set;}
        public decimal grosstotal{get;set;}
         public decimal basetotal{get;set;}
        public decimal discountvalue{get;set;}
        public decimal Unitprice{get;set;}
        public string invtenure{get;set;}
        public boolean mandatory{get;set;}
        public decimal invcount{get;set;}
        
        public itemWrap(OPLI_Accessories__c li){
            opli = new OPLI_Accessories__c();
            opli = li;
            updateAccQty = false;  
        }
    }
}