({

        doInit : function(component, event, helper) {
            console.log("Inside Do Init-----1");
            var action = component.get("c.met");
            action.setParams({
                'recid': ''+component.get('v.recordId')+''
            });
            console.log("Inside Do Init-----2");
            action.setCallback(this, function(response) {
                var state = response.getReturnValue();
                    if (state === "\"Failed\"") {
                        component.set('v.message','You cannot escalate to Super User');
                        component.set('v.show',true);
                    } else {
                        component.set('v.message','Reassigned successfully');
                        component.set('v.show',true);
                    }
            });
            $A.enqueueAction(action);
	}
})