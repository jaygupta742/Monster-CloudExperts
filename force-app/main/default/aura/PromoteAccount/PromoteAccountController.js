({
    doInit : function(component, event, helper) {
        
        
        var action = component.get("c.getAddressAndContactStat");
        action.setParams({
            "accountId": component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.error", list);
        })
        // Invoke the service
        $A.enqueueAction(action);
    },
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})