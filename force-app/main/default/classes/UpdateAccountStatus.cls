public class UpdateAccountStatus {
@InvocableMethod
    public static void UpdateFlowId(List<ID> ods)
    {
       LIst<OrderC__c> cc= new List<OrderC__c>();
        cc=[select id,name,Account__c,Order_Service_End_Date__c from OrderC__c where id=:ods];
        Set<Id> ids= new Set<Id>();
        for(OrderC__c jj:cc){
            ids.add(jj.Account__c);
            
        }
        List<OrderC__C> odc= new List<OrderC__C>();
         List<Account> ac1= new List<Account>();
         List<Account> acc= new List<Account>();
       acc=[select id,name,AccountStatus__c,(select id,Order_Service_End_Date__c from Orders__r where id!=:cc AND Order_Service_End_Date__c>today ) from Account where id=:ids ];
        for(Account a:acc){
            if(a.Orders__r.size()>0){
            
                }
                else{
                    a.id=a.id;
                    a.AccountStatus__c='Lapsed Customer';
                    a.ClientValidationCheck__c=true;
                    ac1.add(a);
                }
       }
        
              Database.update(ac1);
    }
       /*
        odc=[select id,name,Account__c,Contract_End_Date__c from OrderC__c where id!=:ods And Account__c=:ids ANd Contract_End_Date__c>=Today];
        
        
        
        for(OrderC__c pp:cc){
            for(OrderC__c jj:odc){
                if(pp.Contract_End_Date__c>jj.Contract_End_Date__c &&pp.Account__c==jj.Account__c){
                    Account ac = new Account();
                    ac.id=pp.Account__c;
                    ac.AccountStatus__c='Lapsed Customer';
                    ac1.add(ac);
                }
            }
            
        }
        Database.update(ac1);
*/
    
  
    
        
        
    
}