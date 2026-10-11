({
	orderCreation : function(component, event, helper) {
        console.log("In Ordercreationpage----1");
        var createorder = false;
        var disabled = false;
        console.log("In Ordercreationpage----2");
            var action = component.get("c.getOrderCount");
        	component.set("v.disabled",true);
            action.setParams({
                'quoteId': ''+component.get('v.recordId')+''
            });
        console.log("In Ordercreationpage----3");
            action.setCallback(this, function(response) {
                console.log("In Ordercreationpage----4");
                var ordercount = response.getReturnValue();
                if(ordercount >= 1){
                    component.set("v.error",true);
                    component.set("v.message","Cannot create more than one order");
                    
                }
                else{
                    createorder = true;
                    disabled = false;
                }
                if(createorder){
                    console.log("In Ordercreationpage----5");
                var action1 = component.get("c.myMethod");
                action1.setParams({
                    'ids': ''+component.get('v.recordId')+''
                });
                    console.log("In Ordercreationpage----6");
                action1.setCallback(this, function(response) {
                    var state = response.getState();             
                    if(state === "SUCCESS"){
                        
                        console.log("In Ordercreationpage--SUCCESS--7");
                        component.set("v.message","Order Created Successfully");
                        var eUrl= $A.get("e.force:navigateToURL");
                        eUrl.setParams({
                          "url": '/'+response.getReturnValue()
                        });
                        eUrl.fire();
                    }
                });
                $A.enqueueAction(action1);
            }
            });
            
            $A.enqueueAction(action);
	}
})