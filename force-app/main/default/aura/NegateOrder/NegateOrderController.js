({
	doInit : function(component, event, helper) {
        var quoteRecordVal;
        var action = component.get("c.negate");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                if(response.getReturnValue === true){
                    component.set("v.message","Order Status must be \"Rejected\" AND Negation Type must be specified in order to Negate an Order")
                }
                else{
                    component.set("v.message","Order Negated Successfully");
                    location.reload();
                }
            }
        });
        $A.enqueueAction(action);
	},
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})