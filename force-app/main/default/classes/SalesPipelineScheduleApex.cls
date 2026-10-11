global class SalesPipelineScheduleApex implements schedulable{
    
    global void execute(schedulableContext sc ){

      SalesPipeline.GenerateExcel();

    }

}