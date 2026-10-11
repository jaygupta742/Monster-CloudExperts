({
	doInit : function(component, event, helper) {
        var orderRecordVal;
        var action = component.get("c.getRecord");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                orderRecordVal = response.getReturnValue();
                if(orderRecordVal.OrderStatus__c == "Verified" || orderRecordVal.OrderStatus__c == "Closed" || orderRecordVal.OrderStatus__c == "Negated" || orderRecordVal.OrderStatus__c == "Rejected"){
                    return component.set("v.message","Order is already in Verified/Closed/Negated/Rejected status can not be sent to varification.");
                }
                else{
                        var action1 = component.get("c.xCodeCount");
                        action1.setParams({ AccountID : orderRecordVal.Acct_SF_Id__c });
                        action1.setCallback(this, function(response1) {
                            var state1 = response1.getState();
                            if (state1 === "SUCCESS"){
                                if(response1.getReturnValue() === true){
                                    return component.set("v.message","XCode is required on (all) Order Line Item(s).");
                                }
                                else{
                                    	var action2 = component.get("c.ORderVerfiCatcher");
                                        action2.setParams({ Ids : orderRecordVal.Id });
                                        action2.setCallback(this, function(response2) {
                                            var state2 = response2.getState();
                                            if (state2 === "SUCCESS"){
                                                return component.set("v.message","Verified successfully");
                                                location.reload();
                                            }
                                            else{
                                            	return component.set("v.message","Error, Please contact system administator");
                                            }
                                        });
                                        $A.enqueueAction(action2);
                                }
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
        location.reload();
    }
})