/*Created By : Abdul Aziz , Created Date : 25/08/2023 , Description : Trigger to rollup order start and end date*/
trigger OrderRollUpDate on OrderC__c (after insert , after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        if(OrderRollUpDateHelper.isFirstRun){
            OrderRollUpDateHelper.isFirstRun=false;
            OrderRollUpDateHelper.updateAccountServiceStartDate(Trigger.New);
            OrderRollUpDateHelper.updateAccountServiceEndDate(Trigger.New);
        }
    }
}