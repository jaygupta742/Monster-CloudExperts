@RestResource(urlMapping='/Reassign/*')
//@ joshith 
global class Approval_helper {

  
    @HttpPost 
    global static String createNewWidget(String Name) {
       list<string> dd=new list<string>();
       dd.addall(Name.split(','));
        List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId
        From ProcessInstanceWorkitem p where p.ProcessInstance.TargetObjectId = :dd[0]];

 if(workItemList.size()>0)

workItemList[0].ActorId  =dd[1];

 system.debug('approval'+workItemList);

update workItemList;

        return 'Done';
   }

}