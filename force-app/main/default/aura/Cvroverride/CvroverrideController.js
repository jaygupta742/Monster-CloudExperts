({
	Close : function(component, event, helper) {
		var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                      "url": "/lightning/o/Client_Validation_Request__c/home"
                    });
                    urlEvent.fire();
	}
})