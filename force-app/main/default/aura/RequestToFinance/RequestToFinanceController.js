({
    doInit : function(component, event, helper) {
        var quoteRecordVal;
        var action = component.get("c.myMethod");
        action.setParams({ recid : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS"){
                quoteRecordVal = response.getReturnValue();
            	console.log('Hello Pawan Sonu-->'+quoteRecordVal);
                component.set("v.message",quoteRecordVal);
                /*if(quoteRecordVal.Payment_count__c == 0){
                    return component.set("v.message","Please add  APAC payment to validate");
                }*/
               /*
                * Commented 
                * if(quoteRecordVal.Approval_Status__c == 'Approved'){
                    component.set("v.message","Credit Request Already Approved");
                }*
                */
               /* else{
                        var action1 = component.get("c.checkForAttachment");
                        action1.setParams({ quoteRecord : quoteRecordVal });
                        action1.setCallback(this, function(response1) {
                            var state1 = response1.getState();
                            if (state1 === "SUCCESS"){
                                if(response1.getReturnValue() === true){
                                    return component.set("v.message","Please click Generate Quote Report in PDF format to add into Attachments");
                                }
                                else{
                                    location.reload();
                                }
                            }
                        });
                        $A.enqueueAction(action1);
               }*/
            }
        });
        $A.enqueueAction(action);
	},
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})