//Last Modified By : Abdul Aziz , Date : 13/06/2024 , Description : Mapped Custom Product Name as product name feild
public without sharing class CreateOrderFromQuote {
    @AuraEnabled
    public static Order__c getOrderObj(String recId){
        QuotesN__c opp = new QuotesN__c();
        opp = [Select Id,Start_Date__c,Contribution_Person_1__c,Contribution_Person_2__c,Contribution_Person_3__c,Shared_with_Person_1__c,Shared_with_Person_2__c,Shared_with_Person_3__c,ownerId,Base_Order_ID__c,Revised_Service_End_Date__c,Name,Account_Entity_Use_Code1__c,Account__c,Xcode__c,Opportunities__c,Price_Master__c,CurrencyIsoCode,Contact__c, Selling_Country__c,
               Quote_Type__c, Account_Type__c, Approval_Status_Overall__c, Tax_Percentage__c,Owner_Channel__c
               from QuotesN__c
               where Id =: recId];
        User quoteOwner=[select id,city from User where id=:opp.ownerid limit 1];
        
        Order__c qq = new Order__c();
        qq.Invoice_Location__c=quoteOwner.city;
        qq.Xcode__c=opp.Xcode__c;
        qq.Account__c=opp.Account__c;
        qq.Contact__c=opp.Contact__c;
        qq.Opportunities__c=opp.Opportunities__c;
        qq.Quotes__c=opp.id;
        qq.Price_Master__c=opp.Price_Master__c;
        qq.CurrencyIsoCode=opp.CurrencyIsoCode;
        qq.Order_Date__c = Date.today();
        qq.Selling_Country__c = opp.Selling_Country__c;
        qq.Order_Type__c = opp.Quote_Type__c;
        qq.Account_Type__c = opp.Account_Type__c;
        qq.Order_Status__c = 'Open';
        qq.Overall_Quote_Status__c = opp.Approval_Status_Overall__c;
        qq.Tax_Percentage__c = opp.Tax_Percentage__c;
        qq.Account_Entity_Use_Code1__c=opp.Account_Entity_Use_Code1__c;
        qq.Revised_Service_End_Date1__c=opp.Revised_Service_End_Date__c;
        qq.Base_Order_ID__c=opp.Base_Order_ID__c;
        qq.Order_Month__c=qq.Order_Date__c;
        qq.Shared_with_Person_1__c=opp.OwnerId;
        qq.Contribution_Person_1__c=100;
        qq.Shared_with_Person_2__c=opp.Shared_with_Person_2__c;
        qq.Shared_with_Person_3__c=opp.Shared_with_Person_3__c;
        qq.Contribution_Person_2__c=opp.Contribution_Person_2__c;
        qq.Contribution_Person_3__c=opp.Contribution_Person_3__c;
        qq.Owner_Channel_Dev__c = opp.Owner_Channel__c;
        qq.OwnerId=opp.OwnerId;
        
        return qq;
    }
    
    @AuraEnabled
    public static string fetchprofileName(){
        Id id1 = UserInfo.getProfileId();
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        String MyProflieName = PROFILE[0].Name;
        
        system.debug('profileName:'+MyProflieName);
        return MyProflieName;
        
        // List<Profile> pro=[select id,name,User fro];
    }
    
    @AuraEnabled
    public static QuotesN__c fetchqq(string recId){
        QuotesN__c opp = new QuotesN__c();
        opp = [Select Id,Name,Account_Entity_Use_Code1__c,Account__c,Xcode__c,Opportunities__c,Price_Master__c,CurrencyIsoCode,Contact__c, Selling_Country__c,
               Quote_Type__c, Account_Type__c, Approval_Status_Overall__c, Tax_Percentage__c
               from QuotesN__c
               where Id =: recId];
        return opp;
    }
    
    @AuraEnabled
    public static List<Order_Item__c> getOrderLine(String recId){
        List<Quote_Line_Items__c> quliList = new List<Quote_Line_Items__c>();
        List<Order_Item__c> opliList = new List<Order_Item__c>();
        
        quliList = [Select Id,Name,Sku_Type1__c,Account__c,Discount_Type__c,Discount_Value__c,Quantity_Unit__c,CurrencyIsoCode,
                    Price_Master__c,Product__c,Unit_Price__c,Opportunities__c, Adjustment_Type__c, Adjusted_Value__c,
                    of_Master_Login__c, Start_Date__c, End_Date__c, Gross_Total__c, Base_Total__c, Product_Industry__c,
                    Product_Geo_Scope__c, Tenure_Months__c, Product_Country__c,Product_Name__c
                    from Quote_Line_Items__c 
                    where Quotes__c=:recid];
        
        for(Quote_Line_Items__c oo:quliList){
            Order_Item__c qq = new Order_Item__c();
            qq.Account__c=oo.Account__c;
            qq.Adjustment_Type__c = oo.Adjustment_Type__c;
            qq.Adjustment_Value__c = oo.Adjusted_Value__c;
            qq.CurrencyIsoCode=oo.CurrencyIsoCode;
            qq.Quantity__c=oo.Quantity_Unit__c;
            qq.Price_Master__c = oo.Price_Master__c;
            qq.Product__c = oo.Product__c;           
            qq.Unit_Price__c = oo.Unit_Price__c;
            qq.Opportunities__c=oo.Opportunities__c;
            qq.Quote_Line_Items__c=oo.id;
            qq.of_Master_Login__c = oo.of_Master_Login__c;
            qq.Start_Date__c = oo.Start_Date__c;
            qq.End_Date__c = oo.End_Date__c;
            qq.Discount_Amount__c = oo.Discount_Value__c;
            qq.Gross_Total__c = oo.Gross_Total__c;
            qq.Base_Total__c = oo.Base_Total__c;
            qq.Product_Industry__c = oo.Product_Industry__c;
            qq.Product_Geo_Scope__c = oo.Product_Geo_Scope__c;
            qq.Product_Country__c = oo.Product_Country__c;
            qq.Tenure_Months__c = oo.Tenure_Months__c;
            qq.Sku_Type1__c=oo.Sku_Type1__c;
            qq.Base_Product__c = oo.Product__c; 
            qq.Custom_Product_Name__c=oo.Product_Name__c;
            opliList.add(qq);
        }
        return opliList;
    }
    
    @AuraEnabled
    public static String getOrderLineAccessories(String recId){
        
        List<Order_Item_Services__c> oliAccList = new List<Order_Item_Services__c>();
        List<QULI_Accessories__c> quliAccList = new List<QULI_Accessories__c>();
        quliAccList = [Select Id,Name,Top_Ups__c,Unit_Price__c,Quantity_Unit__c,Product__c,CurrencyIsoCode,Price_Master__c,
                       Top_Up_Name__c, Product_Name__c, Inventory_Quota_Tenure1__c, Opp_Line_Item__c, Quote_Line_Items__c,
                       Account__c, Opportunities__c, OPLI_Services__c, Quotes__c, of_Master_Login__c
                       from QULI_Accessories__c 
                       where Quotes__c=:recid];
        List<wraperService> wsli = new List<wraperService> ();
        for(QULI_Accessories__c oo:quliAccList){
            Order_Item_Services__c qq = new Order_Item_Services__c();
            qq.Account__c = oo.Account__c;
            qq.Opportunities__c = oo.Opportunities__c;
            qq.OPLI_Services__c = oo.OPLI_Services__c;
            qq.Quotes__c = oo.Quotes__c;
            qq.QULI_Accessories__c = oo.Id;
            qq.Services__c = oo.Top_Ups__c;
            qq.CurrencyIsoCode = oo.CurrencyIsoCode;
            qq.Price_Master__c = oo.Price_Master__c;
            qq.Product__c = oo.Product__c;
            qq.Quantity__c = oo.Quantity_Unit__c;
            qq.Unit_Price__c = oo.Unit_Price__c;
            qq.Opp_Line_Item__c = oo.Opp_Line_Item__c;
            qq.Quote_Line_Items__c = oo.Quote_Line_Items__c;
            qq.of_Master_Login__c = oo.of_Master_Login__c;
            
            wraperService w = new wraperService(qq);
            w.sname = oo.Top_Up_Name__c;
            w.pname = oo.Product_Name__c;
            w.iqt = oo.Inventory_Quota_Tenure1__c;
            wsli.add(w);
            oliAccList.add(qq);
        }        
        return JSON.serialize(wsli);
    }
    
    @AuraEnabled
    public static string saveQuote(String recId, Order__c quo, List<Order_Item__c> quli, String quacli){
        System.debug('## Running Save Order Component');
        try {
            String currentUserId = UserInfo.getUserId();
            User currentUser = [SELECT Id, Profile.Name,Profile.id FROM User WHERE Id = :currentUserId LIMIT 1];
            String profileName = currentUser.Profile.Name;
            String serviceCRid = currentUser.Profile.id;
            
            System.debug('recordId : ' + recId);
            System.debug('Current User profileName is ** : ' + profileName);
            Date minStartDate = null;
            Date maxEndDate = null;
            
            for (Order_Item__c item : quli) {
                if (item.Start_Date__c != null) {
                    if (minStartDate == null || item.Start_Date__c < minStartDate) {
                        minStartDate = item.Start_Date__c;
                    }
                }
                
                if (item.End_Date__c != null) {
                    if (maxEndDate == null || item.End_Date__c > maxEndDate) {
                        maxEndDate = item.End_Date__c;
                    }
                }
            }
            
            quo.Revised_Service_End_Date__c = minStartDate;
            quo.Order_Service_End_Date__c = maxEndDate;
            System.debug('Order Start Date : ' + quo.Revised_Service_End_Date__c);
            System.debug('Order End Date : ' + quo.Order_Service_End_Date__c);
            
            if(quo.Revised_Service_End_Date__c != null) {
                Date startDate = quo.Revised_Service_End_Date__c;
                
                Integer days = Date.today().daysBetween(startDate);
                System.debug('******days***** ' + days);
                
                if(days <= 0) quo.Order_Priority1__c = 'High';
                if(days == 1) quo.Order_Priority1__c = 'Priority-1';
                if(days == 2) quo.Order_Priority1__c = 'Priority-2';
                if(days > 2) quo.Order_Priority1__c = 'Normal';
            }
            
            System.debug('Order Priority : ' + quo.Order_Priority1__c);
            
            insert quo;
            
            List<Order_Item_Services__c> oliAccList = new List<Order_Item_Services__c>();
            List<wraperService> wsli = (List<wraperService>) JSON.deserialize(quacli, List<wraperService>.class);
            
            for(Order_Item__c qqll : quli){
                qqll.Order__c = quo.Id;
            }
            if(quli.size()>0){
                insert quli;
            }
            
            Map<Id, Id> mquli = new Map<Id, Id> ();
            for(Order_Item__c oi : quli ) {
                mquli.put(oi.Product__c, oi.Id);
            }
            
            for(wraperService w : wsli){
                Order_Item_Services__c oisc = w.ois;
                oisc.Order__c = quo.Id;
                oisc.Order_Item__c = mquli.get(oisc.Product__c);
                oliAccList.add(oisc);
            }
            
            if(oliAccList.size()>0){
                insert oliAccList;
            }
            
            List<APAC_Payments__c> apac = [SELECT Id, Name, Order__c, Quotes__c FROM APAC_Payments__c WHERE Quotes__c =: recId];
            for(APAC_Payments__c a : apac) {
                a.Order__c = quo.Id;
            }
            
            if(apac.size() > 0) update apac;
            
            
            ///////////////////////////////////////Newly Added Anup//////////////////////////////////////////////////
            
            QuotesN__c quote = [SELECT Id, Name, Quote_Type__c, Order_Created__c, Order_Status_Verified_For_Upsell__c, OwnerId 
                                FROM QuotesN__c WHERE Id =: recId];
            if(profileName!='Monster - Service/CR'){
                // if(quote.Quote_Type__c != 'Free Trial' || quote.Quote_Type__c != 'Ecom' || profileName!='Monster - Service/CR'){
                if(quote.Quote_Type__c != 'Free Trial' && quote.Quote_Type__c != 'Ecom' ){
                    
                    System.debug('inside send email******');
                    Order__c order = [SELECT Id, Order_Priority1__c, CurrencyIsoCode, Gross_Total1__c, Owner_Channel__c, Name, Quotes__c, 
                                      Status__c, OwnerId, Account__c, Account__r.Name, Account__r.AccountID__c, Sales_Channel__c,
                                      Order_Type__c, Gross_Total__c, Contact__r.Name, Contact__r.Email, Contact__r.MobilePhone, 
                                      Contact__r.Phone, Comments__c, Order_Comment__c
                                      FROM Order__c WHERE Id =: quo.Id];
                    
                    List<Order_Item_Services__c> lstOrderServices = [SELECT Id, Name, Status__c, Order__c 
                                                                     FROM Order_Item_Services__c WHERE Order__c =: quo.Id];
                    User uu = [SELECT Id, Name, Email, Manager.Email FROM User WHERE Id =: quote.OwnerId];
                    
                    
                    List<string> lstRecipients = new List<string>();
                    lstRecipients.add('activation@foundit.in');
                    
                    List<string> ccaddress = new List<string>();
                    ccaddress.add(uu.Email);
                    ccaddress.add(uu.Manager.Email);
                    
                    System.debug('Order_Priority1__c  : ' + order.Order_Priority1__c);
                    
                    string link = URL.getSalesforceBaseUrl().toExternalForm() + '/' + order.id;
                    String subject = order.Account__r.Name + ' | Request For Activate the Services -' + order.Name +' ('+order.Order_Priority1__c+')';
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(lstRecipients);
                    mail.setCcAddresses(ccaddress);
                    mail.setSubject(subject);
                    mail.setWhatId(order.Id);
                    mail.setHtmlBody(
                        '<b>Please activate the services</b> <br/><br/><br/> Account Name: '+order.Account__r.name+'<br/>Account ID: '  +order.Account__r.AccountID__c 
                        +'<br/>Order Id: ' + order.Name
                        +'<br/>Sales Channel: ' + order.Sales_Channel__c +'<br/>Account Sales Rep: '+uu.Name
                        +'<br/>Order Type: ' + order.Order_Type__c+'<br/> Sales Credit: ' + order.CurrencyIsoCode+' '+ order.Gross_Total1__c
                        +'<br/>Comments: ' + order.Order_Comment__c
                        +'<br/><br/><b>Customer Contact Information: </b><br/>Name - '+order.Contact__r.name
                        +'<br/>Email - '+order.Contact__r.email+'<br/>phone - '+order.Contact__r.Phone
                        +'<br/><br/>Regards,<br/>Team Finance'
                        +'<br/><br/><b>Please click on the record link below for more details<br/>'+link
                    );
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    system.debug('msg sent:'+r);
                }}
            
            quote.Quote_Path__c ='Send To Order';
            UPDATE quote;
            /////////////////////////////////////Newly Added Ends Here//////////////////////////////////////////
            return quo.Id;
        } 
        catch(exception e) {
            System.debug('error message : ' + e.getMessage());
            System.debug('error line number : ' + e.getLineNumber());
            String err_msg = e.getMessage();
            String custom_validation = 'FIELD_CUSTOM_VALIDATION_EXCEPTION,';
            if(err_msg.containsIgnoreCase(custom_validation)) {
                Integer index1 = err_msg.indexOf(custom_validation);
                Integer index2 = index1 + custom_validation.length();
                err_msg = err_msg.substring(index2).trim();
            }
            throw new AuraHandledException(err_msg);   
        }        
    }
    
    public class wraperService {
        public Order_Item_Services__c ois;
        public string sname;
        public string pname;
        public string iqt;
        public wraperService(Order_Item_Services__c item) {
            ois = new Order_Item_Services__c();
            ois = item;
        }
    }
}

/*
subject was: 
'Request For Activating the Services-'+oo1.Name +' For '+oo1.Account__r.Name
*/