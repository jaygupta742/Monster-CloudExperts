({
	doInit : function(component, event, helper) {
        var kycRecordVal;
        var action = component.get("c.getRecord");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                kycRecordVal = response.getReturnValue();
                if(kycRecordVal.Stage__c == 'Submitted' || kycRecordVal.Status__c == 'Open' || kycRecordVal.Response__c == null){
                    return component.set("v.message","Please change status, Stage and provide some value in response");
                }
                else{
                        var action1 = component.get("c.cvrmeth");
                        action1.setParams({ IDD : component.get("v.recordId") });
                        action1.setCallback(this, function(response1) {
                            var state1 = response1.getState();
                            if (response1.getReturnValue() === "Success"){
                                return component.set("v.message","Account updated successfully and sales rep notified");
                            }
                            else{
                                return component.set("v.message",response1.getReturnValue());
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