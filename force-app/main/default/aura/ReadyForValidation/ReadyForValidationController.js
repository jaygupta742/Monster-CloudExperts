({
	doInit : function(component, event, helper) {
        console.log("Insdie dointi");
        var quoteRecordVal;
        var action = component.get("c.getRecord");
        console.log("Insdie dointi---1");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
        	var state = response.getState();
             
            if (state === "SUCCESS"){
                 console.log("Insdie success---");
                quoteRecordVal = response.getReturnValue();
                if(quoteRecordVal.Payment_count__c == 0){
                    return component.set("v.message","Please add  APAC payment to validate");
                }
                else if(quoteRecordVal.Validated__c == true){
                    return component.set("v.message","Quote already Validated");
                }
                else{
                     
                        var action1 = component.get("c.checkForAttachment");
                        action1.setParams({ "quoteRecord" : quoteRecordVal });
                   
                        action1.setCallback(this, function(response1) {
                            var state1 = response1.getState();
                            console.log('Before success'+response1.getReturnValue());
                            if (state1 === "SUCCESS"){
                                 
                                if(response1.getReturnValue() === true){
                                    
                                    return component.set("v.message","Please click Generate Quote Report in PDF format to add into Attachments");
                                }
                                else{
                                     
                                    location.reload();
                                }
                            }
                            else{
                                console.log("IN No28 else block ");
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