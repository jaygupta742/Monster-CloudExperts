Global class Ready_For_Validation_email
{
    @AuraEnabled
    webservice static void myMethod(string recid) 
    { 
        
        user logged=[select id,name,email from user where id=:userinfo.getuserid()];
        user receiver=[select id,name,email,Manager.email from user where id=:logged.id];
        apttus_proposal_proposal__c ap=[select id,name,Channel__c,Gross_Total__c,CreatedDate,/*Account__r.AccountID__c,*/Agency_ID__c, Net_Total__c,Account__r.owner.name,Account__r.name,Account__r.SalesChannel__c,Order_Type__c,Primary_Contact__r.name,Primary_Contact__r.email,Primary_Contact__r.mobilephone,(select Name,Order_Type__c from Orders__r ) from apttus_proposal_proposal__c where id=:recid];
        BusinessHours bh = [SELECT id FROM BusinessHours WHERE IsActive = True AND Name = 'Quote To Order Tracker'];
        
        string oid = '';
        string otype = '';
        if(ap.Orders__r.size() != 0){
            oid = ap.Orders__r[0].Name;
            otype = ap.Orders__r[0].Order_Type__c;
        }
        
        string link=URL.getSalesforceBaseUrl().toExternalForm() + '/'+ap.id;
        string Mangrmail = receiver.Manager.email;
 
        decimal pp=0.0;
        pp=BusinessHours.diff(bh.id,ap.CreatedDate,system.now());
        decimal  p=(decimal)(pp/3600000).setscale(2);
        decimal j= p- p.intvalue();
        Integer min=Math.round(j*60);
        if(min==0){
            min=1;
        }
        integer hour =p.intvalue();
  
        RecordType rid = [select name, id from recordtype where name='After Validated'];
        apttus_proposal_proposal__c forupdate = new apttus_proposal_proposal__c();
        forupdate.Id = ap.Id;
        forupdate.RecordTypeId = rid.Id;
        // By Pankaj
        forupdate.Validated__c=true;
        forupdate.Re_Process_Stage__c='Submitted For Validation';
        forupdate.Ready_For_Validation__c = System.now();
        forupdate.Quote_Created_To_RD_Validation_TAT_hrs__c=hour;
        forupdate.Quote_Created_To_RD_Validation_TAT_Mn__c=min;
        update forupdate;
        
        
        system.debug('meeeee'+link+'hhh'+recid);
        
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setToAddresses(New String[]{'crm@cloudexpertsindia.com','Ajesh.Shyam@monsterindia.com'});
        //mail.setToAddresses(New String[]{'activation@monsterindia.com'});
        
        
        
        List<string> bccadd = new List<string>();
        if(Mangrmail!=NULL)
            bccadd.add(Mangrmail);
        bccadd.add(receiver.Email);
        Validation_Mail__c vm = Validation_Mail__c.getValues(ap.Channel__c);
        if(vm != null)
            bccadd.add(vm.Email__c);
        //mail.setToAddresses(New String[]{'crm@cloudexpertsindia.com'});
        mail.setToAddresses(bccadd);
        if(bccadd.size()>0)
            //  mail.setCcAddresses(bccadd);
            // mail.setSenderDisplayName('Salesforce Team');
            mail.setSubject('Please activate the services-'+ap.name+' for '+ap.Account__r.name);
        // mail.setPlainTextBody('this is test Email Case  ');
        mail.setHtmlBody(
            
            '<b>Please activate the services</b> <br/><br/><br/> Account Name: '+ap.Account__r.name+'<br/>Account ID: ' /* +ap.Account__r.AccountID__c */
            +'<br/>Order Number: '+oid+'<br/>Sales Channel: '+ap.Account__r.SalesChannel__c+'<br/>Account Sales Rep: '+ap.Agency_ID__c //Account__r.owner.name
            +'<br/>Order Type: '+ap.Order_Type__c+'<br/> Sales Credit: '+ap.Gross_Total__c
            +'<br/><br/><b>Customer Contact Information: </b><br/>Name - '+ap.Primary_Contact__r.name
            +'<br/>Email - '+ap.Primary_Contact__r.email+'<br/>phone - '+ap.Primary_Contact__r.mobilephone
            +'<br/><br/>Regards,<br/>Team Finance'
            +'<br/><br/><b>Please click on the record link below for more details<br/>'+link
            
            
        );
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    @AuraEnabled
    Public static apttus_proposal_proposal__c getRecord(id recordId){
        apttus_proposal_proposal__c ap=[select id,name,Payment_count__c,Validated__c,Opportunity__c from apttus_proposal_proposal__c where id=:recordId];
        return ap;
    }
    
    @AuraEnabled
    Public static boolean checkForAttachment(apttus_proposal_proposal__c quoteRecord){
        List<Attachment> listOfAttachment = new List<Attachment>();
        System.debug('Record '+quoteRecord.Id);
        listOfAttachment = [select id,Name from Attachment where Parentid =: quoteRecord.Id];
        if(listOfAttachment.size() == 0){
            return true;
        }
        else{
            List<Template__c> mcs = Template__c.getall().values();
            for(Attachment att : listOfAttachment){
                for(Template__c temp : mcs){
                    string tempName = temp.PDF__c+'.pdf';
                    System.debug('Name####### '+tempName+','+att.Name);
                    if(tempName == att.Name){
                        
                        Opportunity__c opp = new Opportunity__c();
                        opp.id = quoteRecord.Opportunity__c;
                        //opp.Stage__c = 'Quote / Agreement Stage'; // changes done by yamini at line 113 and 115
                        // opp.Stage__c = 'Sale Declared'; -- Nag(Opp enhancement)
                        //opp.Probability__c = '75';
                        //opp.Probability__c = '90'; -- Nag(Opp enhancement)
                        update opp;
                        Ready_For_Validation_email.myMethod(quoteRecord.id);
                        return false;
                    }
                }
            }
            return true;
        }
    }
}