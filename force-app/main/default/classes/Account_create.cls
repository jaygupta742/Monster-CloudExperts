public class Account_create {
    public string callfunc{get;set;}
    public boolean show_button{get;set;}
    public  account acc{get;set;}
    public list<wrapper> existing{get;set;}
    public Boolean showSaveButton {get;set;}
    public Datetime accountSharingDate{get;set;}
    list<Account_Create_Duplication__c> acdup;
    /*   public Account accc{get;set;}
public list<Account> accc1{get;set;}*/
    public Account acc1;
    user s;
    public id recordtypeidPA ;
    public string g{get;set;}
    public boolean b2{get;set;}
    public boolean b1{get;set;}
    public boolean b3{get;set;}
    public boolean b4{get;set;}
    
    public boolean colt{get;set;}
    public boolean salops{get;set;}
    public boolean fin{get;set;}
    public boolean fin1{get;set;}
    public boolean coltmntreqfld{get;set;}
    
    // constructor method
    public Account_create(ApexPages.StandardController controller) {
        
        showSaveButton = true;
        
        acc=(account)controller.getrecord();
        
        //acc=new account();
        //accc1 = [Select id,name,recordtypeid from account];
        
        recordtypeidPA  = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        existing=new list<wrapper>();
        acdup=Account_Create_Duplication__c.getall().values();
        for(Account_Create_Duplication__c j:acdup)
        {
            
            if(j.name==userinfo.getUserId())
            {
                show_button=true;
                
            }
        }
        colt= false;
        salops =false;
        fin = false;
        fin1=true;
        coltmntreqfld = true;
        
        b2=false;
        b1=true;
        b3=true;
        b4=false;
        id id1 = UserInfo.getUserId();
        s  = new user();
        s=[select profileid from user where id =:id1];
        
        
        // @ Rj to give access to finance team and collections team  
        if(s.profileid=='00e7F000000uSSkQAM'){
            
            fin=true;
            fin1=false;
        }
        
        if(s.profileid=='00e7F000000uSSjQAM'){
            colt= true;
            coltmntreqfld = false;
        }
        if(s.profileid=='00e7F000000uSSlQAM'){
            salops = true;
        }
        
        /*    if(s.profileid == '00e7F000000uSSeQAM')
{
this.accc.integration__c = true;
}*/
        
        if(s.profileid=='00e7F000000uSSjQAM'||s.profileid=='00e7F000000uSSiQAM'){
            
            b2=true;
            b1=false;
        }
        
        if(s.profileid=='00e7F000000uSSjQAM'){
            
            b3=false;
            b4=true;
            
        }
        
    }
    
    
    public pagereference save_custom()
    {
        //Nag
        if((acc.Account_Category__c == 'Subsidiary of ____'||acc.Account_Category__c == 'Branch of  ______  in Account Category'||acc.Account_Category__c == 'Sister Concern of')&& acc.Subsidiary_Sister_Concern_Branch_of__c==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Update Account ID of Parent Company before Saving'));
            return null;
        }
        
        
        Id currentUserId = UserInfo.getUserId();
        // Query the User record including the Profile related information
        User currentUser = [SELECT Id, Profile.Name FROM User WHERE Id = :currentUserId LIMIT 1];
        // Get the Profile Name
        String profileName = currentUser.Profile.Name;
        
      if((acc.Lead_Account_Status__c == 'Inactive' || acc.Lead_Account_Status__c == '') && (profileName=='Monster - Sales Ops/LM' || profileName=='Monster - Sales') ){
          acc.AccountStatus__c='Unpromoted';  
        }
        
        /* if(acc.Lead_Account_Status__c == 'Active' && (profileName=='Monster - Sales Ops/LM' || profileName=='Monster - Sales') ){
//1
if(acc.APAC_Industry__c == null || acc.APAC_Industry__c == ''){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'If Account Status is Active then APAC Industry is Mandatory !!!'));
return null; 
}
//2
if(acc.No_of_Employees__c == null ){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'If Account Status is Active then Number of Recruiters is Mandatory !!!'));
return null; 
}
//3
if(acc.Account_Type__c == null || acc.Account_Type__c == ''){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'If Account Status is Active then Account Type is Mandatory !!!'));
return null; 
}
//4
if(acc.CustEmplSize__c == null){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'If Account Status is Active then Emp Size is Mandatory !!!'));
return null; 
}
//5
if(acc.Region__c == null || acc.Region__c == ''){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'If Account Status is Active then Region is Mandatory !!!'));
return null; 
}
}*/
        //Nag
        System.debug('Account name under Save_Custom'+acc.name);
        list<account> ac = new list<account>();
        if(s.profileid == '00e7F000000uSSeQAM')
        {
            System.debug('2--------'+acc.name);
            acc.integration__c = true;
            acc.recordtypeid = recordtypeidPA ;
            acc.name = acc.First_Name__C +' ' +acc.Last_Name__C;
            System.debug('Account name under Save_Custom'+acc.name); 
            system.debug('integration---->'+acc.integration__c);
            ac = [select id,Name,Mobile__c,Mini_EA_account__c,Email__c,Used__c,Account_Sharing_Date__c from Account where Email__c =:acc.Email__c and id!=:acc.id Order By Createddate desc limit 1000];
        }
        
        existing=new list<wrapper>();
        
        Datetime accountSharingDateInner;
        
        if(s.profileid != '00e7F000000uSSeQAM')
            ac=[select id,name,Account_Sharing_Date__c,website,/*accountid__c,*/phone,Used__c,Mini_EA_account__c from account where ((name=:acc.name and name!=null) or (website=:acc.website and website!=null and  website!='na' ) or (phone=:acc.phone and phone!=null and phone!='+910000000000')) and id!=:acc.id Order By Createddate desc limit 1000 ];
        System.debug('Aaaaaaaaaaaaaaaaaaaaa'+ ac.size());
        if(ac.size()>0)
        {
            for(account d:ac)
            {
                existing.add(new wrapper(d));
                
                if(accountSharingDateInner == null) accountSharingDateInner = d.Account_Sharing_Date__c;
                else if(d.Account_Sharing_Date__c > accountSharingDate && d.phone == acc.phone){
                    accountSharingDateInner = d.Account_Sharing_Date__c;
                }
                
            }
            
           /* system.debug('accountSharingDateInner : ' + accountSharingDateInner);
            system.debug(System.today() > accountSharingDate);
            
            accountSharingDate = accountSharingDateInner;
            
            if(System.today() < accountSharingDate){
                showSaveButton = false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'You will not be able to create a new account with this phone number until: ' + accountSharingDate.format() ));
            }else{
                showSaveButton = true;
            }*/
            
            return null;
        }
        
        else
        {
            
            try{
                System.debug('3--------'+acc.name);
                upsert acc;}
            
            catch (Exception e)
            {
                ApexPages.addmessages(e);
                System.debug('ajvajdjajjajajaj'+e.getmessage());
                return null;
                
            }
        }
        
        /* if(s.profileid == '00e7F000000uSSeQAM')
{
accc = [Select id,name,RecordTypeId,Integration__c from Account where id=:acc.id];
for(Account a:accc)
{
accc1 = new list<Account>();
a.RecordTypeId = '0120l000000LPQx';
a.Integration__c = true;   
accc1.add(a);
}
insert accc1;
}
*/
        return new pagereference('/'+acc.id);
        
    }
    public class wrapper
    {
        public boolean b{get;set;}
        public account j{get;set;}
        
        public wrapper(account k)
        {
            j=k;
            b=false;
            
        }
        
    }
    
    
    public pagereference merge_acc()
    {try{
        upsert acc;}
     
     catch (Exception e)
     {
         ApexPages.addmessages(e);
         return null;
     }
     string s='cid='+acc.id+'&';
     string a;
     for(wrapper j:existing)
     {
         
         if(j.b==true){
             s='cid='+j.j.id+'&'+s;
         }
         
     }
     //s.removeend('null');
     string link=URL.getSalesforceBaseUrl().toExternalForm() ;
     g=link+'/merge/accmergewizard.jsp?goNext=+Next+&'+s;
     g= g.removeend('null');
     // return new pagereference('/merge/accmergewizard.jsp?retURL=%2F001%2Fo&srch='+acc.name);
     //return new pagereference('/'+g);
     system.debug('URL '+g);
     pagereference p=new pagereference(g);
     p.setredirect(true);
     // return p;
     callfunc='<script> func(); </script>';
     return null; 
    }
    public pagereference save_ignore()
    {   if(show_button==true){
        try{
            upsert acc;}
        
        catch (Exception e)
        {
            ApexPages.addmessages(e);
            return null;
        }
        return new pagereference('/'+acc.id);
    }else
    {   try{
        upsert acc;}
     
     catch (Exception e)
     {
         ApexPages.addmessages(e);
         return null;
     }
     string s='cid='+acc.id+'&';
     /* string a;
for(wrapper j:existing)
{  
s='cid='+j.j.id+'&'+s;
}*/
     //s.removeend('null');
     string link=URL.getSalesforceBaseUrl().toExternalForm() ;
     //g=link+'/merge/accmergewizard.jsp?goNext=+Next+&'+s;
     // g= g.removeend('null');
     g=link+'/'+acc.id;
     list<string> toaddress=new list<string>();
     for(Account_Create_Duplication__c j:acdup)
     {
         toaddress.add(j.Email_id__c);
     }
     // send email
     
     Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
     
     String subject ='Account Duplicate -'+acc.name;
     string mailbody='Hi Sir/Madam,<br/><br/><br/>Please Find The Link Below For Duplicate Account Merge<br/><br/><b>Account Name: </b>'+acc.name+'<br/><br/>'+g;
     email.setSubject(subject);
     email.setToAddresses( toaddress );
     //email.setPlainTextBody('Account duplicate  '+g);
     email.setHtmlBody(mailbody);
     Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
     return new pagereference('/'+acc.id);
    }
     
    }
    
}