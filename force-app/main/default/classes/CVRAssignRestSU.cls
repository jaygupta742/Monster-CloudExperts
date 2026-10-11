@RestResource(urlMapping='/updateHerereasignng/*')
global class CVRAssignRestSU {
    
    @HttpPost 
    global static String createNewWidget(String Name) {        
       user SuperUsr = [SELECT id,name,managerid,UserRole.name,Alias,manager.UserRole.name FROM user WHERE name ='Super User']; 
       User ceo = [SELECT id,name,managerid,UserRole.name,Alias,manager.UserRole.name FROM user WHERE name ='Sekhar Garisa']; 
        id rid = Name;
       System.debug('name value'+name);       
       System.debug('rid value'+rid);   
       System.debug('Logged in user'+userinfo.getFirstName());    
         ProcessInstanceWorkItem pw = [Select ProcessInstance.Status, ProcessInstance.TargetObjectId,ProcessInstanceId,
                                       OriginalActorId,Id,ActorId From ProcessInstanceWorkitem 
                                       where ProcessInstance.TargetObjectId =: rid]; 
        System.debug('ProcessInstanceWorkItem value'+pw);
        System.debug('ProcessInstanceWorkItem Actor id'+pw.ActorId);
        
        id uid = pw.ActorId; 
        
       user u = [SELECT id,name,managerid,UserRole.name,Alias,manager.UserRole.name FROM user WHERE id =:uid];
   
         if(u.Alias == 'sgari'){
            pw.ActorId  = SuperUsr.id;          
            system.debug('approval--->'+pw);
            update pw;
             System.debug('ProcessInstanceWorkItem actor value after update'+pw.ActorId);
            return 'Success';
        }
        else            
            return 'Failed';
       
       /*if(u.Alias != 'USuper'){
            pw.ActorId  = u.ManagerId;
            //pw.ActorId  = SuperUsr.id;
            
            system.debug('approval--->'+pw);
            update pw;
            return 'Success';
        }
        else            
            return 'Failed';
        */
   }


}