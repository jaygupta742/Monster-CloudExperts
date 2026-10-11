trigger discountcalconqline1 on Quote_Line_Items__c (before insert,before update) {
    Trigger__c t = trigger__c.getvalues('QuoteLineItems');
    if(t.active__C == true){
        set<Id> rid=new set<Id>();
        for(Quote_Line_Items__c qq:trigger.new){
            rid.add(qq.Id);
        }
        List<Quote_Line_Items__c> quli=[select id,Level_of_Approval_Required__c,Category1__c,Discount_Cap1__c from Quote_Line_Items__c where id=:rid];
        system.debug('quli:'+quli);
        for(Quote_Line_Items__c qq:trigger.new){
            if(qq.Discount_Cap1__c<=0){
                qq.Level_of_Approval_Required__c=0;
            }
        }
        List<Quote_Line_Items__c> quli1=[select id,Level_of_Approval_Required__c,Category1__c,Discount_Cap1__c from Quote_Line_Items__c where id=:rid];
        system.debug('quli1:'+quli1);
        for(Quote_Line_Items__c qq:trigger.new){
            system.debug('cat:///'+qq.Category1__c);
            system.debug('discount cap  /// '+qq.Discount_Cap1__c);
            if(qq.Category1__c=='A'){
                if(qq.Discount_Cap1__c>0 && qq.Discount_Cap1__c<=10){
                    qq.Level_of_Approval_Required__c=3;
                }
            }
            if(qq.Category1__c=='B'){
                if(qq.Discount_Cap1__c>0 && qq.Discount_Cap1__c<10){
                    qq.Level_of_Approval_Required__c=1;
                    system.debug('cate b less than 10');
                }
                if(qq.Discount_Cap1__c>=10 && qq.Discount_Cap1__c<=15){
                    qq.Level_of_Approval_Required__c=2;
                }
                if(qq.Discount_Cap1__c>=15 && qq.Discount_Cap1__c<=20){
                    qq.Level_of_Approval_Required__c=3;
                }
                if(qq.Discount_Cap1__c>20){
                    qq.Level_of_Approval_Required__c=4;
                }
            }
            
            if(qq.Category1__c=='C'){
                if(qq.Discount_Cap1__c>0 && qq.Discount_Cap1__c<20){
                    qq.Level_of_Approval_Required__c=1;
                }
                if(qq.Discount_Cap1__c>=20 && qq.Discount_Cap1__c<=25){
                    qq.Level_of_Approval_Required__c=2;
                }
                if(qq.Discount_Cap1__c>=25 && qq.Discount_Cap1__c<=30){
                    qq.Level_of_Approval_Required__c=3;
                }
                if(qq.Discount_Cap1__c>30){
                    qq.Level_of_Approval_Required__c=4;
                }
            }
            
            if(qq.Category1__c=='D'){
                if(qq.Discount_Cap1__c>0 && qq.Discount_Cap1__c<30){
                    qq.Level_of_Approval_Required__c=1;
                }
                if(qq.Discount_Cap1__c>=30 && qq.Discount_Cap1__c<=35){
                    qq.Level_of_Approval_Required__c=2;
                }
                if(qq.Discount_Cap1__c>=35 && qq.Discount_Cap1__c<=40){
                    qq.Level_of_Approval_Required__c=3;
                }
                if(qq.Discount_Cap1__c>40){
                    qq.Level_of_Approval_Required__c=4;
                }
            }
        }
    }   
}