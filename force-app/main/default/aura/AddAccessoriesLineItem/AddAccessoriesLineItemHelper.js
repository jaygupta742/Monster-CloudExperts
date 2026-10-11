({
	x:[],
	fetchOpportunity : function(component, event, helper) {
		var action = component.get('c.getRelatedAccessories');
        var recId = component.get("v.recordId");
        console.log('v.recordId:'+component.get("v.recordId"));
        action.setParams({
            "recId" : recId           
        });
        
        action.setCallback(this, function(response){
            console.log('I am in callback: '+action);
            var status = response.getState();
            console.log('status:'+status);
            if(status==="SUCCESS"){
                console.log('response.getReturnValue():'+response.getReturnValue());
                component.set('v.oppInstance',response.getReturnValue());
            }
        });
       $A.enqueueAction(action);
	},
    fetchProducts : function(component, event, helper) {
        
     var action = component.get('c.getRelatedAccessories');
        var recId = component.get('v.recordId');
        action.setParams({
            "recId" : recId           
        });
      action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                console.log('response.getReturnValue():'+response.getReturnValue());
                component.set('v.oppliWrapList',JSON.parse(response.getReturnValue()));
                component.set('v.allData',JSON.parse(response.getReturnValue()));
                console.log('JSON.parse(response.getReturnValue()): '+JSON.parse(response.getReturnValue()));
            }
        });
        $A.enqueueAction(action);
		
	}
})