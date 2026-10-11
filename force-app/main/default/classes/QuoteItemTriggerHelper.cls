public class QuoteItemTriggerHelper {
    public static void updateFreeTrialProduct(List<Quote_Line_Items__c> lstQuoteItems) {
        Set<String> setQuoteIds = new Set<String> ();
        for(Quote_Line_Items__c item : lstQuoteItems) {
            if(item.Quotes__c != null) setQuoteIds.add(item.Quotes__c);
        }
        List<QuotesN__c> qq=[select id,name,Free_Trial_Product__c,(select id,name,Product__c,Product__r.Product_Name__c from Quote_Line_Items__r ) from QuotesN__c where id in:setQuoteIds];
        for(QuotesN__c q : qq){
            for(Quote_Line_Items__c qitem : q.Quote_Line_Items__r){
                if(qitem.Product__r.Product_Name__c!=null && qitem.Product__r.Product_Name__c.toLowerCase().contains('additional'))
                {
                    q.Free_Trial_Product__c=true;
                }
            }
        }
        update qq;
    }
    
    public static void RollUpAfterInsert(List<Quote_Line_Items__c> lstQuoteItems) {
        Set<String> setQuoteIds = new Set<String> ();
        for(Quote_Line_Items__c item : lstQuoteItems) {
            if(item.Quotes__c != null) setQuoteIds.add(item.Quotes__c);
        }
        List<QuotesN__c> listofQuote=[select id,name,Net_Total_Credit__c,Sales_Credit__c,(select id,name,Sales_Credit__c,Net_Total_Credit__c from Quote_Line_Items__r) from QuotesN__c where id in :setQuoteIds];
        for (QuotesN__c qq : listofQuote) {
            Decimal salesCredit = 0;
            Decimal netTotalCredit = 0;
            for (Quote_Line_Items__c item : qq.Quote_Line_Items__r) {
                salesCredit += item.Sales_Credit__c == null ? 0 : item.Sales_Credit__c;
                netTotalCredit += item.Net_Total_Credit__c == null ? 0 : item.Net_Total_Credit__c;
            }
            qq.Net_Total_Credit__c = netTotalCredit;
            qq.Sales_Credit__c = salesCredit;
        }
        update listofQuote;
    }
}