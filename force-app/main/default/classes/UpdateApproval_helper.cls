/*
Last Modified By    Last Modified Date      Case      Description
Abdul Aziz                              Re-define the condition for all the sales channel
Abdul Aziz                              Descriprion :Updated SMB Channel
Abdul Aziz        29/01/2023                  Added Condition for free trial Product
Jay Gupta        15/02/2024                  Added Condition for 20 To 30 for IN TS and IND TS Channel
Abdul Aziz        01/03/2024                  Updated Approval For EA
Abdul Aziz        24/04/2024                  Updated Approval For SEA-TS / ME-TS /ME-FS
Debasis Das        28/05/2024          00017654    Implement the new discounting matrix in SF, Major changes on discount percentage. check case description
Debasis Das        07/06/2024          00017745    Implement the new scenario for Quote Approval in SF, Major changes on approval level. check case description
Jay Gupta		   01/08/2024		   00018239    Implemented apex sharing to share records with different approvers.
*/
public class UpdateApproval_helper {
    public static Boolean isSharedNew = true;
    public static Boolean Flag_BeforeInsert = true, Flag_AfterInsert = true, Flag_BeforeUpdate = true, Flag_AfterUpdate = true;
    
    public static void HandleBeforeInsert(List<QuotesN__c> TriggerNew) {
        Flag_BeforeInsert = false;
        update_approvers(TriggerNew);
        update_priority(TriggerNew, true);
    }
    
    public static void HandleAfterInsert(List<QuotesN__c> TriggerNew) {
        Flag_AfterInsert = false;
        shareWithAccountOwner(TriggerNew);
    }
    
    public static void HandleBeforeUpdate(List<QuotesN__c> TriggerNew, List<QuotesN__c> TriggerOld) {
        Flag_BeforeUpdate = false;
        update_approvers(TriggerNew);
        update_priority(TriggerNew, false);
    }
    
    public static void HandleAfterUpdate(List<QuotesN__c> TriggerNew, List<QuotesN__c> TriggerOld) {
        Flag_AfterUpdate = false;
    }
    
    public static void update_approvers(List<QuotesN__c> quotes) {        
        System.debug('Update Approvers running');
        Set<Id> setQuoteIds = new Set<Id> ();
        for(QuotesN__c item : quotes) {
            if(item.Approval_Status_Overall__c != 'Submitted'){
                setQuoteIds.add(item.Id);
            }
        }
        
        List<User> users = [SELECT Id, Name, ManagerId,Branch_Manager__c,Retail_Manager__c,Regional_Manager__c,isActive FROM User WHERE isActive = true];
        
        Map<String, Id> mapUsersByName = new Map<String, Id> ();
        Map<Id, Id> mapManagerByUsers = new Map<Id, Id>();
        Map<Id,User> mapdOfRetailAndBranchManager = new Map<Id,User>();
        
        for(User u : users) {
            mapUsersByName.put(u.Name, u.Id);
            mapManagerByUsers.put(u.Id, u.ManagerId);
            mapdOfRetailAndBranchManager.put(u.Id,u);
        }
        
        Map<Id, List<APAC_Payments__c>> mapPaymentsByQuote = new Map<Id, List<APAC_Payments__c>> ();
        Map<Id, List<Quote_Line_Items__c>> mapQuoteItemsByQuote = new Map<Id, List<Quote_Line_Items__c>> ();
        
        List<APAC_Payments__c> lstAPACPayment = [SELECT Id, Name, APAC_Payment_Name__c, CurrencyIsoCode, Due_Date__c, Net_Total__c, Payment_Amount__c, Payment_Date__c, Payment_Received_Amount__c, Quotes__c, Revised_Due_Date__c, TDS_Payment_Amount__c, TDS_Amount__c 
                                                 FROM APAC_Payments__c WHERE Quotes__c IN: setQuoteIds];
        
        List<Quote_Line_Items__c> lstQuoteItems = [SELECT Id, Name, Product_Type1__c, Product_Country__c, Quotes__c FROM Quote_Line_Items__c WHERE Quotes__c IN: setQuoteIds];
        
        for(APAC_Payments__c item: lstAPACPayment) {
            if(mapPaymentsByQuote.containsKey(item.Quotes__c)) {
                List<APAC_Payments__c> payments = mapPaymentsByQuote.get(item.Quotes__c);
                payments.add(item);
                mapPaymentsByQuote.put(item.Quotes__c, payments);
            } else {
                List<APAC_Payments__c> payments = new List<APAC_Payments__c> ();
                payments.add(item);
                mapPaymentsByQuote.put(item.Quotes__c, payments);
            }
        }
        
        for(Quote_Line_Items__c item: lstQuoteItems) {
            if(mapQuoteItemsByQuote.containsKey(item.Quotes__c)) {
                List<Quote_Line_Items__c> quoteitems = mapQuoteItemsByQuote.get(item.Quotes__c);
                quoteitems.add(item);
                mapQuoteItemsByQuote.put(item.Quotes__c, quoteitems);
            } else {
                List<Quote_Line_Items__c> quoteitems = new List<Quote_Line_Items__c> ();
                quoteitems.add(item);
                mapQuoteItemsByQuote.put(item.Quotes__c, quoteitems);
            }
        }
        
        Quote_Approval_Setting__mdt ApprovalSettings = [SELECT Id, DeveloperName, MasterLabel, Label, Payment_Approval_Settings__c, Discount_Approval_Settings__c, Free_Trail_Approval_Settings__c, Approver_Settings__c
                                                        FROM Quote_Approval_Setting__mdt WHERE DeveloperName =: 'Settings_For_Quote_Approval' LIMIT 1];
        
        Map<Id,Set<String>> accountTobeSharedWithUserMap = new Map<Id,Set<String>>();
        
        for(QuotesN__c qu : quotes) {
            if(qu.Approval_Status_Overall__c != 'Submitted'){
                Id OwnerManager = mapManagerByUsers.get(qu.OwnerId);
                Id OwnerManagersManager = OwnerManager != null ? mapManagerByUsers.get(OwnerManager) : null;
                Id BranchManager = mapdOfRetailAndBranchManager.get(qu.OwnerId)?.Branch_Manager__c != null ? mapdOfRetailAndBranchManager.get(qu.OwnerId)?.Branch_Manager__c : null;
                Id RetailManager = mapdOfRetailAndBranchManager.get(qu.OwnerId)?.Retail_Manager__c != null ? mapdOfRetailAndBranchManager.get(qu.OwnerId)?.Retail_Manager__c : null;
                Id RegionalManager = mapdOfRetailAndBranchManager.get(qu.OwnerId)?.Regional_Manager__c != null ? mapdOfRetailAndBranchManager.get(qu.OwnerId)?.Regional_Manager__c : null;
                
                List<APAC_Payments__c> payments = mapPaymentsByQuote.get(qu.Id);
                List<Quote_Line_Items__c> quoteItems = mapQuoteItemsByQuote.get(qu.Id);
                
                qu.Approver_1__c = null;
                qu.Approver_2__c = null;
                qu.Approver_3__c = null;
                qu.Approver_4__c = null;
                qu.Approver_5__c = null;
                qu.Approver_6__c = null;
                qu.Approver_7__c = null;
                qu.Approver_8__c = null;
                qu.Approver_9__c = null;
                qu.Approver_10__c = null;
                
                if(qu.Quote_Type__c == 'Free Trial') {
                    String JSONApprovalSettings = null;
                    if(qu.Quote_Type__c == 'Free Trial') JSONApprovalSettings = ApprovalSettings.Free_Trail_Approval_Settings__c;
                    
                    Map<String, Object> mapMetaSettings = (Map<String, Object>) JSON.deserializeUntyped(JSONApprovalSettings);
                    
                    if(mapMetaSettings.containsKey(qu.Owner_Channel__c)) {
                        /*Map<String, Object> mapSettingByChannel = (Map<String, Object>) mapMetaSettings.get(qu.Owner_Channel__c);
                        List<Object> lstApprovers = (List<Object>) mapSettingByChannel.get('approvers');
                        qu.Level_of_Approval_Required__c = lstApprovers.size();                        
                        for(Integer i=0; i<lstApprovers.size(); i++) {
                            String approver = (String) lstApprovers[i];
                            String ApproverId = null;
                            if(approver == 'Manager') ApproverId = mapManagerByUsers.get(qu.OwnerId);
                            else if(approver == 'Managers Manager') ApproverId = mapManagerByUsers.get(mapManagerByUsers.get(qu.OwnerId));
                            else if(approver == 'Branch Manager') ApproverId = BranchManager;
                            else if(approver == 'Retail Manager') ApproverId = RetailManager;
                            else if(approver == 'Regional Manager') ApproverId = RegionalManager;
                            else ApproverId = mapUsersByName.get(approver);
                            
                            if(ApproverId == null){
                                qu.Level_of_Approval_Required__c -= 1;
                                //Index += 1;
                                continue;
                            }else if(ApproverId != null){
                                Set<String> userSet = accountTobeSharedWithUserMap.get(qu.Id) == null ? new Set<String>() : accountTobeSharedWithUserMap.get(qu.Id);
                                userSet.add(ApproverId);
                                accountTobeSharedWithUserMap.put(qu.Id,userSet);
                            }                   
                            
                            if(i == 0) {
                                qu.Approver_1__c = ApproverId;
                                qu.Approver_2__c = null;
                                qu.Approver_3__c = null;
                                qu.Approver_4__c = null;
                                qu.Approver_5__c = null;
                            }
                            if(i == 1) {
                                qu.Approver_2__c = ApproverId;
                                qu.Approver_3__c = null;
                                qu.Approver_4__c = null;
                                qu.Approver_5__c = null;
                            }
                            if(i == 2) {
                                qu.Approver_3__c = ApproverId;
                                qu.Approver_4__c = null;
                                qu.Approver_5__c = null;
                            }
                            if(i == 3) {
                                qu.Approver_4__c = ApproverId;
                                qu.Approver_5__c = null;
                            }
                            if(i == 4) {
                                qu.Approver_5__c = ApproverId;
                            }
                        }*/
                    }
                } else {
                    QuoteApprovalSettings ApprovalSettingsDetails = new QuoteApprovalSettings(qu, quoteItems, payments, ApprovalSettings);
                    System.debug('Approval Combination ' + ApprovalSettingsDetails.QuoteApprovalCombination);
                    System.debug('Approver Details ' + ApprovalSettingsDetails.approvers);
                    
                    Integer Index = 0;
                    qu.Level_of_Approval_Required__c = ApprovalSettingsDetails.approvers.size();
                    for(String approver : ApprovalSettingsDetails.approvers) {
                        String ApproverId = null;
                        if(approver == 'Manager') ApproverId = OwnerManager;
                        else if(approver == 'Managers Manager') ApproverId = OwnerManagersManager;
                        else if(approver == 'Branch Manager') ApproverId = BranchManager;
                        else if(approver == 'Retail Manager') ApproverId = RetailManager;
                        else if(approver == 'Regional Manager') ApproverId = RegionalManager;
                        else if(mapUsersByName.containsKey(approver)) ApproverId = mapUsersByName.get(approver);
                        
                        system.debug('approver : ' + approver);
                        system.debug('ApproverId : ' + ApproverId);
                        
                        if(ApproverId == null){
							//Index += 1;
							qu.Level_of_Approval_Required__c -= 1;
                            continue;
                        }else if(ApproverId != null){
                            Set<String> userSet = accountTobeSharedWithUserMap.get(qu.Id) == null ? new Set<String>() : accountTobeSharedWithUserMap.get(qu.Id);
                            userSet.add(ApproverId);
                            accountTobeSharedWithUserMap.put(qu.Id,userSet);
                        }   
                        
                        switch on Index {
                            when 0 {
                                qu.Approver_1__c = ApproverId;
                            }
                            when 1 {
                                qu.Approver_2__c = ApproverId;
                            }
                            when 2 {
                                qu.Approver_3__c = ApproverId;
                            }
                            when 3 {
                                qu.Approver_4__c = ApproverId;
                            }
                            when 4 {
                                qu.Approver_5__c = ApproverId;
                            } 
                            when 5 {
                                qu.Approver_6__c = ApproverId;
                            }
                            when 6 {
                                qu.Approver_7__c = ApproverId;
                            }
                            when 7 {
                                qu.Approver_8__c = ApproverId;
                            }
                            when 8 {
                                qu.Approver_9__c = ApproverId;
                            }
                            when 9 {
                                qu.Approver_10__c = ApproverId;
                            }
                            when else {
                            }
                        }
                        Index += 1;
                    }
                }
                
                shareQuoteWithApprovers(accountTobeSharedWithUserMap);            
                
            }
            
        }
    }
    
    public static void update_priority(List<QuotesN__c> quotes, Boolean isInsert) {
        try {
            Date today = Date.today();
            for(QuotesN__c qq : quotes) {
                if(!isInsert) today = Date.valueOf(qq.CreatedDate);
                Integer days = today.daysBetween(qq.Start_Date__c);
                if(days == 0) qq.Quote_Priority__c = 'High';
                if(days == 1) qq.Quote_Priority__c = 'Priority-1';
                if(days == 2) qq.Quote_Priority__c = 'Priority-2';
                if(days > 2) qq.Quote_Priority__c = 'Normal';
            }
        } catch(Exception e) {
            System.debug('error message : ' + e.getMessage());
            System.debug('error line number : ' + e.getLineNumber());
        }
    }
    
    public static void shareWithAccountOwner(List<QuotesN__c> quotes) {
        try {
            User userInformation = [SELECT Id, Name, Department, email, Title, MobilePhone, Phone 
                                    FROM User WHERE Id=:UserInfo.getUserId()];
            
            Set<String> setAccId = new Set<String> ();
            Set<String> setOwnerId = new Set<String> ();
            for(QuotesN__c quote : quotes) {
                if(quote.Account__c != null) setAccId.add(quote.Account__c);
                if(quote.OwnerId != null) setOwnerId.add(quote.OwnerId); 
            }
            
            List<Account> lstAccount = [SELECT Id, Name, OwnerId, Owner.ManagerId FROM Account WHERE Id IN: setAccId];
            List<User> lstOwners = [SELECT Id, Name, Department, email, Title, MobilePhone, Phone, ManagerId FROM User WHERE Id IN: setOwnerId];
            
            Map<Id, Account> mapAcc = new Map<Id, Account> (lstAccount);
            Map<Id, User> mapUsers = new Map<Id, User> (lstOwners);
            
            List<QuotesN__Share> lstSharedQuote = new List<QuotesN__Share> ();
            for(QuotesN__c quote : quotes) {
                if(mapAcc.containsKey(quote.Account__c)) {
                    Account quoteAccount = mapAcc.get(quote.Account__c); 
                    if(quoteAccount.OwnerId != userInformation.Id) {
                        QuotesN__Share quoteShare = new QuotesN__Share();
                        quoteShare.ParentId = quote.Id;
                        quoteShare.UserOrGroupId = quoteAccount.OwnerId;
                        quoteShare.AccessLevel = 'edit';
                        lstSharedQuote.add(quoteShare);
                    }
                    
                    if(quoteAccount.Owner.ManagerId != null && quoteAccount.Owner.ManagerId != userInformation.Id) {
                        QuotesN__Share quoteShare = new QuotesN__Share();
                        quoteShare.ParentId = quote.Id;
                        quoteShare.UserOrGroupId = quoteAccount.Owner.ManagerId;
                        quoteShare.AccessLevel = 'edit';
                        lstSharedQuote.add(quoteShare);
                    }
                }
                
                if(mapUsers.containsKey(quote.OwnerId)) {
                    User quoteUser = mapUsers.get(quote.OwnerId);
                    if(quoteUser.ManagerId != null && quoteUser.ManagerId != userInformation.Id) {
                        QuotesN__Share quoteShare = new QuotesN__Share();
                        quoteShare.ParentId = quote.Id;
                        quoteShare.UserOrGroupId = quoteUser.ManagerId;
                        quoteShare.AccessLevel = 'edit';
                        lstSharedQuote.add(quoteShare);
                    }
                }
            }
            
            Database.SaveResult[] lsr = Database.insert(lstSharedQuote, false);
            
        } catch(Exception e) {
            System.debug('AccountOppRollUpSummary_Helper.shareWithAccountOwner error message : ' + e.getMessage());
            System.debug('AccountOppRollUpSummary_Helper.shareWithAccountOwner error line number : ' + e.getLineNumber());
        }
    }
    
    
    public static void shareQuoteWithApprovers(Map<Id,Set<String>> accountTobeSharedWithUserMap){
        
        try{
            List<QuotesN__Share> quoteShareList = new List<QuotesN__Share>();
            
            for(Id quoteId : accountTobeSharedWithUserMap.keySet()){
                for(String approvers : accountTobeSharedWithUserMap.get(quoteId)){
                    QuotesN__Share quoteShare = new QuotesN__Share();
                    quoteShare.ParentId = quoteId; 
                    quoteShare.UserOrGroupId = approvers;
                    quoteShare.accessLevel = 'Read';
                    quoteShareList.add(quoteShare);
                }
            }
            
            insert quoteShareList;
        }catch(Exception e) {
            System.debug('UpdateApproval_helper.shareQuoteWithApprovers error message : ' + e.getMessage());
            System.debug('UpdateApproval_helper.shareQuoteWithApprovers error line number : ' + e.getLineNumber());
        }
    }
    
    
}