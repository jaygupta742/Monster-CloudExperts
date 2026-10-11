//modified on 19-12-2018 by @imRam changed for cc & from address should not be MO-IN-CR (cr@monsterindia.com)
//modified on 13-12-2022 by @abdulaziz changed for monster to foundit
global class EmailToCase implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Group  g = new Group();
        g = [select Id from Group where  Type = 'Queue' AND DeveloperNAME = 'Case_Queue'];
        //emailmessage em = new emailmessage(); 
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        boolean mailcheck = false;
        boolean crMail = false;
        boolean crCCMail = false;
        // string fromMail = envelope.fromAddress;
        string fromMail = email.fromAddress;
        string ccMail;
        if(email.ccAddresses != NULL)
            ccMail = string.valueof(email.ccAddresses);
        string autoMat = email.subject;
        
        crMail = fromMail.containsIgnoreCase('cr@foundit.in'); //replaced from cr@monsterindia.com to cr@foundit.in on 13-dec-2022
        if(email.ccAddresses != NULL){
            crCCMail = ccMail.containsIgnoreCase('cr@foundit.in'); //replaced from cr@monsterindia.com to cr@foundit.in on 13-dec-2022
        }
        boolean finalRes = false;
        
        if(crMail == true && crCCMail == true){
            finalRes = true;
        }
        
        // crMail = fromMail.containsIgnoreCase('seetaramatest@gmail.com');
        mailcheck  = fromMail.containsIgnoreCase('@foundit'); //replaced from monster to foundit on 13-dec-2022
        boolean neha = fromMail.containsIgnoreCase('neha.kumari@abmtravels.net');
        boolean school = fromMail.containsIgnoreCase('support@schooglink.com');
        boolean expo = fromMail.containsIgnoreCase('jobs@expouniverse.com');
        boolean yaho = fromMail.containsIgnoreCase('MAILER-DAEMON@yahoo.com');
        boolean daemon = fromMail.containsIgnoreCase('mailer-daemon@mx07-002e1001.pphosted.com');
        /* added by yamini on 1/9/2020*/
        boolean balachandran = fromMail.containsIgnoreCase('karikalanbalachandran@yahoo.com');
        boolean vyom = fromMail.containsIgnoreCase('vyom-jobs@yahoogroups.com');
        boolean edarabia = fromMail.containsIgnoreCase('admin@edarabia.com');
        //added till here 
        //@Nag
        boolean ema1 = fromMail.containsIgnoreCase('vikram@aryansearch.com');
        boolean ema2 = fromMail.containsIgnoreCase('vikram@aryan-solutions.com');
        //@Nag
        boolean Out_of_Office = autoMat.containsIgnoreCase('Out of Office');
        /* if(autoMat.contains('Office') && autoMat.contains('Out')) Out_of_Office =true;*/
        boolean Away_from_Office = autoMat.containsIgnoreCase('Away from Office');
        boolean automated_reply = autoMat.containsIgnoreCase('automated reply');
        boolean auto_reply = autoMat.containsIgnoreCase('auto reply');
        boolean auto_responder = autoMat.containsIgnoreCase('auto responder');
        boolean automatic_reply = autoMat.containsIgnoreCase('automatic reply');
        system.debug('Out_of_Office---->'+Out_of_Office);
        system.debug('Away_from_Office---->'+Away_from_Office);
        system.debug('automated reply---->'+automated_reply);
        system.debug('auto_reply---->'+auto_reply);
        system.debug('auto_responder---->'+auto_responder); 
        system.debug('automatic_reply---->'+automatic_reply);
        system.debug('school---->'+school);
        
        String mailSub; 
        if(autoMat.contains(': ')){ mailSub = autoMat.SubStringAfter(': ');}
        else {mailSub = autoMat;}
        System.debug('====> mailSub '+mailSub);
        
        //&& mailcheck == false 
        if(ema2 == false && ema1 == false && finalRes == false && school == false && neha == false && expo == false && balachandran ==false && vyom==false && edarabia == false && yaho == false && daemon == false &&Out_of_Office == false && Away_from_Office == false && automated_reply == false && auto_reply == false && auto_responder == false && automatic_reply == false){
            list<case__c> cas = new List<case__c>([SELECT id,Subject__c,SuppliedEmail__c,Status__c FROM case__C WHERE isdeleted = false AND Subject__c=:mailSub AND SuppliedEmail__c=:fromMail]);
            system.debug('case size-------->'+cas.size());
            
            //account details
            account acc = new account();  
            
            RecordType rt = new RecordType();      
            rt = [SELECT id FROM RecordType WHERE sObjectType ='Account' AND name='Monster Active Account' LIMIT 1];
            
            // contact details
            list<contact> con = new List<contact>([SELECT id,name,email,accountid FROM contact WHERE email = :fromMail]);
            //  con = [SELECT id,name,email,accountid FROM contact WHERE email = :fromMail];
            
            
            
            list<Case_Keywords__c> ck = new List<Case_Keywords__c>();
            ck = [SELECT id,name FROM Case_Keywords__c];
            System.debug('====> Case_Keywords__c '+ck); 
            list<string> ckString = new List<string>();  
            for(Case_Keywords__c cc : ck){
                ckString.add(cc.name);
            }
            System.debug('====> Case string  '+ckString); 
            string comp ;
            string compMail = email.subject  + email.plainTextBody;
            boolean check = false;
            id accid;
            id conid;
            string CMail;
            boolean conExit = false;
            id caseid;   
            
            for(string ccck : ckString){
                
                system.debug('Compilenece Keyword Name---->'+ccck);
                boolean x = false;
                boolean y = false;
                String s =  ccck ;
                Boolean b = s.containsWhitespace();
                system.debug('multiple words-->'+b);
                //for more than one word
                if(b){
                    
                    string  first= s.substringBefore(' ');
                    string  second= s.substringAfter(' ');
                    
                    x = compMail.containsIgnoreCase(first);
                    y = compMail.containsIgnoreCase(second);
                    
                    system.debug('Originl-->'+s);
                    system.debug('first-->'+first);
                    system.debug('second-->'+second);
                    
                    system.debug('x-->'+x);
                    system.debug('y-->'+y);
                    
                    if(x == true && y == true){     //if both Keyword found make yeyword search true
                        system.debug('keyword found for more words');
                        check = true;
                        break;
                    }
                    
                }  
                
                else{ //else single word
                    
                    
                    check = compMail.containsIgnoreCase(ccck);
                    System.debug('====> checkkkkk '+check);
                    if(check)break ;  } 
            }
            System.debug('====> checkkkkk111111 '+check);
            System.debug('====> compMail '+compMail);
            
            boolean yesmail = true;
            List<Attachment> Lattachment = new List<Attachment>();
            
            List<Attachment> CaseAttachment = new List<Attachment>();
            Email__c ema = new Email__c();
            Case__c    Newcase = new Case__c();
            
            string s= email.subject;
            String sub;
            
            
            // String sub = s.SubStringAfter(': ');
            if(s.contains(': ')){
                
                sub = s.SubStringAfter(': '); 
                System.debug('====> Sogladiiiiiiii '+sub);
                
            }
            else{
                sub = s; 
                System.debug('====> pidddiiiiiiiiii '+sub);
            }
            list<case__C> ticket = new list<case__C>();
            if(cas.size()>0) {
                System.debug('This is the caseeeeeeeeeeeeeee sizeeeeeeeeeee--->'+cas.size());
                for(case__C ca : cas){
                    System.debug('====> ca.Subject__c '+ca.Subject__c);
                    System.debug('====> email.subject '+sub);
                    System.debug('====> ca.SuppliedEmail__c '+ca.SuppliedEmail__c);
                    System.debug('====> envelope.fromAddress '+envelope.fromAddress);
                    System.debug('====> email.fromAddress '+  email.fromAddress);
                    
                    
                    // if(ca.Subject__c == sub && ca.SuppliedEmail__c == envelope.fromAddress){  
                    if(ca.Subject__c == sub && ca.SuppliedEmail__c == email.fromAddress){  
                        yesmail = false;
                        caseid = ca.id;
                        if(ca.Status__c == 'Closed')
                            ca.Status__c = 'Reopen'; 
                        System.debug('====> ca.Status__c '+ca.Status__c); 
                        ticket.add(ca);
                        System.debug('====> yesmail case loop '+yesmail); 
                        break;
                        
                    }// if condirion
                    
                    /*    else{  // if existing record
                          System.debug('====> im inside else');
                          ema.Subject__c = email.subject;
                          ema.Body__c = email.plainTextBody;
                          ema.case__c = ca.id;
                          caseid = ca.id;
                          break;
                          }   */
                    
                    
                }// for loop close
                update ticket; //if case is found with same email & Subject status shoud update to Re-open from closed 
            }// If case size close
            
            
            System.debug('====> yesmail final '+yesmail); 
            if(yesmail){
                System.debug('====> yesmail final i am cmg inside  '+yesmail);    
                if(con.size()>0 || con.size()!= NULL)
                    for(contact c : con){
                        
                        //  if(c.email == envelope.fromAddress){
                        if(c.email == email.fromAddress){     
                            accid = c.AccountId;
                            CMail = c.email; 
                            conid = c.Id;  
                            conExit = true;
                            break;
                        }
                        
                    }
                 //  string Aname = envelope.fromAddress;
                //  string Aname =  email.fromAddress;
               //string Aname =  email.fromname;
              //
                if( email.fromname == NULL)
                {
                    string e222 = email.fromAddress;
                    System.debug('This is email from name ---->'+e222);
                    string e33 = e222.substringBefore('@');
                    System.debug('This is email from name ---->'+e33);
                    String Aname = e33;
                    System.debug('====> Aname '+  Aname); 
                    acc.Name = Aname.toUpperCase();
                }
                else{
                    string Aname1 =  email.fromname;
                    System.debug('====> Aname1 '+  Aname1);
                    acc.Name = Aname1.toUpperCase();
                }
                //acc.Name = Aname.toUpperCase();
                acc.RecordTypeId = rt.id;
                acc.SalesChannel__c = 'IN-TS'; //changed from Telesales to IN-TS on 13-dec-2022
                acc.Account_Size__c = 'Small Business';
                acc.Lead_Source1__c = 'Other';
                acc.Case_Accounts__c = true;
                acc.Lead_Account_Status__c = 'InActive';
                /*  acc.Location__c = 'India';
                acc.Phone = '+999999999999';*/
                
                if(check == true || mailcheck == true){
                    system.debug('<--- Keyword Search ---->');
                    Newcase.Keyword_Search__c = true;
                }
                Newcase.LastName__c = email.fromname;
                // Newcase.SuppliedEmail__c = envelope.fromAddress;    
                Newcase.SuppliedEmail__c = email.fromAddress;  
                System.debug('====> Newcase.SuppliedEmail__c '+  Newcase.SuppliedEmail__c);
                
                string truncatedbody1 = ' '; 
                If(email.htmlBody !=NULL){
                    String v3 = email.htmlBody;
                    System.debug('This is my html body/////////////////////'+v3);
                    truncatedbody1 =v3.abbreviate(32000);
                    System.debug('This is my truncated string------>'+truncatedbody1);
                }
                
                Newcase.Description__c = truncatedbody1;
                System.debug('This is the new case description where i am having truncated body--->'+Newcase.Description__c);
                //Newcase.Description__c = email.htmlBody;
                //  Newcase.Subject__c =   email.subject;  
                Newcase.Subject__c =   sub; 
                // Newcase.Subject__c = autoMat;
                system.debug('Newcase.Subject__c'+Newcase.Subject__c);       
                Newcase.Unique_Email_Id__c = email.messageId;
                Newcase.Group__c = 'APAC India Inbound Team';              
                Newcase.Status__c = 'New';  
                Newcase.OwnerId = g.id;
                
                for(String eta : email.toAddresses){
                    System.debug('I am cmg inside etaaaaaaaaaaaaaaaaaaaaaa');
                    if( Newcase.ReceivedTo__c == null) Newcase.ReceivedTo__c = eta;
                    else{ Newcase.ReceivedTo__c =  Newcase.ReceivedTo__c+'; '+eta;}
                }            
                Newcase.SubStatus__c = 'Unresolved';
                Newcase.BusinessProcess__c = 'APAC India Employer Email';  
                //  Newcase.Category__c = 'APAC Support';
                //  Newcase.Issue__c = 'Employer Email'  ;  
                Newcase.Origin__c = 'Email Inbound';
                Newcase.Priority__c = '3-Medium';   
                
                if(conExit == false){
                    System.debug('I am cmg inside conExitttttttttttttttttttttttt');
                    insert acc;
                    contact cc = new contact();
                    
                    // string Cname = email.fromname;
                    //  cc.lastname = Cname.toUpperCase();
                    if( email.fromname == NULL)
                    {
                        string e220 = email.fromAddress;
                        System.debug('This is email from name ---->'+e220);
                        string e330 = e220.substringBefore('@');
                        System.debug('This is email from name ---->'+e330);
                        String Cname = e330;
                        System.debug('====> LastName '+  Cname); 
                        cc.lastname = Cname.toUpperCase();
                    }
                    else{
                        string Cname1 = email.fromname;
                        System.debug('====> Cname1 '+  Cname1);
                        cc.lastname = Cname1.toUpperCase();
                    }
                    //  cc.email = envelope.fromAddress;
                    cc.Case_Contact__c = true;
                    cc.email = email.fromAddress;
                    System.debug('====> cc.email '+  cc.email);  
                    // cc.MobilePhone = '9999999999';
                    cc.accountid = acc.id;
                    
                    insert cc;  // added by yam
                    
                    acc.Lead_Account_Status__c = 'Active';
                    update acc;
                    Newcase.Account__c = acc.id;
                    Newcase.Contact__c = cc.id; 
                    System.debug('After insertttttttttttttttttttttttt cc');    
                }
                
                else if(conExit == true) {Newcase.Account__c = accid;
                                          Newcase.Contact__c = conid;
                                         }
                
                insert Newcase;
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /*Pramodh reply forward */            
                System.debug('I am coming for the email message ...........................');      
                emailmessage em = new emailmessage(); 
                if(email.ccAddresses != null)
                    for(String ecc : email.ccAddresses){
                        if(em.CcAddress == null)em.CcAddress = ecc;
                        else{em.CcAddress = em.CcAddress+'; '+ecc;}
                    }
                em.FromAddress = email.fromAddress;
                System.debug('I have from and cc address............'+em.FromAddress);
                em.FromName = email.fromName;
                for(String eta : email.toAddresses){
                    if(em.ToAddress == null)em.ToAddress = eta;
                    else{em.ToAddress = em.ToAddress+'; '+eta;}
                }
                System.debug('I have toooooo and cc address............'+em.ToAddress);
                /*added by yamini */
                em.Subject = email.subject;
                If(email.htmlBody !=NULL)
                {
                    String v = email.htmlBody;
                    System.debug('This is my html body/////////////////////'+v);
                    String  trucatedStr = v.abbreviate(32000);
                    System.debug('This is my truncated string------>'+trucatedStr);
                    em.HtmlBody=trucatedStr;
                }
                System.debug('Now finalllyyyyyyyyyyyyyyyyyyy i am only having some letters '+em.HtmlBody);
                
                If(email.plainTextBody !=NULL)
                {
                    String tb = email.plainTextBody;
                    System.debug('This is my html body/////////////////////'+tb);
                    String truncatedtxt = tb.abbreviate(32000);
                    System.debug('This is my truncated string------>'+truncatedtxt);
                    em.TextBody = truncatedtxt;
                }            
                
                
                
                
                //em.TextBody = email.plainTextBody;
                /*till here*/
                em.MessageDate = system.now();
                em.Status = '0';
                //  em.Incoming = true;
                em.Related_To__c = Newcase.id;
                em.RelatedToid = Newcase.id;
                insert em;
                
                //binary attachments
                List<Attachment> la = new List<Attachment>();
                if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = email.binaryAttachments[i].body;
                        a.Name = email.binaryAttachments[i].FileName;
                        a.ParentId = em.Id;
                        la.add(a);
                    }
                }
                insert la;
                
                //text attachments
                List<Attachment> la1 = new List<Attachment>();
                if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = Blob.valueOf(email.textAttachments[i].body);
                        a.Name = email.textAttachments[i].FileName;
                        a.ParentId = em.Id;
                        la1.add(a);
                    }
                }
                insert la1;
                
                
                Newcase.Email_Message_ID__c = em.id;
                update Newcase;
                
                
                /*Pramodh reply forward */                
                System.debug('====> Created case '+Newcase.Id);
                // ema.Subject__c = email.subject;
                ema.Subject__c = sub;
                ema.Body__c = email.plainTextBody;
                ema.case__c = Newcase.id;
                ema.Mail_ID__c = em.id;  
                ema.Email_Address__c = em.FromAddress;     
                insert ema;
                
                if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
                    for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
                        Attachment attachment = new Attachment();
                        // attach to the newly created case record
                        attachment.ParentId = Newcase.Id;
                        attachment.Name = email.binaryAttachments[i].filename;
                        attachment.Body = email.binaryAttachments[i].body;
                        Lattachment.add(attachment);
                    }
                }                
                if(!Lattachment.isEmpty()){
                    
                    insert Lattachment; }
                
                
                //text attachments
                List<Attachment> la11 = new List<Attachment>();
                if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = Blob.valueOf(email.textAttachments[i].body);
                        a.Name = email.textAttachments[i].FileName;
                        a.ParentId = Newcase.Id;
                        la11.add(a);
                    }
                }
                insert la11;
                
                
                
                //insert attachment to Case
                if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
                    for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
                        Attachment attachment = new Attachment();
                        // attach to the newly created case record
                        attachment.ParentId = ema.Id;
                        attachment.Name = email.binaryAttachments[i].filename;
                        attachment.Body = email.binaryAttachments[i].body;
                        CaseAttachment.add(attachment);
                    }
                }                
                if(!CaseAttachment.isEmpty()){
                    
                    insert CaseAttachment; }
                
                //text attachments
                List<Attachment> la12 = new List<Attachment>();
                if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = Blob.valueOf(email.textAttachments[i].body);
                        a.Name = email.textAttachments[i].FileName;
                        a.ParentId = ema.Id;
                        la12.add(a);
                    }
                }
                insert la12;        
                
                
                
            }else{
                
                /* @imRam Reply back message*/
                
                emailmessage em1 = new emailmessage(); 
                if(email.ccAddresses != null)
                    for(String ecc : email.ccAddresses){
                        if(em1.CcAddress == null)em1.CcAddress = ecc;
                        else{em1.CcAddress = em1.CcAddress+'; '+ecc;}
                    }
                em1.FromAddress = email.fromAddress;
                em1.FromName = email.fromName;
                for(String eta : email.toAddresses){
                    if(em1.ToAddress == null)em1.ToAddress = eta;
                    else{em1.ToAddress = em1.ToAddress+'; '+eta;}
                }
                /*add by yam */
                em1.Subject = email.subject;
                
                /*String v1=' ';
                 v1=email.htmlBody;
                 System.debug('This is the ')
                 String truncatedstr2 =v1.abbreviate(32000);
                 em1.HtmlBody=truncatedstr2;*/
                
                
                If(email.htmlBody !=NULL)
                {
                    String v1 = email.htmlBody;
                    System.debug('This is my html body/////////////////////'+v1);
                    String  truncatedstr2 = v1.abbreviate(32000);
                    System.debug('This is my truncated string------>'+truncatedstr2);
                    em1.HtmlBody =truncatedstr2;
                }
                //em1.HtmlBody = email.htmlBody;
                If(email.plainTextBody !=NULL)
                {
                    String v100 = email.plainTextBody;
                    System.debug('This is my html body/////////////////////'+v100);
                    String  truncatedstr21 = v100.abbreviate(32000);
                    System.debug('This is my truncated string------>'+truncatedstr21);
                    em1.TextBody =truncatedstr21;
                }
                // em1.TextBody = email.plainTextBody;
                em1.MessageDate = system.now();
                em1.Status = '0';
                //  em.Incoming = true;
                em1.Related_To__c = caseid;
                em1.RelatedToid = caseid;
                insert em1;
                /*till here*/
                system.debug('emailmessage--->'+em1.id);         
                //binary attachments
                List<Attachment> la = new List<Attachment>();
                if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = email.binaryAttachments[i].body;
                        a.Name = email.binaryAttachments[i].FileName;
                        a.ParentId = em1.Id;
                        la.add(a);
                    }
                }
                insert la;
                
                //text attachments
                List<Attachment> la1 = new List<Attachment>();
                if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = Blob.valueOf(email.textAttachments[i].body);
                        a.Name = email.textAttachments[i].FileName;
                        a.ParentId = em1.Id;
                        la1.add(a);
                    }
                }
                insert la1;
                
                /* ----------- update latest emailMessage Id ----- */
                
                case__c cse = [SELECT id,name,Email_Message_ID__c FROM case__c WHERE id =:caseid];
                cse.Email_Message_ID__c = em1.id;
                update cse;
                system.debug('--------- update email message ----'+cse);
                
                /* @imRam Reply back message till here*/
                
                //  ema.Subject__c = email.subject;
                ema.Subject__c = sub;
                ema.Body__c = email.plainTextBody;
                ema.case__c = caseid;
                ema.Mail_ID__c = em1.id;
                ema.Email_Address__c = em1.FromAddress;       
                insert ema;
                system.debug(' ema.Mail_ID__c---->'+ ema.Mail_ID__c);  
                system.debug(' ema---->'+ ema);    
                
                if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
                    for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
                        Attachment attachment = new Attachment();
                        // attach to the newly created case record
                        attachment.ParentId = ema.Id;
                        attachment.Name = email.binaryAttachments[i].filename;
                        attachment.Body = email.binaryAttachments[i].body;
                        Lattachment.add(attachment);
                    }
                    if(!Lattachment.isEmpty()){
                        insert Lattachment; }
                }
                //text attachments
                List<Attachment> la13 = new List<Attachment>();
                if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = Blob.valueOf(email.textAttachments[i].body);
                        a.Name = email.textAttachments[i].FileName;
                        a.ParentId = ema.Id;
                        la13.add(a);
                    }
                }
                insert la13;     
                
                
                // inserting attachments to case
                if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
                    for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
                        Attachment attachment = new Attachment();
                        // attach to the newly created case record
                        attachment.ParentId = caseid;
                        attachment.Name = email.binaryAttachments[i].filename;
                        attachment.Body = email.binaryAttachments[i].body;
                        CaseAttachment.add(attachment);
                    }
                }                
                if(!CaseAttachment.isEmpty()){
                    
                    insert CaseAttachment; } 
                
                
                //text attachments
                List<Attachment> la131 = new List<Attachment>();
                if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                    for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                        Attachment a = new Attachment();
                        a.Body = Blob.valueOf(email.textAttachments[i].body);
                        a.Name = email.textAttachments[i].FileName;
                        a.ParentId = caseid;
                        la131.add(a);
                    }
                }
                insert la131;
                
                
                
            }
            
        }
        result.success = true;
        return result;
        
        
        
    }
    
}