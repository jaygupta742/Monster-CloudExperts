@istest
public class contactBatchApex_Test {

    @istest
    static void TestPA(){
        List<contact> ac1= new List<contact>();
        List<testObject1__c> pt = new List<testObject1__c>();
          Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        
         Trigger__c t1 = new Trigger__c(name ='Attachment',Active__c = true);
        insert t1;
        
         Trigger__c t2 = new Trigger__c(name ='Contact',Active__c = true);
        insert t2;
         trigger__c t3 = new trigger__C(name='EmailMessage',Active__c = true);
        insert t3;
         testObject1__c ty = new testObject1__c();
        ty.Mobile__c = '9845973686';
        pt.add(ty);
        insert pt;
       
        contact a = new contact();
        a.LastName ='singh';
        a.Phone = '9867897689';
        a.Email='amt@gmail.com';
        a.MobilePhone = ty.Mobile__c;
         a.WorkPhoneExtension__c ='9567435687';
       
        a.MobilePhone_Mobile_Do_Not_Call_Registry__c =true;
        a.Phone_Mobile_Do_Not_Call__c=true;
         a.Mobile_Customer_Requested_Do__c = false;
        a.WorkPhone_Customer_Requested_Do_Not_Call__c = true;
        a.Phone_National_Do_Not_Call_Registry__c=true;
       
         ac1.add(a);
          insert ac1;
        list<contact> rty = new list<contact>();
        contact cony = new contact();
         cony.LastName ='sing';
        cony.Phone = '9867897789';
        cony.Email='amert@gmail.com';
        cony.MobilePhone = '9785678456';
         cony.WorkPhoneExtension__c ='9567435687';
       
        cony.MobilePhone_Mobile_Do_Not_Call_Registry__c =true;
        cony.Phone_Mobile_Do_Not_Call__c=true;
         cony.Mobile_Customer_Requested_Do__c = true;
        cony.WorkPhone_Customer_Requested_Do_Not_Call__c = true;
        cony.Phone_National_Do_Not_Call_Registry__c=true;
        rty.add(cony);
        insert rty;
        
        
        
       
        PA_Owner_Assignment__c p = new PA_Owner_Assignment__c();
        p.Name = '1';
        p.Location__c = 'India';
        p.Count__c = 0;
        p.UserId__c = '0057F000004RCwEQAW';
        insert p;
         Test.startTest();
        contactBatchApex bp= new contactBatchApex();
        DataBase.executeBatch(bp);
        Test.stopTest();
    }
}