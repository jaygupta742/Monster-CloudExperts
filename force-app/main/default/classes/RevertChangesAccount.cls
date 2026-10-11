public class RevertChangesAccount {
    
   
    public void updatorStatus(){
         LIst<AccountHistory> ac= new LIst<AccountHistory>();
        LIst<Account> ac1= new LIst<Account>();
       LIst<Account> ac3= new LIst<Account>();
         LIst<Account> ac4= new LIst<Account>();
         LIst<Account> ac5= new LIst<Account>();
         LIst<Account> ac16= new LIst<Account>();
        ac=[SELECT AccountId,NewValue,OldValue FROM AccountHistory WHERE Field = 'AccountStatus__c' AND CreatedById = '0057F000003RvIZ' AND CreatedDate = Yesterday Order BY CReatedDate ASC ];
        
            SET<id> ac2= new SET<id>();   
       
        
        for(AccountHistory cc:ac){
            if(!ac2.contains(cc.AccountId)){
            Account pp= new Account();
            
            pp.id=cc.AccountId;
            pp.AccountStatus__c=cc.OldValue.Tostring();
            ac1.add(pp);
            ac2.add(cc.Accountid);
            
        } 
        
        Update ac1;
    }
         Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String sendto='support@cloudexpertsindia.com';
        String d='crm@cloudexpertsindia.com';
        
            LIst<String> toAddresses = new list<string>();
        toAddresses.add(sendto);
        toAddresses.add(d);
            String subject ='Updated Successfully';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
        String rr='Update Account';
            email.setPlainTextBody(rr);
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        
        
    }

}