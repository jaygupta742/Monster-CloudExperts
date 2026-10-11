public with sharing class ShowProducts {
    
    // Safety cap so no single query can ever blow the 50,000-row limit.
    private static final Integer MAX_ROWS = 49999;
    
    @AuraEnabled(cacheable=true)
    public static ProductC__c[] Getalldata(String ptye, String pname, String selcontry, String curr) {
        System.debug('ptye ' + ptye + ' pname ' + pname + ' selcontry ' + selcontry + ' currency ' + curr);
        
        // The query ANDs all four filters, so only run it once all four are chosen.
        // (Old code used || here, so it fired on page load with blank values.)
        if (String.isBlank(ptye) || String.isBlank(pname) || String.isBlank(selcontry) || String.isBlank(curr)) {
            return new ProductC__c[]{};
                }
        
        return [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate,
                LastViewedDate, LastReferencedDate, Active_From__c, Active__c, Active_to__c, Bin__c, Channel__c, DB_Scope_Geography__c, DB_Type_Industry__c, Discount_Cap__c,
                From__c, List_Price__c, Main_Product_Type__c, Price_Master__c, Primary_Selling_Country__c, Product_Country__c, Product_Description__c, Product_SKU_Code__c,
                Product_Type__c, Product_category__c, Tenure_Months__c, To__c, UOM__c, Unit_List_Price_Value__c, Upsell_Inv_Count__c, of_Master_Login__c, Top_Up_Count__c, BT__c,
                Discount_Amount__c, Discount_Cap_Amount__c, Gross_Total__c, Location__c, Price_Master_ID__c, Product_Code__c, Product_Name__c, SKU_Type__c, Category__c,
                Price_Master_Name__c, S_No__c, Channel_and_is__c, Product_Unique_id__c, Channel_Sku_Bin_Currency__c, TPS_Unit_Price__c, TPS_Value_Type__c, TPS_Value__c, Text__c,
                Credit__c, Classification__c
                FROM ProductC__c
                WHERE Active__c = true
                AND Product_Type__c = :ptye
                AND Product_Name__c = :pname
                AND Product_Country__c = :selcontry
                AND CurrencyIsoCode = :curr
                ORDER BY Name ASC
                LIMIT :MAX_ROWS];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getptype() {
        // Picklist describe - costs zero query rows. Unchanged.
        List<Map<String, String>> allOptions = new List<Map<String, String>>();
        for (Schema.PicklistEntry v : ProductC__c.Product_Type__c.getDescribe().getPicklistValues()) {
            if (v.isActive()) {
                allOptions.add(new Map<String, String>{ 'label' => v.getLabel(), 'value' => v.getValue() });
            }
        }
        return allOptions;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getproductnames(String ptye) {
        List<Map<String, String>> allOptions = new List<Map<String, String>>();
        
        // Old code ran LIKE '%%' when ptye was blank = every active product, 60 fields each.
        if (String.isBlank(ptye)) {
            return allOptions;
        }
        
        // Only fetch the one field we need, filter on the exact picklist value.
        Set<String> names = new Set<String>();
        for (AggregateResult ar : [SELECT Product_Name__c pn
                                   FROM ProductC__c
                                   WHERE Active__c = true
                                   AND Product_Type__c = :ptye
                                   AND Product_Name__c != null
                                   GROUP BY Product_Name__c
                                   ORDER BY Product_Name__c]) {
                                       names.add((String) ar.get('pn'));
                                   }
        for (String pn : names) {
            allOptions.add(new Map<String, String>{ 'label' => pn, 'value' => pn });
        }
        return allOptions;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getCountry(String ptye, String pname) {
        List<Map<String, String>> allOptions = new List<Map<String, String>>();
        
        if (String.isBlank(ptye) || String.isBlank(pname)) {
            return allOptions;
        }
        
        for (AggregateResult ar : [SELECT Product_Country__c pc
                                   FROM ProductC__c
                                   WHERE Active__c = true
                                   AND Product_Type__c = :ptye
                                   AND Product_Name__c = :pname
                                   AND Product_Country__c != null
                                   GROUP BY Product_Country__c
                                   ORDER BY Product_Country__c]) {
                                       String pc = (String) ar.get('pc');
                                       allOptions.add(new Map<String, String>{ 'label' => pc, 'value' => pc });
                                   }
        return allOptions;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getCurrency() {
        // Old code ran GROUP BY over EVERY ProductC__c record (no filter at all).
        // Aggregate queries count every underlying row toward the 50k limit,
        // so this alone fails once the object passes 50,000 records.
        // Read the org's active currencies instead - a handful of rows.
        List<Map<String, String>> allOptions = new List<Map<String, String>>();
        Set<String> activeCurrencies = new Set<String>();
        for (SObject ct : Database.query('SELECT IsoCode FROM CurrencyType WHERE IsActive = true')) {
            activeCurrencies.add((String) ct.get('IsoCode'));
        }
        
        for (Schema.PicklistEntry v : ProductC__c.CurrencyIsoCode.getDescribe().getPicklistValues()) {
            if (activeCurrencies.contains(v.getValue())) {
                allOptions.add(new Map<String, String>{ 'label' => v.getLabel(), 'value' => v.getValue() });
            }
        }
        return allOptions;
    }
    
    public class Wraper {
        public ProductC__c p { get; set; }
        public Integer srno;
        public Wraper(ProductC__c pp) {
            p = pp;
        }
    }
}