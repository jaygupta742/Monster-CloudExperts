@IStest
public class EditAllAttachementsCTRL_TEST {
    @istest
    public static void testdata(){
       // try{  
            List<Trigger__c> cs= new List<Trigger__c>();
            
            Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
            cs.add(t);
            Trigger__c tk = new Trigger__c(name ='Quote',Active__c = true);
            cs.add(tk);
            Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
            cs.add(t1);
            Trigger__c t1k = new Trigger__c(name ='Opportunity',Active__c = true);
            cs.add(t1k);
            
            Trigger__c t2k = new Trigger__c(name ='Order',Active__c = true);
            cs.add(t2k);
            
            Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
            cs.add(t2);
            trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
            cs.add(t3);
            Trigger__c t4 = new Trigger__c(name ='Case',Active__c = true);
            cs.add(t4);
            insert cs;  
            
            List<Account> acclist=new List<Account>();
            Account a = new Account();
            a.Name = 'ANUP ENTERPRISE INDIA LTD';
            a.SalesChannel__c = 'Enterprise Business';
            a.Segment__c='ECOMM';
            a.Import_Source__c='sssss';
            a.Lead_Source1__c='Other';
            a.APAC_Industry__c='Energy';
            a.No_of_Employees__c= 25;
            a.Account_Type__c='NIT';
            a.Location__c='India';
            a.Website='www.asdfert.com';
            a.Phone= '+917878787878';
            a.RegistrationNumber__c='asq111111';
            a.Lead_Account_Status__c='Inactive';
            a.CreditStatus__c='OK';
            a.BillingCountry='India' ; 
            a.BillingState='Karnataka';
            a.BillingStreet ='Test Address';
            a.BillingCity ='bangalore' ;
            a.BillingPostalCode='560076';
            a.ShippingCountry='India';
            a.ShippingCity='Test';
            a.ShippingPostalCode='56000';
            a.ShippingState ='Test Address';
            a.ShippingStreet='Jssttts';
            acclist.add(a);
            insert acclist;
            
            Contact c = new Contact();
            c.AccountID= a.Id;
            c.LastName='MahendraBaahubali';
            c.Email='mbahu@gmail.com';
            c.Phone='9898989898';
            c.PrimarySalesContact__c=true;
            insert c;
            
            Opportunity__c o = new Opportunity__c();
            o.Account__c=a.id;
            o.Close_Date__c=System.today();
            o.OpportunityType__c='Renewal';
            o.Stage__c='Proposal Sent';
            insert o;
            
            QuotesN__C  q=new QuotesN__C ();
            q.Account__c=a.id;
            q.Contact__c=c.id;
            q.CurrencyIsoCode='INR';
            q.Approval_Status_Overall__c = 'Pending';
            insert q;
            
            List<Attachment> attli=new List<Attachment>();
            Attachment att=new Attachment();
            att.Name='GGGG';
            att.Body=Blob.valueOf('hhh');
        att.ParentId=q.Id;
            attli.add(att);
            insert attli;
            
            list<string> exceptionid = new list<string>();
            list<string> liststring = new list<string>();
            list<ContentVersion> cvlist=new list<ContentVersion>();
            ContentVersion cv=new Contentversion();
            cv.title='ABC';
            cv.PathOnClient = 'test';
            cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachme'); 
            cvlist.add(cv);
            
            ContentVersion cv1=new Contentversion();
            cv1.title='ABC';
            cv1.PathOnClient = 'test';
            cv1.VersionData = EncodingUtil.base64Decode('Unit Test Attachme'); 
            cv1.FirstPublishLocationId = q.Id;
            cvlist.add(cv1);
            
            insert cvlist;
            liststring.add(cv.Id);
            liststring.add(cv1.Id); 
            
            EditAllAttachementsCTRL.getstatus(q.Id);
            EditAllAttachementsCTRL.get_Attachements(q.id); 
                        EditAllAttachementsCTRL.get_Attachements1(q.id); 
        EditAllAttachementsCTRL.lineItemDel(q.id,q.id);
            EditAllAttachementsCTRL.onsave(q.Id,liststring); 

            EditAllAttachementsCTRL.onsave1(q.Id,attli,liststring); 
            EditAllAttachementsCTRL.onsave1(q.id,attli,exceptionid);
      /*  }
        catch(exception e){
            
        }*/
        
    }
}