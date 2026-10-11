({
	doInit : function(component, event, helper) {
		var action = component.get("c.ReProcessedQuoteSent");
		action.setParams({
			'ids': ''+component.get('v.recordId')+''
		});
		action.setCallback(this, function(response) {
			var reProcess = response.getReturnValue();
			
            if(reProcess === 'Success'){
                component.set("v.message","Re-Processed Successfully");
                location.reload();
            }
			else{
                component.set("v.message","Error : "+reProcess);
			}
		});
		$A.enqueueAction(action);
	},
	accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})