public class CreditOrder {

public list<Credit_Request__c> lsto{get;set;}
public Credit_Request__c ord {get;set;}
public string rid{get;set;}
Public List<Credit_order__c> lstcr {get;set;}
public Credit_order__c cr{get;set;}
public double reversedamount{get;set;}
public boolean Approval{get;set;}
public boolean Approvalsales{get;set;}

public decimal rt{get;set;}
public CreditOrder () {
approval = false;
Approvalsales=false;
lstcr= new list<Credit_order__c>();

ord = new Credit_Request__c();
lsto= new list<Credit_Request__c>();

rid = ApexPages.currentPage().getParameters().get('id');
lsto= [Select id,name,Billing_Account__c,Credit_Reason__c,Account__c,Vertical_head_Approval_Status__c,Created_By_Users_Profile__c,Credit_Type__c,Order_Custom__c,OrderDate__c,Credit_Comments__c,Credit_Amount__c,Approval_Status__c from Credit_Request__c where id=: rid];
 rt = lsto[0].Credit_Amount__c;
 if(rt>0){
 rt=rt-2*(rt);
 }
 
  if(lsto[0].Approval_Status__c =='Approved' && lsto[0].Created_By_Users_Profile__c=='Monster - Collections' ){
  
  Approval = true;
  
  }
   if(lsto[0].Approval_Status__c =='Approved' && lsto[0].Vertical_head_Approval_Status__c =='Approved' && lsto[0].Created_By_Users_Profile__c=='Monster - Sales'  ){
  
  Approvalsales= true;
  
  }
  
   for(Credit_Request__c o1:lsto ){
    cr = new Credit_order__c();
    cr.Account__c= o1.Account__c;
    cr.Credit_Reason__c=o1.Credit_Reason__c;
     cr.Credit_type__c=o1.Credit_Type__c;
     cr.Order_Custom__c=o1.Order_Custom__c;
     //cr.Reversed_Amount__c=o1.Credit_Amount__c;
     cr.Reversed_Amount__c=rt;
    }


       
      
}
public PageReference Save(){


                        insert cr;
                                   
                        return new PageReference('/'+cr.id);    
}

public PageReference Cancel(){

 return new PageReference('/'+lsto[0].id);
}
 public PageReference onCancel()
    {
        return new PageReference('/'+rid);
    }
}