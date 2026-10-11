/*
Last Modified Date      Last Modified By        Description
01/05/2023              Debasis Das             Allow only Account Owner and Account team member to create new opportunity
11/05/2023              Abdul Aziz              Added Opportunity Creation Restriction for account owner and for Acccount Team Member
23/06/2023              Pranil Ganvir           Added Method to update Closer week according to close date of opportunity
18/07/2023              Pranil Ganvir           Added Method to avoid the opportunity update to closed won if it has no order
06/06/2024				Debasis Das				Need to reconfig, so that Lead Managment & Customer Sucusess users can create opportunity
26/06/2024				Jay Gupta				Updated Code For Account Status Validation
03/06/2024				Jay Gupta				Updated Code For Comments Implementation
*/ 

trigger AccountOppRollUpSummary on OpportunityN__c (before insert, before update, after insert, after update, after delete, after undelete) {  
    if(Trigger.isBefore && Trigger.isInsert && AccountOppRollUpSummary_Helper.Flag_BeforeInsert) {
        AccountOppRollUpSummary_Helper.HandleBeforeInsert(Trigger.New,Trigger.oldMap);
    }

    if(Trigger.isAfter && Trigger.isInsert && AccountOppRollUpSummary_Helper.Flag_AfterInsert){
        AccountOppRollUpSummary_Helper.HandleAfterInsert(Trigger.New,Trigger.oldMap);
    }

    if(trigger.isBefore && Trigger.isUpdate && AccountOppRollUpSummary_Helper.Flag_BeforeUpdate) {
        AccountOppRollUpSummary_Helper.HandleBeforeUpdate(Trigger.New, Trigger.Old,Trigger.oldMap);
    } 

    if(trigger.isAfter && Trigger.isUpdate && AccountOppRollUpSummary_Helper.Flag_AfterUpdate) {
        AccountOppRollUpSummary_Helper.HandleAfterUpdate(Trigger.New, Trigger.Old,Trigger.oldMap);
    }
}