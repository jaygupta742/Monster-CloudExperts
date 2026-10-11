({
	getOrderObject : function(component, event, helper) {
        var action = component.get("c.getOrderObj");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                
                component.set("v.orderObj",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
})