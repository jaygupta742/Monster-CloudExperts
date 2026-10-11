@istest
public class AccountStatusTest{

    
    public static testmethod void alltrig(){
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        

        Account acc =new Account();
        acc.Name = 'Test new A11112';
        acc.SalesChannel__c = 'ECOMM';
        acc.Segment__c = 'Commercial';
        acc.Import_Source__c = 'test rep gen';
        acc.Lead_Source1__c = 'ECOMM';
        acc.APAC_Industry__c = 'Automobile';
        acc.Account_Type__c = 'NIT';
        acc.No_of_Employees__c = 20;
        acc.Location__c = 'Philippines';
        acc.Website = 'www.tesqwqwt2.com';
        acc.Phone = '+917855999958';
        //acc.CreditStatus__c ='OK';
        acc.Lead_Account_Status__c = 'Inactive';
        acc.otherphone__c='+911234567890';
        acc.RegistrationNumber__c='ssssyyyssss';
        acc.Integration__c = false;  
            
       
        
        insert acc;
        
         
       /* Contact c = new Contact();
        c.AccountID= acc.Id;
        c.LastName='MahendraBaahubali';
        c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;**/
        try{  
            acc.Lead_Account_Status__c = 'Active';
            acc.AccountStatus__c = 'Active';   
            update acc;
        }
       catch(Exception ee){
            
            
        }  
    }
    
     /* public static testmethod void alltrig2(){
        
        Trigger__c t = new Trigger__c(name ='Account',Active__c = true);
        insert t;
        

        Account acc =new Account();
        acc.Name = 'Test new A11112';
        acc.SalesChannel__c = 'ECOMM';
        acc.Segment__c = 'Commercial';
        acc.Import_Source__c = 'test rep gen';
        acc.Lead_Source1__c = 'ECOMM';
        acc.APAC_Industry__c = 'Automobile';
        acc.Account_Type__c = 'NIT';
        acc.No_of_Employees__c = 20;
        acc.Location__c = 'Philippines';
        acc.Website = 'www.tesqwqwt2.com';
        acc.Phone = '+917855999958';
        //acc.CreditStatus__c ='OK';
        acc.Lead_Account_Status__c = 'Inactive';
        acc.otherphone__c='+911234567890';
        acc.RegistrationNumber__c='ssssyyyssss';
        acc.Integration__c = false;  
            
       
        
        insert acc;
        
         
       /* Contact c = new Contact();
        c.AccountID= acc.Id;
        c.LastName='MahendraBaahubali';
        //c.Email='mbahu@gmail.com';
        c.Phone='9898989898';
        insert c;
              
            acc.Lead_Account_Status__c = 'Active';
            acc.AccountStatus__c = 'Active';  
            acc.Integration__c = false;
          try{
            update acc;     
          }  
          catch(Exception e) {} 
     
        
    }*/
}