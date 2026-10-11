({
	doinit : function(component, event, helper) {
        helper.getstatusquote(component, event, helper);
		var action = component.get("c.get_Top_Ups");
        
        action.setParams({
            'recordId':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.acc", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	},
    
    cancelit : function(component, event, helper) {
        var urlEvent=$A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url":"/"+ component.get("v.recordId")
        });
        urlEvent.fire();
    },
    
    deleteit : function(component, event, helper) {
        var index = event.getSource().get("v.value");
        var acc = component.get("v.acc");
        
        acc.splice(index, 1);
        
        component.set("v.acc", acc);
    },
    
    saveit : function(component, event, helper) {
        var action = component.get("c.onsave");
        
        action.setParams({
            'recordId':component.get("v.recordId"),
            'acc' : component.get("v.acc")
        });
        let button = component.find('disablebuttonid');
        button.set('v.disabled',true);
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var title, type, message;
            
            if(state === 'SUCCESS') {
            	title = 'SUCCESS';
                type = "success";
                message = "QULI Top Ups updated successfully!!!";
                
                var urlEvent=$A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url":"/"+ component.get("v.recordId")
                });
                urlEvent.fire();
            }
            
            if(state === 'ERROR') {
                title = "ERROR";
                type="error";
                let err = response.getError();
                message = err[0].message;
            }
            
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type":type,
                "message": message
            });
            toastEvent.fire();

        });
        
        $A.enqueueAction(action);
    }
})