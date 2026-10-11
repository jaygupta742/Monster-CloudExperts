public class editAllQULITopUps_cls {
    @AuraEnabled
    public static List<QULI_Accessories__c> get_Top_Ups(String recordId) {
        List<QULI_Accessories__c> acc;
        acc = [SELECT Id, Account__c, CurrencyIsoCode, Inventory_Count__c, Inventory_Quota_Tenure1__c, Mandatory__c, Opp_Line_Item__c,
               Opportunities__c, Opportunity__c, PL_Accessories_ID__c, Price_Master__c, Product__c, Product_Country__c, Product_Geo_Scope__c,
               Product_Name__c, Product_SKU__c, Product_SKU_Type__c, Product_Tenure_Months__c, Quantity_Unit__c, Name, Quote_Line_Items__c, 
               Quotes__c, Top_Up_Name__c, Top_Ups__c, Unit_Price__c
               
               FROM QULI_Accessories__c
               WHERE Quotes__c =: recordId
              ];
        
        return acc;
    }
    @AuraEnabled
    public static string getstatus(string rid){
        QuotesN__c qq=[select id,name,Approval_Status_Overall__c from QuotesN__c where id=:rid];
        
        return qq.Approval_Status_Overall__c;
    }
    
    @AuraEnabled
    public static void onsave(String recordId, List<QULI_Accessories__c> acc) {
        try {
            List<QULI_Accessories__c> oldacc;
            oldacc = [SELECT Id, Account__c, CurrencyIsoCode, Inventory_Count__c, Inventory_Quota_Tenure1__c, Mandatory__c, Opp_Line_Item__c,
                      Opportunities__c, Opportunity__c, PL_Accessories_ID__c, Price_Master__c, Product__c, Product_Country__c, Product_Geo_Scope__c,
                      Product_Name__c, Product_SKU__c, Product_SKU_Type__c, Product_Tenure_Months__c, Quantity_Unit__c, Name, Quote_Line_Items__c, 
                      Quotes__c, Top_Up_Name__c, Top_Ups__c, Unit_Price__c
                      
                      FROM QULI_Accessories__c
                      WHERE Quotes__c =: recordId
                     ];
            
            Map<Id, QULI_Accessories__c> newacc = new Map<Id, QULI_Accessories__c> ();        
            for(QULI_Accessories__c item : acc) {
                newacc.put(item.Id, item);
            }
            
            for(QULI_Accessories__c item : oldacc) {
                if(newacc.containsKey(item.Id)) {
                    QULI_Accessories__c qc = newacc.get(item.Id);
                    update qc;
                }
                else {
                    delete item;
                }
            }   
        }
        catch(Exception e) {
            throw new AuraHandledException('Something went wrong: '+e.getMessage());
        }
    }
}