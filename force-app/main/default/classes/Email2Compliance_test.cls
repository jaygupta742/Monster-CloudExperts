@isTest
public class Email2Compliance_test {
    public static testMethod void TestinBoundEmail11(){
        
        List<Compliance_Keywords__c> ck = new List<Compliance_Keywords__c>();
        
        Compliance_Keywords__c ck1 = new Compliance_Keywords__c();
        ck1.Name = 'Test';
        ck.add(ck1);
        
        Compliance_Keywords__c ck2 = new Compliance_Keywords__c();
        ck2.Name = 'Mail Send';
        ck.add(ck2);
        
        insert ck;      
        
        system.debug('ckk--->'+ck);
        
        
        List<Trigger__c> tt = new List<Trigger__c>();
        
        Trigger__c t = new Trigger__c(name = 'Compliance',active__c = true);
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
        
        
        Compliance_Escalation__c  ce = new Compliance_Escalation__c();
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
        a.BillingStreet='street1';
        a.BillingCity='city1';
        a.BillCountry__c='INDIA';
        a.BillingState='State1';
        a.ShippingStreet='street2';
        a.ShippingCity='cty2';
        a.ShippingState='state2';
        a.ShippingPostalCode='7890';
        a.BillingPostalCode='6789';
        a.ShippingCountry='INDIA';
        a.CreditStatus__c='OK';
        
        insert a;
        
        Contact c = new Contact();
        c.AccountID= a.Id;
        c.LastName='Testcontact';
        c.Email='someaddress@email.com';
        c.Phone='9999988888';
        c.Case_Contact__c = true;
        c.PrimarySalesContact__c=true;
        insert c;
        
        a.Lead_Account_Status__c='Active';
        update a;
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        // setup the data for the email
        email.subject = ': Create Test Contact';
        //email.fromname = 'Holla';
        email.toAddresses = New String[]{'som@tng.com'};  
            email.ccAddresses = New String[]{'som@tnggg.com'};    
                envelope.fromAddress = 'someaddress@email.com';
        email.fromAddress = 'someaddress@email.com';  
        email.plainTextBody = 'email body\n2225256325\nTitle';
        email.htmlBody ='abcdefghijklmn';
        test.starttest();
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
            
            
            
            Messaging.InboundEmail email1 = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope1 = new Messaging.InboundEnvelope();
        
        
        email1.subject = ': Create Contact Mail Send';
        email1.fromname = 'Hollaaa';
        email1.toAddresses = New String[]{'som@tng.com'};  
            email1.ccAddresses = New String[]{'som@tnggg.com'};
                envelope1.fromAddress = 'someemailaddress@email.com';
        email1.fromAddress = 'someemailaddress@email.com';   
        email1.plainTextBody = 'email body\n2225256325\nTitle';
        email1.htmlBody ='abcdefghijklmn';
        
        
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
            
            Email2Compliance  testInbound=new Email2Compliance ();
        testInbound.handleInboundEmail(email1, envelope1);
        delete c;
        
        Messaging.InboundEmail email11 = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope11 = new Messaging.InboundEnvelope();
        
        // setup the data for the email
        email11.subject = ': Create Contact Mail Send';
        // email11.subject = ': Create Test Contact to Compilance';
        email11.fromname = 'Hollaaa';
        email11.toAddresses = New String[]{'som@tng.com'};  
            email11.ccAddresses = New String[]{'som@tnggg.com'};    
                envelope11.fromAddress = 'someemailaddress@email.com';
        email11.fromAddress = 'someemailaddress@email.com';   
        email11.plainTextBody = 'email body\n2225256325\nTitle';
        email11.htmlBody ='abcdefghijklmn';
        
        
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
            Email2Compliance  testInbound1=new Email2Compliance ();
        testInbound1.handleInboundEmail(email11, envelope11);
        test.stoptest();
        
    }   
}