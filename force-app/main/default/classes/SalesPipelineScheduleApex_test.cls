@isTest
public class SalesPipelineScheduleApex_test {
    
    static testmethod void MEthod1(){
 SalesPipelineScheduleApex sp = new SalesPipelineScheduleApex();
 
 
 Test.StartTest();
 
 String sch = '0 0 23 * * ?'; 
 
 system.schedule('Test Territory Checkaa', sch, sp);
 
  Test.stopTest();
 
 }

}