({
    getquoteinformation : function(component, event, helper) {
        var action = component.get("c.getquoteinfo");
        action.setParams({
            "rid" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                component.set("v.qq1",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    
    sendemail : function(component,event, helper) {
        console.log("Under email helper");
        var action = component.get("c.sendMail");
        action.setParams({
            'rid': component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let rval = response.getReturnValue();
                if(rval === 'error-1') {
                    let toast_data = {};
                    toast_data.title = "WARNING";
                    toast_data.type = "warning";
                    toast_data.message = "You can't do escalate.";
                    this.show_toast(component, event, helper, toast_data);
                    return;
                }
                if(rval === 'error-2') {
                    let toast_data = {};
                    toast_data.title = "ERROR";
                    toast_data.type = "error";
                    toast_data.message = "You are not allowed to do.";
                    this.show_toast(component, event, helper, toast_data);
                    return;
                }
                if(rval === 'success') {
                    let toast_data = {};
                    toast_data.title = "SUCCESS";
                    toast_data.type = "success";
                    toast_data.message = "Email notification has been sent.";
                    this.show_toast(component, event, helper, toast_data);
                    return;
                }
            } else {
                console.log("Email Not Send");
            }
        });
        $A.enqueueAction(action);
    },
    
    show_toast : function(component, event, helper, toast_data) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": toast_data.title,
            "type": toast_data.type,
            "message": toast_data.message
        });  
        toastEvent.fire();
    }
})