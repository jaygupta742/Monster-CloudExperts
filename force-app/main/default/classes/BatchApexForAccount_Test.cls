@istEst
public class BatchApexForAccount_Test {
    
      
    
    
    public static testMethod void TestPa(){
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
         Trigger__c trr = new Trigger__c(name ='Compliance',Active__c = true);
        insert trr;
        
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
        
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
        
        trigger__c t4 = new trigger__C(name='Opportunity',Active__c = true);
        insert t4;
        
        trigger__c t5 = new trigger__C(name='Quote',Active__c = true);
        insert t5;
        
        trigger__c t6 = new trigger__C(name='Order',Active__c = true);
        insert t6;
        LIst<Account> ac= new List<Account>();
        Account a = new Account();
        a.Name = 'ANKSkkkakka';
        a.OtherPhone__c='+919110400258';
        a.SalesChannel__c = 'ECOMM';
        a.Import_Source__c='sssss';
        a.Lead_Source__c='Other';
        a.APAC_Industry__c='Energy';
        a.No_of_Employees__c= 25;
        a.Account_Type__c='NIT';
        a.Location__c='India';
        a.Website='www.asdfert.com';
        a.Phone= '+917878787878';
        a.RegistrationNumber__c='asq111111';
        a.Lead_Account_Status__c='Inactive';
        a.CreditStatus__c='OK';
        a.ShippingCity='Bangalore';
        a.ShippingCountry='India';
        a.ShippingPostalCode='560000';
        a.ShippingState='Karnataka';
        a.ShippingStreet='BTM';
        a.BillingCity='Bangalore';
        a.BillingCountry='India';
        a.BillingPostalCode='560000';
        a.BillingPostalCode='Karnataka';
        a.BillingStreet='BTM';
        a.Segment__c='Corporate';
        a.Lead_Source1__c='CR';
  
        ac.add(a);
        insert ac; 
        
       /* Address1__c ad= new Address1__c();
        ad.City__c='Mahe';
        ad.State__c='Pondicherry';
        ad.Address1__c='hhhhhhhhhhh';
        ad.PinCode__c='456123';
        ad.type__C='Billing';
        ad.Address2__c='gggggggggggggg';
        insert ad; */
        
     LIst<Events__c> ev = new List<Events__c>();
        Events__c  e = new Events__c();
        //e.What_Account__c = ac[0].id;
        e.Priority__c = 'Normal';
        e.Assigned_To_C__c=userinfo.getuserid();
        ev.add(e);
         insert e;
   /* list<apttus_proposal_proposal__c> qq=new list<apttus_proposal_proposal__c>();
    apttus_proposal_proposal__c k=new apttus_proposal_proposal__c();
    k.N_external_ownerid__c=userinfo.getuserid();
    qq.add(k);
   insert qq;
        
        
         Opportunity__c o = new Opportunity__c();
        o.Account__c=a.id;
        o.Close_Date__c=System.today();
        o.OpportunityType__c='Trial';
        o.Stage__c='Rejected';
        insert o;*/
        
     //   Test.StartTest();
       BatchApexForAccount bp= new BatchApexForAccount();
        bp.last_record='';
      ID batchprocessid = Database.executeBatch(bp);
        
     BatchApexForAccount_task jj=new BatchApexForAccount_task ();
 ID batchprocessid1 = Database.executeBatch(jj);  
        BatchApexForAddress_delete jj1=new BatchApexForAddress_delete ();
 ID batchprocessid11 = Database.executeBatch(jj1);
       
    //  Test.StopTest();
    
  //  heapcheck  amma=new heapcheck();
   //  ID batchprocessid = Database.executeBatch(amma);
   //BatchApexForAccountaddressfile jio=new BatchApexForAccountaddressfile();
 //  ID batchprocessid = Database.executeBatch(jio);
 
 
 
 //BatchApexForQuote_owner jio=new BatchApexForQuote_owner();
 //ID batchprocessid = Database.executeBatch(jio);
   // BatchApexForopportunity_owner kk=new    BatchApexForopportunity_owner();
  //  ID batchprocessidyyy = Database.executeBatch(kk);
 // BatchApexForAddress_delete hh=new BatchApexForAddress_delete();
 // ID batchprocessidyyy = Database.executeBatch(hh);
 
//BatchApexForAccount_event_delete lop=new BatchApexForAccount_event_delete();
 // ID batchprocessidyyy = Database.executeBatch(lop);
 //BatchApexForAccount_segment_update jj=new BatchApexForAccount_segment_update();
 //ID batchprocessidyyy = Database.executeBatch(jj);
 
 //BatchApexForAccount_autonumber_update kl=new BatchApexForAccount_autonumber_update();
// kl.start_number=4;
// ID batchprocessidyyy = Database.executeBatch(kl);
    }
    
}