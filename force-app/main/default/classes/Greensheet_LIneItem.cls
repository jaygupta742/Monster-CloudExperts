public class Greensheet_LIneItem {
string recid;
public Integer numberOfRowToRemove{get;set;}
public list<Contract_Line_Item__c> cl{get;set;}
    public Greensheet_LIneItem()
    {
    recid=apexpages.currentpage().getparameters().get('cc');
    cl=new list<Contract_Line_Item__c>();
    Contract_Line_Item__c h=new Contract_Line_Item__c();
    cl.add(h);
    
    }
    
    public void addrow()
    {
    Contract_Line_Item__c h1=new Contract_Line_Item__c();
    cl.add(h1);
    
    }
    
    public pagereference save()
    {
    for(Contract_Line_Item__c koo:cl)
    {
    koo.Green_Sheet__c=recid;
    
    }
    insert cl;
    return new pagereference('/'+recid);
    
    }
    
    
    
    
     public pagereference cancel()
    {
    
    return new pagereference('/'+recid);
    
    }




 public PageReference removeNewObject()
             {
                   if(numberOfRowToRemove!=0)
                   {
             cl.remove(numberOfRowToRemove);}
             system.debug('SSSSSSSSSSSSSSS' + numberOfRowToRemove);         
             return null;  
             
             }   
}