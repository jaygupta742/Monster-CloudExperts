({
    doinit : function(component, event, helper) {
                helper.getstatusquote(component, event, helper);
                        helper.getvalidatedquote(component, event, helper);

		var action = component.get("c.getAPACPayments");
        
        action.setParams({
            'recordId' : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.apac", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	},
    
    deleteit : function(component, event, helper) {
      	var index = event.getSource().get("v.value");
        var li = component.get("v.apac");
        
        li.splice(index, 1);
        
        component.set("v.apac", li);
    },
    
    saveit : function(component, event, helper) {
        var action = component.get("c.onsave");
        
        action.setParams({
            'recordId' : component.get("v.recordId"),
            'apac' : component.get("v.apac")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var title, type, message;
            
            if(state === 'SUCCESS') {
            	type="success";
                title="SUCCESS!!!";
                message="APAC Payments Updated Successfully!!!";
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+component.get("v.recordId")
                });
                urlEvent.fire();                
                $A.get('e.force:refreshView').fire();
            }
            
            if(state === "ERROR") {
                type="error";
                title="ERROR!!!";
                message="Something went wrong!!!";
            }
            
            var toastevent = $A.get("e.force:showToast");
            toastevent.setParams({
                'title':title,
                'type':type,
                'message':message
            });
            
            toastevent.fire();
        });
        
        $A.enqueueAction(action);
    },
    
    cancelit : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/"+component.get("v.recordId")
        });
        urlEvent.fire();                
        $A.get('e.force:refreshView').fire();
    },
})