@isTest
public class ShowProducts_Test {

    @testSetup
    static void setupData() {
        Price_Master__c pm = new Price_Master__c();
        pm.Name = 'INR Price Book';
        pm.CurrencyIsoCode = 'INR';
        insert pm;

        User uu = [SELECT Id, Channel__c FROM User WHERE Id = :UserInfo.getUserId()];

        List<ProductC__c> prodList = new List<ProductC__c>();

        // Active product that should be returned
        ProductC__c p1 = new ProductC__c();
        p1.Active__c = true;
        p1.CurrencyIsoCode = 'INR';
        p1.SKU_Type__c = 'Bundle-x';
        p1.Product_category__c = 'Standard';
        p1.Price_Master__c = pm.Id;
        p1.Product_SKU_Code__c = 'RDAS1ME01M00BN1';
        p1.Main_Product_Type__c = 'RDA';
        p1.Product_Description__c = 'Test product';
        p1.Product_Type__c = 'Upsell';
        p1.Product_Name__c = 'Login Pack';
        p1.Product_Country__c = 'India';
        p1.Primary_Selling_Country__c = 'India';
        p1.Tenure_Months__c = '60 Days';
        p1.Bin__c = 'vghvgh';
        p1.Channel__c = uu.Channel__c;
        p1.Category__c = 'A';
        prodList.add(p1);

        // Inactive product that should never be returned
        ProductC__c p2 = p1.clone(false, true, false, false);
        p2.Active__c = false;
        p2.Product_SKU_Code__c = 'RDAS1ME01M00BN2';
        prodList.add(p2);

        insert prodList;
    }

    @isTest
    static void testGetAllDataWithAllFilters() {
        Test.startTest();
        ProductC__c[] result = ShowProducts.Getalldata('Upsell', 'Login Pack', 'India', 'INR');
        Test.stopTest();

        System.assertEquals(1, result.size(), 'Only the active matching product should be returned');
        System.assertEquals(true, result[0].Active__c);
    }

    @isTest
    static void testGetAllDataWithMissingFilters() {
        Test.startTest();
        ProductC__c[] blankAll   = ShowProducts.Getalldata('', '', '', '');
        ProductC__c[] partial    = ShowProducts.Getalldata('', '', 'India', '');
        ProductC__c[] nullValues = ShowProducts.Getalldata(null, null, null, null);
        Test.stopTest();

        System.assertEquals(0, blankAll.size(), 'No query should run when filters are blank');
        System.assertEquals(0, partial.size(), 'No query should run until all filters are chosen');
        System.assertEquals(0, nullValues.size());
    }

    @isTest
    static void testGetPType() {
        Test.startTest();
        List<Map<String, String>> options = ShowProducts.getptype();
        Test.stopTest();

        System.assert(!options.isEmpty(), 'Product Type picklist values should be returned');
    }

    @isTest
    static void testGetProductNames() {
        Test.startTest();
        List<Map<String, String>> options = ShowProducts.getproductnames('Upsell');
        List<Map<String, String>> blank   = ShowProducts.getproductnames('');
        Test.stopTest();

        System.assertEquals(1, options.size());
        System.assertEquals('Login Pack', options[0].get('value'));
        System.assertEquals(0, blank.size(), 'Blank Product Type should return no names');
    }

    @isTest
    static void testGetCountry() {
        Test.startTest();
        List<Map<String, String>> options = ShowProducts.getCountry('Upsell', 'Login Pack');
        List<Map<String, String>> blank   = ShowProducts.getCountry('Upsell', '');
        Test.stopTest();

        System.assertEquals(1, options.size());
        System.assertEquals('India', options[0].get('value'));
        System.assertEquals(0, blank.size(), 'Blank Product Name should return no countries');
    }

    @isTest
    static void testGetCurrency() {
        Test.startTest();
        List<Map<String, String>> options = ShowProducts.getCurrency();
        Test.stopTest();

        Set<String> values = new Set<String>();
        for (Map<String, String> o : options) {
            values.add(o.get('value'));
        }
        System.assert(values.contains('INR'), 'INR should be listed as an active currency');
    }

    @isTest
    static void testWrapper() {
        ProductC__c p = [SELECT Id FROM ProductC__c WHERE Active__c = true LIMIT 1];
        ShowProducts.Wraper w = new ShowProducts.Wraper(p);
        System.assertEquals(p.Id, w.p.Id);
    }
}