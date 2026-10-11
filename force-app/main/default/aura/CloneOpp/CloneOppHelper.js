({
	getopp : function(component,event,helper) {
        //console.log("Inside getopp in helper");
		var action = component.get("c.fetchopp");
        action.setParams({
            "rid" : component.get("v.recordId")
        });
          //console.log("Inside getopp in helper------>Param assigned");
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS")
            {
				//console.log("Inside getopp Helper -->Inside SUCCESS Block");
                component.set("v.oppobj",response.getReturnValue());
            }
            else
            {
                //console.log("Inside getopp Helper -->Inside FAILS Block");
            }
        });
        $A.enqueueAction(action);
	},
    
    getopli : function(component,event,helper)
    {
        //console.log("inside getopli in helper");
        var action = component.get("c.fetchopli");
        action.setParams({
            "rid" : component.get("v.recordId")
        });
         //console.log("Inside getopli in helper------>Param assigned");
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS")
            {
				//console.log("Inside getopli Helper -->Inside SUCCESS Block");
                component.set("v.oppli",response.getReturnValue());
            }
            else
            {
                //console.log("Inside getopli Helper -->Inside FAILS Block");
            }
        });
        $A.enqueueAction(action);
    },
    getoplia : function(component,event,helper)
    {
        //console.log("inside getopli in helper");
        var action = component.get("c.fetchoplia");
        action.setParams({
            "rid" : component.get("v.recordId")
        });
         //console.log("Inside getopli in helper------>Param assigned");
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS")
            {
				//console.log("Inside getopli Helper -->Inside SUCCESS Block");
                component.set("v.opplia",response.getReturnValue());
            }
            else
            {
                //console.log("Inside getopli Helper -->Inside FAILS Block");
            }
        });
        $A.enqueueAction(action);
    }
})