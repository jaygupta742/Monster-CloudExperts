public class sendQuote_cls {
    @AuraEnabled
    public static string get_Quote(String recordId) {
        try{
            QuotesN__c quoteObj;
            quoteObj = [SELECT Id, Name, Account__c, Account_Type__c, Active__c, Bill_Contact__c, Billing_Address__c, Billing_City__c, Attach_Service_Agreement__c,Attach_Prefilled_Cart_Report__c,
                        Billing_Country__c, Billing_Pin_Code__c, Billing_State__c, Billing_Street__c, CurrencyIsoCode, Opportunities__c,
                        Order_Type__c, Posting_Address__c, Posting_City__c, Posting_Contact__c, Posting_Country__c, Posting_Pin_Code__c, 
                        Posting_State__c, Posting_Street__c, Price_Master__c, Contact__c, Contact__r.Name, Contact__r.Email, Quote_Type__c, Special_Terms__c, Xcode__c	
                        FROM QuotesN__c 
                        WHERE Id=: recordId
                       ];
            wraper wrap = new wraper(quoteObj);
            wrap.to = quoteObj.Contact__r.Email;
            wrap.name = quoteObj.Contact__r.Name;
            wrap.cc = UserInfo.getUserEmail();
            System.debug('user Email: '+UserInfo.getUserEmail());
            return JSON.serialize(wrap);            
        }
        catch(Exception e) {
            throw new AuraHandledException('Something went worng: '+e.getMessage());
        }
    }
    
    @AuraEnabled
    public static list<Template__c> getTemplate(string recId){
        
        QuotesN__c hh= new QuotesN__c();
        hh=[select id,name,Selling_Country__c,Opportunities__c from QuotesN__c where id=:recId limit 1];
        String j= '%'+hh.Selling_Country__c+'%';
        
        List<Template__c> templa = new List<Template__c>();
        templa = new List<Template__c>([Select ID , Name,PDF__c,DOC__c ,Location__c From Template__c 
                                        where Location__c like:j And  CreatedDate = LAST_N_DAYS:90]);
        
        List<SelectOption> pdfdoc = new List<SelectOption> ();
        Map<String,String> pval= new  Map<String,String>();
        
        For(Template__c  t : templa){
            
            //  wrp.add(New wrap(t));
            pdfdoc.add(new SelectOption(t.Name,t.Name));
            if(t.PDF__c != null)
                pval.put(t.Name,t.PDF__c);
        }
        
        return templa;
        
    }


      @AuraEnabled
    public static String onSend(String recordId, String subject, String reciever, String cc, String body,list<Template__c> pdff) {
        try {
            QuotesN__c quoteObj;
            quoteObj = [SELECT Id, Name, Account__c, Account_Type__c, Active__c, Bill_Contact__c, Billing_Address__c, Billing_City__c, Attach_Service_Agreement__c,
                        Billing_Country__c, Billing_Pin_Code__c, Billing_State__c, Billing_Street__c, CurrencyIsoCode, Opportunities__c,Attach_Prefilled_Cart_Report__c,
                        Order_Type__c, Posting_Address__c, Posting_City__c, Posting_Contact__c, Posting_Country__c, Posting_Pin_Code__c, 
                        Posting_State__c, Posting_Street__c, Price_Master__c, Contact__c, Contact__r.Name, Contact__r.Email, Quote_Type__c,
                        Special_Terms__c, Xcode__c, Account__r.Name	
                        FROM QuotesN__c 
                        WHERE Id=: recordId
                       ];
            
            
            List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            //Set recievers.. this parameter actually a list, so we need a list of reciever
            List<String> sendTo = new List<String>();
            sendTo.add(reciever);
            List<String> ccTo = new List<String>();
            ccTo.add(cc);
            
            mail.setToAddresses(sendTo);
            mail.setCcAddresses(ccTO);
            mail.setReplyTo('noreply@gmail.com');
            mail.setSenderDisplayName('Salesforce Demo1 User');
            mail.setSubject(subject);
            mail.setHtmlBody(body);
            
            allMails.add(mail);
            
            List<Messaging.EmailFileAttachment> allefaList = new List<Messaging.EmailFileAttachment>();
                             
              for(Template__c p:pdff){
                   List<Messaging.EmailFileAttachment> efaList1 = new List<Messaging.EmailFileAttachment>();
                //  string namep=p.PDF__c;
                  //system.debug('namep====='+namep);
           PageReference pdf = new PageReference('/apex/' +p.PDF__c); //Quote PDF is the name of vf page  
                pdf.getParameters().put('id',recordId);
                
                blob b;
                if(Test.isRunningTest()){
                    b=blob.valueOf('xcsd');
                }
                else{
                    b = pdf.getContent();
                }
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(p.name+' Account .- '+quoteObj.Account__r.Name+' Quote No.- '+quoteObj.Name+'.pdf');
                efa.setBody(b);
                  allefaList.add(efa);
                //efaList1.add(efa);
               // mail.setFileAttachments(efaList1);
        }
            //
            if(quoteObj.Attach_Service_Agreement__c==true && quoteObj.Attach_Prefilled_Cart_Report__c==False){
                PageReference pdf = Page.Quote_pdf; //Quote PDF is the name of vf page  
                pdf.getParameters().put('id',recordId);
                
                blob b;
                if(Test.isRunningTest()){
                    b=blob.valueOf('xcsd');
                }
                else{
                    b = pdf.getContent();
                }
                Messaging.EmailFileAttachment efaa = new Messaging.EmailFileAttachment();
                efaa.setFileName('Service Agreement from Monster for '+quoteObj.Account__r.Name+' Quote No.- '+quoteObj.Name+'.pdf');
                efaa.setBody(b);
                 allefaList.add(efaa);
               // mail.setFileAttachments(new Messaging.Emailfileattachment[]{efaa});
            }
            
            else if(quoteObj.Attach_Prefilled_Cart_Report__c==true && quoteObj.Attach_Service_Agreement__c==False){
                PageReference pdf1 = Page.QuoteNewPDF; //Quote PDF is the name of vf page  
                pdf1.getParameters().put('id',recordId);
                
                blob c;
                if(Test.isRunningTest()){
                    c=blob.valueOf('xcsd');
                }
                else{
                    c = pdf1.getContent();
                }
                Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
                efa1.setFileName('Prefilled Cart Report from Monster for  prefilled'+quoteObj.Account__r.Name+' Quote No.- '+quoteObj.Name+'.pdf');
                efa1.setBody(c);
                allefaList.add(efa1);
                //mail.setFileAttachments(new Messaging.Emailfileattachment[]{efa1});
            }
            
            
            else if(quoteObj.Attach_Prefilled_Cart_Report__c==true && quoteObj.Attach_Service_Agreement__c==true){
                
                List<Messaging.EmailFileAttachment> efaList = new List<Messaging.EmailFileAttachment>();
                System.debug('user efaList: '+efaList);
                
                PageReference pdf = Page.Quote_pdf; //Quote PDF is the name of vf page  
                pdf.getParameters().put('id',recordId);
                blob b;
                if(Test.isRunningTest()){
                    b=blob.valueOf('xcsd');
                }
                else{
                    b = pdf.getContent();
                }
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('Service Agreement from Monster for '+quoteObj.Account__r.Name+' Quote No.- '+quoteObj.Name+'.pdf');
                efa.setBody(b);
               // efaList.add(efa);
                // mail.setFileAttachments(new Messaging.Emailfileattachment[]{efa});
                allefaList.add(efa);
                
                PageReference pdf1 = Page.QuoteNewPDF; //Quote PDF is the name of vf page  
                pdf1.getParameters().put('id',recordId);
                
                blob c;
                if(Test.isRunningTest()){
                    c=blob.valueOf('xcsd');
                }
                else{
                    c = pdf1.getContent();
                }
                Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
                efa1.setFileName('Prefilled Cart Report from Monster for  prefilled'+quoteObj.Account__r.Name+' Quote No.- '+quoteObj.Name+'.pdf');
                efa1.setBody(c);
                 allefaList.add(efa1);
               // efaList.add(efa1);
                //mail.setFileAttachments(new Messaging.Emailfileattachment[]{efa1,efa});
               // mail.setFileAttachments(efaList);
            }
            mail.setFileAttachments(allefaList);
            system.debug('All attachments=====' + allefaList);
            
            Messaging.sendEmail(allMails);
            return 'SUCCESS';
        }
        catch(Exception e) {
            system.debug('getline'+e.getLineNumber());
              system.debug('getsg'+e.getMessage());
            throw new AuraHandledException('Something went wrong: '+e.getMessage());
        }
    }

    
   // public static list<Template__c> getTe
    
    public class wraper {
        public QuotesN__c qt;
        public String to;
        public String name;
        public String cc;
        
        public wraper(QuotesN__c item) {
            qt = new QuotesN__c();
            qt = item;
            
            
        }
    }
}