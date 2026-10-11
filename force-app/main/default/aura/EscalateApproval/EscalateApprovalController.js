({

        doInit : function(component, event, helper) {
            var action = component.get("c.met");
            action.setParams({
                'recid': ''+component.get('v.recordId')+''
            });
            action.setCallback(this, function(response) {
                var state = response.getReturnValue();
                    if (state === "\"Failed\"") {
                        component.set('v.message','You cannot reassign further');
                        component.set('v.show',true);
                    } else {
                        component.set('v.message','Reassigned successfully');
                        component.set('v.show',true);
                    }
            });
            $A.enqueueAction(action);
	}
})