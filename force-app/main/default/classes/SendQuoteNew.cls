public class SendQuoteNew {
    
    @AuraEnabled
    Public static boolean checkForAttachment(string rid){
        List<Attachment> listOfAttachment = new List<Attachment>();
       // System.debug('Record '+quoteRecord.Id);
        listOfAttachment = [select id,Name from Attachment where Parentid =:rid];
        if(listOfAttachment.size() == 0){
            return true;
        }
        else {
            return false;
        }
    }
     @AuraEnabled
    public static string get_Quote(String recordId) {
        try{
            QuotesN__c quoteObj;
            quoteObj = [SELECT Id,Name,Account__c, Account_Type__c, Active__c, Bill_Contact__c, Billing_Address__c, Billing_City__c, Attach_Service_Agreement__c,Attach_Prefilled_Cart_Report__c,
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
    public static string sendAttachedPdf(string rid){
       List<Attachment> listOfAttachment = new List<Attachment>();
        listOfAttachment = [select id,Name from Attachment where Parentid =:rid];
                   List<New_Template1__c> mcs = New_Template1__c.getall().values();

         List<New_Template1__c> templa = new List<New_Template1__c>();
        
       // templa = new List<New_Template1__c>([Select ID,Name,PDF__c,Location__c From New_Template1__c	 
                                     //   where Location__c like:j]);
            
        string pname;
      for(Attachment att : listOfAttachment){
                for(New_Template1__c temp : mcs){
                    string tempName = temp.PDF__c+'.pdf';
                    System.debug('Name####### '+tempName+','+att.Name);
                    if(tempName == att.Name){
                       pname=temp.Pdf__c;
                    }
                }
      }
        system.debug('selected pdf name:'+pname);
       // New_Template1__c tt=[Select ID,Name,PDF__c,Location__c From New_Template1__c where name=:pname];
            
        return pname;
    }
    
    @AuraEnabled
    public static list<New_Template1__c> getTemplate(string recId){
        
        QuotesN__c hh= new QuotesN__c();
        hh=[select id,name,Selling_Country__c,Opportunities__c from QuotesN__c where id=:recId limit 1];
        String j= '%'+hh.Selling_Country__c+'%';
        
        List<New_Template1__c> templa = new List<New_Template1__c>();
        templa = new List<New_Template1__c>([Select ID,Name,PDF__c,Location__c From New_Template1__c	 
                                        where Location__c like:j]);
        
        List<SelectOption> pdfdoc = new List<SelectOption> ();
        Map<String,String> pval= new  Map<String,String>();
        
        For(New_Template1__c  t : templa){
            
            //  wrp.add(New wrap(t));
            pdfdoc.add(new SelectOption(t.Name,t.Name));
            if(t.PDF__c != null)
                pval.put(t.Name,t.PDF__c);
        }
        
        return templa;
        
    }


      @AuraEnabled
    public static String onSend(String recordId, String subject, String reciever, String cc, String body,string uploadedAttId,string uploadedAttId1,string uploadedAttId2) {
        try {
            set<string> str= new  set<string>();
        str.add(uploadedAttId);
        str.add(uploadedAttId1);
        str.add(uploadedAttId2);
            
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
            List<string> sendTo=new List<string>(reciever.split(','));
            system.debug('comma to:'+sendTo);
            //Set recievers.. this parameter actually a list, so we need a list of reciever
            //List<String> sendTo = new List<String>();
            //sendTo.add(reciever);
                        //sendTo.add(ss);

            //List<String> ccTo = new List<String>();
                        List<string> ccTo=new List<string>(cc.split(','));
            system.debug('cc to:'+ccTo);

           // ccTo.add(cc);
                      //ccTo.add('anupshaw654321@gmail.com');
  
            mail.setToAddresses(sendTo);
            mail.setCcAddresses(ccTO);
            mail.setReplyTo('noreply@gmail.com');
            mail.setSenderDisplayName('Salesforce Demo1 User');
            mail.setSubject(subject);
            mail.setHtmlBody(body);
            
            allMails.add(mail);
            
            List<Attachment> listOfAttachment = new List<Attachment>();
        listOfAttachment = [select id,Name from Attachment where Parentid =:recordId];
                   List<New_Template1__c> mcs = New_Template1__c.getall().values();

         List<New_Template1__c> templa = new List<New_Template1__c>();
        
       // templa = new List<New_Template1__c>([Select ID,Name,PDF__c,Location__c From New_Template1__c	 
                                     //   where Location__c like:j]);
            
        string pname;
      for(Attachment att : listOfAttachment){
                for(New_Template1__c temp : mcs){
                    string tempName = temp.PDF__c+'.pdf';
                  //  System.debug('Name####### '+tempName+','+att.Name);
                    if(tempName == att.Name){
                       pname=temp.Pdf__c;
                    }
                }
      }
            List<Messaging.EmailFileAttachment> allefaList = new List<Messaging.EmailFileAttachment>();
                             
             // for(Template__c p:pdff){
                   List<Messaging.EmailFileAttachment> efaList1 = new List<Messaging.EmailFileAttachment>();
                //  string namep=p.PDF__c;
                  //system.debug('namep====='+namep);
           PageReference pg = new PageReference('/apex/' +pname); //Quote PDF is the name of vf page  
                pg.getParameters().put('id',recordId);
                
                blob b;
                if(Test.isRunningTest()){
                    b=blob.valueOf('xcsd');
                }
                else{
                    b = pg.getContent();
                }
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(pname+' Account .- '+quoteObj.Account__r.Name+' Quote No.- '+quoteObj.Name+'.pdf');
                efa.setBody(b);
                  allefaList.add(efa);
            
            if(uploadedAttId != null || uploadedAttId1 != null || uploadedAttId2 != null){ 
                system.debug('uploadedAttId ..: '+str);
               
               list<Attachment> att = [select Id,Name,Body,ContentType from Attachment where ID =:str];
                 system.debug('uploadedAttId ..: '+att);
             
                //list <Messaging.EmailFileAttachment> efalist= new list<Messaging.EmailFileAttachment>();
                for(Attachment  at:att){
                    Messaging.EmailFileAttachment efaAtt = new Messaging.EmailFileAttachment();
                    efaAtt.setFileName(at.Name);
                    efaAtt.setBody(at.Body);
                    system.debug('efaAtt : '+efaAtt);
                    allefaList.add(efaAtt);
                   // efalist.add(efa);
                    
                }
            }
                //efaList1.add(efa);
               // mail.setFileAttachments(efaList1);
       // }
            //
           /* if(quoteObj.Attach_Service_Agreement__c==true && quoteObj.Attach_Prefilled_Cart_Report__c==False){
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
            }*/
            
           /* else if(quoteObj.Attach_Prefilled_Cart_Report__c==true && quoteObj.Attach_Service_Agreement__c==False){
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
            }*/
            
            
            /*else if(quoteObj.Attach_Prefilled_Cart_Report__c==true && quoteObj.Attach_Service_Agreement__c==true){
                
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
            }*/
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
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) 
    {
        
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    @AuraEnabled
    public static Id saveChunk1(Id parentId1, String fileName1, String base64Data, String contentType, String fileId1) 
    {
        
        if (fileId1 == '') {
            fileId1 = saveTheFile(parentId1, fileName1, base64Data, contentType);
        } else {
            appendToFile(fileId1, base64Data);
        }
        
        return Id.valueOf(fileId1);
    }
    @AuraEnabled
    public static Id saveChunk2(Id parentId2, String fileName2, String base64Data, String contentType, String fileId2) 
    {
        
        if (fileId2 == '') {
            fileId2 = saveTheFile(parentId2, fileName2, base64Data, contentType);
        } else {
            appendToFile(fileId2, base64Data);
        }
        return Id.valueOf(fileId2);
    }
    
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType)
    {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
        
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
        
        insert oAttachment;
        
        return oAttachment.Id;
    }
    
    public static Id saveTheFile1(Id parentId1, String fileName1, String base64Data, String contentType)
    {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId1;
        
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName1;
        oAttachment.ContentType = contentType;
        
        insert oAttachment;
        
        return oAttachment.Id;
    }
    
    
    private static void appendToFile(Id fileId, String base64Data)
    {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
        
        String existingBody = EncodingUtil.base64Encode(a.Body);
        
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        
        update a;
    }
    private static void appendToFile1(Id fileId1, String base64Data)
    {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId1
        ];
        
        String existingBody = EncodingUtil.base64Encode(a.Body);
        
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        
        update a;
    }

    
public class wraper {
         @AuraEnabled
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