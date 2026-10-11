public class CRTracker {

public string rec{get;set;}
//public string rec1{get;set;}

public string Lapsed {get;set;}
//public string Lapsed1{get;set;}

public string days90{get;set;}
//public string days901{get;set;}

public string Complaints{get;set;}
//public string Complaints1{get;set;}

public string Quarter{get;set;}
//public string Quarter1{get;set;}

Public string LowusageaccountsTracker{get;set;}

public CR_Tracker__c crt{get;set;}
public id rtid {get;set;}

    public CRTracker(ApexPages.StandardController controller) {
     crt = new CR_Tracker__c();
    
    this.crt = (CR_Tracker__c )controller.getRecord();
    
    system.debug('crt-->'+this.crt);
    
    rtid =  this.crt.RecordTypeId;
    
     system.debug('rtid -->'+rtid);

    
      rec = Schema.SObjectType.CR_Tracker__c.getRecordTypeInfosByName().get('General').getRecordTypeId();
     // rec1 = rec.substring(0,15);
      system.debug('rec1 --->'+rec );
      
      Lapsed = Schema.SObjectType.CR_Tracker__c.getRecordTypeInfosByName().get('Lapsed Accounts').getRecordTypeId();
    //  Lapsed1 = rec.substring(0,15);
      system.debug('Lapsed1 --->'+Lapsed );
      
      
       days90 = Schema.SObjectType.CR_Tracker__c.getRecordTypeInfosByName().get('90 Days').getRecordTypeId();
      //  days901 = rec.substring(0,15);
        system.debug('90 days--->'+days90 );
     
      
       Complaints = Schema.SObjectType.CR_Tracker__c.getRecordTypeInfosByName().get('Complaints').getRecordTypeId();
    //  Complaints1 = rec.substring(0,15);
       system.debug('Complaints1 --->'+Complaints );
       
       Quarter = Schema.SObjectType.CR_Tracker__c.getRecordTypeInfosByName().get('Quarter').getRecordTypeId();
    //  Quarter1 = rec.substring(0,15);
      system.debug('Quarter1 --->'+Quarter );
      
      LowusageaccountsTracker = Schema.SObjectType.CR_Tracker__c.getRecordTypeInfosByName().get('Low or Zero RDA Usage / Or No Login').getRecordTypeId();
      System.debug('Low usage accounts Tracker ----->'+LowusageaccountsTracker);
        
     if(rtid  == rec)
      crt.subject__c = 'Client\'s Monthly Feedback';
    if(rtid  == Lapsed)
      crt.subject__c = 'Reasons for not Renewing';
    if(rtid  == Quarter)
      crt.subject__c = 'Client\'s Feedback since Start Date';
    if(rtid  == days90)
      crt.subject__c = 'Client\'s Feedback after 90 days';
    if(rtid  == Complaints)
      crt.subject__c = 'Complaints by Customer'; 
    if(rtid == LowusageaccountsTracker)
        crt.Subject__c ='Low or Zero RDA Usage / Or No Login';
    }

}