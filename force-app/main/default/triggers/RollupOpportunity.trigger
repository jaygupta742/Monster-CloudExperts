trigger RollupOpportunity on Opportunity__c (after delete, after insert, after update, after undelete) {
    
     if( trigger.isDelete)
     {
         
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
                      new RollUpSummaryUtility.fieldDefinition('SUM', 'no__c','No_of_Opportunity__c')
                          };
        
         
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, trigger.old, 
       ' Opportunity__c	', 'Account__c', 'Account','');
       
  }  
    
     if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete)
     {
         
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'no__c','No_of_Opportunity__c')
              };
        
         
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitions, trigger.new, 
        'Opportunity__c', 'Account__c', 'Account','');
         
  }
    
    
    
}