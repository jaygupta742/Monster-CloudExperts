trigger rollupcount on Call_Disposition__c (After insert) {
list<Account> acc =new list<Account>();
    
    for(Call_Disposition__c cc:trigger.new) {
        if(cc.Account__c!=null) {
     Account acc1=[select name,Disposition_Count__c,Last_Disposition__c,Last_Disposition_Date_Time__c from account where id=:cc.Account__c];
            if(acc1.Disposition_Count__c==null) {
                acc1.Disposition_Count__c=0;
            }
        acc1.Disposition_Count__c+=1;
        acc1.Last_Disposition__c=cc.Disposition__c;
        acc1.Last_Disposition_Date_Time__c=cc.call_time__c;
            
        acc.add(acc1);            
        }
    }
    if(acc.size()>0) {
     update acc;   
    }
}