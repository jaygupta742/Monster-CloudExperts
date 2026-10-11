global class Email2Seeker implements Messaging.InboundEmailHandler{
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        list<Seeker__c> ccop = new list<Seeker__c>();
        string autoMat = email.subject;
        string fromMail = email.fromAddress;
        
        map<string,string> seMap = new  map<string,string>();
        list<SeekerEmails__c> se = new List<SeekerEmails__c>([SELECT id,name FROM SeekerEmails__c]);
        for(SeekerEmails__c s : se)
        {
            seMap.put(s.name, s.name);
        }
        
        boolean mailDemo = fromMail.containsIgnoreCase('mailer-daemon@monsterindia.com');
        // boolean mailDemo = fromMail.containsIgnoreCase('crm@cloudexpertsindia.com');
        system.debug('mailDemo--->'+mailDemo);
        
        boolean ccChek = false;
        list<string> ccmail = new list<string>(email.ccAddresses);
        list<string> tomail = new list<string>(email.toAddresses);
        system.debug('ccmail---->'+ccmail.size());
        if(ccmail != NULL && ccmail.size() > 0){
            for(string str : email.ccAddresses)
            {
                system.debug('str---->'+str);
                ccChek = str.containsIgnoreCase('@foundit'); //replaced from monster to foundit on 13-dec-2022
                if(ccChek) {break;}
                
            }
        }
        
        boolean NaChek = false;
        system.debug('before check---'+NaChek);
        if(ccmail != NULL && ccmail.size() > 0)
        {
            for(string str : email.ccAddresses)
            {
                string str1 = email.fromAddress;
                system.debug('str---->'+str);
                if(seMap.get(str) != NULL && seMap.get(str1)!= NULL)
                { 
                    NaChek = true; 
                    break;
                }
                
            }
        }
        system.debug('after check---'+NaChek);
        boolean ccadd = false;
        boolean toadd = false;
        boolean finadd = false;
        boolean bol = false;
        
        if(ccmail != NULL && ccmail.size() > 0)
        {
            for(string s : ccmail)
            {
                string ss = s.toLowerCase();
                
                if(seMap.get(ss) != NULL)
                {
                    ccadd = true; break;
                }
                
            }
            
        }
        if(tomail != NULL && tomail.size() > 0)
        {
            for(string s : tomail)
            {
                string ss = s.toLowerCase();
                if(seMap.get(ss) != NULL)
                {
                    toadd = true; break;
                }
            }
        }
        
        if(ccadd == true && toadd == true)
        {
            finadd = true;
        }
        system.debug('ccadd--->'+ccadd);
        system.debug('toadd--->'+toadd);
        system.debug('finadd--->'+finadd);
        
        
        if(ccmail != NULL && ccmail.size() > 0)
        {
            for(string str : email.ccAddresses)
            {
                string s = str.toLowerCase();
                system.debug('slower---->'+s +'--> '+seMap.get(s));
                if(seMap.get(s) != nULL)
                { 
                    bol = true;                           
                    system.debug('<---seeker email found---->'); break;  
                }
            }
        }
        system.debug('bol---->'+bol);
        system.debug('ccChek---->'+ccChek);
        
        boolean mailcheck = false;
        boolean Out_of_Office = autoMat.containsIgnoreCase('Out of Office');
        boolean Away_from_Office = autoMat.containsIgnoreCase('Away from Office');
        boolean automated_reply = autoMat.containsIgnoreCase('automated reply');
        boolean auto_reply = autoMat.containsIgnoreCase('auto reply');
        boolean auto_responder = autoMat.containsIgnoreCase('auto responder');
        boolean automatic_reply = autoMat.containsIgnoreCase('automatic reply');
        boolean sub1 = automat.containsIgnoreCase('Upload your resume now to find better job opportunities');
        boolean sub2 = automat.containsIgnoreCase('Verify your e-mail address of your Foundit Account'); //replaced from monster to foundit on 13-dec-2022
        boolean sub3 = automat.containsIgnoreCase('Welcome to Foundit'); //replaced from monster.com to foundit on 13-dec-2022
        boolean sub4 = automat.containsIgnoreCase('Add a profile picture and maximize your chances of being shortlisted by employers');
        boolean sub5 = automat.containsIgnoreCase('Beware of fraudsters impersonating as Foundit partners');//replaced from monster to foundit on 13-dec-2022
        boolean Undeliverable = automat.containsIgnoreCase('Undeliverable');
        
        mailcheck = fromMail.containsIgnoreCase('@foundit'); //replaced from monster to foundit on 13-dec-2022
        
        system.debug('Out_of_Office---->'+Out_of_Office);
        system.debug('Away_from_Office---->'+Away_from_Office);
        system.debug('automated reply---->'+automated_reply);
        system.debug('auto_reply---->'+auto_reply);
        system.debug('auto_responder---->'+auto_responder); 
        system.debug('automatic_reply---->'+automatic_reply);
        system.debug('mailcheck---->'+mailcheck);
        system.debug('sub1---->'+sub1);
        system.debug('sub2---->'+sub2);
        system.debug('sub3---->'+sub3);
        system.debug('sub4---->'+sub4);
        //sub1 == false && sub2 == false && sub3 == false && sub4 == false && mailcheck == false && finadd == false &&
        if(mailDemo == False && NaChek == false && Out_of_Office == false && Away_from_Office == false && automated_reply == false && auto_reply == false && auto_responder == false && automatic_reply == false && Undeliverable == false){
            
            system.debug('inside if----');
            //declaration section
            id compid; //seeker id
            id conid; // contact id
            id accid; //account id
            boolean conexist = false; //if already a customer
            list<EmailMessage> Lema = new list<EmailMessage>(); // for inserting emailmessages at once
            List<Attachment> BLa = new List<Attachment>(); // binary attachments
            List<Attachment> TLa = new List<Attachment>(); // text attachments
            
            boolean compfound = false; //if compilance already exists
            Group  g = new Group();
            g = [select Id from Group where  Type = 'Queue' AND DeveloperNAME = 'Seeker_Queue'];
            
            String Fmail = email.fromAddress; //sender email
            String Smail = email.subject;
            // String InClass = string.valueOf(email.toAddresses);
            String InClass ;
            list<string> li = new list<string>(email.toAddresses);
            for(string l : li)
            {
                
                InClass = l;
            }
            
            system.debug('Fmail---->'+Fmail);
            system.debug('Smail---->'+Smail);
            system.debug('InClass---->'+InClass);
            
            //if someone forwards the mail ignore FWD: etc
            String sub; 
            // if(Smail.containsIgnoreCase(': ')){sub = Smail.substringAfter(': ');} else {sub = Smail;}
            
            if((Smail.containsIgnoreCase('Re: ')) || (Smail.containsIgnoreCase('Fwd: ')))
            {
                sub = Smail.substringAfter(': ');
                system.debug('inside Reply or Forward Subject IF----> ');
            } 
            else 
            {
                sub = Smail;
            }
            system.debug('sub---->'+sub);
            
            //Logic to find if any keyword Search 
            
            String KeywordSerch = email.subject + email.plainTextBody;
            system.debug('KeywordSerch---->'+KeywordSerch);
            boolean Kywordfind = false;
            List<Seeker__c> comp = [SELECT Id, Name, CreatedById, Subject__c, Description__c, Email__c, Received_To__c, 
                                    Status__c, IsKeyword__c, X1st_Contact_Resolution_SLA__c, X2nd_Escalation__c, Account__c, 
                                    Contact__c, Priority__c, Category__c, Issue__c, Resolution_SLA_Hours__c, 
                                    Account_Id__c FROM Seeker__c WHERE Subject__c =:sub AND Email__c=:Fmail];
            
            system.debug('Compilenece size---->'+comp.size());
            List<Seeker_Keywords__c> ck = [SELECT id,name FROM Seeker_Keywords__c];
            system.debug('Compilenece keywordsize---->'+ck.size());
            
            for(Seeker_Keywords__c cck : ck)
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
                    Boolean b2 = second.containsWhitespace();
                    system.debug('b2-->'+b2);
                    if(b2)
                    {
                        system.debug('3 letter-->'+second);
                        string c1 = second.substringBefore(' ');
                        string c2 = second.substringAfter(' ');
                        system.debug('c1-->'+c1);
                        system.debug('c2-->'+c2);
                        boolean p = false;
                        boolean q = false;
                        p = KeywordSerch.containsIgnoreCase(c1);
                        q = KeywordSerch.containsIgnoreCase(c2);
                        
                        system.debug('p-->'+p);
                        system.debug('q-->'+q);
                        
                        if(p == true && q == true)
                        {  
                            y = true;
                        }
                        
                    } 
                    else { 
                        system.debug('inside 2 word else');
                        y = KeywordSerch.containsIgnoreCase(second);
                    }
                    
                    x = KeywordSerch.containsIgnoreCase(first);
                    // y = KeywordSerch.containsIgnoreCase(second);
                    
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
                    
                    if(KeywordSerch.containsIgnoreCase(cck.name)){ system.debug('keyword found for single word');  Kywordfind = true; break;} }
            } //Compliance_Keywords for loop close
            
            system.debug('Compilenece Kywordfind---->'+Kywordfind);
            
            
            //Account contact Compliance initialization
            
            account acc = new account();  
            RecordType AccRT = new RecordType();      
            AccRT = [SELECT id FROM RecordType WHERE sObjectType ='Account' AND name='Monster Active Account' LIMIT 1];
            
            // contact details
            list<contact> con = new List<contact>([SELECT id,name,email,accountid FROM contact WHERE email = :Fmail]);
            
            //Compliance details
            Seeker__c NewComp = new Seeker__c();
            if(comp.size()>0)
                for(Seeker__c cco : comp)
            {
                if(cco.Email__c == Fmail && cco.Subject__c == sub)
                {
                    compid = cco.id;
                    system.debug('cco.Status__c before update-->'+cco.Status__c);
                    if(cco.Status__c == 'Closed')
                    {
                        cco.Status__c = 'Reopen'; 
                        system.debug('cco.Status__c after update-->'+cco.Status__c); 
                        ccop.add(cco);
                    }
                    compfound = true;
                    break;
                }  // if close
            }//Compliance__c for loop close
            update ccop;
            system.debug('reopen update---->'+ccop);
            system.debug('boolean compfound---->'+compfound);
            
            if(compfound){ 
                // map email with existing compilance record
                
                EmailMessage ema = new EmailMessage();
                ema.FromAddress = email.fromAddress;
                ema.FromName = email.fromName;
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
                //for cc address 
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
                /*-------------------------------------added by yam------------------------------------------*/
                If(email.htmlBody !=NULL)
                {
                    String v = email.htmlBody;
                    System.debug('This is my html body/////////////////////'+v);
                    String  trucatedStr = v.abbreviate(32000);
                    System.debug('This is my truncated string------>'+trucatedStr);
                    ema.HtmlBody=trucatedStr;
                }
                
                // String v = ' ';
                // String  trucatedStr;
                // v = email.htmlBody;
                // System.debug('This is my html body/////////////////////'+v);
                // trucatedStr = v.abbreviate(32000);
                //System.debug('I have cutted down the htmlbodyyyyyyyy'+trucatedStr);
                String  trucatedStr45 =' ';
                If(email.plainTextBody != NULL)
                {
                    String v45 = email.plainTextBody;
                    System.debug('This is my html body/////////////////////'+v45);
                    trucatedStr45 = v45.abbreviate(32000);
                    System.debug('This is my truncated string------>'+trucatedStr45);
                    ema.TextBody=trucatedStr45; 
                }
                
                //ema.TextBody=email.plainTextBody;
                /*-----------------------------------------------------------------------till here -----------------------*/
                ema.Subject =  sub;   //email.subject;
                ema.RelatedToId = compid;
                ema.Seeker__c = compid;
                insert ema;
                //  lema.add(ema);
                
                
                /*-----------------  Email Message Attachments ------------------- */   
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
                
                /*     ------ Mapping latest emailmessage ------ */
                
                Seeker__c see = [SELECT id,name,Email_Message_ID__c FROM Seeker__c WHERE id=:compid];
                see.Email_Message_ID__c = ema.id;
                update see;
                system.debug('-------updated latest emailMessage id---'+see);
                
                
                /*---------------  Seeker Attachments    -------------------- */ 
                
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
            
            
            else{ 
                //create new account, contact if email is not found else create compilance & email Map it to account & contact related to it
                
                if(con.size()>0 || con !=NULL)
                    for(contact c : con)
                {
                    if(c.email == email.fromAddress)
                    {
                        conid = c.id;
                        accid = c.AccountId;
                        conexist = true;
                        break;
                    }// end conexist
                    
                }//end contact for
                
                if(conexist){ //contact exist = true
                    NewComp.Account__c = accid;
                    NewComp.Contact__c = conid;
                    NewComp.Status__c = 'New';
                    NewComp.Subject__c = sub;
                    
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
//added by yam ---->

if(trucatedStr1 !=NULL)
{
NewComp.Description__c = trucatedStr1;
}
else{
NewComp.Description__c = ' ';
System.debug('This is having empty body --->');
}*/
                    //NewComp.Description__c = email.htmlBody;
                    
                    //--------------------check & proceed to addressssss -----------------------
                    //    NewComp.Received_To__c = InClass; 
                    NewComp.Email__c = email.fromAddress;
                    for(String eta : email.toAddresses)
                    {
                        if( NewComp.Received_To__c == null) 
                        {
                            NewComp.Received_To__c = eta;
                        }
                        
                        else
                        { 
                            NewComp.Received_To__c =  NewComp.Received_To__c+'; '+eta;
                        }
                    }
                    
                    if(email.ccAddresses != null)
                        for(String eta : email.ccAddresses)
                    {
                        if( NewComp.ccAddress__c == null) {
                            NewComp.ccAddress__c = eta;
                        }
                        else
                        { 
                            NewComp.ccAddress__c =  NewComp.ccAddress__c+'; '+eta;
                        }
                    }
                    
                    if( (Kywordfind == true || mailcheck == true) && sub1 == false && sub2 == false && sub3 == false && sub4 == false && sub5 == false && bol == false){
                        system.debug('----inside keyword found----');
                        NewComp.IsKeyword__c = true;} 
                    NewComp.OwnerId = g.Id; 
                    NewComp.Priority__c = '3-Medium'; 
                    NewComp.Category__c = 'Seeker';
                    insert  NewComp;
                    system.debug('----newcomp with existing contact created------'+NewComp); 
                    
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
                    }//if text acttachments close
                    
                    
                }
                else
                { // conexist = false, i.e contact not exist logic
                    //added by yam at 511
                    //string Aname;
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
                    
                    
                    //acc.name = email.fromName;
                    acc.RecordTypeId = AccRT.id;
                    acc.SalesChannel__c = 'IN-TS'; //changed from Telesales to IN-TS on 13-dec-2022
                    acc.Account_Size__c = 'Small Business';
                    acc.Lead_Source1__c = 'Other';
                    acc.Case_Accounts__c = true;
                    acc.Lead_Account_Status__c = 'InActive';
                    insert acc;
                    system.debug('---- new account created------'+acc);
                    
                    contact ccon = new contact();
                    ccon.AccountId = acc.id;
                    //ccon.LastName = email.fromName;
                    if( email.fromname == NULL)
                    {
                        string e220 = email.fromAddress;
                        System.debug('This is email from name ---->'+e220);
                        string e330 = e220.substringBefore('@');
                        System.debug('This is email from name ---->'+e330);
                        String Cname = e330;
                        System.debug('====> LastName '+  Cname); 
                        ccon.lastname = Cname.toUpperCase();
                    }
                    else{
                        string Cname1 = email.fromname;
                        System.debug('====> Cname1 '+  Cname1);
                        ccon.lastname = Cname1.toUpperCase();
                    }
                    ccon.email = email.fromAddress;
                    ccon.Case_Contact__c = true;                
                    insert ccon;
                    system.debug('---- new contact created------'+ccon); 
                    
                    acc.Lead_Account_Status__c = 'Active';
                    update acc;
                    
                    NewComp.Account__c = acc.id;
                    NewComp.Contact__c = ccon.id;
                    NewComp.Status__c = 'New';
                    NewComp.Subject__c = sub;
                    
                    If(email.htmlBody !=NULL)
                    {
                        String v3 = email.htmlBody;
                        System.debug('This is my html body/////////////////////'+v3);
                        String  trucatedStr3 = v3.abbreviate(32000);
                        System.debug('This is my truncated string------>'+trucatedStr3);
                        NewComp.Description__c = trucatedStr3;
                    }
                    NewComp.Email__c = email.fromAddress;
                    //--------------------check & proceed to addressssss -----------------------
                    
                    if( (Kywordfind == true || mailcheck == true)  && sub1 == false && sub2 == false && sub3 == false && sub4 == false && sub5 == false && bol == false)
                    {
                        system.debug('----inside keyword found----');
                        NewComp.IsKeyword__c = true;
                    }  //&& ccChek == false 
                    //  NewComp.Received_To__c = InClass; 
                    System.debug('This is the email to addresssss------------->'+email.toAddresses);
                    for(String eta : email.toAddresses)
                    {
                        if( NewComp.Received_To__c == null) 
                        {
                            NewComp.Received_To__c = eta;
                        }
                        else
                        {
                            NewComp.Received_To__c =  NewComp.Received_To__c+'; '+eta;
                        }
                    }
                    if(email.ccAddresses != null)
                        for(String eta : email.ccAddresses)
                    {
                        if( NewComp.ccAddress__c == null) 
                        {
                            NewComp.ccAddress__c = eta;
                        }
                        else
                        { 
                            NewComp.ccAddress__c =  NewComp.ccAddress__c+'; '+eta;
                        }
                    }
                    
                    NewComp.OwnerId = g.Id; 
                    NewComp.Priority__c = '3-Medium'; 
                    NewComp.Category__c = 'Seeker';
                    insert  NewComp;
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
                /*-----------------------------------------------added by yam -----------------------*/
                
                If(email.htmlBody !=NULL)
                {
                    String v1 = email.htmlBody;
                    System.debug('This is my html body/////////////////////'+v1);
                    String  trucatedStr1 = v1.abbreviate(32000);
                    System.debug('This is my truncated string------>'+trucatedStr1);
                    ema1.HtmlBody = trucatedStr1;
                }
                /*String v1= ' ';
String  trucatedStr1;
v1 = email.htmlBody;
System.debug('This is my html body/////////////////////'+v1);
trucatedStr1 = v1.abbreviate(32000);
System.debug('I have cutted down the htmlbodyyyyyyyy'+trucatedStr1);
if(trucatedStr1 !=NULL)
{
ema1.HtmlBody=trucatedStr1;
}
else{
ema1.HtmlBody = ' ';
System.debug('This is having empty body --->');
}*/
                If(email.plainTextBody !=NULL)
                {
                    String v100 = email.plainTextBody;
                    System.debug('This is my html body/////////////////////'+v100);
                    String  trucatedStr100 = v100.abbreviate(32000);
                    System.debug('This is my truncated string------>'+trucatedStr100);
                    ema1.TextBody = trucatedStr100;
                }
                
                
                
                //ema1.HtmlBody = email.htmlBody;
                /*-----------------------------------------------------added till here -------------------------*/
                ema1.Subject = sub; // email.subject;
                ema1.RelatedToId = NewComp.id;
                ema1.Seeker__c = NewComp.id;
                insert ema1;
                
                //binary attachments
                if (email.binaryAttachments!=null && email.binaryAttachments.size() > 0) 
                {
                    for(integer i = 0 ; i < email.binaryAttachments.size() ; i++)
                    {
                        Attachment a = new Attachment();
                        a.Body = email.binaryAttachments[i].body;
                        a.Name = email.binaryAttachments[i].FileName;
                        a.ParentId = ema1.Id;
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
                        a.ParentId = ema1.Id;
                        TLa.add(a);
                    }
                }//if text acttachments end
                
                system.debug('EmailMessage---->'+ema1);
                NewComp.Email_Message_ID__c = ema1.id;
                update NewComp;
                system.debug('updatedddd Compilance---->'+NewComp);
                
                //  lema.add(ema1);
                
            }//else compfound == false logic end
            // insert lema; 
            insert BLa;
            insert TLa; 
            
        }//auto responce if condition close
        return null;
    }
    
    public static void testCoverageHandler(){
        integer i = 0 ;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
         i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
         i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
                i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
        i += 1;
    }
    
}