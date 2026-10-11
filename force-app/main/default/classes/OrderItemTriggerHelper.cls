/*Created by : Abdul Aziz , Created Date : 07/07/2023 , Description : Helper class for OrderItemTrigger*/

public class OrderItemTriggerHelper {
    public static Boolean isFirstRun = true;
    /*Update order service start date function*/
    public static void updateServiceStartDate(List<Order_Item__c> orderItem) { 
        Set<id> setoforderid=new Set<id>();
        List<Order__c> orderStartDate =new  List<Order__c>();
        for(Order_Item__c oitem : orderItem )
        {
            setoforderid.add(oitem.Order__c);
        }
        List<Order__c> listOfOrderforStartDate=[select id,name,Service_Start_Date__c,Service_End_Date__c,(select id,name,Order__c,Start_Date__c,End_Date__c from Order_Items__r order by Start_Date__c asc limit 1)  from Order__c where id in:setoforderid];
        /*Iterate Over first list to get order service start date*/
        for(Order__c o1 : listOfOrderforStartDate){
            for(Order_Item__c oitem1 :o1.Order_Items__r)
            {
                if(oitem1.Order__c==o1.Id)
                {
                    o1.Service_Start_Date__c=oitem1.Start_Date__c;
                    orderStartDate.add(o1);
                } 
            } 
        }
        try{
            update orderStartDate; 
        }
        catch(Exception e){
            
        }
    } 
    
    /*Update order service end date function*/
    public static void updateServiceEndDate(List<Order_Item__c> orderItem) {
        Set<id> setoforderid=new Set<id>();
        List<Order__c> orderEndDate =new  List<Order__c>();
        for(Order_Item__c oitem : orderItem )
        {
            setoforderid.add(oitem.Order__c);
        }
        List<Order__c> listOfOrderforEndDate=[select id,name,Service_Start_Date__c,Service_End_Date__c,(select id,name,Order__c,Start_Date__c,End_Date__c from Order_Items__r order by End_Date__c desc limit 1) from Order__c where id in:setoforderid ];
        /*Iterate Over second list to get order service end date*/
        for(Order__c o2 : listOfOrderforEndDate){
            for(Order_Item__c oitem2 :o2.Order_Items__r)
            {
                if(oitem2.Order__c==o2.Id)
                {
                    o2.Service_End_Date__c=oitem2.End_Date__c;
                    orderEndDate.add(o2);
                } 
            } 
        }
        try{
            update orderEndDate;
        }
        catch(Exception e){
            
        } 
    } 
    
    /*Update Sales Credit and Net Total Credit to Order */
    public static void updateCredits(List<Order_Item__c> orderItem) {
        try {
            Set<String> setOrders = new Set<String> ();
            for(Order_Item__c items : orderItem) {
                setOrders.add(items.Order__c);
            }
            
            List<Order__c> lstOrders = [SELECT Id, Name, Net_Total_Credit__c, Sales_Credit__c, 
                                        (SELECT Id, Name, Net_Total_Credit__c, Sales_Credit__c FROM Order_Items__r ) 
                                        FROM Order__c WHERE ID IN: setOrders];
            
            for(Order__c item : lstOrders) {
                Decimal salesCredit = 0;
                Decimal netTotalCredit = 0;
                for(Order_Item__c lineItems : item.Order_Items__r) {
                    salesCredit += lineItems.Sales_Credit__c == null ? 0 : lineItems.Sales_Credit__c;
                    netTotalCredit += lineItems.Net_Total_Credit__c == null ? 0 : lineItems.Net_Total_Credit__c;
                }
                item.Net_Total_Credit__c = netTotalCredit;
                item.Sales_Credit__c = salesCredit;
            }
            
            Update lstOrders;
        } catch(Exception e) {
            System.debug('error in rollup sales credit');
            System.debug('error message : ' + e.getMessage());
            System.debug('error line number : ' + e.getLineNumber());
        }
    }
}