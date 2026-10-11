trigger UpdateApacPayment1 on APAC_Payments__c (after insert,after update,after delete,after undelete) {
    Trigger__c t = trigger__c.getvalues('ApacPayment');
    if(t.active__C == true){
        set<Id> qid=new set<Id>();
        if(trigger.isinsert || trigger.isupdate || trigger.isundelete){
            
            for(APAC_Payments__c pp:trigger.new){
                if(pp.Quotes__c!=null){
                    qid.add(pp.Quotes__c);
                }
            }
        }
        if(trigger.isdelete){
            for(APAC_Payments__c pp:trigger.old){
                if(pp.Quotes__c!=null){
                    qid.add(pp.Quotes__c);
                }
            }
        }
        
        if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
            List<QuotesN__c> qulist=[select id, name, Net_Total__c, (SELECT id,name,TDS_Payment_Amount__c,Payment_Amount__c,Net_Total__c from APAC_Payments__r) from QuotesN__c where id=:qid];
            //List<QuotesN__c> qu=[select id,name from QuotesN__c ];
            for(APAC_Payments__c pp:trigger.new){
                for(QuotesN__c qq:qulist){
                    decimal tot=0;
                    for(APAC_Payments__c ppp:qq.APAC_Payments__r){
                        if(ppp.Payment_Amount__c!=null && ppp.TDS_Payment_Amount__c!=null){
                            //tot+=ppp.Net_Total__c;
                            tot+=ppp.Payment_Amount__c;
                            tot+=ppp.TDS_Payment_Amount__c;
                        }
                    }
                    system.debug('tot:'+tot);
                    if(qq.Net_Total__c!=tot){
                        pp.addError('The sum of Tds Amount and Payment amount will be equal to net total');
                    }
                }
            }
        }
    }
}