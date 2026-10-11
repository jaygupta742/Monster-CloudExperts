trigger Accountchangesemail on Account (after update) {

    Trigger__c t =  Trigger__c.getValues('Account'); 
    if(t.Active__c == true){
       list<messaging.SingleEmailMessage> trigmals = new list<messaging.SingleEmailMessage>();
    messaging.SingleEmailMessage activemail= new messaging.SingleEmailMessage();
        list<Client_Validation_Request__c> cvrlst = new list<Client_Validation_Request__c>();
     list<string> sendto = new list<string>();
        list<task> tsklst = new list<task>();
        task ta = new task();
        ta.Type = 'Email - Outbound';
     ta.Status = 'completed';
       ta.ActivityDate = system.today();
      profile profi = [select id from profile where name='Monster - Sales Ops/LM'];
        
        list<Account> akntlist = [select id,name,Lead_Account_Status__c,Location__c,AccountID__c,SalesChannel__c,Person_Account__c,Case_Accounts__c,Integration__c,BillingCountry,BillingCity,BillingState,BillingPostalCode,BillingStreet,ShippingCountry,ShippingState,ShippingCity,ShippingStreet,ShippingPostalCode,Trade_name__c,VATNumber__c,RegistrationNumber__c,ownerid,owner.email,owner.Manager_Email__c,GST_ID__c,Name_as_per_PAN__c,PAN__c,TAN__c,Phone,(select id,name,Stage__c,Status__c,Reference__c ,Account__c from Client_Validation_Requests__r where Account__r.id!= null) from Account where  id =: trigger.new AND Person_Account__c= false AND Case_Accounts__c= false AND Integration__c =false AND owner.email!= null ] ;  
       // to assign different from addresses based on the location perform a query on "OrgWideEmailAddress"
        list<OrgWideEmailAddress> orglst = [select id,Address from OrgWideEmailAddress];
        map<string,id> mporgwead = new map<string,id>();// key = string and value = id[orgwideemail should be always id]
        system.debug('orgggggggggggg'+mporgwead);
        // iterate the owea and add it to map to pass the key and get the value
        for(OrgWideEmailAddress ro : orglst){
           mporgwead.put(ro.Address,ro.id);
        }
           string midest =mporgwead.get('mesfrequest@monstergulf.com');
        system.debug('middleest'+midest);
      String phrsm =mporgwead.get('seasfrequest@monster.com.sg');
        system.debug('philipines'+phrsm);
        string imi = mporgwead.get('sfrequesttsacq@monsterindia.com');// till here for owea
        system.debug('india'+imi);
            string valfromadrs = mporgwead.get('kyc@monsterindia.com');
            system.debug('kycaddress'+valfromadrs);
        
        if(trigger.isupdate &&  profi.id==userinfo.getProfileId()){
        
   for(Account a : akntlist) //[select id,name,Lead_Account_Status__c,Location__c,AccountID__c,SalesChannel__c,Person_Account__c,Case_Accounts__c,Integration__c,BillingCountry,BillingCity,BillingState,BillingPostalCode,BillingStreet,ShippingCountry,ShippingState,ShippingCity,ShippingStreet,ShippingPostalCode,Trade_name__c,VATNumber__c,RegistrationNumber__c,ownerid,owner.email,owner.Manager_Email__c,GST_ID__c,Name_as_per_PAN__c,PAN__c,TAN__c,Phone,(select id,name,Stage__c,Status__c,Reference__c ,Account__c from Client_Validation_Requests__r where Account__r.id!= null) from Account where  id =: trigger.new AND Person_Account__c= false AND Case_Accounts__c= false AND Integration__c =false AND owner.email!= null ]/*)
        {
             Account oldacnt = new Account();
            oldacnt= trigger.oldmap.get(a.id);
            // location-1
            if(a.Location__c!= null && a.Location__c =='Middle East'){
                // Account Activate process
                if(oldacnt.Lead_Account_Status__c!=null && oldacnt.Lead_Account_Status__c!='Active'&& a.Lead_Account_Status__c =='Active')
                {
                    activemail.setOrgWideEmailAddressId(midest);
                    if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr '+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
                    system.debug('middleeast Active'+sendto);
              activemail.setSubject('Account Promotion Process '+a.AccountID__c);
             activemail.setHtmlBody('Your request for '+ a.AccountID__c +  ' promotion is processed Successfully');  
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                    // Account Name change Middle east
                } else if(oldacnt.Name !=null && oldacnt.Name != a.Name)
                {
                  activemail.setOrgWideEmailAddressId(midest);
                    if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
                     system.debug('middleeast name'+sendto);
               activemail.setSubject('Account Name Change Process '+a.AccountID__c);   
             activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' Name change/Update is processed Successfully'+'From  '+oldacnt.Name +'To  '+a.Name);
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                    // Address change process middle east
       } else if(oldacnt.BillingCountry != null && oldacnt.BillingCountry != a.BillingCountry ||oldacnt.BillingStreet !=null && oldacnt.BillingStreet != a.BillingStreet ||oldacnt.BillingCity!=null && oldacnt.BillingCity!=a.BillingCity ||oldacnt.BillingState !=null && oldacnt.BillingState != a.BillingState ||oldacnt.BillingPostalCode != null && oldacnt.BillingPostalCode != a.BillingPostalCode ||oldacnt.ShippingCountry != null && oldacnt.ShippingCountry != a.ShippingCountry || oldacnt.ShippingState != null && oldacnt.ShippingState != a.ShippingState || oldacnt.ShippingCity!= null && oldacnt.ShippingCity!=a.ShippingCity || oldacnt.ShippingStreet!=null && oldacnt.ShippingStreet!=a.ShippingStreet || oldacnt.ShippingPostalCode != null && oldacnt.ShippingPostalCode != a.ShippingPostalCode)  
       {
             activemail.setOrgWideEmailAddressId(midest);
               sendto.add(a.owner.email);
               if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
            system.debug('middleeast Address'+sendto);
               activemail.setHtmlBody('Your request for '+ a.AccountID__c+ ' Address change is processed Successfully changed');
             activemail.setSubject('Account Address Change Process '+a.AccountID__c);  
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                  // Trade Name change process
                }else if(oldacnt.Trade_name__c!=null && oldacnt.Trade_name__c!= a.Trade_name__c)
 {
     system.debug('middleeeeeee Acccccctradddd');
     activemail = new messaging.SingleEmailMessage();
    activemail.setOrgWideEmailAddressId(midest);
            sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
               activemail.setToAddresses (sendto) ;
      system.debug('middleeast Tradename'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' TradeName change/Update is processed Successfully');
             activemail.setSubject('Trade Name Change/Update Process for '+a.AccountID__c);     
            trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'TradeName change/Update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
     //vat change process email 
 }else if(oldacnt.VATNumber__c !=null &&  oldacnt.VATNumber__c != a.VATNumber__c)
 {
      system.debug('middleeeeeee Accccccvatttttt');
     activemail = new messaging.SingleEmailMessage();
    activemail.setOrgWideEmailAddressId(midest);
             sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                activemail.setToAddresses (sendto) ;
      system.debug('middleeast Vatname'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' VatID change/Update is processed Successfully');
             activemail.setSubject('VAt Change/Update Process '+a.AccountID__c);     
            trigmals.add(activemail);
     
     ta.Subject = 'Email: '+ a.SalesChannel__c +'VatID change/Update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
   // registration change process  
 }else if(oldacnt.RegistrationNumber__c !=null &&  oldacnt.RegistrationNumber__c != a.RegistrationNumber__c)
 {
 system.debug('middleeeeeee Accccccreggggg');
     activemail = new messaging.SingleEmailMessage();
    activemail.setOrgWideEmailAddressId(midest);
              sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                activemail.setToAddresses (sendto) ;
      system.debug('middleeast Regnum'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c +  'Registration change/update is processed Successfully');
             activemail.setSubject('Registration Change/Update Process  '+a.AccountID__c);     
            trigmals.add(activemail); 
     
     ta.Subject = 'Email:  '+ a.SalesChannel__c +' Registration change/update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
 }
    } // first if  
            // locatin -2
         else if(a.Location__c!= null && a.Location__c =='Philippines' ||a.Location__c =='Hong Kong' || a.Location__c =='Rest of SEA'||a.Location__c =='Singapore'||a.Location__c == 'Malaysia' )
         {
             system.debug('cominginsidephillipines');
                // Account Activate process
                if(oldacnt.Lead_Account_Status__c!=null && oldacnt.Lead_Account_Status__c!='Active'&& a.Lead_Account_Status__c =='Active')
                {
                     activemail.setOrgWideEmailAddressId(phrsm);
                    if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
                    system.debug('PHRSM Active'+sendto);
              activemail.setSubject('Account Promotion Process '+a.AccountID__c);
             activemail.setHtmlBody('Your request for '+ a.AccountID__c+ ' promotion is processed Successfully');  
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                    // Account Name change process
                } else if(oldacnt.Name !=null && oldacnt.Name != a.Name)
                {
                     activemail.setOrgWideEmailAddressId(phrsm);
                    if(a.owner.email!= null){ 
                       sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c!= null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                     
                    activemail.setToAddresses(sendto);
                    system.debug('PHRSM Name'+sendto);
               activemail.setSubject('Account Name Change Process '+a.AccountID__c);   
             activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' Name change/Update is processed Successfully'+'From '+oldacnt.Name +'To'+a.Name);
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                    // Address change process
       }else if(oldacnt.BillingCountry != null && oldacnt.BillingCountry != a.BillingCountry ||oldacnt.BillingStreet !=null && oldacnt.BillingStreet != a.BillingStreet ||oldacnt.BillingCity!=null && oldacnt.BillingCity!=a.BillingCity ||oldacnt.BillingState !=null && oldacnt.BillingState != a.BillingState ||oldacnt.BillingPostalCode != null && oldacnt.BillingPostalCode != a.BillingPostalCode ||oldacnt.ShippingCountry != null && oldacnt.ShippingCountry != a.ShippingCountry || oldacnt.ShippingState != null && oldacnt.ShippingState != a.ShippingState || oldacnt.ShippingCity!= null && oldacnt.ShippingCity!=a.ShippingCity || oldacnt.ShippingStreet!=null && oldacnt.ShippingStreet!=a.ShippingStreet || oldacnt.ShippingPostalCode != null && oldacnt.ShippingPostalCode != a.ShippingPostalCode)
          {
              activemail.setOrgWideEmailAddressId(phrsm);
                if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c!= null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
              
                    activemail.setToAddresses(sendto);
              system.debug('PHRSM Address'+sendto);
               activemail.setHtmlBody('Your request for '+ a.AccountID__c+ ' Address change is processed Successfully changed');
             activemail.setSubject('Account Address Change Process '+a.AccountID__c);  
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                     // trade name change process
                }else if(oldacnt.Trade_name__c!=null && oldacnt.Trade_name__c!= a.Trade_name__c)
 {
     activemail = new messaging.SingleEmailMessage();
     activemail.setOrgWideEmailAddressId(phrsm);
            sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c!= null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
               activemail.setToAddresses(sendto);
     system.debug('PHRSM Trade'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c +  ' TradeName change/Update is processed Successfully');
             activemail.setSubject('Trade Name Change/Update Process for '+a.AccountID__c);     
            trigmals.add(activemail);
     
     ta.Subject = 'Email: '+ a.SalesChannel__c +'TradeName change/Update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
     //vat change process email 
 }else if(oldacnt.VATNumber__c != a.VATNumber__c)
 {
      system.debug('middleeeeeee Accccccvatttttt');
     activemail = new messaging.SingleEmailMessage();
     activemail.setOrgWideEmailAddressId(phrsm);  
             sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c!= null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
               activemail.setToAddresses(sendto);
     system.debug('PHRSM vat'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c +  ' VatID change/Update is processed Successfully');
             activemail.setSubject('VAt Change/Update Process '+a.AccountID__c);     
            trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'VatID change/Update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
   // registration change process  
 }else if( oldacnt.RegistrationNumber__c != a.RegistrationNumber__c)
 { 
    activemail = new messaging.SingleEmailMessage();
     activemail.setOrgWideEmailAddressId(phrsm);
              sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                activemail.setToAddresses(sendto);
     system.debug('PHRSM REG'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c +  'Registration change/update is processed Successfully');
             activemail.setSubject('Registration Change/Update Process '+a.AccountID__c);     
            trigmals.add(activemail); 
     ta.Subject = 'Email:  '+ a.SalesChannel__c +'Registration change/update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
 }
    }  // second if location-3
            else if(a.Location__c!= null && a.Location__c =='India' || a.Location__c =='Multi-Location' || a.Location__c =='International'){
                // Account Activate process
                if(oldacnt.Lead_Account_Status__c!=null && oldacnt.Lead_Account_Status__c!='Active'&& a.Lead_Account_Status__c =='Active')
                {
                    activemail.setOrgWideEmailAddressId(imi);
                    if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
                    system.debug('IMI Active'+sendto);
              activemail.setSubject('Account Promotion Process '+a.AccountID__c);
             activemail.setHtmlBody('Your request for '+ a.AccountID__c+ ' promotion is processed Successfully');  
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                    // Account Name change india
                }else if(oldacnt.Name !=null && oldacnt.Name != a.Name)
                {
                    activemail.setOrgWideEmailAddressId(imi);
                    if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
                    system.debug('IMI Name'+sendto);
               activemail.setSubject('Account Name Change Process '+a.AccountID__c);   
             activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' Name change/Update is processed Successfully'+'From '+oldacnt.Name +'To'+a.Name);
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                    // Address change process india
       }else   if(oldacnt.BillingCountry != null && oldacnt.BillingCountry != a.BillingCountry ||oldacnt.BillingStreet !=null && 
                  oldacnt.BillingStreet != a.BillingStreet ||oldacnt.BillingCity!=null && oldacnt.BillingCity!=a.BillingCity 
                  ||oldacnt.BillingState !=null && oldacnt.BillingState != a.BillingState ||oldacnt.BillingPostalCode != null && oldacnt.BillingPostalCode != a.BillingPostalCode 
                  ||oldacnt.ShippingCountry != null && oldacnt.ShippingCountry != a.ShippingCountry || oldacnt.ShippingState != null && oldacnt.ShippingState != a.ShippingState || 
                  oldacnt.ShippingCity!= null && oldacnt.ShippingCity!=a.ShippingCity || oldacnt.ShippingStreet!=null && oldacnt.ShippingStreet!=a.ShippingStreet || oldacnt.ShippingPostalCode != null && oldacnt.ShippingPostalCode != a.ShippingPostalCode)  
       {
             activemail.setOrgWideEmailAddressId(imi);
               sendto.add(a.owner.email);
               if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                    activemail.setToAddresses(sendto);
           system.debug('IMI Address'+sendto);
               activemail.setHtmlBody('Your request for '+ a.AccountID__c+ ' Address change is processed Successfully changed');
             activemail.setSubject('Account Address Change Process '+a.AccountID__c);  
                    trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'Account Promotion Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
                  // Trade Name change process india
                }else if(oldacnt.Trade_name__c!=null && oldacnt.Trade_name__c!= a.Trade_name__c)
 {
     system.debug('middleeeeeee Acccccctradddd');
     activemail = new messaging.SingleEmailMessage();
    activemail.setOrgWideEmailAddressId(imi);
            sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
               activemail.setToAddresses (sendto) ;
     system.debug('IMI Trade'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' TradeName change/Update is processed Successfully');
             activemail.setSubject('Trade Name Change/Update Process for '+a.AccountID__c);     
            trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'TradeName change/Update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
     //vat change process email 
 }else if(oldacnt.VATNumber__c !=null &&  oldacnt.VATNumber__c != a.VATNumber__c)
 {
      system.debug('middleeeeeee Accccccvatttttt');
     activemail = new messaging.SingleEmailMessage();
    activemail.setOrgWideEmailAddressId(imi);
             sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                activemail.setToAddresses (sendto) ;
     system.debug('IMI VAT'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c + ' VatID change/Update is processed Successfully');
             activemail.setSubject('VAt Change/Update Process '+a.AccountID__c);     
            trigmals.add(activemail);
     ta.Subject = 'Email: '+ a.SalesChannel__c +'VatID change/Update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
   // registration change process  
 }else if(oldacnt.RegistrationNumber__c !=null &&  oldacnt.RegistrationNumber__c != a.RegistrationNumber__c)
 {
 system.debug('middleeeeeee Accccccreggggg');
     activemail = new messaging.SingleEmailMessage();
    activemail.setOrgWideEmailAddressId(imi);
              sendto = new list<string>();
              if(a.owner.email!= null){ 
                        sendto.add(a.owner.email);
                         system.debug('ownermail'+a.owner.email);
                    }
                   if(a.owner.Manager_Email__c != null){ 
                        sendto.add(a.owner.Manager_Email__c);
                         system.debug('ownermngerrrrr'+a.owner.Manager_Email__c);
                    }
                activemail.setToAddresses (sendto);
     system.debug('IMI REG'+sendto);
            activemail.setHtmlBody('Your request for '+ a.AccountID__c +  'Registration change/update is processed Successfully');
             activemail.setSubject('Registration Change/Update Process  '+a.AccountID__c);     
            trigmals.add(activemail); 
     ta.Subject = 'Email:  '+ a.SalesChannel__c +' Registration change/update Process '+a.AccountID__c;
     ta.Assigned_To_C__c = a.ownerid;
     ta.WhatId = a.id;
     tsklst.add(ta);
 }
            }
             
        } // for
            system.debug('comingoutofforrrrrrr');
            
               } // trig is update
        
        // update cvr to unvalidated
      /*  for(Account cvraknt : akntlist){
            Account coldacnt = new Account();
            coldacnt= trigger.oldmap.get(cvraknt.id);
            
            if(cvraknt.Client_Validation_Requests__r.size()>0 && coldacnt.Name != null  && coldacnt.Name != cvraknt.Name || coldacnt.GST_ID__c != null && cvraknt.GST_ID__c != coldacnt.GST_ID__c || coldacnt.PAN__c!= null && coldacnt.PAN__c !=cvraknt.PAN__c || coldacnt.RegistrationNumber__c!= null && coldacnt.RegistrationNumber__c!= cvraknt.RegistrationNumber__c || coldacnt.Name_as_per_PAN__c!= null && coldacnt.Name_as_per_PAN__c!= cvraknt.Name_as_per_PAN__c || coldacnt.TAN__c!= null && coldacnt.TAN__c!= cvraknt.TAN__c|| coldacnt.Phone!=null && coldacnt.Phone!= cvraknt.Phone || coldacnt.BillingCountry != null && coldacnt.BillingCountry != cvraknt.BillingCountry ||coldacnt.BillingStreet !=null && coldacnt.BillingStreet != cvraknt.BillingStreet ||coldacnt.BillingCity!=null && coldacnt.BillingCity!=cvraknt.BillingCity ||coldacnt.BillingState !=null && coldacnt.BillingState != cvraknt.BillingState ||coldacnt.BillingPostalCode != null && coldacnt.BillingPostalCode != cvraknt.BillingPostalCode ||coldacnt.ShippingCountry != null && coldacnt.ShippingCountry != cvraknt.ShippingCountry || coldacnt.ShippingState != null && coldacnt.ShippingState != cvraknt.ShippingState || coldacnt.ShippingCity!= null && coldacnt.ShippingCity!=cvraknt.ShippingCity || coldacnt.ShippingStreet!=null && coldacnt.ShippingStreet!=cvraknt.ShippingStreet || coldacnt.ShippingPostalCode != null && coldacnt.ShippingPostalCode != cvraknt.ShippingPostalCode)
            {
                for(Client_Validation_Request__c avr :cvraknt.Client_Validation_Requests__r){
                    avr.Reference__c = 'Unvalidated';
                    cvrlst.add(avr);
                     activemail = new messaging.SingleEmailMessage();
                    
                     sendto = new list<string>();
                    sendto.add('kyc@monsterindia.com');
                    sendto.add('naveen.teegulla@monsterindia.com');
                     //sendto.add('rjprashanth.rp@gmail.com');
                            
                        
                    activemail.setOrgWideEmailAddressId(valfromadrs);
                    activemail.setSubject('Changes Made in Account level After Creating KYC');
                    activemail.setToAddresses (sendto);
                    activemail.setHtmlBody('Dear Sir/Madam please find the information of an Account updated after creating KYC');
                     trigmals.add(activemail);
                }
            }
                
        }*/
        
        messaging.sendEmail(trigmals);
       // insert tsklst;
       // update cvrlst;
    } // trig isactive to true
}