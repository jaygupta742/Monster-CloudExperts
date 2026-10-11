({
	doInit : function(component, event, helper) {
        var quoteRecordVal;
        var action = component.get("c.generatecsv");
        action.setParams({ cvrid : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                if(response.getReturnValue() === 'Success'){
                    component.set("v.message","Validation Review Created Successfully")
                }
                else{
                    component.set("v.message","Error: "+response.getReturnValue());
                    
                }
            }
        });
        $A.enqueueAction(action);
	},
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        location.reload();
    }
})