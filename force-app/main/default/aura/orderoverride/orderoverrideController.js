({
	Close : function(component, event, helper) {
		var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                      "url": "/lightning/o/OrderC__c/home"
                    });
                    urlEvent.fire();
	}
})