/*Created By : Abdul Aziz 27-Feb-2023*/
/*This trigger will calculate total time elapsed/consumed to close a case from Case Busineess Hours*/
/*Last Modifed by : Abdul Aziz , 27/07/2023 , Updated Total ReOpen Cout and Case Duration Days Count*/

trigger CaseBusinessHours on Case__c (before update) {
    
    Trigger__c t = Trigger__c.getValues('CaseBusinessHours');
    if(t.Active__c == true){
        
        if(trigger.isupdate && trigger.isbefore){
            for(Case__c caseObj : trigger.new ){
                /*Always update closed date if case is closed first time*/
                if(Trigger.oldMap.get(caseObj.Id).Status__c != caseObj.Status__c && caseObj.Status__c == 'Closed' && caseObj.ReOpened__c==false)
                {
                    caseObj.ClosedDateTime__c=System.now();
                    caseObj.Case_Closed_By__c = userinfo.getUserId();
                }
                /*Always update ReOpen date and checkbox ReOpened__c true if case is ReOpen*/
                if(Trigger.oldMap.get(caseObj.Id).Status__c != caseObj.Status__c && caseObj.Status__c == 'Reopen')
                {
                    caseObj.ReOpen_DateTime__c=System.now();
                    caseObj.ReOpened__c=true;
                    if(caseObj.Total_ReOpen_Count__c==null){caseObj.Total_ReOpen_Count__c=0;}
                    caseObj.Total_ReOpen_Count__c=caseObj.Total_ReOpen_Count__c+1;
                }
                /*Always update ReClosed time if case is closed more than one time*/
                if(Trigger.oldMap.get(caseObj.Id).Status__c != caseObj.Status__c && caseObj.Status__c == 'Closed' && caseObj.ReOpened__c==true)
                {
                    caseObj.ReClosed_DateTime__c=System.now();
                    caseObj.Reopen_Case_Closed_By__c = userinfo.getUserId();
                }
                
            }
        }
        
        //Selecting Seeker business hours (BH) record
        BusinessHours defaultBH = [SELECT Id,name FROM BusinessHours WHERE name = 'Case'];
        //Making sure BH record exists
        if(defaultBH != NULL){
            if(trigger.isupdate && trigger.isbefore){
                for(Case__c caseObj : trigger.new ){
                    /*Count Time When Case Is Closed First Time*/
                    if(caseObj.Status__c != NULL && Trigger.oldMap.get(caseObj.Id).Status__c != caseObj.Status__c && caseObj.Status__c == 'Closed' && caseObj.ReOpened__c==false){
                        //For BH method we assign (BH record id, start time field, end time field)
                        decimal result = BusinessHours.diff(defaultBH.Id, caseObj.CreatedDate, System.now() );
                        //Result from the method is divided by 60*60*100 (milliseconds to be then converted into hours)
                        Decimal resultingHours = result/(60*1000);
                        //Populating result into our custom field & setting number of decimals
                        //   caseObj.Elapsed_Time__c = resultingHours.setScale(1);
                        caseObj.Elapsed_Time__c = resultingHours;
                        caseObj.Last_Elapsed_Time_Minutes__c=resultingHours;
                    }  
                    /*Count Time When Case Is ReOpened then Closed Again*/
                    if(caseObj.Status__c != NULL && Trigger.oldMap.get(caseObj.Id).Status__c != caseObj.Status__c && caseObj.Status__c == 'Closed' && caseObj.ReOpened__c==true){
                        //For BH method we assign (BH record id, start time field, end time field)
                        decimal result = BusinessHours.diff(defaultBH.Id, caseObj.ReOpen_DateTime__c, System.now() );
                        //Result from the method is divided by 60*60*100 (milliseconds to be then converted into hours)
                        Decimal resultingHours = result/(60*1000);
                        //Populating result into our custom field & setting number of decimals
                        //   caseObj.Elapsed_Time__c = resultingHours.setScale(1);
                        if(caseObj.Elapsed_Time__c==null){caseObj.Elapsed_Time__c=0;}
                        caseObj.Elapsed_Time__c =caseObj.Elapsed_Time__c + resultingHours;
                        caseObj.Last_Elapsed_Time_Minutes__c=resultingHours;
                    }  
                    /*Update Total Case Duration Days From Created Date till the Case is closed(status==closed)*/
                    if(caseObj.Status__c != NULL && Trigger.oldMap.get(caseObj.Id).Status__c != caseObj.Status__c && caseObj.Status__c == 'Closed'){
                        Date createdDate = date.newinstance(caseObj.CreatedDate.year(), caseObj.CreatedDate.month(), caseObj.CreatedDate.day());
                        Integer dayscount = createdDate.daysBetween(System.today())+1;
                        // System.debug('dayscount is*****'+dayscount);
                        if(caseObj.Case_Duration_Days_Count__c==null){caseObj.Case_Duration_Days_Count__c=0;}
                        caseObj.Case_Duration_Days_Count__c=dayscount;
                    }
                }  
            }
        } 
    }
}