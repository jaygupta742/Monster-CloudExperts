@isTest
public class EmailToCase_test {
    
    static testMethod void TestinBoundEmail(){
        
         List<Trigger__c> tt = new List<Trigger__c>();
        
       Trigger__c t1 = new Trigger__c(name = 'EmailMessage',active__c = true);
        tt.add(t1); 
       
       Trigger__c t2 = new Trigger__c(name = 'Account',active__c = true);
        tt.add(t2);
       
       Trigger__c t3 = new Trigger__c(name = 'Contact',active__c = true);
        tt.add(t3);
        
        Trigger__c t4 = new Trigger__c(name = 'Case',active__c = true);
        tt.add(t4);
        
        Trigger__c t5 = new Trigger__c(name = 'Attachment',active__c = true);
        tt.add(t5);
       
       insert tt;
        
        Case_Escalation__c ce = new Case_Escalation__c();
        ce.Name = '1stescalation';
        ce.UID__c = '0057F000003Sa4T';
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

        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='some@email.com';
        c.Phone='9999988888';
        c.PrimarySalesContact__c=true;
        insert c;
        
          List<Case_Keywords__c> cck = new List<Case_Keywords__c>();
        
        Case_Keywords__c ck = new Case_Keywords__c();
        ck.Name = 'Test';
        cck.add(ck);
        
        Case_Keywords__c ck1 = new Case_Keywords__c();
        ck1.Name = 'Body Sub';
        cck.add(ck1);
        
        insert cck;        
       
        
        
   // create a new email and envelope object
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       // setup the data for the email
      email.subject = ': Create Test Contact';
      email.fromname = 'Holla';
      email.toAddresses = New String[]{'som@tng.com','seet@ram.com'};  
      email.ccAddresses = New String[]{'som@tnggg.com','sommmm@tnggg.com'};    
      envelope.fromAddress = 'someaddress@email.com';
      email.fromAddress = 'someaddress@email.com';  
      email.plainTextBody = 'email body\n2225256325\nTitle';
  
       
    
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
      email.htmlBody = 'faasdasdad';
      
      // call the email service class and test it with the data in the testMethod
      EmailToCase  testInbound=new EmailToCase ();
       
      testInbound.handleInboundEmail(email, envelope);
        
        
     list<case__c> cas = new list<case__c>();
        cas = [SELECT id,Subject__c,SuppliedEmail__c FROM case__c];
      //  for(case__c c : cas){ system.debug('ccccccccccc'+c.Subject__c);}
        system.debug('ccccccccccc'+cas);   
      
      //2nd time   
        
   // create a new email and envelope object
       Messaging.InboundEmail email1 = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope1 = new Messaging.InboundEnvelope();
       
       // setup the data for the email
     // email1.subject = ': Create Test Contact';
      email1.subject = ': Create Test Contact';
      email1.fromname = 'Holla';
      email1.toAddresses = New String[]{'som@tng.com','ter@dmg.com'};  
      email1.ccAddresses = New String[]{'som@tnggg.com','sommmm@tnggg.com'};      
      envelope1.fromAddress = 'someaddress@email.com';  
      email1.fromAddress = 'someaddress@email.com';   
     /* envelope1.fromAddress = 'some@email.com';  
      email1.fromAddress = 'some@email.com';  */  
      email1.plainTextBody = 'email body\n2225256325\nTitle';
      email1.htmlBody ='This is my mail body<td></td>';
        
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
      
      
      // call the email service class and test it with the data in the testMethod
      EmailToCase  testInbound1=new EmailToCase ();
        
      testInbound1.handleInboundEmail(email1, envelope1);
        
        
   /* list<case__c> cas1 = new list<case__c>();
        cas1 = [SELECT id,Subject__c,SuppliedEmail__c FROM case__c];
        system.debug('caaaaaaaaaaa'+cas);*/
    
 
        //3rd Round
         
        
   // create a new email and envelope object
       Messaging.InboundEmail email11 = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope11 = new Messaging.InboundEnvelope();
       
       // setup the data for the email
     // email1.subject = ': Create Test Contact';
      email11.subject = 'Create Contact Body Sub';
      email11.fromname = 'Holla';
      email11.toAddresses = New String[]{'som@tng.com'};  
      email11.ccAddresses = New String[]{'som@tnggg.com','sommmm@tnggg.com'};      
     /* envelope11.fromAddress = 'someaddress@email.com';  
      email11.fromAddress = 'someaddress@email.com';   */
      envelope11.fromAddress = 'some@email.com';  
      email11.fromAddress = 'some@email.com';    
      email11.plainTextBody = 'email body\n2225256325\nTitle';
      
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
      email11.htmlBody = 'sdfsdfsdf';
      
      // call the email service class and test it with the data in the testMethod
      EmailToCase  testInbound11=new EmailToCase ();
        
      testInbound11.handleInboundEmail(email11, envelope11);
        
    
   }

}