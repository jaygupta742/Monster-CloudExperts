({
    doInit : function(component, event, helper) {
        
        
		var action = component.get("c.getPickListValuesIntoList");
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistValues", list);
        })
        // Invoke the service
        $A.enqueueAction(action);
    },
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    updateAccount : function(component, event, helper) {
        var action = component.get("c.updateAccountStat");
        //alert('Record Id'+component.get("v.accountRecordId"));
        action.setParams({
            "accountId": component.get("v.accountRecordId"),
            "accountStat" : component.find("selectSP").get("v.value")
        });
        // Register the callback function
        action.setCallback(this, function(response) {
            var updateResult = response.getReturnValue();
            if(updateResult === 'Success'){
                //alert('Success '+updateResult);
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
        		dismissActionPanel.fire();
                var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                    "entityApiName": "Task" ,
                    "defaultFieldValues":{
                    "WhatId" : component.get("v.accountRecordId"),
                    "Status" : "Completed",
                    "ActivityDate" : $A.localizationService.formatDate(new Date(), "YYYY-MM-DD")
                    }
                }); 
                createRecordEvent.fire();
            }
            else{
                alert('Error '+updateResult);
            }
        });
        
        $A.enqueueAction(action);
        
    }
})