trigger CreateEmail on EmailMessage (before insert,after insert) {
    
    trigger__c t = [SELECT id,name,Active__c FROM trigger__c WHERE name='EmailMessage'];
    system.debug('customSetting------->'+t);
    if(t.Active__c == true){

list<email__c> em = new list<email__c>();

if(trigger.isbefore){

for(emailmessage e :  trigger.new){

system.debug('Record------->'+e);
system.debug('ID------->'+e.RelatedToId);
if(e.RelatedToId != NULL){
String s1 = string.valueof(e.RelatedToId);

if( (s1.startsWith('a0I') ) || (s1.startsWith('a0J') ) ){e.Compliance__c = s1;}
system.debug('compilance------->'+e.Compliance__c);
if((s1.startsWith('a0M'))){e.seeker__c = s1;}
system.debug('seeker------->'+e.seeker__c);

 }
}


}

if(trigger.isafter){
for(emailmessage e :  trigger.new){

system.debug('Record------->'+e);
system.debug('ID------->'+e.RelatedToId);
if(e.RelatedToId != NULL){
String s1 = string.valueof(e.RelatedToId);

/*if(s1.startsWith('a0I')){e.Compliance__c = s1;}
system.debug('compilance------->'+e.Compliance__c);*/

if(s1.startsWith('a0W')){
system.debug('status------->'+e.Status);
system.debug('CaseID------->'+s1);
if(e.Status == '3'){
email__c ee = new email__c();
ee.Body__c = e.TextBody;
ee.Case__c = e.RelatedToId;
ee.Subject__c = e.Subject;
ee.Mail_ID__c  = e.id;
ee.Email_Address__c = e.FromAddress;
em.add(ee);
}
}
}
}

insert em;
system.debug('email------>'+em);
}
    
}
}