public class SendBackEmail {
    
    public  void SendToUsers(string rid){
        
        QuotesN__c qq=[select id,name,Send_Back__c,ownerId,Send_Back_Reason__c,Send_Back_Reason_Text__c from QuotesN__c where id=:rid];
        id st=UserInfo.getUserId();
      User u= new User();
      u=[select id,name,email,User.Manager.Email,User.Manager.FirstName,User.Manager.LastName from user where id=:qq.OwnerId];
         String sendername = UserInfo.getname();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      
      List<String> cc= new List<String>();
      if(u.Manager.Email!=null){
       cc.add(u.Manager.Email);
      }
      cc.add(u.email);
        //cc.add('anupshaw54321@gmail.com');
     // mail.setCcAddresses(cc);
     String st1;
        
            if(qq.Send_Back_Reason_Text__c!='' || qq.Send_Back_Reason__c!=''){
                      System.debug('NUlllllll'+qq.Send_Back_Reason__c);
           //st1=ac.Sent_Back_Reason__c+ac.SentBackReasonText__c;
             st1=qq.Send_Back_Reason__c+qq.Send_Back_Reason_Text__c ;        
         // System.debug('STTTTTTTTT1'+st1);
                    }
                   if(qq.Send_Back_Reason_Text__c=='' || qq.Send_Back_Reason_Text__c==null){
                        st1=qq.Send_Back_Reason__c;
                   
                       System.debug('STTTTTTTTT1ELSE'+st1);  
                    } 
     
     
     
      
      mail.setToAddresses(cc);
      mail.setSubject('Proposal Rejection Notifications '+ qq.name);
      String ebody='Dear '+ u.name+' / ' +u.Manager.FirstName+' '+u.Manager.LastName +',<br/><br/>'
          +'Your quote has been reject for the following reason below.'+'<br/>'+
          st1+'<br/><br/>'
          +'Thanks And Regards,'+'<br/>'
          +sendername;
       mail.setHtmlBody(ebody);
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}