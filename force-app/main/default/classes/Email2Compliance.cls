global class Email2Compliance implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        //  Debug_Compliance__c dc=new Debug_Compliance__c();
        //  dc.Start_message__c='hitting the Email2Compliance';
        // insert dc;
        try{
            //    dc.Inside_Try_Block__c=true; 
            
            list<Compliance__c> ccop = new list<Compliance__c>();
            string autoMat = email.subject;
            // dc.subject__C=email.subject;
            string fromMail = email.fromAddress;
            //  dc.fromAddress__c=email.fromAddress;
            boolean mailcheck = false;
            boolean Out_of_Office = autoMat.containsIgnoreCase('Out of Office');
            boolean Away_from_Office = autoMat.containsIgnoreCase('Away from Office');
            boolean automated_reply = autoMat.containsIgnoreCase('automated reply');
            boolean auto_reply = autoMat.containsIgnoreCase('auto reply');
            boolean auto_responder = autoMat.containsIgnoreCase('auto responder');
            boolean automatic_reply = autoMat.containsIgnoreCase('automatic reply');
            mailcheck = fromMail.containsIgnoreCase('@monster'); //replaced from monster to foundit on 13-dec-2022
            //  dc.mailcheck__C=mailcheck;
            //  update dc;
            
            system.debug('Out_of_Office---->'+Out_of_Office);
            system.debug('Away_from_Office---->'+Away_from_Office);
            system.debug('automated reply---->'+automated_reply);
            system.debug('auto_reply---->'+auto_reply);
            system.debug('auto_responder---->'+auto_responder); 
            system.debug('automatic_reply---->'+automatic_reply);
            system.debug('mailcheck---->'+mailcheck);
            
            //mailcheck == false && 
            if(Out_of_Office == false && Away_from_Office == false && automated_reply == false && auto_reply == false && auto_responder == false && automatic_reply == false){
                
                system.debug('inside if----');
                //declaration section
                id compid; //compilance id
                id conid; // contact id
                id accid; //account id
                boolean conexist = false; //if already a customer
                list<EmailMessage> Lema = new list<EmailMessage>(); // for inserting emailmessages at once
                List<Attachment> BLa = new List<Attachment>(); // binary attachments
                List<Attachment> TLa = new List<Attachment>(); // text attachments
                
                boolean compfound = false; //if compilance already exists
                Group  g = new Group();
                g = [select Id from Group where  Type = 'Queue' AND DeveloperNAME = 'Compliance_Queue'];
                
                
                
                String Fmail = email.fromAddress; //sender email
                String Smail = email.subject;
                String Dmail=email.plainTextBody;
                // String InClass = string.valueOf(email.toAddresses);
                String InClass ;
                list<string> li = new list<string>(email.toAddresses);
                for(string l : li){
                    
                    InClass = l;
                }
                
                system.debug('Fmail---->'+Fmail);
                system.debug('Smail---->'+Smail);
                system.debug('InClass---->'+InClass);
                system.debug('Dmail---->'+Dmail);
                //if someone forwards the mail ignore FWD: etc
                String sub;
                if(Smail.containsIgnoreCase(': '))
                {
                    sub = Smail.substringAfter(': ');
                } 
                else 
                {
                    sub = Smail;
                }
                
                system.debug('sub---->'+sub);
                
                //Logic to find if any keyword Search 
                
                //String KeywordSerch = email.subject + email.plainTextBody;
                
                String s1 = email.plainTextBody;
                string s2 ;
                //string s3 = email.subject;
                if(s1!=null && s1.containsIgnoreCase('Thanks & Regards,'))
                {
                    s2 = s1.substringBefore('Thanks & Regards,');
                }
                If(s1!=null && s1.containsIgnoreCase('NOTICE: This message and any attachments contain(s)'))
                {
                    s2 = s1.substringBefore('NOTICE: This message and any attachments contain(s)');
                }
                
                System.debug('This is the string s2 ---->'+s2);
                //System.debug('This is the string s4 ---->'+s4);
                
                String KeywordSerch = email.subject + s2;
                boolean Kywordfind = false;
                List<Compliance__c> comp = [SELECT Id, Name, CreatedById, Subject__c, Description__c, Email__c, Received_To__c, 
                                            Status__c, IsKeyword__c, X1st_Contact_Resolution_SLA__c, X2nd_Escalation__c, Account__c, 
                                            Contact__c, Sub_Status__c, Priority__c, Category__c, Issue__c, Resolution_SLA_Hours__c, 
                                            Account_Id__c FROM Compliance__c WHERE Subject__c =:sub AND Email__c=:Fmail];
                
                system.debug('Compilenece size---->'+comp.size());
                
                List<Compliance_Keywords__c> ck = [SELECT id,name FROM Compliance_Keywords__c];
                system.debug('Compilenece keywordsize---->'+ck.size());
                
                If(string.isBlank(email.subject)&& string.isBlank(s2))
                {
                    Kywordfind = false;
                }
                
                for(Compliance_Keywords__c cck : ck)
                {
                    system.debug('Compilenece Keyword Name---->'+cck.name);
                    boolean x = false;
                    boolean y = false;
                    String s =  cck.name ;
                    Boolean b = s.containsWhitespace();
                    system.debug('multiple words-->'+b);
                    //for more than one word
                    if(b){
                        
                        string  first= s.substringBefore(' ');
                        string  second= s.substringAfter(' ');
                        
                        x = KeywordSerch.containsIgnoreCase(first);
                        y = KeywordSerch.containsIgnoreCase(second);
                        
                        system.debug('Originl-->'+s);
                        system.debug('first-->'+first);
                        system.debug('second-->'+second);
                        
                        system.debug('x-->'+x);
                        system.debug('y-->'+y);
                        
                        if(x == true && y == true){     //if both Keyword found make yeyword search true
                            system.debug('keyword found for more words');
                            Kywordfind = true;
                            break;
                        }
                        
                    }  
                    
                    else{ //else single word
                        
                        if(KeywordSerch.containsIgnoreCase(cck.name))
                        { 
                            system.debug('keyword found for single word'); 
                            Kywordfind = true; break;
                        }
                        /*If(string.isBlank(email.subject) && string.isNotBlank(s2) && s2.containsIgnoreCase(cck.name))
{
Kywordfind = true; break;
}
else If(string.isBlank(s2) && string.isNotBlank(s3) && s3.containsIgnoreCase(cck.name))
{
Kywordfind = true; break;
}*/
                    }
                } //Compliance_Keywords for loop close
                system.debug('Compilenece Kywordfind---->'+Kywordfind);
                //Account contact Compliance initialization
                
                account acc = new account();  
                RecordType AccRT = new RecordType();      
                AccRT = [SELECT id FROM RecordType WHERE sObjectType ='Account' AND name='Monster Active Account' LIMIT 1];
                // contact details
                list<contact> con = new List<contact>([SELECT id,name,email,accountid FROM contact WHERE email = :Fmail]);
                
                //Compliance details
                Compliance__c NewComp = new Compliance__c();
                if(comp.size()>0)
                    for(Compliance__c cco : comp)
                {
                    if(cco.Email__c == Fmail && cco.Subject__c == sub)
                    {
                        compid = cco.id;
                        if(cco.Status__c == 'Closed')
                        {
                            cco.Status__c = 'Reopen'; 
                            system.debug('cco.Status__c-->'+cco.Status__c); 
                            ccop.add(cco);
                        }
                        compfound = true;
                        break;
                    }  // if close
                }//Compliance__c for loop close
                update ccop;
                system.debug('reopen update---->'+ccop);   
                system.debug('boolean compfound---->'+compfound);
                
                if(compfound){ // map email with existing compilance record
                    
                    EmailMessage ema = new EmailMessage();
                    ema.FromAddress = email.fromAddress;
                    ema.FromName = email.fromName;
                    ema.TextBody=email.plainTextBody; //added to test
                    system.debug('this is textbody---------->'+ema.TextBody);
                    // ema.ToAddress = InClass;
                    for(String eta : email.toAddresses)
                    {
                        if(ema.ToAddress == null)
                        {
                            ema.ToAddress = eta;
                        }
                        else
                        {
                            ema.ToAddress = ema.ToAddress+'; '+eta;
                        }
                    }
                    if(email.ccAddresses != null)
                        for(String ecc : email.ccAddresses)
                    {
                        if(ema.CcAddress == null)
                        {
                            ema.CcAddress = ecc;
                        }
                        else
                        {
                            ema.CcAddress = ema.CcAddress+'; '+ecc;
                        }
                    }
                    
                    
                    ema.Status = '0';
                    //added by yam from 169 to 177
                    //ema.HtmlBody = email.htmlBody;
                    String v = ' ';
                    String  trucatedStr;
                    If(email.htmlBody != null)
                    {
                        v = email.htmlBody;
                        System.debug('This is my html body/////////////////////'+v);
                        trucatedStr = v.abbreviate(32000);
                        System.debug('I have cutted down the htmlbodyyyyyyyy'+trucatedStr);
                        
                        ema.HtmlBody=trucatedStr;
                        //      dc.HtmlBody__c=trucatedStr;
                    }
                    ema.TextBody = email.plainTextBody;
                    //  dc.plainTextBody__c=email.plainTextBody;
                    ema.Subject =  sub;   //email.subject;
                    ema.RelatedToId = compid;
                    ema.Compliance__c = compid;
                    insert ema;
                    //  lema.add(ema);
                    
                    /*  ----- Attachments  to Email Message ------ */
                    //binary attachments
                    if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
                        for(integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                            Attachment a = new Attachment();
                            a.Body = email.binaryAttachments[i].body;
                            a.Name = email.binaryAttachments[i].FileName;
                            a.ParentId = ema.id;
                            BLa.add(a);
                        }
                    } //if binary close
                    
                    
                    //text attachments close
                    
                    if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                        for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                            Attachment a = new Attachment();
                            a.Body = Blob.valueOf(email.textAttachments[i].body);
                            a.Name = email.textAttachments[i].FileName;
                            a.ParentId = ema.id;
                            TLa.add(a);
                        }
                    }//if text acttachments close   
                    
                    /*   ------ Mapping latest emailmessage ------ */
                    Compliance__c cop = [SELECT id,name,Email_Message_ID__c FROM Compliance__c WHERE id=:compid];
                    cop.Email_Message_ID__c = ema.id;
                    update cop;
                    system.debug('-------updated latest emailMessage id---'+cop);
                    
                    /*  ----- Attachments  to Compilance ------ */
                    
                    //binary attachments
                    if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
                        for(integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                            Attachment a = new Attachment();
                            a.Body = email.binaryAttachments[i].body;
                            a.Name = email.binaryAttachments[i].FileName;
                            a.ParentId = compid;
                            BLa.add(a);
                        }
                    } //if binary close
                    
                    
                    //text attachments close
                    
                    if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                        for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                            Attachment a = new Attachment();
                            a.Body = Blob.valueOf(email.textAttachments[i].body);
                            a.Name = email.textAttachments[i].FileName;
                            a.ParentId = compid;
                            TLa.add(a);
                        }
                    }//if text acttachments close   
                    
                    
                    
                    
                }//if compfound condition close
                
                
                else{ //create new account, contact if email is not found else create compilance & email Map it to account & contact related to it
                    
                    if(con.size()>0 || con !=NULL)
                        for(contact c : con){
                            
                            if(c.email == email.fromAddress)
                            {
                                conid = c.id;
                                accid = c.AccountId;
                                conexist = true;
                                break;
                            }// end conexist
                            
                        }//end contact for
                    
                    if(conexist)
                    { 
                        //contact exist = true
                        NewComp.Account__c = accid;
                        NewComp.Contact__c = conid;
                        NewComp.Status__c = 'New';
                        NewComp.Subject__c = sub;
                        //NewComp.Description__c = email.htmlBody;//added to test 
                        
                        If(email.htmlBody !=NULL)
                        {
                            String v1 = email.htmlBody;
                            System.debug('This is my html body/////////////////////'+v1);
                            String  trucatedStr1 = v1.abbreviate(32000);
                            System.debug('This is my truncated string------>'+trucatedStr1);
                            NewComp.Description__c=trucatedStr1;
                        }
                        
                        /*String v1 = ' ';
String  trucatedStr1;
v1 = email.htmlBody;
System.debug('This is my html body/////////////////////'+v1);
trucatedStr1 = v1.abbreviate(32000);
System.debug('I have cutted down the htmlbodyyyyyyyy'+trucatedStr1);
NewComp.Description__c = trucatedStr1;*/
                        NewComp.Email__c = email.fromAddress;
                        //--------------------check & proceed to addressssss -----------------------
                        //    NewComp.Received_To__c = InClass; 
                        
                        for(String eta : email.toAddresses)
                        {
                            if( NewComp.Received_To_String__c == null) 
                            {
                                NewComp.Received_To_String__c = eta;
                            }
                            else
                            { 
                                NewComp.Received_To_String__c =  NewComp.Received_To_String__c+'; '+eta;
                            }
                        }
                        
                        
                        if(Kywordfind == true || mailcheck == true)
                        {
                            system.debug('-- inside keyword1--'); 
                            NewComp.IsKeyword__c = true;
                        } 
                        NewComp.OwnerId = g.Id; 
                        NewComp.Priority__c = '3-Medium'; 
                        NewComp.Category__c = 'Compliance';
                        insert  NewComp;
                        system.debug('----newcomp with existing contact created------'+NewComp); 
                        
                        //binary attachments
                        if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) 
                        {
                            for(integer i = 0 ; i < email.binaryAttachments.size() ; i++)
                            {
                                Attachment a = new Attachment();
                                a.Body = email.binaryAttachments[i].body;
                                a.Name = email.binaryAttachments[i].FileName;
                                a.ParentId = NewComp.Id;
                                BLa.add(a);
                            }
                        } //if binary close
                        
                        
                        //text attachments close
                        if (email.textAttachments !=null && email.textAttachments.size() > 0) 
                        {
                            for(integer i = 0 ; i < email.textAttachments.size() ; i++)
                            {
                                Attachment a = new Attachment();
                                a.Body = Blob.valueOf(email.textAttachments[i].body);
                                a.Name = email.textAttachments[i].FileName;
                                a.ParentId = NewComp.Id;
                                TLa.add(a);
                            }
                        }//if text acttachments close
                        
                        
                    }
                    else 
                    { // conexist = false, i.e contact not exist logic
                        
                        contact ccon = new contact();
                        if( email.fromname == NULL)
                        {
                            string e222 = email.fromAddress;
                            System.debug('This is email from name ---->'+e222);
                            string e33 = e222.substringBefore('@');
                            System.debug('This is email from name ---->'+e33);
                            String Aname = e33;
                            System.debug('====> Aname '+  Aname); 
                            acc.Name = Aname.toUpperCase();
                            ccon.LastName = Aname.toUpperCase();
                        }
                        else{
                            string Aname1 =  email.fromname;
                            System.debug('====> Aname1 '+  Aname1);
                            acc.Name = Aname1.toUpperCase();
                            ccon.LastName = Aname1.toUpperCase();
                        }
                        //acc.name = email.fromName;
                        acc.RecordTypeId = AccRT.id;
                        acc.SalesChannel__c = 'IN-TS'; //changed from Telesales to IN-TS on 13-dec-2022
                        acc.Account_Size__c = 'Small Business';
                        acc.Lead_Source1__c = 'Other';
                        acc.Case_Accounts__c = true;
                        acc.Lead_Account_Status__c = 'InActive';
                        acc.Case_Accounts__c = true;
                        insert acc;
                        system.debug('---- new account created------'+acc);
                        
                        //contact ccon = new contact();
                        ccon.AccountId = acc.id;
                        //ccon.LastName = email.fromName;
                        ccon.email = email.fromAddress;
                        ccon.Case_Contact__c = true;                
                        insert ccon;
                        
                        acc.Lead_Account_Status__c = 'Active';
                        Update acc;
                        
                        system.debug('---- new contact created------'+ccon); 
                        
                        NewComp.Account__c = acc.id;
                        NewComp.Contact__c = ccon.id;
                        NewComp.Status__c = 'New';
                        NewComp.Subject__c = sub;
                        //NewComp.Description__c = email.htmlBody;
                        
                        If(email.htmlBody !=NULL)
                        {
                            String v3 = email.htmlBody;
                            System.debug('This is my html body/////////////////////'+v3);
                            String  truncatedbody1 = v3.abbreviate(32000);
                            System.debug('This is my truncated string------>'+truncatedbody1);
                            NewComp.Description__c=truncatedbody1;
                        }
                        
                        
                        /*String v3=' ';
v3=email.htmlBody;
string truncatedbody1 =v3.abbreviate(32000);

if(truncatedbody1 != NULL)
{
NewComp.Description__c = truncatedbody1;
}
else
{
NewComp.Description__c = ' ';
System.debug('this is empty body-->');
}*/
                        
                        NewComp.Email__c = email.fromAddress;
                        //--------------------check & proceed to addressssss -----------------------
                        
                        if(Kywordfind == true || mailcheck == true )
                        { 
                            system.debug('-- inside keyword2--'); 
                            NewComp.IsKeyword__c = true;
                        } 
                        //  NewComp.Received_To__c = InClass; 
                        for(String eta : email.toAddresses)
                        {
                            if( NewComp.Received_To_String__c == null)
                            {
                                NewComp.Received_To_String__c = eta;
                            }
                            else
                            { 
                                NewComp.Received_To_String__c =  NewComp.Received_To_String__c+'; '+eta;
                            }
                        }
                        NewComp.OwnerId = g.Id; 
                        NewComp.Priority__c = '3-Medium'; 
                        NewComp.Category__c = 'Compliance';
                        insert  NewComp;
                        //    dc.Compliance__c=NewComp.Id;
                        system.debug('----newcomp with new account & contact created------'+NewComp); 
                        
                        //binary attachments
                        if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
                            for(integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                                Attachment a = new Attachment();
                                a.Body = email.binaryAttachments[i].body;
                                a.Name = email.binaryAttachments[i].FileName;
                                a.ParentId = NewComp.Id;
                                BLa.add(a);
                            }
                        } //if binary close
                        
                        
                        //text attachments close
                        
                        if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                            for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                                Attachment a = new Attachment();
                                a.Body = Blob.valueOf(email.textAttachments[i].body);
                                a.Name = email.textAttachments[i].FileName;
                                a.ParentId = NewComp.Id;
                                TLa.add(a);
                            }
                        }//if text acttachments end
                        
                        
                    }// if conexist = false logic end  
                    
                    EmailMessage ema1 = new EmailMessage();
                    ema1.FromAddress = email.fromAddress;
                    ema1.FromName = email.fromName;
                    
                    for(String eta : email.toAddresses)
                    {
                        if(ema1.ToAddress == null)
                        {
                            ema1.ToAddress = eta;
                        }
                        else
                        {
                            ema1.ToAddress = ema1.ToAddress+'; '+eta;
                        }
                    }
                    if(email.ccAddresses != null)
                        for(String ecc : email.ccAddresses)
                    {
                        if(ema1.CcAddress == null)
                        {
                            ema1.CcAddress = ecc;
                        }
                        else
                        {
                            ema1.CcAddress = ema1.CcAddress+'; '+ecc;
                        }
                    }
                    
                    ema1.Status = '0';
                    //ema1.HtmlBody = email.htmlBody;
                    //added  by yam 
                    ema1.Subject = email.subject;
                    
                    If(email.htmlBody !=NULL)
                    {
                        String v1 = email.htmlBody;
                        System.debug('This is my html body/////////////////////'+v1);
                        String truncatedstr2 =v1.abbreviate(32000);
                        System.debug('This is my truncated string------>'+truncatedstr2);
                        ema1.HtmlBody=truncatedstr2;  
                    }
                    //till here 
                    ema1.TextBody = email.plainTextBody;
                    ema1.Subject = sub; // email.subject;
                    ema1.RelatedToId = NewComp.id;
                    ema1.Compliance__c = NewComp.id;
                    insert ema1;
                    
                    //binary attachments
                    
                    if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) {
                        for(integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                            Attachment a = new Attachment();
                            a.Body = email.binaryAttachments[i].body;
                            a.Name = email.binaryAttachments[i].FileName;
                            a.ParentId = ema1.Id;
                            BLa.add(a);
                        }
                    }
                    
                    
                    //text attachments
                    
                    if (email.textAttachments !=null && email.textAttachments.size() > 0) {
                        for(integer i = 0 ; i < email.textAttachments.size() ; i++){
                            Attachment a = new Attachment();
                            a.Body = Blob.valueOf(email.textAttachments[i].body);
                            a.Name = email.textAttachments[i].FileName;
                            a.ParentId = ema1.Id;
                            TLa.add(a);
                        }
                    }
                    
                    
                    system.debug('EmailMessage---->'+ema1);
                    NewComp.Email_Message_ID__c = ema1.id;
                    update NewComp;
                    system.debug('updatedddd Compilance---->'+NewComp);
                    
                    //  lema.add(ema1);
                    
                }//else compfound == false logic end
                // insert lema; 
                insert BLa;
                insert TLa; 
                //    update dc;
                
            }//auto responce if condition close
            return null;  
        }//method close
        catch(Exception e){
            //   dc.Inside_Catch_Block__c=true; 
            //   dc.Error_Cause__c=String.valueOf(e.getCause());
            //   dc.Error_LineNumber__c=String.valueOf(e.getLineNumber());
            //   dc.Error_Message__c=String.valueOf(e.getMessage());
            //   dc.Error_TypeName__c=String.valueOf(e.getTypeName());
            //  update dc;
            return null; }
        // dc.End_Message__c='End Message Successfully';
        // update dc;
    }
    
}//class close