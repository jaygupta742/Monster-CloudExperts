//Last Modified By : Abdul Aziz , Date : 28/06/2023, Description : Updated Activation emmail from activation@monsterindia.com to activation@foundit.in*/
//Last Modified By : Abdul Aziz , Date : 05/01/2024, Description : Added BCC for seeker ed sales channel
//Last Modified By : Abdul Aziz , Date : 10/01/2024, Description : For Quote Type Fre Trial and Ecom Remove sending email to booking resouce from order email custom setting
//Last Modified By : Abdul Aziz , Date : 24/01/2024, Description : Updated URL In Email Body
//Last Modified By : Abdul Aziz , Date : 30/05/2024, Description : Add Strat and Graowth Channel in Send Email For Ready For Validation // From Order Email Custome Setting
public without sharing class ReadyForValidationEmail {
    public virtual class BaseException extends Exception {}
    public class CustomException extends BaseException {}
    
    @AuraEnabled
    public static String SendEmailNotfication(string recid) {         
        try {  
            User receiver = [SELECT Id, Name, Email, Manager.Email FROM User WHERE Id =: userinfo.getuserid()];
            
            QuotesN__c EQuote = [SELECT Gross_Total1__c, Account__c, QUOTE_PATH__C, Active__c, Owner_Channel__c, Finalised__c, Base_Total__c,
                                 Contact__c, CreatedById, CurrencyIsoCode, Gross_Total__c, Id, Name, Net_Total__c, Opportunities__c, Order_Type__c,
                                 OwnerId, Price_Master__c, Quote_Finalize_Date_Time__c, Quote_Type__c, Quote_Value__c, Validated__c, Xcode__c, CreatedDate, 
                                 Account__r.Name, Contact__r.Name, Contact__r.Email, Contact__r.MobilePhone, Account__r.Id, Account__r.AccountID__c, 
                                 Agency_ID__c, Account__r.SalesChannel__c, Payment_count__c, Owner.Name, Contact__r.Phone,
                                 (SELECT Id, Name, Order_Type__c FROM Orders__r)
                                 FROM QuotesN__c  where Id=:recid ];
            
            string oid = '';
            string otype ='';
            
            Account acc = [SELECT Id, Name, OwnerId, Owner.Name FROM Account WHERE Id =: EQuote.Account__c];
            
            if(EQuote.Orders__r.size() != 0){
                oid = EQuote.Orders__r[0].Name;
                otype = EQuote.Orders__r[0].Order_Type__c;
            }
            
            //String link = URL.getSalesforceBaseUrl().toExternalForm() + '/' + EQuote.id + '/view';
            String link = URL.getSalesforceBaseUrl().toExternalForm() + '/' + 'lightning/r/QuotesN__c/' + EQuote.id + '/view';
            
            
            List<string> bccadd = new List<string>();
            if(receiver.Manager.Email != null){
                bccadd.add(receiver.Manager.Email);
                bccadd.add(receiver.Email);
            }
            
            Order_Email__c VerficationEmails = Order_Email__c.getValues(EQuote.Owner_Channel__c);
            
            if(EQuote.Quote_Type__c=='Free Trial' || EQuote.Quote_Type__c=='Ecom') {
                bccadd.add('activation@foundit.in');
            }
            if(EQuote.Owner_Channel__c=='Seeker-Ed Sales') {
                bccadd.add('nisha.v@foundit.ai');
            }
            
            if(VerficationEmails != null && EQuote.Quote_Type__c!='Free Trial' && EQuote.Quote_Type__c!='Ecom' ) {  
                bccadd.add(VerficationEmails.Email__c);
            }
            
            if(bccadd.size() > 0) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(bccadd);
                mail.setWhatId(recid);
                mail.setSubject('Please activate the services-'+EQuote.name+' for '+EQuote.Account__r.name);   
                mail.setHtmlBody(
                    '<b>Please activate the services</b> <br/><br/><br/> Account Name: '+EQuote.Account__r.name+'<br/>Account ID: '  +EQuote.Account__r.AccountID__c 
                    +'<br/>Order Number: '+oid+'<br/>Sales Channel: '+EQuote.Account__r.SalesChannel__c +'<br/>Account Sales Rep: '+acc.owner.name //Account__r.owner.name
                    +'<br/>Order Type: '+EQuote.Order_Type__c+'<br/> Sales Credit: '+EQuote.CurrencyIsoCode+' '+EQuote.Gross_Total1__c	
                    +'<br/><br/><b>Customer Contact Information: </b><br/>Name - '+EQuote.Contact__r.name
                    +'<br/>Email - '+EQuote.Contact__r.email+'<br/>Phone - '+EQuote.Contact__r.phone
                    +'<br/>Mobile:'+EQuote.Contact__r.mobilephone
                    +'<br/><br/>Regards,<br/>Team Finance'
                    +'<br/><br/><b>Please click on the record link below for more details<br/>'+link
                    
                );
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                system.debug('@@ msg sent : ' + r);
            }
            
            QuotesN__c forupdate = new QuotesN__c();
            forupdate.Id = EQuote.Id;
            forupdate.Validated__c = true;
            forupdate.Finalised__c = true;
            forupdate.Quote_Finalize_Date_Time__c = system.now();
            forupdate.Validate_DateTime__c = system.now();
            
            update forupdate;
            
            if(EQuote.Opportunities__c!=null){
                OpportunityN__c	EOpportunity = new OpportunityN__c();
                EOpportunity.Validated__c = true;
                EOpportunity.Id = EQuote.Opportunities__c;
                update EOpportunity;
            }
            
            return 'Mail Send Successfully!!!';
        } catch (Exception e) {
            System.debug('Exception Occured'+e.getMessage());
            System.debug('Exception Occured in Line'+e.getLineNumber());
            return e.getMessage();
        }
    }
    
    @AuraEnabled
    public static QuotesN__c getRecord(id recordId) {
        try {
            QuotesN__c EQuote = [SELECT Id, Name, Validated__c, Finalised__c, Opportunities__c, Payment_count__c FROM QuotesN__c WHERE Id =: recordId];
            if(EQuote.Payment_count__c == 0) throw new CustomException('Please add  APAC payment to validate');
            
            List<ContentVersion> lstDocument = [SELECT Id, Title FROM ContentVersion WHERE FirstPublishLocationId =: recordId];
            if(lstDocument.size() == 0) throw new CustomException('Please click Generate Foundit PDF to add Quote Agreement PDF into Attachments');
            
            List<Foundit_Quote_Pdf__c> lstPDFTemplates = Foundit_Quote_Pdf__c.getall().values();
            
            Boolean document_flag = false;
            for(ContentVersion document : lstDocument) {
                for(Foundit_Quote_Pdf__c pdfTemplate : lstPDFTemplates) {
                    string tempName = pdfTemplate.PDF__c+'.pdf';
                    if(tempName == document.Title) {
                        document_flag = true;
                        break;
                    }
                }
                if(document_flag == true) break;
            }
            if(document_flag == false) throw new CustomException('Please click Generate Foundit PDF to add Quote Agreement PDF into Attachments.');
            if(EQuote.Validated__c) throw new CustomException('Quote already Validated.');
            
            return EQuote;
        } catch(Exception e) {
            System.debug('@@ Get Record error message: ' + e.getMessage());
            System.debug('@@ Get Record error line number: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}