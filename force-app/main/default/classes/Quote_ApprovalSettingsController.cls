public without sharing class Quote_ApprovalSettingsController {
    @AuraEnabled(cacheable=true)
    public static String GetApprovalSettings(String recordId) {
        try {
            Quote_Approval_Setting__mdt ApprovalSettings = [SELECT Id, DeveloperName, MasterLabel, Label, Payment_Approval_Settings__c, Discount_Approval_Settings__c, Free_Trail_Approval_Settings__c, Approver_Settings__c
            FROM Quote_Approval_Setting__mdt WHERE DeveloperName =: 'Settings_For_Quote_Approval' LIMIT 1];

            QuotesN__c Quote = [SELECT Id, OwnerId, Name, CurrencyIsoCode, Service_Start_Date__c,CreatedDate, Account__c, Active__c, Approval_Status_Overall__c, Approver_1__c, Approver_2__c, 
            Approver_3__c, Contact__c, Opportunities__c, Price_Master__c, Quote_Type__c, Gross_Total__c, Base_Total__c, Payment_count__c, Quote_Value__c, Net_Total__c, 
            Owner_Channel__c, Tax_Amount__c, Total_Discount__c, Total_Discount_Amount__c, Approver_4__c, Gross_Total1__c, Base_Total1__c, Days_Between__c, Free_Trial_Product__c, 
            Min_Due_Date__c, Deal__c, Approver_5__c, Pre_Renewal__c, Contract_Type__c FROM QuotesN__c WHERE Id =: recordId];

            List<Quote_Line_Items__c> lstQuoteItems = [SELECT Id, Name, Product_Type1__c, Product_Country__c, Quotes__c FROM Quote_Line_Items__c WHERE Quotes__c =: recordId];
            
            List<APAC_Payments__c> lstAPACPayment = [SELECT Id, Name, APAC_Payment_Name__c, CurrencyIsoCode, Due_Date__c, Net_Total__c, Payment_Amount__c, Payment_Date__c, Payment_Received_Amount__c, Quotes__c, Revised_Due_Date__c, TDS_Payment_Amount__c, TDS_Amount__c 
                                                     FROM APAC_Payments__c WHERE Quotes__c =: recordId];
            
            system.debug([SELECT Id,Approval_Status_Overall__c,Level_of_Approval_Required__c,Owner_Channel__c From QuotesN__c Where Id =: recordId]);
            
            QuoteApprovalSettings Controller = new QuoteApprovalSettings(Quote, lstQuoteItems, lstAPACPayment, ApprovalSettings);

            System.debug(Controller.approvers);
            return JSON.serialize(Controller);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String ApprovalPaymentVariables(String recordId){
        try {
            Quote_Approval_Setting__mdt ApprovalSettings = [SELECT Id, DeveloperName, MasterLabel, Label, Payment_Approval_Settings__c, Discount_Approval_Settings__c, Free_Trail_Approval_Settings__c, Approver_Settings__c
            FROM Quote_Approval_Setting__mdt WHERE DeveloperName =: 'Settings_For_Quote_Approval' LIMIT 1];

            QuotesN__c quote = [SELECT Id, OwnerId, Name, CurrencyIsoCode, CreatedDate, Account__c, Active__c, Approval_Status_Overall__c, Approver_1__c, Approver_2__c, 
            Approver_3__c, Contact__c, Opportunities__c, Price_Master__c, Quote_Type__c, Gross_Total__c, Base_Total__c, Payment_count__c, Quote_Value__c, Net_Total__c, Min_Due_Amount__c,
            Owner_Channel__c,Service_Start_Date__c, Tax_Amount__c, Total_Discount__c, Total_Discount_Amount__c, Approver_4__c, Gross_Total1__c, Base_Total1__c, Days_Between__c, Free_Trial_Product__c, 
            Min_Due_Date__c, Deal__c, Approver_5__c, Pre_Renewal__c, Contract_Type__c FROM QuotesN__c WHERE Id =: recordId];

            List<APAC_Payments__c> Payments = [SELECT Id, Name, APAC_Payment_Name__c, CurrencyIsoCode, Due_Date__c, Net_Total__c, Payment_Amount__c, Payment_Date__c, Payment_Received_Amount__c, Quotes__c, Revised_Due_Date__c, TDS_Payment_Amount__c, TDS_Amount__c 
            FROM APAC_Payments__c WHERE Quotes__c =: recordId];

            List<WrapPaymentVariables> lstVariables = new List<WrapPaymentVariables> ();
            if(Payments == null || Payments.size() == 0) return JSON.serialize(lstVariables);

            if(ApprovalSettings.Payment_Approval_Settings__c != null) {
                Map<String, Object> mapMeta = (Map<String, Object>) JSON.deserializeUntyped(ApprovalSettings.Payment_Approval_Settings__c);

                Date CreateDate = Date.today();
                Date QuoteYear = CreateDate.addDays(365);
                Date MaxDueDate_FirstYear = quote.Min_Due_Date__c;
                Decimal UpfrontPayment = null, Upfront = null;
                Integer TotalInstallment_FirstYear = 0;
                for(APAC_Payments__c item : payments) {
                    if(item.Due_Date__c <= QuoteYear) MaxDueDate_FirstYear = item.Due_Date__c;
                    if(item.Due_Date__c == quote.Min_Due_Date__c) UpfrontPayment = item.Net_Total__c;
                    if(item.Due_Date__c <= QuoteYear) TotalInstallment_FirstYear += 1;
                }
                if(UpfrontPayment != null && quote.Net_Total__c != null) {
                    Upfront = (UpfrontPayment / quote.Net_Total__c) * 100;
                    Upfront = Upfront.setScale(2, RoundingMode.HALF_UP);
                }

                System.debug('Upfron Payment ' + Upfront);
    
                String ChannelCategory = null;
                if(quote.Owner_Channel__c == 'ME FS' || quote.Owner_Channel__c == 'SG FS' || quote.Owner_Channel__c == 'MY FS' || quote.Owner_Channel__c == 'PH FS' || quote.Owner_Channel__c == 'HK FS' || quote.Owner_Channel__c == 'Strat' || quote.Owner_Channel__c == 'Growth') {
                    ChannelCategory = 'Enterprise';
                } else {
                    ChannelCategory = 'Non Enterprise';
                }

                Map<String, Object> mapChannelSettings = (Map<String, Object>) mapMeta.get(ChannelCategory);
                if(mapChannelSettings.containsKey(quote.Deal__c)) {
                    system.debug('quote.Deal__c : ' + quote.Deal__c);
                    List<Object> lstSettings = (List<Object>) mapChannelSettings.get(quote.Deal__c);

                    for(Object settings : lstSettings) {
                        Map<String, Object> mapSettings = (Map<String, Object>) settings;
                        Map<String, Object> MinGrossTotalAll = (Map<String, Object>) mapSettings.get('minGrossTotal'); 
                        Map<String, Object> MaxGrossTotalAll = (Map<String, Object>) mapSettings.get('maxGrossTotal'); 
                        Map<String, Object> MinDueAmountAll = (Map<String, Object>) mapSettings.get('minDueAmount'); 

                        Decimal minGrossTotal = MinGrossTotalAll == null ? null : (Decimal) MinGrossTotalAll.get(Quote.CurrencyIsoCode);
                        Decimal maxGrossTotal = MaxGrossTotalAll == null ? null : (Decimal) MaxGrossTotalAll.get(Quote.CurrencyIsoCode);

                        Decimal minPaymentCount = (Decimal) mapSettings.get('minPaymentCount');
                        Decimal maxPaymentCount = (Decimal) mapSettings.get('maxPaymentCount');
                        Decimal AllowedUpfront = (Decimal) mapSettings.get('Upfront');
                        Decimal AllowedInstallment = (Decimal) mapSettings.get('installment');
                        Decimal AllowedMinDueAmount = MinDueAmountAll == null ? null : (Decimal) MinDueAmountAll.get(Quote.CurrencyIsoCode);
                        Decimal AllowedMinMaxDueDateDiff = (Decimal) mapSettings.get('minMaxDueDateDiff');
                        Decimal AllowedMinDueDateDiff = (Decimal) mapSettings.get('minDueDateDiff');

                        Decimal GrossTotal = quote.Gross_Total1__c;
                        Decimal paymentCount = quote.Payment_count__c;

                        // Check if GrossTotal satisfies the range
                        Boolean isInRange = false, isPaymentCountInRange = false;   

                        if (minGrossTotal == null && maxGrossTotal == null) {
                            // No range specified, consider all gross totals valid
                            isInRange = true;
                        } else if (minGrossTotal == null) {
                            // Only maxGrossTotal is specified
                            if (grossTotal <= maxGrossTotal) {
                                isInRange = true;
                            }
                        } else if (maxGrossTotal == null) {
                            // Only minGrossTotal is specified
                            if (grossTotal >= minGrossTotal) {
                                isInRange = true;
                            }
                        } else {
                            // Both minGrossTotal and maxGrossTotal are specified
                            if (grossTotal >= minGrossTotal && grossTotal <= maxGrossTotal) {
                                isInRange = true;
                            }
                        }

                        // Check if PaymentCount satisfies the range
                        if (minPaymentCount == null && maxPaymentCount == null) {
                            isPaymentCountInRange = true;
                        } else if (minPaymentCount == null) {
                            if (paymentCount <= maxPaymentCount) {
                                isPaymentCountInRange = true;
                            }
                        } else if (maxPaymentCount == null) {
                            if (paymentCount >= minPaymentCount) {
                                isPaymentCountInRange = true;
                            }
                        } else {
                            if (paymentCount >= minPaymentCount && paymentCount <= maxPaymentCount) {
                                isPaymentCountInRange = true;
                            }
                        }

                        // if isInRange, check other conditions
                        if (isInRange && isPaymentCountInRange) {
                            System.debug(settings);
                            if(AllowedUpfront != null && Upfront < AllowedUpfront) {
                                WrapPaymentVariables wrap = new WrapPaymentVariables('Upfront', 'Upfront Payment', 'Less than '+ Upfront + '%, (Less than ' + AllowedUpfront + '%)');
                                lstVariables.add(wrap);
                            }
                            
                            if(AllowedInstallment != null && TotalInstallment_FirstYear > AllowedInstallment) {
                                WrapPaymentVariables wrap = new WrapPaymentVariables('Installment', '#Installments (per year)', (TotalInstallment_FirstYear + ', (Exceeds ' + AllowedInstallment + ')'));
                                lstVariables.add(wrap);
                            }
                            
                            if(AllowedMinDueAmount != null && quote.Min_Due_Amount__c < AllowedMinDueAmount) {
                                WrapPaymentVariables wrap = new WrapPaymentVariables('Min Installment Amount', 'Min Installment Amount', (quote.Min_Due_Amount__c.format() + ', (min. installment amount should be ' + AllowedMinDueAmount.format()));
                                lstVariables.add(wrap);
                            }
                            if(AllowedMinMaxDueDateDiff != null && quote.Min_Due_Date__c.daysBetween(MaxDueDate_FirstYear) > AllowedMinMaxDueDateDiff) {
                                Integer Diff = quote.Min_Due_Date__c.daysBetween(MaxDueDate_FirstYear);
                                WrapPaymentVariables wrap = new WrapPaymentVariables('MinMax Due Date', 'Payment dates for the year are spaced at', (Diff + 'Days, (allowed limit '+ AllowedMinMaxDueDateDiff + 'days)'));
                                lstVariables.add(wrap);
                            } 
                            
                            if(AllowedMinDueDateDiff != null && quote.Service_Start_Date__c.daysBetween(quote.Min_Due_Date__c) > AllowedMinDueDateDiff) {
                                Integer Diff = quote.Service_Start_Date__c.daysBetween(quote.Min_Due_Date__c);
                                WrapPaymentVariables wrap = new WrapPaymentVariables('Min Due Date', '1st payment date due in', (Diff + ' days (should not be more ' + AllowedMinDueDateDiff + ' days from service start date)'));
                                lstVariables.add(wrap);
                            }
                            break;
                        }
                    }
                } else {
                    WrapPaymentVariables wrap = new WrapPaymentVariables('Deal Type', 'Multi-Year', 'Finance Head approval required');
                    lstVariables.add(wrap);
                }
            }
            return JSON.serialize(lstVariables);
        } catch (Exception e) {
            System.debug('Apex Error • Get Payment Approval Variables • ' + e.getMessage() + ' at ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string SubmitForApproval(String recordId, String comment, String processName){
        try {
            // Create an approval request for the account
            Approval.ProcessSubmitRequest request = new Approval.ProcessSubmitRequest();
            request.setComments(comment);
            request.setObjectId(recordId);

            // Submit on behalf of a specific submitter
            request.setSubmitterId(UserInfo.getUserId());
            
            // Submit the record to the existing process named PTO_Reqwuest_Process
            request.setProcessDefinitionNameOrId(processName);

            // Submit the approval request for the account
            if(!Test.isRunningTest()){
                 Approval.ProcessResult result = Approval.process(request);
                 return result.isSuccess() ? 'Success' : 'Error';
            }else{
                return 'Error';
            }
           
        } catch (Exception e) {
             System.debug('Apex Error • SubmitForApproval • ' + e.getMessage() + ' at ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class WrapPaymentVariables {
        public String id, label, description;
        public WrapPaymentVariables(String id, String label, String description) {
            this.id = id;
            this.label = label;
            this.description = description; 
        }
    }
}