public class CreditRequest {
public list<OrderC__c> lsto{get;set;}
public OrderC__c ord {get;set;}
public string rid{get;set;}
Public List<Credit_Request__c > lstcr {get;set;}
public Credit_Request__c cr{get;set;}
//public double reversedamount{get;set;}
public boolean qwerty{get;set;}
   
	public CreditRequest() {
        qwerty= false;
        lstcr= new list<Credit_Request__c>();
        
        ord = new OrderC__c ();
        lsto= new list<OrderC__c>();
        
        rid = ApexPages.currentPage().getParameters().get('id');
        lsto= [Select id,name,Account__c,Account__r.name,OrderNumber__c,RemainingCreditAmount__c,OrderDate__c,NetOrderAmount__c ,Payment_Amount__c,Gross_Total__c,Base_Total__c,CreditReason__c,Detailed_Credit_Reason__c,Type_of_Order__c from OrderC__c where id=: rid];
  
         for(OrderC__c o1:lsto ){
         cr = new Credit_Request__c();
         cr.OrderDate__c= o1.OrderDate__c;
         cr.Order_Custom__c = o1.id;
         cr.Account__c=o1.Account__c;   
	}     
}
    
		public PageReference Save(){
    		OrderC__c oc = new OrderC__c();
    		oc = [select id,name,Total_Bad_Debt_Value__c,Gross_Total__c from OrderC__c where id =: cr.Order_Custom__c limit 1];
                
            if(cr.Credit_Amount__c > lsto[0].Gross_Total__c ){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Reversed Credit amount cannot be greater than Gross Total'));
                 return null;
            } 
    		else if(oc.Total_Bad_Debt_Value__c!=null && cr.Credit_Amount__c != null && cr.Order_Custom__c == oc.id && (oc.Total_Bad_Debt_Value__c+cr.Credit_Amount__c)> oc.Gross_Total__c ){ 
                 Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error,'You cannot create credit requests greater than remaining reversals value'));
                 return null;
            } 
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