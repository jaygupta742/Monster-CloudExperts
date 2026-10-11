({
    getOrderObject : function(component, event, helper) {
        var action = component.get("c.getOrderObj");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                var x = [];
                x=JSON.stringify(response.getReturnValue());
                console.log('x'+x);
                component.set("v.orderObj",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    getQuoteObject : function(component, event, helper) {
        var action = component.get("c.fetchqq");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                //var x = [];
                // x=JSON.stringify(response.getReturnValue());
                //console.log('x'+x);
                component.set("v.quoteObj",response.getReturnValue()); 
                console.log('quote:'+component.get("v.quoteObj"));
                
            }
        });
        $A.enqueueAction(action);
    },
    getProfileObject : function(component, event, helper) {
        var action = component.get("c.fetchprofileName");
        
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                
                component.set("v.pro",response.getReturnValue()); 
                console.log('profile:'+component.get("v.pro"));
            }
        });
        $A.enqueueAction(action);
    },
    getOLI : function(component, event, helper) {
        var action = component.get("c.getOrderLine");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                console.log('response.getReturnValue(): '+response.getReturnValue());
                component.set("v.orderLineItems",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    getOLIAcc : function(component, event, helper) {
        var action = component.get("c.getOrderLineAccessories");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                var rval = JSON.parse(response.getReturnValue());
                console.log('service response.getReturnValue(): '+response.getReturnValue());
                component.set("v.OAccessories", rval); 
            }
        });
        $A.enqueueAction(action);
    }
    
})