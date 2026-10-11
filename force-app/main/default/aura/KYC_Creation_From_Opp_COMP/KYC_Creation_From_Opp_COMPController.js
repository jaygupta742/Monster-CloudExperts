({
	doInit : function(component, event, helper) {
        console.log("Inside ----1");
		var getresponsefromfirst;
        var action = component.get("c.getRecord");
        action.setParams({
            "recordId" : component.get("v.recordId")
        });
        console.log("Inside ----2");
        action.setCallback(this,function(res){
            var status = res.getState();
            if(status === "SUCCESS")
            {
                console.log("Inside --SUCCESS 1--1");
				getresponsefromfirst = res.getReturnValue();
                var action1 = component.get("c.create_new_kyc");
                action1.setParams({
                    "accid" : getresponsefromfirst.Account__c
                });
                console.log("Inside --SUCCESS 1--2");
                action1.setCallback(this,function(res1){
                    var state = res1.getState();
                    if(state === "SUCCESS")
                    {
                          console.log("Inside --ssssss 2--2");
                        if(res1.getReturnValue() === "Success KYC")
                        {
                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();
                            console.log("Inside --ssssss 2--3");
                           var action2 = component.get("c.savekyc");
                            action2.setParams({
                                "opp1" : getresponsefromfirst
                            });
                            action2.setCallback(this,function(res3){
                                var state1 = res3.getState();
                               if(state1 === "SUCCESS")
                               {
                                   console.log("Inside ultimate SUCC");
                               }
                            });
                             $A.enqueueAction(action2);
                            console.log("Inside --ssssss 2--4");
                            
                            
                        }
                        else if(res1.getReturnValue() === "Success Quote")
                        {
                            console.log("Inside --ssssss 2--5");
                            component.set("v.message","KYC is required only for INDIAN account/KYC already validated please proceed with quote");
                        }
                         else{
                             console.log("Inside --ssssss 2--6");
                            component.set("v.message","Error: "+res1.getReturnValue());
                        }
                    }
                });
                $A.enqueueAction(action1);
            }
            else{
                console.log("Inside else block");
            }
        });
        $A.enqueueAction(action);
	},
     accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        location.reload();
    }
})