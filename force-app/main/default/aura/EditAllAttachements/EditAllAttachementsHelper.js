({
	getstatusquote : function(component, event, helper) {
		var action = component.get("c.getstatus");
        
        action.setParams({
            'rid':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.status", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	},
    fetchatt : function(component, event, helper) {
		var action = component.get("c.get_Attachements1");
        
        action.setParams({
            'recordId':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state new att:'+state);
            
            if(state === 'SUCCESS') {
                component.set("v.attach", response.getReturnValue());
                console.log('att list:'+component.get('v.attach'));
            }
        });
        
        $A.enqueueAction(action);
	},
    
})