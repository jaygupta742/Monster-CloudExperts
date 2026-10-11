({
    HandleSendEmail: function(component, event, helper) {
        let action = component.get("c.SendEmailNotfication");
        action.setParams({ 
            recid : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let rval = response.getReturnValue();
                let message = 'Email send successfully!.';
                helper.HandleShowToast(component, event, helper, 'Success!', message, 'success');
                helper.HandleNavigateRecord(component, component.get("v.recordId"));
                return;
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
    
    HandleOpenAlert: function(component, event, label, message, theme, onCallback) {
        this.LightningAlert.open({
            label: label,
            message: message,
            theme: theme,
        }).then(function() {
            onCallback();
            console.log('alert is closed');
        });
    },
    
    HandleOpenConfirm: function(component, event, label, message, theme, onCancel, onConfirm) {
        this.LightningConfirm.open({
            message: message,
            theme: theme,
            label: label,
        }).then(function(result) {
            console.log('confirm result is : ' + result);
            if(result) onConfirm();
            else onCancel();
        });
    },
    
    HandleShowToast : function(component, event, helper, title, message, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type
        });
        toastEvent.fire();
    },
    
    HandleNavigateRecord : function (component, recordId) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/" + recordId
        });
        urlEvent.fire();
    }
})