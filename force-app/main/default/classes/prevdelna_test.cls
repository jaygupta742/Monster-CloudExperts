@istest
public class prevdelna_test {
    
    public static testmethod void prevdel()
    {
        
        test.startTest();
        //cvr
        Trigger__c te = new Trigger__c(name ='CVR',Active__c = true);
        insert te;
        
        //account
        Trigger__c te1 = new Trigger__c(name ='Account',Active__c = true);
        insert te1;
        
       
       Trigger__c tc = new Trigger__c();
        tc.name = 'Attachment';
        tc.Active__c = TRUE;
        insert tc;
        DeleteAttachment__c da = new DeleteAttachment__c();
        	da.Name = 'Admin';
        	da.Granted__c = true;
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
        
        
       
       
    }

}