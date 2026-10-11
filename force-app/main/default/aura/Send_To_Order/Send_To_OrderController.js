({
	doInit : function(component, event, helper) {
        var proid;
        var pro = component.get("c.getprofileId");
            pro.setCallback(this, function(response) {
                proid = response.getReturnValue();
                if(proid != '00e7F000000uSShQAM'){
                    component.set("v.profileId",false);
                    component.set("v.message","Please click on Create Order");
                }
                else{
                    component.set("v.message","Please contact finance team to create order");
                }
                
            });
        $A.enqueueAction(pro);
	},
    createOrder : function(component, event, helper) {
    	helper.orderCreation(component, event, helper);
    },
		accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})