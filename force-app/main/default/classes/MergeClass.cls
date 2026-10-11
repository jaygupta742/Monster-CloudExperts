public class MergeClass {
public string callfunc{get;set;}
public String link{get;set;}
public List<String> accountIds{get;set;}
public integer rowIndexN{get;set;}
public string acIds{get;set;}
 public MergeClass ()
 {
     accountIds= new List<String>();
     rowIndexN=0;
     
     
 } 
 
 public void addrow()
 {
      accountIds.add(acIds);
      acIds=null;
     
 }
 
     public void RemoveMoreAccount() {
     
       
    accountIds.remove(rowIndexN-1);
        //return null;       
            
 }
 
 public pagereference  goToMerge(){
 List<Account> ac= [select id,name from Account where AccountID__c=:accountIds];
 system.debug(ac);
 String c='';
 for(Account cc:ac){
 if(c==''){
 c='cid='+cc.id;
 }
 if(c!='')
 {
 c=c+'&cid='+cc.id;
 }
 
   }
     string link1=URL.getSalesforceBaseUrl().toExternalForm() ;
   link=link1+'/merge/accmergewizard.jsp?goNext=+Next+&'+c;
   link= link.removeend('null');
   pagereference   pf= new pagereference('/'+link);
    pf.setredirect(true);
    callfunc='<script> func(); </script>';
 //return new pagereference('/merge/accmergewizard.jsp?goNext=+Next+&'+c);
 accountIds.clear();
  return null; 
    }


}