global class CaptureOrderVfDateTime {

    @AuraEnabled
    webservice static void ORderVerfiCatcher(String Ids){
        System.debug('ID '+Ids);
               BusinessHours bh = [SELECT id FROM BusinessHours WHERE IsActive = True AND Name = 'Order To Order Verification Tracker'];

        Orderc__c cc=[select id,name,OrderStatus__c,SentToVerificationDate__c,QuoteProposal__r.Ready_For_Validation__c,QuoteProposal__r.Re_Process_DateTime__c,Total_Hours__c,SentToVerificationBy__c,createddate,QuoteProposal__r.CReatedDate,QuoteProposal__r.Quote_Finalize_Date_Time__c from OrderC__C where id=:ids];
       
        
        decimal pp=BusinessHours.diff(bh.id,cc.CreatedDate,system.now());
         system.debug('Total MiliScond'+pp/3600000);
         
       
        decimal  p=(decimal)(pp/3600000).setscale(2);
        system.debug('Total MiliScond'+p);
        decimal j= p- p.intvalue();
               Integer min=Math.round(j*60);
        
        if(min==0){
            min=1;
        }
               integer hour =p.intvalue();
        
        
        //Master time from Quote Created Date to Verification
        decimal totalTimeFromQtoOdHour=0.0;
         totalTimeFromQtoOdHour=BusinessHours.diff(bh.id,cc.QuoteProposal__r.CreatedDate,system.now());
         decimal  p1=(decimal)(totalTimeFromQtoOdHour/3600000).setscale(2);
        system.debug('Total MiliScond'+p);
        decimal jj= p1- p1.intvalue();
               Integer minn=Math.round(jj*60);
        if(minn==0){
            minn=1;
        }
               integer hrs =p1.intvalue();
        
        // from Ready To Validation to Order Verification
       
        
        if(cc.QuoteProposal__r.Re_Process_DateTime__c!=null && cc.QuoteProposal__r.Ready_For_Validation__c!=null){
        
       pp=BusinessHours.diff(bh.id,cc.QuoteProposal__r.Re_Process_DateTime__c,system.now());
         
        }
        else if(cc.QuoteProposal__r.Re_Process_DateTime__c==null && cc.QuoteProposal__r.Ready_For_Validation__c!=null){
        pp=BusinessHours.diff(bh.id,cc.QuoteProposal__r.Ready_For_Validation__c ,system.now());

        }
        else if(cc.QuoteProposal__r.Re_Process_DateTime__c==null && cc.QuoteProposal__r.Ready_For_Validation__c==null){
             pp=BusinessHours.diff(bh.id,cc.QuoteProposal__r.Quote_Finalize_Date_Time__c,system.now());
        }
        
        
        
        decimal  RValidationToVerifi=(decimal)(pp/3600000).setscale(2);
            decimal js= RValidationToVerifi- RValidationToVerifi.intvalue();
               Integer min1=Math.round(js*60);
        if(min1==0){
            min1=1;
        }
               integer hour1 =RValidationToVerifi.intvalue();
        
        
        
        
        cc.SentToVerificationDate__c=system.now();
        cc.SentToVerificationBy__c=userinfo.getName();
        cc.Total_Time_Taken_To_Verify_Order_Hours__c=hour;
        cc.Total_Time_Taken_To_Verify_Order__c= min ;
        
        cc.Master_Total_TAT_QC_To_Verification_Hrs__c=hrs;
        cc.Master_Total_TAT_QC_To_Verification_Mn__c=minn;
        
        cc.Total_TAT_validation_To_verification_Hrs__c=hour1;
        cc.Total_TAT_validation_To_verification_Mn__c=min1;
        cc.OrderStatus__c = 'Verified';
        cc.id=cc.id;
        update cc;
       
       
    }
    @AuraEnabled
     webservice static void ORderRejectCatcher(String Ids){
        Orderc__c cc = new Orderc__c();
        cc.RejectedDate__c=system.now();
        cc.RejectedBy__c=userinfo.getName();
        cc.OrderStatus__c = 'Rejected';
        cc.id=ids;
        update cc;
         
    }
    
    @AuraEnabled
    Public static Orderc__c getRecord(id recordId){
        Orderc__c order=[select id,name,RejectedDate__c,RejectedBy__c,OrderStatus__c,RejectedReason__c,Acct_SF_Id__c from OrderC__C where id=:recordId];
        return order;
    }
    
    @AuraEnabled
    Public static boolean xCodeCount(id AccountID){
       List<Xcode__c> xcode = new List<Xcode__c>();
        xcode = [SELECT id,name,Created_For_Account__c,Order_Custom__c from Xcode__c where Created_For_Account__c =: AccountID];
        if(xcode.size()>0){
            return false;
        }
        else{
            return true;
        }
    }
  
}