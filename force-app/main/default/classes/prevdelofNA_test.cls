@istest
public class prevdelofNA_test {
    
    public static testmethod void prevdel()
    {
        Trigger__c tc = new Trigger__c();
        tc.name = 'Attachment';
        tc.Active__c = TRUE;
        
        insert tc;
        
        user u = [SELECT id,lastname FROM user WHERE Profile_Name__c ='Raj-Service' AND IsActive = true LIMIT 1];
        
        DeleteAttachment__c da = new DeleteAttachment__c();
            da.Name = 'Admin';
            da.Granted__c = false;
            da.UserId__c = '0057F000003RvIZ';
        insert da;
        
       Seeker_Skip__c t = new Seeker_Skip__c();
        t.name = 'test';
        insert t;
        
        blob b= blob.valueOf('attach');
        
        Attachment atach = new Attachment();
        atach .name ='testattachmnet';
        atach.ParentId=t.id;
        atach.body = b;
        insert atach;
        
        try{
            delete atach;
        }
        catch(exception e){
            
        }
        
        system.runAs(u) {
          try{
            delete atach;
        }
        catch(exception e){
            
        }  
        }
       
       
    }

}