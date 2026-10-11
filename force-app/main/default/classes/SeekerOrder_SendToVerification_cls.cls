public with sharing class SeekerOrder_SendToVerification_cls {
    public virtual class BaseException extends Exception {}
    public class CustomException extends BaseException {}

    @AuraEnabled(cacheable=true)
    public static Seeker_Order__c FetchOrderDetails(String recordId){
        try {
            Seeker_Order__c Order = [SELECT Id, Name, Account__c, Selling_Country__c, OwnerId, CurrencyIsoCode, Price_Master__c, Base_Total__c, APAC_Payment_Count__c,Enrollment_No__c ,
            Discount__c, Subvention_Cost__c, Selling_Cost__c, Gross_Total__c, Net_Total__c, Order_Status__c, Approved_Rejected_By__c, Sent_For_Verification_At__c,
            Account__r.SalesChannel__c
            FROM Seeker_Order__c WHERE Id =: recordId];
            
            if(Order.Enrollment_No__c == null){
                throw new CustomException('Enrollment Number Is Needed For Verification');
            }

            if(Order.Order_Status__c != 'Quote' && Order.Order_Status__c != 'Rejected') {
                throw new CustomException('Order is already in "' + Order.Order_Status__c + '" status, can not be sent to varification.');
            }

            if(Order.APAC_Payment_Count__c == 0) {
                throw new CustomException('Please add APAC Payments to send for verification');
            }
            return Order;
        } catch (Exception e) {
            System.debug('Fetch Order Details error message: ' + e.getMessage());
            System.debug('Fetch Order Details error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string SendForVerification(String recordId) {
        try {
            Seeker_Order__c Order = [SELECT Id, Name, Account__c, Account__r.Name, Account__r.AccountID__c, Account__r.SalesChannel__c, Selling_Country__c, OwnerId, Owner.Name, CurrencyIsoCode, 
            Price_Master__c, Base_Total__c, APAC_Payment_Count__c, Discount__c, Subvention_Cost__c, Selling_Cost__c, Gross_Total__c, Net_Total__c, 
            Order_Status__c, Approved_Rejected_By__c, Sent_For_Verification_At__c, Seeker_Name__c, Seeker_Contact__c, Enrollment_No__c, Seeker_Email__c 
            FROM Seeker_Order__c WHERE Id =: recordId];

            User CurrentUser = [SELECT Id, Name, Email, ManagerId, Manager.Email, Channel__c FROM User WHERE Id =: UserInfo.getUserId()];

            Order.Sent_For_Verification_At__c = Datetime.now();
            Order.Order_Status__c = 'Sent To Order';

            Update Order;

            List<String> lstCCAddress = new List<String> ();
            if(CurrentUser.Email != null) lstCCAddress.add(CurrentUser.Email);
            if(CurrentUser.ManagerId != null && CurrentUser.Manager.Email != null) lstCCAddress.add(CurrentUser.Manager.Email);

            List<String> lstToAddress = new List<String> ();
            Order_Email__c OrderEmails = Order_Email__c.getValues(CurrentUser.Channel__c);
            if(OrderEmails != null && OrderEmails.Email__c != null) lstToAddress.add(OrderEmails.Email__c);
            
            String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
            String recordUrl = baseUrl + '/' + recordId;

            String EmailBody = '';
            EmailBody += '<b>Please activate the services</b> <br/> Account Name: ' + Order.Account__r.Name + '<br/>Account ID: ' + Order.Account__r.AccountID__c ;
            EmailBody += '<br/>Order Number: ' + Order.Name +'<br/>Sales Channel: ' + Order.Account__r.SalesChannel__c + '<br/>Account Sales Rep: '+Order.Owner.Name;
            EmailBody += '<br/>Order Type: Seeker Orders <br/> Sales Credit: ' + Order.CurrencyIsoCode + ' '+ Order.Gross_Total__c;
            EmailBody += '<br/><br/><b>Customer Contact Information: </b><br/>Name: ' + Order.Seeker_Name__c;
            EmailBody += '<br/>Email: ' + Order.Seeker_Email__c + '<br/>Mobile: ' + Order.Seeker_Contact__c;
            EmailBody += '<br/>Enrollment No: ' + Order.Enrollment_No__c;
            EmailBody += '<br/><br/><b>Please click on the record link below for more details<br/>';
            EmailBody += recordUrl;
            EmailBody += '<br/><br/>Regards,<br/>Team Finance';

            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(lstToAddress);
            message.setCcAddresses(lstCCAddress);
            message.setWhatId(Order.Id);

            if(lstToAddress.size() > 0) {
                message.setSubject('Please activate the services-' + Order.Name + ' for ' + Order.Account__r.Name);
                message.setHtmlBody(EmailBody);
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message});
                System.debug(r);
            }
            System.debug('success');

            return 'success';
        } catch (Exception e) {
            System.debug('Send For Verification error message: ' + e.getMessage());
            System.debug('Send For Verification error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Seeker_Order__c FetchOrderDetail_ApprovedRejected(String recordId){
        try {
            Seeker_Order__c Order = [SELECT Id, Name, Account__c, Selling_Country__c, OwnerId, CurrencyIsoCode, Price_Master__c, Base_Total__c, APAC_Payment_Count__c,
            Discount__c, Subvention_Cost__c, Selling_Cost__c, Gross_Total__c, Net_Total__c, Order_Status__c, Approved_Rejected_By__c, Sent_For_Verification_At__c
            FROM Seeker_Order__c WHERE Id =: recordId];

            if(Order.Order_Status__c == 'Quote') {
                throw new CustomException('Order is in "' + Order.Order_Status__c + '" status. You can not perform this action at this stage.');
            }

            if(Order.Order_Status__c == 'Verified' || Order.Order_Status__c == 'Rejected') {
                throw new CustomException('Order is already in "' + Order.Order_Status__c + '" status. You can not perform this action at this stage.');
            }

            return Order;
        } catch (Exception e) {
            System.debug('Fetch Order Detail Approved/Rejected error message: ' + e.getMessage());
            System.debug('Fetch Order Detail Approved/Rejected error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string Accept_SeekerOrder(String recordId) {
        try {
            Seeker_Order__c Order = [SELECT Id, Name, Account__c, Selling_Country__c, OwnerId, CurrencyIsoCode, Price_Master__c, Base_Total__c, APAC_Payment_Count__c,
            Discount__c, Subvention_Cost__c, Selling_Cost__c, Gross_Total__c, Net_Total__c, Order_Status__c, Approved_Rejected_By__c, Sent_For_Verification_At__c, Approved_Rejected_Date__c
            FROM Seeker_Order__c WHERE Id =: recordId];

            Order.Order_Status__c = 'Verified';
            Order.Approved_Rejected_By__c = UserInfo.getUserId();
            Order.Approved_Rejected_Date__c = Datetime.now();

            Update Order;
            return 'success';
        } catch (Exception e) {
            System.debug('Fetch Order Details error message: ' + e.getMessage());
            System.debug('Fetch Order Details error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string Reject_SeekerOrder(String recordId) {
        try {
            Seeker_Order__c Order = [SELECT Id, Name, Account__c, Selling_Country__c, OwnerId, CurrencyIsoCode, Price_Master__c, Base_Total__c, APAC_Payment_Count__c,
            Discount__c, Subvention_Cost__c, Selling_Cost__c, Gross_Total__c, Net_Total__c, Order_Status__c, Approved_Rejected_By__c, Sent_For_Verification_At__c, Approved_Rejected_Date__c
            FROM Seeker_Order__c WHERE Id =: recordId];

            Order.Order_Status__c = 'Rejected';
            Order.Approved_Rejected_By__c = UserInfo.getUserId();
            Order.Approved_Rejected_Date__c = Datetime.now();

            return 'success';
        } catch (Exception e) {
            System.debug('Fetch Order Details error message: ' + e.getMessage());
            System.debug('Fetch Order Details error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}