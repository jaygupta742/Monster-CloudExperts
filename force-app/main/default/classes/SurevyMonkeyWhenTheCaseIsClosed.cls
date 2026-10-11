//@imYam, this survey should work only for Raj-Service Profile, Profile condition has been given in Process Builder (SurveyMonkey)
public class SurevyMonkeyWhenTheCaseIsClosed {
    
     @InvocableMethod(label='Send Link' description='If Case is closed send the mail')
     public static void insertEmail(List<id> CIds) 
     {
      met(CIds);
     }
    
     @future
      public static void met(List<id> CIds)
      {
         List<OrgWideEmailAddress> OWEA = [SELECT Address,DisplayName,Id FROM OrgWideEmailAddress WHERE Address='customerservice@monsterindia.com' OR Address='jobseeker@monsterindia.com'];
         system.debug('OrgWideEmailAddress---->'+OWEA);
         map<string,id> owmp = new map<string,id>();
         for(OrgWideEmailAddress o : OWEA)
         {
         owmp.put(o.Address,o.id);
         }
        set<id> cid = new set<id>();
        Map<string,id> mp = new Map<string,id>();
        Map<id,date> cmp = new Map<id,date>();
        Map<id,contact> contMp = new Map<id,contact>();
        set<contact> AScont = new set<contact>();
        set<case__c> coo = new set<case__c>();
          
        List<Messaging.SingleEmailMessage> multipleM = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage singleM = new Messaging.SingleEmailMessage();
     
        List<EmailTemplate > temp = new List<EmailTemplate >([SELECT id, name,Description  FROM EmailTemplate WHERE 
                                                                Description ='RajSurveyMonkeyEmployer']);
        System.debug('tmp size-->'+temp.size());
        for(EmailTemplate et : temp)
        { 
           mp.put(et.Description , et.id);
        }
     
      List<Case__c> case1 = new List<case__c>([SELECT id,status__c,contact__c,ownerid,SuppliedEmail__c,Keyword_Search__c,Category__c,contact__r.CSAT_Mail_Sent__c FROM case__c WHERE id=:CIds And contact__c !=NULL AND contact__r.CSAT_Mail_Sent__c = false]);
      for(case__c c1 : case1)
      {
          cid.add(c1.contact__C);
          System.debug('This is the conatct id ---->'+cid);
      }
      System.debug('I am coming inside contact------>');
      List<contact> con = new List<contact>([SELECT id,lastname,SurveyMonkeyDate__c,email,CSAT_Mail_Sent__c FROM contact WHERE id =:cid]);
      system.debug('con --->'+con); 
          
       System.debug('I am coming inside case------>'); 
       for(case__C cs : case1)
       {
           string ownr = cs.OwnerId;
           string ownr15 = ownr.substring(0,15);
           system.debug('ownr--->'+ownr);
           system.debug('ownr15--->'+ownr15);
           
           List<SurveyMonkey__c> ls = [SELECT id,name,UserID__c FROM SurveyMonkey__c WHERE UserID__c=:ownr15];
           system.debug('CustomValues--->'+ls);
           system.debug('size--->'+ls.size());
           
           string s1 = cs.SuppliedEmail__c;//yam@monsterindia.com for monster mails 
           string s2 = '@monster';
           Boolean b1 = s1.containsIgnoreCase(s2);
           System.debug('This is the bool value ----------->'+b1);
           boolean b2 = cs.Keyword_Search__c; // condition for catch all where keyword search is false.
           boolean b3 = cs.contact__r.CSAT_Mail_Sent__c;
            
           System.debug('This is the case status -->'+cs.Status__c);
           System.debug('This is the contact CSAT b3 ----->'+b3);
           System.debug('This is b1 ------->'+b1);
           System.debug('This is b2---------->'+b2);
           System.debug('This is i am gng to try if possible');
           try{ 
           if(cs.Status__c =='Closed' && b3==false && b1==false && b2==true)
           {
               
               System.debug('I tried and its possible----->');
               System.debug('This is the mail i am sending');
               System.debug('Oops... Category is not matching -->'+cs.Category__c);
               If(cs.Category__c == 'Employer')
               {
               System.debug('This is the category matching------>'+cs.Category__c);
               singleM.setTemplateId(mp.get('RajSurveyMonkeyEmployer'));
               singleM.setTargetObjectId(cs.Contact__c);
               System.debug('This is the target object id ------->'+cs.Contact__c);
               singleM.setSaveAsActivity(true);
               SingleM.setOrgWideEmailAddressId(owmp.get('customerservice@monsterindia.com'));
               multipleM.add(singleM);
               system.debug('if employeer added------'+multipleM);
               }
           }
           }
           catch(exception e)
           {
               
           }
        
      }
      for(contact aa : con)
         {
          cmp.put(aa.id,aa.SurveyMonkeyDate__c);
          contMp.put(aa.id,aa);
          aa.SurveyMonkeyDate__c = system.today();
          aa.CSAT_Mail_Sent__c = true;
          System.debug('This is the csat mail after sending the mailm--->'+aa.CSAT_Mail_Sent__c);
          AScont.add(aa);
         
         }
  
          
     List<emailmessage> emess = new  List<emailmessage>([SELECT id,Subject,Status FROM emailmessage WHERE Subject ='Email: Your Feedback on Monster Customer Service!']);
       system.debug('emailmessage before delete----->'+emess);
        
       Messaging.sendEmail(new Messaging.Email[] { SingleM });
       delete emess;
        
       system.debug('emailmessage after delete----->'+emess);
        
      List<contact> Acont = new List<contact>(AScont);
       update Acont;
    
      System.debug('This is the contact to update---->'+Acont);
       system.debug('Acont --->'+Acont);
        
       
      }
}