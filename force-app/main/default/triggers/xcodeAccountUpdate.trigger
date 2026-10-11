trigger xcodeAccountUpdate on Xcode_Account__c (Before Insert ,before Update) {
  
    set<id> aid = new set<id>();
    set<id> xid = new set<id>(); 
    list<Account> acc = new list<Account>();
    list<Xcode_Account__c> xad1 = new list<Xcode_Account__c>();
                
           for(Xcode_Account__c a: trigger.new){
                  aid.add(a.Account__c);
                  xid.add(a.id);
           }

    list<Xcode_Account__c> xac = new list<Xcode_Account__c >([SELECT id,name,Is_Primary__c,Account__c,Xcode__c  FROM Xcode_Account__c WHERE Account__c =: aid AND Is_Primary__c=true AND id !=: xid]);
    list<Account> acc1 = new list<Account>([SELECT id,name FROM Account WHERE id =: aid]);
           system.debug('aaaaaaaaaaaaaaaaaaa'+xac);
           system.debug('bbbbbbbbbbbb'+xac.size());
           system.debug('qqqqqqqqqqq'+acc1.size());
           system.debug('wwwwwwwwwwwwwwwwww'+acc1);
  
  
  
           if(Trigger.isInsert){ 
  
              for(Xcode_Account__c a: trigger.new){
              system.debug('cccccccccc'+a);
              
              if(a.Is_Primary__c == true){
              system.debug('dddddddddddd');
                  
              for(Account ac:acc1){
              system.debug('zzzzzzzzzzzz'+ac);
                      
              if(a.Account__c == ac.id){
                system.debug('yessssssssssssss');
                ac.Primary_Xcode__c = a.Xcode_Name__c;
                system.debug('rrrrrrrrrrr'+ac.Primary_Xcode__c);
                acc.add(ac);
              }
              }
              for(Xcode_Account__c x:xac){
                   x.Is_Primary__c = false;
                   system.debug('eeeeeeeeeeeeee'+x.Is_Primary__c);
                   xad1.add(x);
              }
              }
              }  
              update xad1;
              update acc;
              }

if(Trigger.isUpdate){ 
  
            for(Xcode_Account__c a: trigger.new){
            system.debug('fffffffffffffffff'+a);
            if(a.Is_Primary__c == true){
            system.debug('gggggggggggggggggggggggg');
            for(Account ac:acc1){
            system.debug('tttttttttt'+ac);
            if(a.Account__c == ac.id){
            system.debug('hhhhhhhhhhhhhhhhhh');
            ac.Primary_Xcode__c = a.Xcode_Name__c;
            system.debug('jjjjjjjjjjjjjjjjjjj'+a.Xcode_Name__c);
            system.debug('rrrrrrrrrrr'+ac.Primary_Xcode__c);
            acc.add(ac);
            }
            }
            for(Xcode_Account__c x:xac)
            {
            x.Is_Primary__c = false;
            system.debug('eeeeeeeeeeeeee'+x.Is_Primary__c);
            xad1.add(x);
            }
                  
          
         }

    }update xad1;
     update acc;
  
  
}

}