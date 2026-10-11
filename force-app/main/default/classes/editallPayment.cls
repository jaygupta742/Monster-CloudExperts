public class editallPayment {
    public id parentId{get;set;}
    public decimal dd;
    public Integer numberOfRowToRemove{get;set;}
    public apttus_proposal_proposal__c  ap;
    Public list<APTS_APAC_Payment__c> so{get;set;}
    public editallPayment(ApexPages.StandardController controller) {
    so = new list<APTS_APAC_Payment__c>();
      parentId = ApexPages.CurrentPage().getParameters().get('id');
    ap = [SELECT id,Net_Total__c,CurrencyIsoCode FROM apttus_proposal_proposal__c WHERE id =: parentid]; //@Ram added
      so = [SELECT id,Name,APAC_Payment_Type__c,Due_Date__c,DueDateWithoutTime__c,Payment_Amount__c,Proposal__c,TDS_Amount_c__c,CurrencyIsoCode,Finance_Reference__c,Payment_Date__c,TDS_Payment_Amount__c,Payment_Received_Amount__c,Revised_Due_Date__c FROM APTS_APAC_Payment__c Where Proposal__c=:parentId];
    } 
   Public Pagereference savemethod(){
       dd = 0;
         for(APTS_APAC_Payment__c pp : so){
        if( pp.Payment_Amount__c == 0 ) {
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Amount Cannot Be Zero Or Empty'));
             return null;
         }
         
         pp.CurrencyIsoCode = ap.CurrencyIsoCode;
          system.debug('seeetaram'+pp.CurrencyIsoCode);
         dd= dd + (pp.Payment_Amount__c + pp.TDS_Amount_c__c);
         }
         
         system.debug('hollaaaaa'+dd);
         if(dd != ap.Net_Total__c){
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, 'Amount cannot be less/greater than Quotes/Proposals Net Total = '+ap.Net_Total__c+ ' Payment Total = '+dd));
           return null;
          }
     
     
        try{
       
           upsert so; 
           system.debug('aaaaaaaaaaaaaaaaaaa'+so);
             //return null;
              PageReference prf = New PageReference('/'+parentId);
         return prf;
           } 
            
           
         catch(exception e){
          system.debug('The exception is ' + e.getMessage());
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, + e.getMessage()));
           return null;
        }
      /*   PageReference prf = New PageReference('/'+parentId);
         return prf;*/
                
          
   
   
   
   
   
   
   /*try{
     update so;
      PageReference prf = New PageReference('/'+parentId);
         return prf;
       }catch(exception e){
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, + e.getMessage()+ '& Net total Value='+ ap.Net_Total__c));
           return null;
       }   */
       
       
       
   }
   
   
   Public Void Addrows()
    {
                 
         APTS_APAC_Payment__c tsk1 = New APTS_APAC_Payment__c();
         tsk1.Proposal__c= parentId;
     
         so.add(tsk1); 
             
    }
   public PageReference removeLine()
    {
        APTS_APAC_Payment__c apd= New APTS_APAC_Payment__c();
         apd.id= so.get(numberOfRowToRemove).id;
         delete apd;
         so = new list<APTS_APAC_Payment__c>();
         so = [SELECT id,Name,APAC_Payment_Type__c,Due_Date__c,DueDateWithoutTime__c,Payment_Amount__c,Proposal__c,TDS_Amount_c__c FROM APTS_APAC_Payment__c Where Proposal__c=:parentId];
         //so.remove(numberOfRowToRemove);
         system.debug('SSSSSSSSSSSSSSS' + numberOfRowToRemove);         
         return null;  
             
    }  
}