@istest
public class Schedularbirthdaytest{
public static testmethod void MethodTestOp(){
 Test.StartTest();
    SchedularClassBirthday scl = new SchedularClassBirthday();
 
 
 
 
 String sch = '0 0 21 * * ?'; 
 
 system.schedule('Test Territory Check', sch, scl);
    
     Contact con = new contact();
       con.LastName ='Test Test';
       con.Email ='Test@test.com';
       con.Birthdate =system.today();
       con.Anniversary__c =system.today();
       insert con;

       scl.SendEmail();
       scl.SendEmail1();
  Test.stopTest();
 
 }
    
  
    
}