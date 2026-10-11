trigger Tax_Generation on apttus_proposal_proposal__c (before insert,before update,after update) {
Trigger__c t = Trigger__c.getValues('Quote');
//Pramodh to update opportunity stage
    if(t.active__c == true){
set<id> PRid = new set<id>();

    for(apttus_proposal_proposal__c cc:trigger.new){
        PRid.add(cc.PriceList__c);
       // system.debug('CCCCCCCCCC'+cc.CurrencyIsoCode);
    }
list<Product_PriceList__c> vs = new list<Product_PriceList__c>([select id,name,CurrencyIsoCode FROM Product_PriceList__c WHERE id=:PRid]);     

if(Trigger.isInsert && Trigger.Isbefore){
    set<id> oppid = new set<id>();
    for(apttus_proposal_proposal__c apt : Trigger.new){
        oppid.add(apt.Opportunity__c);
        
        //Added one line by Pankaj
        apttus_proposal_proposal__c ap= new apttus_proposal_proposal__c();
        ap.Re_Process_Stage__c='New';
        
    }
    List<Opportunity__c> lopp= new List<Opportunity__c>([select id,Stage__c,Probability__c from Opportunity__c where id = : oppid]);
    for(apttus_proposal_proposal__c apt : Trigger.new){
        
        
        
        for(Opportunity__c o : lopp){
            if(apt.Opportunity__c == o.id){
                //o.Stage__c = 'Proposal Sent'; -- Nag(Opp enhancement)
                //o.Probability__c = '25';-- Nag(Opp enhancement)
            }
        }
    }
    update lopp;
}
//Pramodh to update opportunity stage
    if(Trigger.isInsert && Trigger.Isbefore ||Trigger.isUPdate && Trigger.Isbefore){
map<string,Tax_Refference__c>taxdetails=new map<string,Tax_Refference__c>();
 
        if(test.isRunningTest() != true)
        for(Tax_Refference__c t:[select id,name,Client_Location__c,Selling_Country__c,TAx_Name__c,Tax_Rate__c from Tax_Refference__c]){ string a=t.Selling_Country__c+'-'+t.Client_Location__c; taxdetails.put(a,t); }
        for(apttus_proposal_proposal__c j:trigger.new)
        {
            j.Order_Type__c=j.APTS_Quote_Type__c;
            
            if(j.Posting_Country__c!=null&&j.Selling_Country__c!=null)
            {    
            
                if((j.Posting_Country__c==j.Selling_Country__c)&&j.Account_Entity_Use_Code__c==null)
                    {
                    
                    // get tax
                    string b=j.Selling_Country__c+'-'+j.Posting_Country__c;
                    Tax_Refference__c tt=taxdetails.get(b);
                    if(tt!=null)
                        {
                            j.Tax_Percentage__c=tt.Tax_Rate__c; j.Tax_Name__c=tt.TAx_Name__c;
                        }else
                        {
                            // if needed show error that tax not defined
                        }
                    
                    }
                    else
                    {
                    
                        j.Tax_Percentage__c=0; j.Tax_Name__c='NIL';
                    
                    }
            
            
            }
            
            //@imRam adding
          //PRid.add(j.PriceList__c);
        
        }
         for(apttus_proposal_proposal__c j:trigger.new){    
                 if(vs.size() >0)
            for(Product_PriceList__c v : vs){
            
          system.debug('insert CurrencyIsoCode -->'+v.CurrencyIsoCode);
              j.CurrencyIsoCode = v.CurrencyIsoCode; 
            }
        }
        //By Panakj For Sent Back
           String rtid=schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('Rejected').getRecordtypeid();

        for(apttus_proposal_proposal__c cc:trigger.new){
            if(cc.SentBack__c==true){
                
                apttus_proposal_proposal__c op= new apttus_proposal_proposal__c(); cc.id=cc.id; cc.RecordTypeId=rtid; cc.Re_Process_Stage__c='Rejected'; cc.Sent_Back_DateTime__c=system.now();
                //This class is gettig called to notify the owner and manager 
                ReProcessedQuote tt= new ReProcessedQuote(); tt.sendItToUSer(cc.id);
                
            }
            
            
        }
        
        
        
    }
   
        
   
        If(Trigger.isUpdate && Trigger.Isbefore){
            Id atf = Schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('after finalize').getRecordTypeId();

        system.debug('Update');
            Map<id,id> uid = new Map<id,id>();
            List<user> lou = new List<user>([select id,Managerid from user where id!='0057F000003Sa5g' AND isActive=true]);
            for(user u : lou){
            system.debug('user');
                uid.put(u.id,u.Managerid);
            }
            for(apttus_proposal_proposal__c j:trigger.new)
            {
                //ram logic for total discount exceeding
                system.debug('base amt-->'+j.Base_Total__c+'  Gross amt-->'+j.Gross_Total__c);
              decimal  totalDiscountAmount = j.Base_Total__c - j.Gross_Total__c;
                 system.debug('totalDiscountAmount-->'+totalDiscountAmount);
                
                decimal totalDiscount = 0;
                if(j.Base_Total__c==0){totalDiscount =0;} else{totalDiscount =(totalDiscountAmount / j.Base_Total__c)*100; }
                
                system.debug('totalDiscount-->'+totalDiscount);
                
                if(totalDiscount > 80 && j.Discount_Exception__c == false && j.GCS_Opportunity__c == false){
                    j.adderror('The maximum discount that can be applied to this qupte is 80% , Please contact your Super User to proceed further.');
                }
                
            system.debug('quote');
                if((j.GCS_Opportunity__c == FALSE)  && ( j.Approval_Status__c == 'No Need Of Approval' || j.Approval_Status__c == 'Required Approval' || j.Approval_Status__c == null || j.Approval_Status__c == ' ' || (j.Approval_Status__c == 'Rejected' && j.Total_Discount__c != Trigger.oldMap.get(j.Id).Total_Discount__c))){
                system.debug('pass'+j.Total_Discount__c );
                if(j.Total_Discount__c < 25)
                {j.Approval_Status__c='No Need Of Approval';j.Manager1__c = null;j.Manager2__c = null;j.Manager3__c = null;j.Manager4__c = null;j.Level_of_Approval__c =null;j.Manager5__c = null;j.Level_of_Approval__c =null;}
                if(j.Total_Discount__c > 25){j.Manager1__c = uid.get(j.Ownerid);j.Level_of_Approval__c =1;j.Approval_Status__c='Required Approval';j.Manager2__c = null;j.Manager3__c = null;j.Manager4__c = null;}
                if(j.Total_Discount__c > 35){j.Manager2__c = uid.get(j.Manager1__c );j.Level_of_Approval__c =2;j.Manager3__c = null;j.Manager4__c = null;}
                if(j.Total_Discount__c > 45){j.Manager3__c = uid.get(j.Manager2__c );j.Level_of_Approval__c =3;j.Manager4__c = null;}
                    if(j.Total_Discount__c>25 &&j.Total_Discount__c <60 ){
                        
                      if(j.Manager1__c=='0057F000003Sa5gQAC' ){  
                          j.Manager1__c=null;
                          j.Level_of_Approval__c =null;
                          j.Approval_Status__c='No Need Of Approval';
                          } 
                         if(j.Manager2__c=='0057F000003Sa5gQAC' ){ j.Manager2__c=null; j.Level_of_Approval__c =1; j.Approval_Status__c='Required Approval';
                          }   
                         if(j.Manager3__c=='0057F000003Sa5gQAC' ){ j.Manager3__c=null; j.Level_of_Approval__c =2; j.Approval_Status__c='Required Approval';
                          }   
                         if(j.Manager4__c=='0057F000003Sa5gQAC' ){  j.Manager4__c=null; j.Level_of_Approval__c =3;j.Approval_Status__c='Required Approval';
                          }   
                         if(j.Manager5__c=='0057F000003Sa5gQAC' ){  
                          j.Manager5__c=null;
                             j.Level_of_Approval__c =4;
                              j.Approval_Status__c='Required Approval';
                          }   
                    }
                if(j.Total_Discount__c > 60){j.Manager4__c = uid.get(j.Manager3__c );j.Level_of_Approval__c =4;}
                if(j.Total_Discount__c > 60)
                    //system.debug('User Manager'+);
                {if(j.Manager1__c == null  )
                {j.Manager1__c = '0057F000003Sa5g';//j.Level_of_Approval__c =1;
                 system.debug('Level 1');
                }
                 
                 else if(j.Manager2__c == null  && j.Manager1__c != '0057F000003Sa5g' && j.Manager1__c != null)
                 {j.Manager2__c = '0057F000003Sa5g';//j.Level_of_Approval__c =2;
                  system.debug('Level 2');
                 }
                 
                 else if(j.Manager3__c == null && j.Manager2__c != '0057F000003Sa5g' && j.Manager2__c != null)
                 {j.Manager3__c = '0057F000003Sa5g';//j.Level_of_Approval__c =3;
                  system.debug('Level 3');
                 }
                 
                 else if(j.Manager4__c == null && j.Manager3__c != '0057F000003Sa5g' && j.Manager3__c != null)
                 {j.Manager4__c = '0057F000003Sa5g';//j.Level_of_Approval__c =4;
                  system.debug('Level 4');
                 }
                 
                 else if(j.Manager5__c == null && j.Manager4__c != '0057F000003Sa5g' && j.Manager4__c != null)
                 {j.Manager5__c = '0057F000003Sa5g';//j.Level_of_Approval__c =5;
                 system.debug('Level 5');
                 }
                 
                 
                  
                 /*if(j.Manager5__c!=null || j.Manager5__c!=''){
                     j.Manager5__c='0057F000003Sa5gQAC';j.Level_of_Approval__c =5;j.Approval_Status__c='Required Approval';
                  }*/
                
    
                
                }
                    if(j.Manager1__c=='0057F000003Sa5gQAC' ){
                     j.Manager2__c=null;j.Manager3__c=null;j.Manager4__c=null;j.Manager5__c=null;//j.Level_of_Approval__c =1;j.Approval_Status__c='Required Approval';
                     
                 }
                 if(j.Manager2__c=='0057F000003Sa5gQAC' ){
                       
                     j.Manager3__c=null;j.Manager4__c=null;j.Manager5__c=null;//j.Level_of_Approval__c =2;j.Approval_Status__c='Required Approval'; 
                 }
                  if(j.Manager3__c=='0057F000003Sa5gQAC'){
                       j.Manager4__c=null; j.Manager5__c=null;//j.Level_of_Approval__c =3;j.Approval_Status__c='Required Approval';
                      
                 }
                  if(j.Manager4__c=='0057F000003Sa5gQAC' ){
                      j.Manager5__c=null;//j.Level_of_Approval__c =4;j.Approval_Status__c='Required Approval'; 
                 }
                    ////===========
    if(j.Manager1__c!=null ){j.Level_of_Approval__c =1;j.Approval_Status__c='Required Approval';
     system.debug('Here At Level One');                                           }
    if(j.Manager2__c!=null  ){j.Level_of_Approval__c =2;j.Approval_Status__c='Required Approval';
      system.debug('Here At Level One1');                                          }
    if(j.Manager3__c!=null ){j.Level_of_Approval__c =3;j.Approval_Status__c='Required Approval'; 
                                                system.debug('Here At Level One2');}
    if(j.Manager4__c!=null ){j.Level_of_Approval__c =4;j.Approval_Status__c='Required Approval';
                                                system.debug('Here At Level One3');
                                                system.debug('manager 4 '+j.Manager4__c);}
    if(j.Manager5__c!=null  ){j.Level_of_Approval__c =5;j.Approval_Status__c='Required Approval';
                                                 system.debug('Here At Level One4');
                                                 system.debug('manager 5 '+j.Manager5__c);}
                }
                
             //@imRam adding          
                 if(vs.size() >0)
            for(Product_PriceList__c v : vs){
          system.debug('insert CurrencyIsoCode -->'+v.CurrencyIsoCode);
              j.CurrencyIsoCode = v.CurrencyIsoCode; 
            }
                if(j.RecordTypeId==atf &&j.Quote_Finalize_Date_Time__c==null){
                    j.Quote_Finalize_Date_Time__c=system.now();
                }
            
            }
        }
//Pankaj   

    if(Trigger.Isupdate && Trigger.Isafter){
        
        
         System.debug('After Update');
        //set<id>PRid = new set<Id>();
        set<id>qp=new set<id>();
        set<id> managerUpdated =new set<id>();
        
            for(apttus_proposal_proposal__c cc:Trigger.new){
              //  PRid.add(cc.PriceList__c);
               qp.add(cc.id);
            
             //  @imRam commented for Approval Process   
             /*   apttus_proposal_proposal__c oldProposal = trigger.oldMap.get(cc.id);
                System.debug('Quote Old Values --->'+cc);
                System.debug('Quote New Values --->'+oldProposal);
                if(cc.Update_Manager1__c == true && oldProposal.Update_Manager1__c != cc.Update_Manager1__c){
                    System.debug('<---inside 1 manager --->');
                    managerUpdated.add(cc.id);
                }if(cc.Update_Manager2__c == true && oldProposal.Update_Manager2__c != cc.Update_Manager2__c){
                     System.debug('<---inside 2 manager --->');
                    managerUpdated.add(cc.id);
                }if(cc.Update_Manager3__c == true && oldProposal.Update_Manager3__c != cc.Update_Manager3__c){
                     System.debug('<---inside 3 manager --->');
                    managerUpdated.add(cc.id);
                }if(cc.Update_Manager4__c == true && oldProposal.Update_Manager4__c != cc.Update_Manager4__c){
                     System.debug('<---inside 4 manager --->');
                    managerUpdated.add(cc.id);
                }if(cc.Update_Manager5__c == true && oldProposal.Update_Manager5__c != cc.Update_Manager5__c){
                     System.debug('<---inside 5 manager --->');
                    managerUpdated.add(cc.id);
                }if(cc.Update_Manager6__c == true && oldProposal.Update_Manager6__c != cc.Update_Manager6__c){
                     System.debug('<---inside 6 manager --->');
                    managerUpdated.add(cc.id);
                } 
               
                */
            }
         
      /*   System.debug('managerUpdated'+managerUpdated.size());
         boolean bTest = quoteUpdateTriggerControl.inFutureContext;
         System.debug('bTest-->'+bTest);
         System.debug('before true-->'+quoteUpdateTriggerControl.inFutureContext);
         if(quoteUpdateTriggerControl.inFutureContext == false){
            if(managerUpdated.size() >0){
                quoteUpdateTriggerControl.inFutureContext = true;
                quoteApprovalRequest.sendQupteDetails(managerUpdated);
            }
         }

         System.debug('after true-->'+quoteUpdateTriggerControl.inFutureContext);
           */
        System.debug('QPPPPPPPPPPPPka Size'+qp.size());
        
         List<OrderC__c> od = new List<OrderC__c>();
         List<Order_Line_Item__c>oli= new  List<Order_Line_Item__c>();
          List<Proposal_Line_Item__c> pl= new list<Proposal_Line_Item__c>(); 
          List<APTS_APAC_Payment__c > py= new list<APTS_APAC_Payment__c >(); 
        //---------------------------
        List<apttus_proposal_proposal__c>app=[select id,CurrencyIsoCode,pricelist__r.CurrencyIsoCode,
                                              (select id,CurrencyIsoCode from APAC_Payments__r),
                                             (select id,CurrencyIsoCode from Quote_Line_Item__r),
                                              (select id,CurrencyIsoCode from Orders__r)
                                              from apttus_proposal_proposal__c where id=:qp];
        
        System.debug('APPPPPPPPPPka Size'+app.size());
        
        
        for(apttus_proposal_proposal__c pp:app){
           apttus_proposal_proposal__c  oldOpp = Trigger.oldMap.get(pp.id);
          System.debug(oldOpp.PriceList__c+'Quote Line Size'+pp.PriceList__c);

            if(pp.PriceList__c !=oldopp.PriceList__c ){
            for(Proposal_Line_Item__c kk:pp.Quote_Line_Item__r){
                        System.debug('Quote Line Size'+pp.Quote_Line_Item__r.size());

                Proposal_Line_Item__c zz= new Proposal_Line_Item__c(); zz.id=kk.id; zz.CurrencyIsoCode=pp.pricelist__r.CurrencyIsoCode; pl.add(zz);
            }
            
            for(APTS_APAC_Payment__c ap:pp.APAC_Payments__r){ APTS_APAC_Payment__c apt= new APTS_APAC_Payment__c(); apt.id=ap.id; apt.CurrencyIsoCode=pp.pricelist__r.CurrencyIsoCode; py.add(apt);
            }
                for(OrderC__c ll:pp.Orders__r){ OrderC__c od1 = new OrderC__c(); od1.id=ll.id; od1.CurrencyIsoCode=pp.pricelist__r.CurrencyIsoCode; od.add(od1);
            
           
            }
            } 
       
        }         
      
     
              List<Case__c> sbc= new List<Case__c>();
                  List<Case__c> ss= new List<Case__c>();
        IF(test.isRunningTest()!=true)          
        sbc=[select id,name,Sent_Back_Reason__c,Proposal_ID__c from case__c where Proposal_ID__c=:qp];
        
        for(Case__c tt:sbc){
            for(apttus_proposal_proposal__c dd:trigger.new){
                 Case__c sc = new Case__c();
                if(tt.Proposal_ID__c==dd.id){ sc.id=tt.id;
                    if(dd.SentBackReasonText__c!='' || dd.SentBackReasonText__c!=null){ String st=dd.SentBackReasonText__c; sc.Sent_Back_Reason__c=dd.Sent_Back_Reason__c+st;
                    }
                    else{sc.Sent_Back_Reason__c=dd.Sent_Back_Reason__c;
                    }
                    ss.add(sc);
                }
                
                
            }
            
        }
        
        
        
                         update py;
                         update od;
                         update pl;
                         update ss;
    }
}
    }