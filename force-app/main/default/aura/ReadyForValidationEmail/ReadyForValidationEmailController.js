({
    doinit : function(component, event, helper) {
        let action = component.get("c.getRecord");
        action.setParams({ 
            recordId : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let rval = response.getReturnValue();
                let message = 'Are you sure you want to perform this action? This will lock the record. Click on "OK" to continue.';
                helper.HandleOpenConfirm(component, event, 'Warning! Record will locked!', message, 'warning', function() {
                    helper.HandleNavigateRecord(component, component.get("v.recordId"));
                    return;
                }, function() {
                    helper.HandleSendEmail(component, event, helper);
                    return;
                });
            }
            if(state === "ERROR") {
                let error = response.getError();
                let error_message = error[0].message;
                helper.HandleOpenAlert(component, event, 'Error!, Please review error meessage!', error_message, 'error', function() {
                    helper.HandleNavigateRecord(component, component.get("v.recordId"));
                    return;
                });
            }
        });
        $A.enqueueAction(action);
    },
    
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
})