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
    },
    getapprovalstatus : function(component, event, helper) {
        var action = component.get('c.getstatus');
        action.setParams({
            "rid":component.get('v.recordId')   
        });
        action.setCallback(this, function(res){
            console.log('state stat:'+res.getState());
            if(res.getState() === "SUCCESS"){
                component.set("v.status",res.getReturnValue());
                console.log('stat'+component.get('v.status')) ;    
            }
        });
        $A.enqueueAction(action);
    },
    getValidatedapprovalstatus : function(component, event, helper) {
        var action = component.get('c.getValidatedstatus');
        action.setParams({
            "rid":component.get('v.recordId')   
        });
        action.setCallback(this, function(res){
            console.log('state stat:'+res.getState());
            if(res.getState() === "SUCCESS"){
                component.set("v.Validationstatus",res.getReturnValue());
                console.log('stat'+component.get('v.status')) ;    
            }
        });
        $A.enqueueAction(action);
    }
})