/*Create By : Abdul Aziz , Created Date : 17/06/2023 , ActivationTrigger for sending Email after record creation*/
trigger ActivationTrigger on Activation__c (after insert) {
    Trigger__c t = trigger__c.getvalues('Activation');
    if(t.active__C == true){
        if(trigger.isafter && trigger.isInsert)
        {
            ActivationTriggerHelper.sendEmail(trigger.new);
            
        }
    }
}