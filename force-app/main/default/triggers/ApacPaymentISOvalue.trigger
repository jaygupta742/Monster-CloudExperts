//@imRam adding to assign CurrencyISO code from Price List

trigger ApacPaymentISOvalue on APTS_APAC_Payment__c (before insert) {

set<id> q = new set<id>();
for(APTS_APAC_Payment__c j:trigger.new){
q.add(j.Proposal__c);
}

system.debug('quote proposal -->'+q.size());

List<apttus_proposal_proposal__c> app = new list<apttus_proposal_proposal__c>([SELECT id,name,PriceList__c ,PriceList__r.CurrencyIsoCode FROM apttus_proposal_proposal__c WHERE id=:q]);

for(APTS_APAC_Payment__c j:trigger.new){
system.debug('quote proposal -->'+j.Proposal__c);
system.debug('quote price list -->'+j.Proposal__r.PriceList__c);
if(app.size()>0)
for(apttus_proposal_proposal__c a : app){
system.debug('quote price list -->'+a.PriceList__c);
if(j.Proposal__c == a.id){
if(a.PriceList__c != NULL){
          system.debug('update CurrencyIsoCode -->'+a.PriceList__r.CurrencyIsoCode);
              j.CurrencyIsoCode = a.PriceList__r.CurrencyIsoCode; 
              }
              }  
              }     
        
        
    }    

}