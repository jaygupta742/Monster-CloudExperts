({
	doInit : function(component, event, helper) {
        var orderRecordVal;
        var action = component.get("c.getRecord");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                orderRecordVal = response.getReturnValue();
                if(orderRecordVal.RejectedReason__c == null){
                    return component.set("v.message","Please Choose Rejected Reason");
                }
                else{
                        var action1 = component.get("c.ORderRejectCatcher");
                        action1.setParams({ Ids : orderRecordVal.Id });
                        action1.setCallback(this, function(response1) {
                            var state1 = response1.getState();
                            if (state1 === "SUCCESS"){
                                    component.set("v.message","Order Rejected");
                                    location.reload();
                                }
                        });
                        $A.enqueueAction(action1);
               }
            }
        });
        $A.enqueueAction(action);
	},
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})