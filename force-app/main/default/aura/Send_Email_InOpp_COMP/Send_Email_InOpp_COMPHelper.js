({
	getopli : function(component,event,helper) {
        console.log("Insdie getopli help");
		var action= component.get("c.getOPLI");
        action.setParams({
            "rid" : component.get("v.recordId")
        });
        action.setCallback(this,function(res){
            var status = res.getState();
            if(status === "SUCCESS")
            {
                console.log("Inside Succes");
                component.set("v.opp",res.getReturnValue());
            }
            else{
                console.log("Inside Error");
            }
        });
        $A.enqueueAction(action);
	},
    gettoadd : function(component,event,helper){
         console.log("Insdie gettoadd help");
        var action= component.get("c.getToAddress");
        action.setParams({
            "rid" : component.get("v.recordId")
        });
         action.setCallback(this,function(res){
            var status = res.getState();
            if(status === "SUCCESS")
            {
                console.log("Inside Succes");
                component.set("v.toadd",res.getReturnValue());
            }
            else{
                console.log("Inside Error");
            }
        });
        $A.enqueueAction(action);
    },
    
    getccadd : function(component,event,helper){
         console.log("Insdie getccadd help");
        var action= component.get("c.getCCAddress");
         action.setParams({
            "rid" : component.get("v.recordId")
        });
         action.setCallback(this,function(res){
            var status = res.getState();
            if(status === "SUCCESS")
            {
                console.log("Inside Succes");
                component.set("v.ccadd",res.getReturnValue());
            }
            else{
                console.log("Inside Error");
            }
        });
          $A.enqueueAction(action);
    }
})