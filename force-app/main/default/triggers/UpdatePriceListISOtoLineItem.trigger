//@imRam adding to assign CurrencyISO code from Price List

trigger UpdatePriceListISOtoLineItem on Proposal_Line_Item__c (before insert, before update) {

set<id> q = new set<id>();
set<id> pid = new set<id>();    
for(Proposal_Line_Item__c j:trigger.new){
q.add(j.Proposal_Locked__c);     
    pid.add(j.Product__c);
        }
    
    if(trigger.isInsert){

system.debug('quote proposal -->'+q.size());

List<apttus_proposal_proposal__c> app = new list<apttus_proposal_proposal__c>([SELECT id,name,PriceList__c ,PriceList__r.CurrencyIsoCode FROM apttus_proposal_proposal__c WHERE id=:q]);


for(Proposal_Line_Item__c j:trigger.new){

if(app.size()>0)
for(apttus_proposal_proposal__c a : app){
system.debug('quote price list -->'+a.PriceList__c);
if(j.Proposal_Locked__c == a.id){
if(a.PriceList__c != NULL){

          system.debug('update CurrencyIsoCode -->'+a.PriceList__r.CurrencyIsoCode);
              j.CurrencyIsoCode = a.PriceList__r.CurrencyIsoCode; 
              }
              }  
              }
}

}
    if(trigger.isupdate){
        
        List<apttus_proposal_proposal__c> app = [SELECT PriceList__c,GCS_Opportunity__c FROM apttus_proposal_proposal__c WHERE id=:q];
         system.debug('update quote app-->'+app);
         map<id,apttus_proposal_proposal__c> quoteMap = new  map<id,apttus_proposal_proposal__c>();
       set<id> priceId = new set<id>();
        if(app.size()>0){
            for(apttus_proposal_proposal__c a :app){
                priceId.add(a.PriceList__c);
                quoteMap.put(a.id,a);
            }
 			            
        }
        
      //  map<id,ProductM__c> prodMap = new map<id,ProductM__c>([SELECT id,name,DiscountLimit__c,MaxDiscount__c,No_Discount__c FROM ProductM__c WHERE id=:pid]);
		list<Product_Price_Entry__c> productPriceList = [SELECT id,name,DiscountLimit__c,MaxDiscount__c,No_Discount__c,PriceList__r.name,Product__r.name FROM Product_Price_Entry__c WHERE Product__c =:pid AND PriceList__c=:priceId];
         system.debug('productPriceList-->'+productPriceList);
        
        map<id,Product_Price_Entry__c> prodMap = new map<id,Product_Price_Entry__c>();
		for(Product_Price_Entry__c p: productPriceList){
            prodMap.put(p.Product__c,p);
          }	
        
        system.debug('prodMap-->'+prodMap);
        
        for(Proposal_Line_Item__c j:trigger.new){

            boolean gcs  = false;
            if(quoteMap.get(j.Proposal_Locked__c) != NULL){
                gcs = quoteMap.get(j.Proposal_Locked__c).GCS_Opportunity__c;
            }
            system.debug('gcs--->'+gcs);
            system.debug('product--->'+j.Product__c);
            decimal disAmount =0;
            decimal maxDiscount =0;
             system.debug('AdjustmentType--->'+j.Adjustment_Type__c);
             system.debug('Price--->'+j.Price__c);
             system.debug('AdjustmentAmount--->'+j.Adjustment_Amount__c);
            system.debug('Quantity--->'+j.Quantity__c);
            
            if(j.Adjustment_Type__c == 'Price Override'){
                
            disAmount = j.Price__c-(j.Adjustment_Amount__c/j.Quantity__c) ; 
                                    
            }else if(j.Adjustment_Type__c == 'Base Price Override'){
                                        
               disAmount =(j.Price__c - j.Adjustment_Amount__c);  
                
            }else if(j.Adjustment_Type__c == '% Discount'){
                                        
               disAmount =(j.Price__c * j.Adjustment_Amount__c)/100;                       
            }else if(j.Adjustment_Type__c == 'Discount Amount'){
                disAmount = j.Adjustment_Amount__c ;
            }
            
            
            system.debug('disAmount--->'+disAmount);
            
              
             system.debug('product--->'+j.Product__c);      
            if(j.Product__c != NULL){
               system.debug('product check--->'+prodMap.get(j.Product__c).DiscountLimit__c);
                if(prodMap.get(j.Product__c).DiscountLimit__c == true){
                 system.debug('inside product check--->');     
                    decimal proDis;
                    if(prodMap.get(j.Product__c).MaxDiscount__c != NULL){
                          system.debug('inside map check--->');
                    proDis  = prodMap.get(j.Product__c).MaxDiscount__c ;
                       system.debug('proDis--->'+proDis); 
                         system.debug('Price--->'+j.Price__c); 
                            maxDiscount  =  (j.Price__c * j.Quantity__c *proDis)/100;
                          system.debug('maxDiscount--->'+maxDiscount);
                        if((proDis == NULL || disAmount > maxDiscount) && j.Discount_Exception__c == false && gcs == false){
                          //  j.Product__c.adderror(' '+prodMap.get(j.Product__c).Product__r.name+'\'s Maximum discount '+proDis+'% exceeded');
                        j.Product__c.adderror('The maximum discount that can be applied to '+prodMap.get(j.Product__c).Product__r.name+' is '+proDis+'%. Please contact your Super User to proceed further.');
                       
                             
                        }
                    }   
                }
               
            }
            
        }
        
     /*   if(ispickval(Adjustment_Type__c,"Price Override"),(Price__c-(Adjustment_Amount__c/Quantity__c)),
      * if(ispickval(Adjustment_Type__c,"Base Price Override"),(Price__c-Adjustment_Amount__c),
      * if(ispickval(Adjustment_Type__c,"% Discount"),((Price__c*Adjustment_Amount__c)/100),Adjustment_Amount__c)))*/
        
        
        
        
        
    }
    
}