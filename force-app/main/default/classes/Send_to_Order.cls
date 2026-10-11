global class Send_to_Order 
{
    @AuraEnabled
    webservice static string myMethod(string ids) 
    {    
        apttus_proposal_proposal__c ap= [SELECT Id, Name,ownerid, QuoteStatus__c,Start_Date__c,End_Date__c, APTS_Billing_Contact_Email_Address__c, APTS_Quote_Type__c, BillContact__c, Order_Type__c, Payment1_Term__c, Payment_Method1__c, PostingContact__c, Selling_Country__c, Special_Terms__c, PriceList__c, Opportunity__c,Opportunity__r.Actual_Revenue__c, Base_Total__c, Gross_Total__c, Total_Discount_Amount__c, Total_Discount__c, /*Billing_Address__c, Posting_Address__c,*/ Posting_Country__c, Account__c, Tax_Percentage__c, Tax_Name__c, Tax_Amount__c, Net_Total__c, Primary_Contact__c, Billing_Street__c, Billing_City__c, Billing_Country__c, Billing_Pin_code__c, Billing_State__c, Posting_Street__c, Posting_City__c, Posting_State__c, Posting_Pin_Code__c, TDS_Amount__c, Payment_Amount__c, Payment_Net_Total__c FROM apttus_proposal_proposal__c WHERE Id =:ids];       
        list<Proposal_Line_Item__c > gg =[SELECT Id,APTS_Attribute_Display__c,Product__r.name, Name, APTS_Extended_List_Price__c, APTTS_Tax_Amount__c, APTTS_Tax_Rate__c, Proposal_Locked__c, StateProvinceTaxRate__c, TotalStateProvinceTaxAmount__c, Product__c, Quantity__c, Adjustment_Amount__c, Adjustment_Type__c, End_Date__c, Price__c, Start_Date__c, Discount_Amount__c, Price_After_Discount__c, Gross_Total__c, Total_Discount__c, Base_Total__c FROM Proposal_Line_Item__c WHERE Proposal_Locked__c=:ids];
        
        OrderC__c sobj = new OrderC__c();
        sobj.QuoteProposal__c=ids;
        sobj.APTS_Billing_Contact_Email_Address__c=ap.APTS_Billing_Contact_Email_Address__c;
        sobj.APTS_Quote_Type__c=ap.APTS_Quote_Type__c;
        sobj.BillContact__c=ap.BillContact__c;
        sobj.ContractStartDate__c = ap.Start_Date__c;
        sobj.Contract_End_Date__c = ap.End_Date__c;
        //sobj.Time_To_Fire_Flow__c=ap.End_Date__c+1;
        sobj.Order_Type__c=ap.Order_Type__c;
        sobj.Payment1_Term__c=ap.Payment1_Term__c;
        sobj.Payment_Method1__c=ap.Payment_Method1__c;
        sobj.Posting_Contact__c=ap.PostingContact__c;
        sobj.QuoteStatus__c=ap.QuoteStatus__c;
        sobj.Selling_Country__c=ap.Selling_Country__c;
        sobj.Special_Terms__c=ap.Special_Terms__c;
        sobj.PriceList__c=ap.PriceList__c;
        sobj.Opportunity__c=ap.Opportunity__c;
        //sobj.Billing_Address__c=ap.Billing_Address__c;
        // sobj.Posting_Address__c=ap.Posting_Address__c; 
        sobj.Account__c=ap.Account__c;
        sobj.Tax_Percentage__c=ap.Tax_Percentage__c;
        sobj.Tax_Name__c=ap.Tax_Name__c;
        sobj.Primary_Contact__c=ap.Primary_Contact__c;
        sobj.TDS_Amount__c=ap.TDS_Amount__c;
        sobj.Payment_Amount__c=ap.Payment_Amount__c;
        sobj.PrimarySalesRep__c=ap.ownerid;
        sobj.OwnerId=ap.ownerid;
        insert sobj;
                        
        LIst<Proposal_Line_Item__c> st= new List<Proposal_Line_Item__c>();
        list<Order_Line_Item__c > sssy=new list<Order_Line_Item__c>();
        
        for(Proposal_Line_Item__c hhh:gg)
        {
            Order_Line_Item__c sobj1 = new Order_Line_Item__c(
                Order__c = sobj.id,
                Product__c=hhh.Product__c,
                Quantity__c=hhh.Quantity__c,
                Adjustment_Amount__c=hhh.Adjustment_Amount__c,
                Adjustment_Type__c=hhh.Adjustment_Type__c,
                End_Date__c=hhh.End_Date__c,
                Price__c=hhh.Price__c,
                Start_Date__c=hhh.Start_Date__c,
                APTS_Attribute_Display__c=hhh.APTS_Attribute_Display__c  
            );
            //sssy.add(sobj1);
            
            Proposal_Line_Item__c ss= new Proposal_Line_Item__c();
            ss.id=hhh.id;
            ss.Product_Name_With_Attribute__c=hhh.Product__r.name+hhh.APTS_Attribute_Display__c;
            st.add(ss);
            
            //Start Missing==================================================================
            string finalCountry;
            String CountryFinalName;
            String ProdCountryFinalName;
            if(hhh.APTS_Attribute_Display__c!=null){
                String prdDesc=hhh.APTS_Attribute_Display__c;
                if(prdDesc.startsWith('Country')){
                    integer istSemiColon=prdDesc.indexOf(';');
                    String countryname=prdDesc.substring(0, istSemiColon+1);
                    integer finalCountryNameStart=countryname.indexOf('=');
                    Integer indOfColon=countryname.indexOf(';');
                    finalCountry= countryname.substring(finalCountryNameStart+1, indOfColon) ;
                    System.debug('1st if------finalCountry>'+finalCountry);
                }
                
                if(prdDesc.containsIgnoreCase(';Country')){
                    Integer indexOfCountry=prdDesc.indexOf(';Country'); 
                    string subprdDescr=prdDesc.substring(indexOfCountry+1);
                    integer indexColonSub=subprdDescr.indexOf(';');
                    String FinalCountryName=subprdDescr.subString(0,indexColonSub);
                    Integer subIndex=FinalCountryName.indexOf('=');
                    CountryFinalName=FinalCountryName.subString(subIndex+1,FinalCountryName.length());
                    System.debug('2nd if------CountryFinalName>'+CountryFinalName);
                }
                if(prdDesc.containsIgnoreCase(';Product Country')){
                    Integer indexOfCountry=prdDesc.indexOf(';Product Country'); 
                    string subprdDescr=prdDesc.substring(indexOfCountry+1);
                    integer indexColonSub=subprdDescr.indexOf(';');
                    String FinalCountryName=subprdDescr.subString(0,indexColonSub);
                    Integer subIndex=FinalCountryName.indexOf('=');
                    ProdCountryFinalName=FinalCountryName.subString(subIndex+1,FinalCountryName.length());
                    System.debug('3rd if------ProdCountryFinalName>'+ProdCountryFinalName);
                }      
                if(prdDesc.containsIgnoreCase('Product Country')){
                    Integer indexOfCountry=prdDesc.indexOf('Product Country'); 
                    string subprdDescr=prdDesc.substring(indexOfCountry+1);
                    integer indexColonSub=subprdDescr.indexOf(';');
                    String FinalCountryName=subprdDescr.subString(0,indexColonSub);
                    Integer subIndex=FinalCountryName.indexOf('=');
                    ProdCountryFinalName=FinalCountryName.subString(subIndex+1,FinalCountryName.length());
                    System.debug('4th if------ProdCountryFinalName>'+ProdCountryFinalName);
                }  
                //Nag
                if(prdDesc.startsWith('Selling Country') && (!(prdDesc.containsIgnoreCase('Product Country')))){
                    Integer indexOfCountry=prdDesc.indexOf('Selling Country'); 
                    string subprdDescr=prdDesc.substring(indexOfCountry+1);
                    integer indexColonSub=subprdDescr.indexOf(';');
                    String FinalCountryName=subprdDescr.subString(0,indexColonSub);
                    Integer subIndex=FinalCountryName.indexOf('=');
                    ProdCountryFinalName=FinalCountryName.subString(subIndex+1,FinalCountryName.length());
                    System.debug('subprdDescr'+subprdDescr);
                    System.debug('FinalCountryName'+FinalCountryName);
                    System.debug('5th if------ProdCountryFinalName>'+ProdCountryFinalName);
                }
                //Nag   
            } 
            System.debug('finalc'+finalCountry);
            if(finalCountry!=null){
                sobj1.Product_Country__c=finalCountry;
                sobj1.Country__c=finalCountry;
            }
            
            if(CountryFinalName!=null){
                sobj1.Product_Country__c=CountryFinalName; 
                sobj1.Country__c=CountryFinalName;
            } 
            if(ProdCountryFinalName!=null){
                sobj1.Product_Country__c=ProdCountryFinalName; 
                sobj1.Country__c=ProdCountryFinalName;
            } 
            //End here the missing 
            
            
            if(sobj1.Product_Country__c == 'India'||sobj1.Product_Country__c == 'Gulf'||sobj1.Product_Country__c == 'Singapore'||sobj1.Product_Country__c == 'Monster Gulf'||sobj1.Product_Country__c == 'Middle East and Africa'||sobj1.Product_Country__c == 'United Arab Emirates'||sobj1.Product_Country__c == 'Middle East and Africa'||sobj1.Product_Country__c == 'Malaysia'||sobj1.Product_Country__c == 'Philippines'||sobj1.Product_Country__c == 'Hong Kong'||sobj1.Product_Country__c == 'South East Asia'||sobj1.Product_Country__c == 'Greater China'||sobj1.Product_Country__c ==' Asia Pacific'||sobj1.Product_Country__c ==' Asia Pacific-Excluding Gr China'||sobj1.Product_Country__c == 'Asia Pacific-Excluding India'||sobj1.Product_Country__c ==' Asia Pacific-Including Gr China'||sobj1.Product_Country__c =='Asia-Pacific'){
                sobj1.Country_Value__c = 'Quess Country';
            }
            else
                sobj1.Country_Value__c = 'Other Country';            
            	sssy.add(sobj1);
        }
        apttus_proposal_proposal__c cc= new apttus_proposal_proposal__c();
        cc.id=ap.id;
        cc.Order_Created_Date__c=system.today();
        cc.Order_Created_Date_N_Time__c=system.now();
        cc.Re_Process_Stage__c='Order Created';
        insert sssy;
        
        update cc;
        update st;
               
        updateAcRe(sobj.id);
        return sobj.id;        
    }
    
    @AuraEnabled
    Public Static decimal getOrderCount(id quoteId){
        List<OrderC__c> orders = [SELECT id,name FROM OrderC__c WHERE QuoteProposal__c = :quoteId];
        return orders.size();
    }
    
    @AuraEnabled
    Public Static id getprofileId(){
        System.debug(userinfo.getProfileId());
        return userinfo.getProfileId();
    }   
    
    @future
    public static void updateAcRe(String ids){
        Orderc__c cc=[select id,Opportunity__c,QuoteProposal__r.Quote_Finalize_Date_Time__c,QuoteProposal__r.Re_Process_DateTime__c,QuoteProposal__r.Ready_For_Validation__c    ,Contract_End_Date__c,Opportunity__r.Actual_Revenue__c,Account__c,Net_total__c from Orderc__C where id=:ids ];
        double dd=cc.Opportunity__r.Actual_Revenue__c;
        double dd1=0;
        if(dd!=null&&cc.Net_total__c!=null){
            dd1=dd+cc.Net_total__c  ;
        }
        if(dd==null){
            dd1=cc.Net_total__c  ; 
        }
        Double jj=0;
        if(dd1==null){
            jj=0;
        }
        if(dd1!=null){
            jj=dd1;
        }
        
        date lastestProductEndDate;
        date resumeProductEndDate;
        date jobProductEndDate;
        
        List<Order_Line_Item__c> gg=[select id,name,end_Date__C,Product__r.name from Order_Line_Item__c where Order__c=:ids];  
        for(Order_Line_Item__c h:gg)
        {  
            if(lastestProductEndDate==null){
                lastestProductEndDate=h.end_Date__c;
            }
            if(h.End_Date__c>lastestProductEndDate &&lastestProductEndDate!=null){
                lastestProductEndDate=h.End_Date__c;
            }
            
            string pname=(h.Product__r.name).trim();
            
            if(pname.containsIgnoreCase('Job') && jobProductEndDate==null ){
                jobProductEndDate=h.End_Date__c;
            }
            if(pname.containsIgnoreCase('Job') && jobProductEndDate!=null ){
                if(h.End_Date__c>jobProductEndDate){
                    jobProductEndDate=h.End_Date__c;
                }
            }
            
            if(pname.containsIgnoreCase('resume') && resumeProductEndDate==null){
                resumeProductEndDate=h.End_Date__c;
            }
            if(pname.containsIgnoreCase('resume') && resumeProductEndDate!=null){
                if(h.End_Date__c>resumeProductEndDate){
                    resumeProductEndDate=h.End_Date__c;
                }
            }   
        }
        
        if(cc.Net_Total__c>0){
            Opportunity__c updateopp = new Opportunity__c();
            updateopp.id = cc.Opportunity__c;
            updateopp.Probability__c = '100'; //-- Nag(Opp enhancement)
            updateopp.Stage__c = 'Closed Won';
            updateopp.Close_Date__c = system.today();
            updateopp.Actual_Revenue__c=jj;
            update updateopp;
            system.debug('DDDDDD Here Else1'); 
        }
        else if(cc.Net_Total__c<1){
            Opportunity__c updateopp = new Opportunity__c();
            updateopp.id = cc.Opportunity__c;
            updateopp.Probability__c = '0';
            updateopp.Stage__c = 'Closed Won';
            updateopp.Close_Date__c = system.today();
            updateopp.Actual_Revenue__c=jj;
            update updateopp;
            system.debug('DDDDDD Here Else');
        }
        Account ppj= new Account();
        ppj.id=cc.Account__c;
        if(cc.Net_total__c>1){            
            ppj.AccountStatus__c='Customer';           
        } 
        //lastestProductEndDate
        // String stt=Datetime.valueOf(lastestProductEndDate).format().removeEnd('5:30 AM');
        //stt=stt+' 00:00:00 AM';
        //datetime val=datetime.valueOf(stt);
        //datetime val1=datetime.newInstance(datetime.year(date.valueOf(val), datetime.month(val), datetime.day(val), datetime.hour(val), datetime.minute(val), datetime.second(val));
        // system.debug('my Time'+stt);
        
        //ppj.Latest_Product_End_Date__c=lastestProductEndDate;
        ppj.ResumeExpires__c=resumeProductEndDate;
        ppj.JobPostzExpires__c=jobProductEndDate;
        update ppj;
        
        
        
        // Turn Around time from Ready To validation/ Reprocessed Date to Order Created Date
        BusinessHours bh = [SELECT id FROM BusinessHours WHERE IsActive = True AND Name = 'Quote To Order Tracker'];
        system.debug('Total MiliScond'+cc.QuoteProposal__r.Ready_For_Validation__c  );
        decimal pp=0.0;
        if(cc.QuoteProposal__r.Re_Process_DateTime__c!=null && cc.QuoteProposal__r.Ready_For_Validation__c!=null){            
            pp=BusinessHours.diff(bh.id,cc.QuoteProposal__r.Re_Process_DateTime__c,system.now());           
        }
        else if(cc.QuoteProposal__r.Re_Process_DateTime__c==null && cc.QuoteProposal__r.Ready_For_Validation__c!=null){
            pp=BusinessHours.diff(bh.id,cc.QuoteProposal__r.Ready_For_Validation__c ,system.now());            
        }
        else if(cc.QuoteProposal__r.Re_Process_DateTime__c==null && cc.QuoteProposal__r.Ready_For_Validation__c==null){
            pp=BusinessHours.diff(bh.id,cc.QuoteProposal__r.Quote_Finalize_Date_Time__c,system.now());
        }
        
        decimal  p=(decimal)(pp/3600000).setscale(2);
        decimal j= p- p.intvalue();
        Integer min=Math.round(j*60);
        if(min==0){
            min=1;
        }
        integer hour =p.intvalue();
                
        cc.id=cc.id;
        cc.Total_Time_Taken_To_Create_Order_Hour__c=hour;
        cc.Time_Taken_To_Create_Order_Min__c=min ;
        update cc;
        
        LIst<OrderC__c> pa= new List<OrderC__c>();
        // pp=[select id,name,Flow_Id_To_Lapsed_Account__c from Orderc__c where Account__c=cc.Account__c And cc.Contract_End_Date__c>System.today() And ];
        /* if(cc.Net_Total__c>1 && cc.Contract_End_Date__c>System.today()){
		Map<String, Object> mp= new  Map<String,Object>();
		mp.put('OrderId',cc.id);
		flow.Interview fp= new flow.Interview.Call_Account_Updator_Class(mp);
		fp.start();
		//system.debug('Flow Id'+fp.getVariableValue('InterviewIdOfFlow'));
}
*/
    }
    
    //this method used to call the flow which updating the account status based on order service date and its net total
    @future
    public Static void CallFlowAccpuntStatusUpdate(String ids){        
        OrderC__c   cc=[select id,name,Account__c,Order_Service_End_Date__c,Net_Total__c from OrderC__c where id=:ids];        
        if(cc.Net_Total__c>1 && cc.Order_Service_End_Date__c>System.today()){
            Map<String, Object> mp= new  Map<String,Object>();
            mp.put('OrderId',cc.id);            
            flow.Interview fp= new flow.Interview.Call_Account_Updator_Class(mp);
            fp.start();                        
        }        
    }
}