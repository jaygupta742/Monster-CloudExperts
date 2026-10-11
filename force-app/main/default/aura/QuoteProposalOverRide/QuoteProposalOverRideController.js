({
	Close : function(component, event, helper) {
		var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                      "url": "/lightning/o/apttus_proposal_proposal__c/home"
                    });
                    urlEvent.fire();
	}
})