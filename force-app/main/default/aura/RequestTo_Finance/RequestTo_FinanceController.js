({
    doInit : function(component, event, helper) {
        var quoteRecordVal;
        var action = component.get("c.getRecord");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS"){
        	quoteRecordVal = response.getReturnValue();
              /*if(quoteRecordVal.Approval_Status__c != 'Approved'){
                    return component.set("v.message","Get Credit Request Approved before you Request to Finance");
                }
                else{
                     var action1 = component.get("c.myMethod");
                     action1.setParams({ quoteRecord : quoteRecordVal });
                     action1.setCallback(this, function(response1) {
                     var state1 = response1.getState();
                     if(state1 === "SUCCESS"){
                        if(response1.getReturnValue() === true){
                             return component.set("v.message","Credit Request Approved Successfully");
                        } else{
                             location.reload();
                         }
                       }
                      });
                      $A.enqueueAction(action1);
                    } */
            }
        });
        $A.enqueueAction(action);
	},
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})