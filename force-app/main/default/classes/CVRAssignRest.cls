@RestResource(urlMapping='/updateHereram/*')
global class CVRAssignRest {
    
    @HttpPost 
    global static String createNewWidget(String Name) {
       id rid = Name;
       //System.debug('idvalue'+Id); 
           
         ProcessInstanceWorkItem pw = [Select ProcessInstance.Status, ProcessInstance.TargetObjectId,ProcessInstanceId,
                                       OriginalActorId,Id,ActorId From ProcessInstanceWorkitem 
                                       where ProcessInstance.TargetObjectId = :rid]; 
 
        id uid = pw.ActorId; 
        
       user u = [SELECT id,name,managerid,UserRole.name,Alias,manager.UserRole.name FROM user WHERE id =:uid];
        
        system.debug('User name'+u.name+' user rolename--->'+u.manager.UserRole.name+'User Alias-->'+u.Alias);

     //   if(u.manager.UserRole.name != 'Super User'){
   if(u.Alias != 'USuper'){
        pw.ActorId  = u.ManagerId;

        
 system.debug('approval--->'+pw);
  update pw;
             return 'Success';
        }
        else
            
            return 'Failed';
       
   }


}