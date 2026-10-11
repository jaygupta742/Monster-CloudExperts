public class AddMultiplePayment {
  public id parentId{get;set;}
  public decimal dd;
  public apttus_proposal_proposal__c ap = new apttus_proposal_proposal__c(); // @Ram added
  Public List<APTS_APAC_Payment__c> Pro{get;Set;}
  Public List<APTS_APAC_Payment__c> Pro1{get;set;}
  public Integer numberOfRowToRemove{get;set;}
  Public APTS_APAC_Payment__c tt{get;set;}
    public AddMultiplePayment(ApexPages.StandardController controller) {
         parentId = ApexPages.CurrentPage().getParameters().get('id');
          Pro = new List<APTS_APAC_Payment__c>();
          Pro1=new List<APTS_APAC_Payment__c>();
          ap = [SELECT id,Net_Total__c,Payment_Amount__c,CurrencyIsoCode FROM apttus_proposal_proposal__c WHERE id =: parentid]; //@Ram added
          tt = New APTS_APAC_Payment__c();
          tt.Proposal__c=parentId; 
          pro.add(tt);
          Pro1=new List<APTS_APAC_Payment__c>([SELECT id,Name,APAC_Payment_Type__c, Due_Date__c,DueDateWithoutTime__c,Payment_Amount__c,Proposal__c,TDS_Amount_c__c,Finance_Reference__c,Payment_Date__c,TDS_Payment_Amount__c,Payment_Received_Amount__c FROM APTS_APAC_Payment__c Where Proposal__c=:parentId]);
    }
     Public Void Addrows()
    {
                 
         APTS_APAC_Payment__c tsk1 = New APTS_APAC_Payment__c();
         tsk1.Proposal__c= parentId;
     
         pro.add(tsk1); 
             
    }
    
     public PageReference Save1(){
        dd = 0;
         for(APTS_APAC_Payment__c pp : pro){
        if( pp.Payment_Amount__c == 0 ) {
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Amount Cannot Be Zero Or Empty'));
             return null;
         }
         
         pp.CurrencyIsoCode = ap.CurrencyIsoCode;
          system.debug('seeetaram'+pp.CurrencyIsoCode);
         dd= dd + (pp.Payment_Amount__c + pp.TDS_Amount_c__c);
         }
         for(APTS_APAC_Payment__c pp : pro1){
             dd= dd + (pp.Payment_Amount__c + pp.TDS_Amount_c__c);
         }
         system.debug('hollaaaaa'+dd);
         if(dd != ap.Net_Total__c){
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'Amount cannot be less than Quotes/Proposals Net Total = '+ap.Net_Total__c+ ' Payment Total = '+dd));
           return null;
          }
     
     
        try{
       
           insert pro; 
           system.debug('aaaaaaaaaaaaaaaaaaa'+pro1);
             //return null;
           } 
            
           
         catch(exception e){
          system.debug('The exception is ' + e.getMessage());
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, + e.getMessage()));
           return null;
        }
         PageReference prf = New PageReference('/'+parentId);
         return prf;
                
          
   } 
   
    public PageReference removeLine()
    {
         Pro.remove(numberOfRowToRemove);
         system.debug('SSSSSSSSSSSSSSS' + numberOfRowToRemove);         
         return null;  
             
    }  
}