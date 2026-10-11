/**
* @File Name          : addressAndContactCheck.cls
* @Description        : 
* @Author             : phUser@phDomain.com
* @Group              : 
* @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
* @Last Modified On   : 4/3/2019, 3:56:53 PM
* @Modification Log   : 
*==============================================================================
* Ver         Date                     Author                Modification
*==============================================================================
* 1.0    1/3/2019, 11:00:27 AM   phUser@phDomain.com     Initial Version
**/
/*Last Modified  By : Abdul Aziz, Date : 12/10/2023 , Based on channel updated emails
Last Modified  By : Jay Gupta, Date : 19/12/2024 , Updated SFrequesttsacq@monsterindia.com to sfrequesttsacq@foundit.in and 

*/



public class AddressAndContactCheck {
    @AuraEnabled
    public static String getAddressAndContactStat(id accountId){
        Account acc = new Account();
        acc = [select id,BillingCity,BillingCountry,BillingStreet,BillingPostalCode,ShippingCity,ShippingCountry,ShippingStreet,ShippingPostalCode,(select id from contacts where PrimarySalesContact__c=true) from account where id =: accountId];
        if(acc.BillingCity == null || acc.BillingStreet == null || acc.BillingPostalCode == null || acc.ShippingCity == null || acc.ShippingStreet == null || acc.ShippingPostalCode == null || acc.Contacts.size()<=0){
            //if( acc.Contacts.size()<=0){
            System.debug('inside if bloack');
            return 'Success';
        }
        else{
            System.debug('inside else bloack');
            String semail;        
            List<String> useremalist = new List<String>();        
            account a = [select id,Name,SalesChannel__c,Location__c,Ownerid,Primary_Sales_Rep__c,Comments__c FROM account WHERE id = :accountId];
            //  map<id , string> mu =  new  map<id , string>();
            User u = [SELECT id,CompanyName,Email ,Phone,Manager.email,MobilePhone, FirstName, LastName,Location__c,Job_Type__c FROM user where id = :a.OwnerId];
            useremalist.add(u.Email);
            if(u.Manager.email != NULL && u.Manager.email != 'anurag.arora@foundit.ai') //anurag.arora@monsterindia.com
                useremalist.add(u.Manager.email);  
            
            string urlid =URL.getSalesforceBaseUrl().getHost();
            
            system.debug('urlll'+urlid);
            system.debug('SalesChannel & Location'+a.SalesChannel__c + ' '+a.Location__c);
            
            //   if(a.SalesChannel__c == 'EA' && a.Location__c == 'India')
            if(a.SalesChannel__c == 'EA' )
            {
                system.debug('Fieldsales & Enterprise Business India');
                semail =  'SFrequestfieldsales@foundit.in'; // SFrequestfieldsales@foundit.in 
            }
            // else if(a.SalesChannel__c == 'SMB' && a.Location__c == 'India')
            else if(a.SalesChannel__c == 'SMB' || a.SalesChannel__c == 'Strat' || a.SalesChannel__c == 'Growth')
            {
                system.debug('Fieldsales & SMB Business India');
                semail = 'SFrequestfieldsales@foundit.in';  //SFrequestfieldsales@foundit.in
            }
            //  else if(a.SalesChannel__c == 'ME-FS' && a.Location__c == 'Middle East')
            else if(a.SalesChannel__c =='ME-FS' || a.SalesChannel__c =='ME FS' )
            {
                system.debug('Fieldsales & Middle East');
                semail = 'MESFrequest@monstergulf.com'; // MESFrequest@monstergulf.com
            } 
            //   else if(a.SalesChannel__c == 'ME-TS' && a.Location__c == 'Middle East')
            else if(a.SalesChannel__c =='ME-TS' || a.SalesChannel__c =='ME TS')
            {
                system.debug('Telesales & Middle East');
                semail = 'MESFrequest@monstergulf.com'; //MESFrequest@monstergulf.com
            }
            //  else if(a.SalesChannel__c == 'IN-TS' && a.Location__c == 'India')
            else if(a.SalesChannel__c == 'IN-TS' || a.SalesChannel__c == 'IN TS' )
            {
                system.debug('Telesales & India');
                semail = 'sfrequesttsacq@foundit.in'; // SFrequesttsacq@monsterindia.com;
            } 
            //SEA South East Asisan Related Country Channel
            else if(a.SalesChannel__c == 'SEA-TS' || a.SalesChannel__c == 'SEA TS' || a.SalesChannel__c == 'SG-FS' ||  a.SalesChannel__c == 'SG FS' || a.SalesChannel__c == 'MY-FS' || a.SalesChannel__c == 'MY FS' || a.SalesChannel__c == 'PH-FS' || a.SalesChannel__c == 'PH FS' || a.SalesChannel__c == 'HK-FS' || a.SalesChannel__c == 'HK FS')
            {
                system.debug('Telesales & Middle East');
                semail = 'SEASFrequest@monster.com.sg'; //MESFrequest@monstergulf.com
            }
            else if(a.SalesChannel__c == 'MMW' && a.Location__c == 'India')
            {
                system.debug('Fieldsales & Media Works India');
                semail = 'SFrequestfieldsales@foundit.in';  //SFrequestfieldsales@foundit.in
            }
            else if(a.SalesChannel__c == 'International' && a.Location__c == 'International')
            {
                system.debug('Fieldsales & International');
                semail = 'SFrequestfieldsales@foundit.in'; //SFrequestfieldsales@foundit.in
            } 
            else if(a.SalesChannel__c == 'Revenue.in' && a.Location__c == 'International')
            {
                system.debug('Fieldsales & Revenue.in International');
                semail = 'SFrequestfieldsales@foundit.in'; // 'seetaramatest@gmail.com';
            }
            else if(a.SalesChannel__c == 'SG-FS' && a.Location__c == 'Singapore')
            {
                system.debug('Fieldsales & Singapore');
                semail = 'SEASFrequest@monster.com.sg'; // SEASFrequest@monster.com.sg 
            } 
            else if(a.SalesChannel__c == 'MY-FS' && a.Location__c == 'Malaysia')
            {
                system.debug('Fieldsales & Malaysia');
                semail = 'SEASFrequest@monster.com.sg'; //SEASFrequest@monster.com.sg
            } 
            else if(a.SalesChannel__c == 'PH-FS' && a.Location__c == 'Philippines')
            {
                system.debug('Fieldsales & Philippines');
                semail = 'SEASFrequest@monster.com.sg'; //SEASFrequest@monster.com.sg
            }
            else if(a.SalesChannel__c == 'HK-FS' && a.Location__c == 'Hong Kong')
            {
                system.debug('Fieldsales & Hong Kong');
                semail = 'SEASFrequest@monster.com.sg'; //SEASFrequest@monster.com.sg               
            }             
            else if((a.SalesChannel__c == 'SEA-TS') && (a.Location__c == 'Singapore' || a.Location__c == 'Malaysia' || a.Location__c == 'Philippines' || a.Location__c == 'Hong Kong' || a.Location__c == 'Rest of SEA')){
                system.debug('Telesales & SEA');
                semail = 'SEASFrequest@monster.com.sg'; // SEASFrequest@monster.com.sg                
            }
            else if(a.Location__c == 'India' || a.Location__c == 'Multi-location' || a.Location__c == 'International')
            {
                system.debug('location based 1 - MO-IN-SF Request TS ACQ');
                semail = 'sfrequesttsacq@foundit.in'; // SFrequesttsacq@monsterindia.com                
            }   
            else if(a.Location__c == 'Middle East')
            {
                system.debug('location based 2 - MO-ME SF Request');
                semail = 'MESFrequest@monstergulf.com'; // MESFrequest@monstergulf.com           
            }  
            else if(a.Location__c == 'Singapore' || a.Location__c == 'Malaysia' || a.Location__c == 'Philippines' || a.Location__c == 'Hong Kong' || a.Location__c == 'Rest of SEA')
            {
                system.debug('location based 3 - MO-SEA SF Request');
                semail = 'SEASFrequest@monster.com.sg'; //SEASFrequest@monster.com.sg            
            }  
            else
            {
                semail = 'Chintala.Swapna@monsterindia.com'; // Chintala.Swapna@monsterindia.com
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
                
                'India Telesales ACQ Users  - MO-IN-SF Request TS ACQ (sfrequesttsacq@foundit.in)  <br/><br/>'+
                'India Telesales RET Users  - MO-IN-SF Request Retention (SFrequestfieldsales@foundit.in)<br/>'+
                'India Fieldsales Users  - MO-IN-SF Request Fieldsales (SFrequestfieldsales@foundit.in)<br/>'+
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
            try {
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
                return 'Error';
            } catch (Exception ex) { return String.valueOf(ex); }
        }        
    }
}