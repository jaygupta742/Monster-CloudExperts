//@imRAM modified on 24/7/18. Added emailmessage
global class AccountPromotionRequest {
    
    webservice static void sendmail(id ii){
  String semail;
        
        List<String> useremalist = new List<String>();
        
                account a = [select id,Name,SalesChannel__c,Location__c,Ownerid,Primary_Sales_Rep__c,Comments__c FROM account WHERE id = :ii];
     //  map<id , string> mu =  new  map<id , string>();
        User u = [SELECT id,CompanyName,Email ,Phone,Manager.email,MobilePhone, FirstName, LastName,Location__c,Job_Type__c FROM user where id = :a.OwnerId];
     useremalist.add(u.Email);
        if(u.Manager.email != NULL)
          useremalist.add(u.Manager.email);  
            
        string urlid =URL.getSalesforceBaseUrl().getHost();
       
       system.debug('urlll'+urlid);
        system.debug('SalesChannel & Location'+a.SalesChannel__c + ' '+a.Location__c);
        
        if(a.SalesChannel__c == 'Enterprise Business' && a.Location__c == 'India'){
            system.debug('Fieldsales & Enterprise Business India');
        semail =  'SFrequestfieldsales@monsterindia.com'; //'seetaramatest@gmail.com'; 
        }else
            if(a.SalesChannel__c == 'SMB Business' && a.Location__c == 'India'){
                  system.debug('Fieldsales & SMB Business India');
                semail = 'SFrequestfieldsales@monsterindia.com';  //'support@cloudexpertsindia.com';
            }else
                if(a.SalesChannel__c == 'Media Works' && a.Location__c == 'India'){
                system.debug('Fieldsales & Media Works India');
                    semail = 'SFrequestfieldsales@monsterindia.com';  //'crm@cloudexpertsindia.com';
            }else
                if(a.SalesChannel__c == 'International' && a.Location__c == 'International'){
                system.debug('Fieldsales & International');
                    semail = 'SFrequestfieldsales@monsterindia.com'; //cloudacademyin@gmail.com;
            } else
                if(a.SalesChannel__c == 'Revenue.in' && a.Location__c == 'International'){
                system.debug('Fieldsales & Revenue.in International');
                    semail = 'SFrequestfieldsales@monsterindia.com'; // 'seetaramatest@gmail.com';
            }else
                if(a.SalesChannel__c == 'Telesales-India' && a.Location__c == 'India'){
                system.debug('Telesales & India');
                    semail = 'SFrequesttsacq@monsterindia.com'; // 'MOME@Monster.com;';
            } else
                if(a.SalesChannel__c == 'Fieldsales.me' && a.Location__c == 'Middle East'){
                system.debug('Fieldsales & Middle East');
                    semail = 'MESFrequest@monstergulf.com'; //MOSEA@Monster.com;
            } else
                if(a.SalesChannel__c == 'Telesales-ME' && a.Location__c == 'Middle East'){
                system.debug('Telesales & Middle East');
                   semail = 'MESFrequest@monstergulf.com'; //MOSEA@Monster.com;    
            } else
                if(a.SalesChannel__c == 'Fieldsales.sg' && a.Location__c == 'Singapore'){
                system.debug('Fieldsales & Singapore');
                    semail = 'SEASFrequest@monster.com.sg'; //MOSEA@Monster.com;  
            } else
                if(a.SalesChannel__c == 'Fieldsales.my' && a.Location__c == 'Malaysia'){
                system.debug('Fieldsales & Malaysia');
                    semail = 'SEASFrequest@monster.com.sg'; //MOSEA@Monster.com;
            } else
                if(a.SalesChannel__c == 'Fieldsales.ph' && a.Location__c == 'Philippines'){
                system.debug('Fieldsales & Philippines');
                    semail = 'SEASFrequest@monster.com.sg'; //MOSEA@Monster.com;
            } else
                if(a.SalesChannel__c == 'Fieldsales.hk' && a.Location__c == 'Hong Kong'){
                system.debug('Fieldsales & Hong Kong');
                    semail = 'SEASFrequest@monster.com.sg'; //MOSEA@Monster.com;                    
            } else
                if((a.SalesChannel__c == 'Telesales-SEA') && (a.Location__c == 'Singapore' || a.Location__c == 'Malaysia' || a.Location__c == 'Philippines' || a.Location__c == 'Hong Kong' || a.Location__c == 'Rest of SEA')){
                system.debug('Telesales & SEA');
                    semail = 'SEASFrequest@monster.com.sg'; //MOSEA@Monster.com;                      
            }else{
            semail = 'Chintala.Swapna@monsterindia.com'; // ' seetaramatest@gmail.com';
            }
                
             system.debug('mail to -----------> '+semail);   
        string sub =  a.SalesChannel__c+' Promote Pending Lead - '+a.Name;
        
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       // mail.setToAddresses(New String[]{'Chintala.Swapna@monsterindia.com'}); //seetaramatest@gmail.com
        mail.setToAddresses(New String[]{semail});
        mail.setCcAddresses(useremalist);
      /*  mail.setSaveAsActivity(TRUE);
        mail.setTargetObjectId(u.id);*/
       // mail.setSenderDisplayName('Salesforce Team');
        mail.setSubject(sub);
       // mail.setPlainTextBody('this is test Email Case  ');
        mail.setHtmlBody(
            
'India Telesales ACQ Users  - MO-IN-SF Request TS ACQ (SFrequesttsacq@monsterindia.com)  <br/><br/>'+
'India Telesales RET Users  - MO-IN-SF Request Retention (SFrequestretenstion@monsterindia.com)<br/>'+
'India Fieldsales Users  - MO-IN-SF Request Fieldsales (SFrequestfieldsales@monsterindia.com)<br/>'+
'Gulf Users  - MO-ME SF Request (MESFrequest@monstergulf.com)<br/>'+
'SEA Users - MO-SEA SF Request (SEASFrequest@monster.com.sg)<br/><br/><br/>'+

'Subject: Promote Pending Lead :'+ a.Name+'<br/><br/>'+

'To ensure that your request is processed correctly, please DO NOT change the subject line of this message<br/><br/>'+

'Please do not delete any fields when filling out template.<br/><br/>'+

'Please enter the following, all the fields are mandatory to process this request:<br/>'+
'Pending Lead Name -'+ a.Name+'<br/><br/>'+
'Pending Lead Sales Channel - '+a.SalesChannel__c+'<br/><br/>'+
'Pending Lead Sales Rep - '+u.LastName+'<br/><br/>'+


'Reason for Urgent Promotion Request:'+ a.Comments__c+' <br/><br/>'
            + 'Please click on the below link for more details:-'+urlid+'/'+a.id
     
        );

     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
         emailmessage em = new emailmessage(); 
          em.FromAddress = u.Email;
          em.FromName = u.LastName;
          em.ToAddress = semail;          
          em.Subject = sub;
          em.HtmlBody = mail.getHtmlBody();
          em.MessageDate = system.now();
          em.Status = '3';
          em.RelatedToid = a.id;
          insert em;

        
        
    }

}