global class scheduleEscalation implements Schedulable{
    public string evtIds;
    public Id jobId;
    public scheduleEscalation(String eventId){
        evtIds = eventId;
        system.debug('evtIds : '+evtIds);
        //jobId = execjobId;
    }
    
   global void execute(SchedulableContext sc){
       system.debug('sc : '+sc);
       schedulerHelperExecution sce = new schedulerHelperExecution(evtIds);
       
       //ID BatchId= Database.executeBatch(new escalationBatch(evtIds), 200);  
       //system.debug('BatchId : '+BatchId);
    }
    
   /* public static Id SchedulerMethod(String name,String cron_exp){
    	Id jobId= System.Schedule(name, cron_exp, new scheduleEscalation());
        system.debug('jobId: '+jobId);
    	return jobId;
    }*/

}