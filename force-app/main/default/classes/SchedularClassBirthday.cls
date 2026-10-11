public class SchedularClassBirthday implements System.Schedulable{
    public void execute(System.schedulableContext sc){
                SendEmail();
                SendEmail1();
    
   }
    
          Public  Void SendEmail(){
        list<contact> con=[SELECT id,Name,Email,Anniversary__c,AnniversaryToday__c,BirthdayToday__c,Birthdate From Contact Where BirthdayToday__c = Today ];
        list<Messaging.SingleEmailMessage> mails = new list<Messaging.SingleEmailMessage>();
        if(con.size() >0){
            for(contact c:con)  {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(New String[]{c.Email});
               
      //  mail.setSenderDisplayName();
        mail.setSubject('Best wishes for a bright future and a Very Happy Birthday !!');
        mail.setHtmlbody('<b><i>Dear '+ c.Name+' , <br /><br /><div style="margin:0px 200px 0px 0px;">  May this birthday bring happiness, joy and loads of success. May you achieve all your ambitions. A very Happy Birthday.Forget about the past and hope for the best for we all believe this birthday will bring all the success you deserve in your life and you will again grow in your professional career. Have a fantastic birthday filled with love and surprises.</div><br /><br/><image URL="https://c.ap5.content.force.com/servlet/servlet.FileDownload?file=0157F000000lhef" alt="Birthday Image"></image></i></b>');
       
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            }                                                                                    
          } 
    } 
    
     Public  Void SendEmail1(){
        list<contact> con=[SELECT id,Name,Email,Anniversary__c,AnniversaryToday__c,BirthdayToday__c,Birthdate From Contact Where AnniversaryToday__c = Today ];
        list<Messaging.SingleEmailMessage> mails = new list<Messaging.SingleEmailMessage>();
        if(con.size() >0){
            for(contact c:con)  {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(New String[]{c.Email});
               
      //  mail.setSenderDisplayName();
        mail.setSubject('Best wishes for a bright future and a Very Happy Anniversary !!');
        mail.setHtmlbody('<b><i>Dear '+ c.Name+' , <br /><br /><div style="margin:0px 200px 0px 0px;">  May this Anniversary bring happiness, joy and loads of success. May you achieve all your ambitions. A very Happy Anniversary.Forget about the past and hope for the best for we all believe this Anniversary will bring all the success you deserve in your life and you will again grow in your professional career. Have a fantastic Anniversary filled with love and surprises.</div><br /><br/></i></b>');
       
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            }                                                                                    
          }
    } 
    
}