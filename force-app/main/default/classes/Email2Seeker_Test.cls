@isTest
public class Email2Seeker_Test {
    
    public static testMethod void TestinBoundEmail(){
        
        list<SeekerEmails__c> se = new list<SeekerEmails__c>();
        SeekerEmails__c s = new SeekerEmails__c(name = 'jobseeker@monsterindia.com');
        se.add(s);
        insert se;
        
                List<Trigger__c> lstTriggerSettings = new List<Trigger__c>();
        
        Trigger__c Account = new Trigger__c(name ='SeekerBusinessHours',Active__c = true);
        lstTriggerSettings.add(Account);
        insert lstTriggerSettings;
          
        List<Seeker_Keywords__c> ck = new List<Seeker_Keywords__c>();
       
  /*     Seeker_Keywords__c ck1 = new Seeker_Keywords__c();
        ck1.Name = 'Test';
       ck.add(ck1);*/
       
       Seeker_Keywords__c ck2 = new Seeker_Keywords__c();
        ck2.Name = 'Mail Send';
       ck.add(ck2);
        
        Seeker_Keywords__c ck3 = new Seeker_Keywords__c();
        ck3.Name = 'send mons sample';
       ck.add(ck3);
        
         Seeker_Keywords__c ck1 = new Seeker_Keywords__c();
        ck1.Name = 'Test';
       ck.add(ck1);
       
        insert ck;      
       
       system.debug('ckk--->'+ck);
       
       
        List<Trigger__c> tt = new List<Trigger__c>();
       
        Trigger__c t = new Trigger__c(name = 'Seeker',active__c = true);
        tt.add(t);
       
        Trigger__c t1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        tt.add(t1);
       
       Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
        tt.add(t2);
       
       Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
        tt.add(t3);
        
        Trigger__c t4 = new Trigger__c(name = 'Attachment',active__c = true);
        tt.add(t4);
       
       insert tt;
        
        SeekerEmails__c sek = new SeekerEmails__c(name = 'same@same.com');
       insert sek;
       
       Seeker_Escalation__c  ce = new Seeker_Escalation__c();
        ce.Name = '1stescalation';
        ce.UID__c = '0057F000003RvIZ';
        ce.Email__c = 'email@gmail.com';
        insert ce;
       
         Account a = new Account();
         a.Name = 'ANKSkkkakka';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source1__c='CR';
        a.Segment__c = 'ECOMM';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Case_Accounts__c = true;
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.BillingStreet='street1';
        a.BillingCity='city1';
        a.BillCountry__c='INDIA';
        a.BillingState='State1';
        a.ShippingStreet='street2';
        a.ShippingCity='cty2';
        a.ShippingState='state2';
        a.ShippingPostalCode='5600182';
        a.BillingPostalCode='5600892';
        a.ShippingCountry='INDIA';
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='someaddress@email.com';
        c.Phone='9999988888';
        c.Case_Contact__c = true;
        c.PrimarySalesContact__c=true;
        insert c;
        
       
       
        
        
   // create a new email and envelope object
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      email.subject = ': Create Test Contact';
      email.fromname = 'Holla';
      email.toAddresses = New String[]{'som@tng.com'};  
      email.ccAddresses = New String[]{'som@tnggg.com'};    
      envelope.fromAddress = 'someaddress@email.com';
      email.fromAddress = 'someaddress@email.com';  
      email.plainTextBody = 'email body\n2225256325\nTitle';
       email.htmlBody='bdhbhbhs';
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
      
      
  
      // add an Text atatchment
  
      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
      
          //2nd message
           // create a new email and envelope object
       Messaging.InboundEmail emaill = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelopel = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      emaill.subject = ': Create Test Contact';
      emaill.fromname = 'Holla';
      emaill.toAddresses = New String[]{'some@tng.com','tng@sme.vgd'};  
      emaill.ccAddresses = New String[]{'some@tnggg.com', 'tnge@sme.vgde'};    
      envelopel.fromAddress = 'someaddressss@email.com';
      emaill.fromAddress = 'someaddresssss@email.com';  
      emaill.plainTextBody = 'email bodyyy\n2225256325\nTitle';
      emaill.htmlBody='bdhbhbhs';
          
      
      // call the email service class and test it with the data in the testMethod
      Email2Seeker  testInbound=new Email2Seeker();
      testInbound.handleInboundEmail(email, envelope);
        
        
     list<Seeker__c> cas = new list<Seeker__c>();
        cas = [SELECT id,Subject__c,Email__c FROM Seeker__c];
      //  for(case__c c : cas){ system.debug('ccccccccccc'+c.Subject__c);}
        system.debug('ccccccccccc'+cas);   
      
   
          //2nd time   
        
   // create a new email and envelope object
       Messaging.InboundEmail email1 = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope1 = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      email1.subject = ': Create Contact Mail Send';
     // email1.subject = ': Create Test Contact to Compilance';
      email1.fromname = 'Hollaaa';
      email1.toAddresses = New String[]{'som@tng.com','tng@sme.vgd'};  
      email1.ccAddresses = New String[]{'som@tnggg.com','tgng@sme.vgd'};    
      envelope1.fromAddress = 'someemailaddress@email.com';
      email1.fromAddress = 'someemailaddress@email.com';   
      email1.plainTextBody = 'email body\n2225256325\nTitle';
      email1.htmlBody='vgftdrfddsdsxfgghuhuhuhuhygfgtghuhu';
       
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment1 = new Messaging.InboundEmail.BinaryAttachment();
      attachment1.body = blob.valueOf('my attachment text');
      attachment1.fileName = 'textfileone.txt';
      attachment1.mimeTypeSubType = 'text/plain';
      email1.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment1 };
      
      
  
      // add an Text atatchment
  
      Messaging.InboundEmail.TextAttachment attachmenttext1 = new Messaging.InboundEmail.TextAttachment();
      attachmenttext1.body = 'my attachment text';
      attachmenttext1.fileName = 'textfiletwo3.txt';
      attachmenttext1.mimeTypeSubType = 'texttwo/plain';
      email1.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext1 };
          
       delete c; //delete contact
          
          
      
      // call the email service class and test it with the data in the testMethod
      Email2Seeker  testInbound1=new Email2Seeker();
        
      testInbound1.handleInboundEmail(email1, envelope1);
        
        list<Seeker__c> cas1 = new list<Seeker__c>();
        cas1 = [SELECT id,Subject__c,Email__c FROM Seeker__c];
      //  for(case__c c : cas){ system.debug('ccccccccccc'+c.Subject__c);}
        system.debug('cas111'+cas1);   
       
       
         //3rd time   
        
   // create a new email and envelope object
       Messaging.InboundEmail email11 = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope11 = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      email11.subject = ': Create Contact Mail Send';
     // email11.subject = ': Create Test Contact to Compilance';
      email11.fromname = 'Hollaaa';
      email11.toAddresses = New String[]{'som@tng.com','tng@sme.vgd'};  
      email11.ccAddresses = New String[]{'som@tnggg.com','tng@sme.vgd'};    
      envelope11.fromAddress = 'someemailaddress@email.com';
      email11.fromAddress = 'someemailaddress@email.com';   
      email11.plainTextBody = 'email body\n2225256325\nTitle';
      email11.htmlBody='ftfggvg';      
       
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment11 = new Messaging.InboundEmail.BinaryAttachment();
      attachment11.body = blob.valueOf('my attachment text');
      attachment11.fileName = 'textfileone.txt';
      attachment11.mimeTypeSubType = 'text/plain';
      email11.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment11 };
      
      
  
      // add an Text atatchment
  
      Messaging.InboundEmail.TextAttachment attachmenttext11 = new Messaging.InboundEmail.TextAttachment();
      attachmenttext11.body = 'my attachment text';
      attachmenttext11.fileName = 'textfiletwo3.txt';
      attachmenttext11.mimeTypeSubType = 'texttwo/plain';
      email11.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext11 };
               
      
      // call the email service class and test it with the data in the testMethod
      Email2Seeker  testInbound11=new Email2Seeker();
        
      testInbound11.handleInboundEmail(email11, envelope11);
        
        
        //4th time
            
        
   // create a new email and envelope object
       Messaging.InboundEmail email111 = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope111 = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      email111.subject = 'Re: Create Contact Mail Send';
     // email11.subject = ': Create Test Contact to Compilance';
      email111.fromname = 'Hollaaa';
      email111.toAddresses = New String[]{'som@tng.com','tng@sme.vgd'};  
      email111.ccAddresses = New String[]{'som@tnggg.com','dfg@jk.oi'};    
      envelope111.fromAddress = 'someemailaddress@email.com';
      email111.fromAddress = 'someemailaddress@email.com';   
      email111.plainTextBody = 'email body\n2225256325\nTitle';
      email111.htmlBody='bdhbhbhs';
       
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment111 = new Messaging.InboundEmail.BinaryAttachment();
      attachment111.body = blob.valueOf('my attachment text');
      attachment111.fileName = 'textfileone.txt';
      attachment111.mimeTypeSubType = 'text/plain';
      email111.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment11 };
      
      
  
      // add an Text atatchment
  
      Messaging.InboundEmail.TextAttachment attachmenttext111 = new Messaging.InboundEmail.TextAttachment();
      attachmenttext111.body = 'my attachment text';
      attachmenttext111.fileName = 'textfiletwo3.txt';
      attachmenttext111.mimeTypeSubType = 'texttwo/plain';
      email111.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext11 };
               
      
      // call the email service class and test it with the data in the testMethod
      Email2Seeker  testInbound111=new Email2Seeker();
        
      testInbound11.handleInboundEmail(email111, envelope111);
        
     //5th time   
              
   // create a new email and envelope object
       Messaging.InboundEmail email1111 = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope1111 = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      email1111.subject = 'Re: New Case Test';
     // email11.subject = ': Create Test Contact to Compilance';
      //email1111.fromname ;
      email1111.toAddresses = New String[]{'same@same.com'};  
      email1111.ccAddresses = New String[]{'same@same.com'};    
      envelope1111.fromAddress = 'same@same.com';
      email1111.fromAddress = 'same@same.com';   
      email1111.plainTextBody = 'email body\n2225256325\nTitle';
      email1111.htmlBody='xbhsbhjbd';
       
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment1111 = new Messaging.InboundEmail.BinaryAttachment();
      attachment1111.body = blob.valueOf('my attachment text');
      attachment1111.fileName = 'textfileone.txt';
      attachment1111.mimeTypeSubType = 'text/plain';
      email1111.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment1111 };
      
      
  
      // add an Text atatchment
  
      Messaging.InboundEmail.TextAttachment attachmenttext1111 = new Messaging.InboundEmail.TextAttachment();
      attachmenttext1111.body = 'my attachment text';
      attachmenttext1111.fileName = 'textfiletwo3.txt';
      attachmenttext1111.mimeTypeSubType = 'texttwo/plain';
      email1111.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext1111 };
               
      
      // call the email service class and test it with the data in the testMethod
      Email2Seeker  testInbound1111=new Email2Seeker();
        
      testInbound11.handleInboundEmail(email1111, envelope1111);
      
        
        
    }

}