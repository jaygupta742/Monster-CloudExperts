@isTest
public class seekerOrder_AddApacPayments_cls_test {
    @isTest
    public static void TestMethod01() {
        Trigger__c AccountTrigger = new Trigger__c(Name = 'Account', Active__c = true);
        insert AccountTrigger;
        
        Account NAcc1 = new Account();
        NAcc1.Name = 'Debasis Das';
        NAcc1.SalesChannel__c = 'EA';
        NAcc1.Import_Source__c = 'Import_Source__c';
        NAcc1.Lead_Source__c = 'Other';
        NAcc1.APAC_Industry__c = 'Internet';
        NAcc1.No_of_Employees__c = 25;
        NAcc1.Account_Type__c = 'IT';
        NAcc1.Location__c = 'India';
        NAcc1.Lead_Source1__c = 'ECOMM';
        NAcc1.Website = 'www.asdfert.com';
        NAcc1.Phone = '+985478547256';
        NAcc1.OtherPhone__c = '+985478547856';
        NAcc1.RegistrationNumber__c = 'asq111111';
        NAcc1.Lead_Account_Status__c = 'Inactive';
        NAcc1.CreditStatus__c = 'OK';
        NAcc1.BillingCountry = 'India' ; 
        NAcc1.BillingState = 'Karnataka';
        NAcc1.BillingStreet = 'Test Address';
        NAcc1.BillingCity = 'bangalore' ;
        NAcc1.BillingPostalCode = '560076'; 
        NAcc1.ShippingCountry = 'India';
        NAcc1.BillCountry__c = 'India';
        NAcc1.BillState__c = 'Karnataka';
        NAcc1.PostCountry__c = 'India';
        NAcc1.PostState__c = 'Karnataka';
        NAcc1.ShippingStreet = 'Test Address';
        NAcc1.ShippingCity = 'bangalore' ;
        NAcc1.ShippingPostalCode = '560076'; 
        insert NAcc1;
        
        ProductC__c product = new ProductC__c();
        product.Product_Name__c = 'Jain';
        product.Active__c = true;
        product.Product_SKU_Code__c = 'JaBCom001IN';
        product.Product_Type__c = 'Standalone';
        product.Product_Description__c = 'B.Com - Accounting and Finance (Jain)';
        product.UOM__c = 'Qty';
        product.Unit_List_Price_Value__c = 50000;
        product.Credit__c = 10;
        product.Channel__c = 'Seeker-Ed Sales';
        product.SKU_Type__c = 'B.Com';
        product.Tenure_Months__c = '12 Months';
        
        insert product;
        
        Seeker_Order__c order = new Seeker_Order__c();
        order.Account__c = NAcc1.Id;
        order.Enrollment_No__c = 'ENR-0001';
        order.Seeker_Contact__c = '9832560557';
        order.Seeker_Name__c = 'Debasis Das';
        order.Seeker_Email__c = 'to.debasisdas.cu@gmail.com';
        insert order;
        
        Seeker_Order_Line_Item__c seekerItem1 = new Seeker_Order_Line_Item__c();
        seekerItem1.Seeker_Order__c = order.Id;
        seekerItem1.Commission__c = 10;
        seekerItem1.Product_No__c = product.Id;
        seekerItem1.Discount__c = 1000;
        seekerItem1.Subvention_Cost__c = 1000;
        seekerItem1.Quantity__c = 1;
        seekerItem1.Start_Date__c = Date.today();
        seekerItem1.End_Date__c = Date.today().addDays(30);
        insert seekerItem1;
        
        Seeker_Order__c seekerOrders = seekerOrder_AddApacPayments_cls.GetOrderDetails(order.Id);
        APAC_Payment_Seeker__c apacPayment1 = new APAC_Payment_Seeker__c();
        apacPayment1.Payment_Type__c = 'Single Shot';
        apacPayment1.Due_Date__c = Date.today();
        apacPayment1.Payment_Amount__c = seekerOrders.Net_Total__c;
        apacPayment1.Seeker_Order__c = seekerOrders.Id;

        List<APAC_Payment_Seeker__c> apac_payments = new List<APAC_Payment_Seeker__c> ();
        apac_payments.add(apacPayment1);
        
        try {
            seekerOrder_AddApacPayments_cls.SaveAPACPayments(order.Id, '');
        } catch(Exception e) {
            seekerOrder_AddApacPayments_cls.SaveAPACPayments(order.Id, JSON.serialize(apac_payments));
        }
    }
}