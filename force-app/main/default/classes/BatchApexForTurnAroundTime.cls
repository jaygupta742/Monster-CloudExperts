global class BatchApexForTurnAroundTime implements Database.Batchable<Sobject>, Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext BC){
         
        String rtname='After Validated';
        String st='select id,name,Channel__c,SalesChannel__c,Selling_Country__c,RecordType.name,CreatedDate,Ready_For_Validation__c,Re_Process_DateTime__c,Sent_Back_DateTime__c,CurrencyIsoCode,Gross_Total__c,Account_Owner__c,Owner_Location__c,(select id,name,AccountID__c,Account__r.name,createddate,QuoteProposal__r.name,SentToVerificationDate__c,Order_Created_Time__c from Orders__r where createddate>2018-10-01T00:00:00.000+0000) from apttus_proposal_proposal__c where Ready_For_Validation__c>2018-10-01T00:00:00.000+0000 AND recordtype.name=:rtname';
       return Database.getQueryLocator(st);
    }
   global void execute(Database.BatchableContext BC, List<apttus_proposal_proposal__c> odc){
           BusinessHours QuoteBH = [SELECT id FROM BusinessHours WHERE IsActive = True AND Name = 'Quote To Order Tracker'];
           BusinessHours orderBH = [SELECT id FROM BusinessHours WHERE IsActive = True AND Name = 'Order To Order Verification Tracker'];

       List<apttus_proposal_proposal__c> qt= new List<apttus_proposal_proposal__c>();
       List<OrderC__c> od = new List<OrderC__c>();
       for(apttus_proposal_proposal__c cc:odc){
           if(cc.Ready_For_Validation__c!=null){
               
               
           apttus_proposal_proposal__c quoteup= new apttus_proposal_proposal__c();
               
               //Quote created to quote validations
      decimal pp=BusinessHours.diff(QuoteBH.id,cc.CreatedDate,cc.Ready_For_Validation__c);
            decimal  p=(decimal)(pp/3600000).setscale(2);
        system.debug('Total MiliScond'+p);
        decimal j= p- p.intvalue();
               Integer min=Math.round(j*60);
        
        if(min==0){
            min=1;
        }
          integer hour =p.intvalue();
          quoteup.id=cc.id;
           quoteup.Quote_Created_To_RD_Validation_TAT_hrs__c=hour;
           quoteup.Quote_Created_To_RD_Validation_TAT_Mn__c=min;
           qt.add(quoteup);
           }
           //=====================================================
           for(OrderC__c dd:cc.Orders__r){//Inner Loop
               
            //Ready to validation to Order Created Date   
               OrderC__c kk=new OrderC__c();
               kk.id=dd.id;
               decimal quotetoOrder=0.0;
        if(cc.Re_Process_DateTime__c!=null && cc.Ready_For_Validation__c!=null){
        
       quotetoOrder=BusinessHours.diff(orderBH.id,cc.Re_Process_DateTime__c,dd.CreatedDate);
         
        }
        else if(cc.Re_Process_DateTime__c==null && cc.Ready_For_Validation__c!=null){
        quotetoOrder=BusinessHours.diff(orderBH.id,cc.Ready_For_Validation__c ,dd.CreatedDate);

        }
        else if(cc.Re_Process_DateTime__c==null && cc.Ready_For_Validation__c==null){
             quotetoOrder=BusinessHours.diff(orderBH.id,cc.Quote_Finalize_Date_Time__c,dd.CreatedDate);
        }
        
        
        
        decimal  p=(decimal)(quotetoOrder/3600000).setscale(2);
            decimal j= p- p.intvalue();
               Integer min=Math.round(j*60);
        if(min==0){
            min=1;
        }
               integer hour =p.intvalue();
         kk.Total_Time_Taken_To_Create_Order_Hour__c=hour;
         kk.Time_Taken_To_Create_Order_Min__c=min;
        //==========================================================================
        
               //Master time from Quote Created Date to Verification
               if(dd.SentToVerificationDate__c!=null){
        decimal totalTimeFromQtoOdHour=0.0;
         totalTimeFromQtoOdHour=BusinessHours.diff(orderBH.id,cc.CreatedDate,dd.SentToVerificationDate__c);
         decimal  p1=(decimal)(totalTimeFromQtoOdHour/3600000).setscale(2);
        system.debug('Total MiliScond'+p1);
        decimal jj= p1- p1.intvalue();
               Integer minn=Math.round(jj*60);
        if(minn==0){
            minn=1;
        }
               integer hrs =p1.intvalue();
           kk.Master_Total_TAT_QC_To_Verification_Hrs__c=hrs;
           kk.Master_Total_TAT_QC_To_Verification_Mn__c=minn;
         
       //Order Created To Order Verified    
       
           decimal ppp=BusinessHours.diff(orderBH.id,dd.CreatedDate,dd.SentToVerificationDate__c);
         system.debug('Total MiliScond'+ppp/3600000);
         
       
        decimal  Totaltime=(decimal)(ppp/3600000).setscale(2);
        system.debug('Total MiliScond111 '+Totaltime   +'Order Id'+dd.name);
        decimal jst= Totaltime- Totaltime.intvalue();
               Integer mnt=Math.round(jst*60);
        
        if(mnt==0){
            mnt=1;
        }
               integer hur =Totaltime.intvalue();   
        kk.Total_Time_Taken_To_Verify_Order_Hours__c=hur;
        kk.Total_Time_Taken_To_Verify_Order__c= mnt ;
                   
      //validation to verification
      decimal ps;
             if(cc.Re_Process_DateTime__c!=null && cc.Ready_For_Validation__c!=null){
        
       ps=BusinessHours.diff(orderBH.id,cc.Re_Process_DateTime__c,dd.SentToVerificationDate__c);
         
        }
        else if(cc.Re_Process_DateTime__c==null && cc.Ready_For_Validation__c!=null){
        ps=BusinessHours.diff(orderBH.id,cc.Ready_For_Validation__c ,dd.SentToVerificationDate__c);

        }
        else if(cc.Re_Process_DateTime__c==null && cc.Ready_For_Validation__c==null){
             ps=BusinessHours.diff(orderBH.id,cc.Quote_Finalize_Date_Time__c,dd.SentToVerificationDate__c);
        }
        
        
        
        decimal  RValidationToVerifi=(decimal)(ps/3600000).setscale(2);
            decimal js= RValidationToVerifi- RValidationToVerifi.intvalue();
               Integer min1=Math.round(js*60);
        if(min1==0){
            min1=1;
        }
               integer hour1 =RValidationToVerifi.intvalue();
         kk.Total_TAT_validation_To_verification_Hrs__c=hour1;
         kk.Total_TAT_validation_To_verification_Mn__c=min1;
         }
              od.add(kk); 
                   
           }// end Order loop
           
       }
   update od;
     update qt;  
   
   }

    global void finish(Database.BatchableContext BC){
    
    
    }
    
}