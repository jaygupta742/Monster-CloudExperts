({
    chkv : function(component, event, helper) {
    var action = component.get('c.getdel');
        action.setParams({
           "rId":component.get('v.recordId')   
        });
    action.setCallback(this, function(res){
            console.log('res.getState():'+res.getState());
            
            
            console.log('res.getReturnValue():'+JSON.parse(res.getReturnValue()));
            if(res.getState() === "SUCCESS"){
        component.set("v.Del",JSON.parse(res.getReturnValue()));
        console.log('hhu'+component.get('v.Del')) ;    
               
            }
            
        });
        $A.enqueueAction(action);
    }
})