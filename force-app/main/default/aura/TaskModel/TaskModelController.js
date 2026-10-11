({
	doInit : function(component, event, helper) {
		
		/*var evt = $A.get("e.c:passAccountId");
		alert('TM AID '+component.get("v.recordId"));
		var evtAid = component.get("v.recordId");
		evt.setParams({"AccountId":evtAid.toString()});
		evt.fire();
		alert('event fired');

		/*var compEvent = component.getEvent("navAccountId");
		alert('TM AID '+component.get("v.recordId"));
		var evtAid = component.get("v.recordId");
		compEvent.setParams({"AccountId":evtAid});
		compEvent.fire();*/
		
		

		var action = component.get("c.getAccountStat");
        action.setParams({
            "accountId": component.get("v.recordId")
        }); 
        // Register the callback function
        action.setCallback(this, function(response) {
			var data = response.getReturnValue();
			component.set("v.showAccount",data);
			if(!data){
				//alert('Not Fire');
				var dismissActionPanel = $A.get("e.force:closeQuickAction");
        		dismissActionPanel.fire();
				var createRecordEvent = $A.get("e.force:createRecord");
				createRecordEvent.setParams({
                    "entityApiName": "Task" ,
                    "defaultFieldValues":{
                    "WhatId" : component.get("v.recordId"),
                    "Status" : "Completed",
                    "ActivityDate" : $A.localizationService.formatDate(new Date(), "YYYY-MM-DD")
                    }
                }); 
                createRecordEvent.fire();
			}
		});
		$A.enqueueAction(action);
	}
})