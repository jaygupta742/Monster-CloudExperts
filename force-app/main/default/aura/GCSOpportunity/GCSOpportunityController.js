({
	doInit : function(component, event, helper) {
        var opportunityRecordVal;
        var action = component.get("c.checkForError");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                var reuturnVal = response.getReturnValue();
                var res = reuturnVal.split(" ");
                if (res[0] === "Success"){
                    
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                      "url": "/"+res[1]
                    });
                    urlEvent.fire();
                }
                else{
                 		component.set("v.message","Error: "+response.getReturnValue());
            	}
            }
            else{
                 component.set("v.message","Error: "+response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})