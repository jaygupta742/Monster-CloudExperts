({
	getstatusquote : function(component, event, helper) {
		var action = component.get("c.getstatus");
        
        action.setParams({
            'rid':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('status st:'+state);
            if(state === 'SUCCESS') {
                component.set("v.status", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	},
    getvalidatedquote : function(component, event, helper) {
		var action = component.get("c.getvalidated");
        
        action.setParams({
            'rid':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('status validated:'+state);
            if(state === 'SUCCESS') {
                component.set("v.validated", response.getReturnValue());
                console.log('validated:'+component.get("v.validated"));
            }
        });
        
        $A.enqueueAction(action);
	},
})