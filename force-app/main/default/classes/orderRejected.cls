public class orderRejected { 
    @AuraEnabled 
    public static Order__c getorder (string rid){
        
        Order__c   ord = [select id ,Rejected_Date__c, name, Order_Status__c, Rejected_By__c,Rejected_Reason__c from Order__c  where id =: rid ]; 
        
        
        
        String Name = UserInfo.getName();//Returns the context user's full name.
        ord.Rejected_By__c = Name; 
        ord.Rejected_Date__c = system.now();
        ord.Order_Status__c = 'Rejected';
        
        return ord;
        
    }
    
    @AuraEnabled
    
    public static string onsave( Order__c mn){
        
        try{
            
            String Name = UserInfo.getName();//Returns the context user's full name.
            System.Debug('Name-' + Name); 
            mn.Rejected_By__c = Name; 
            mn.Rejected_Date__c = system.now();
            mn.Order_Status__c = 'Rejected';
            System.Debug('mn-' + mn);
            update mn;
            
        }
        catch(Exception ex){
            system.debug('debug: '+ex.getLineNumber());
            system.debug('debug: '+ex.getMessage());
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
        
        
        return mn.Id;
    }
    
}