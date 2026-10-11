({
	doinit : function(component, event, helper)
    {
        helper.getopli(component, event, helper);
        helper.gettoadd(component, event, helper);
        helper.getccadd(component, event, helper);
		
	},
    sendMail : function(component, event, helper)
    {
        var action = component.get("c.sendemailmethod");
        action.setParams({
            "bud" : component.get("v.budget"),
             "auth" : component.get("v.authority"),
             "need" : component.get("v.need"),
             "timing" : component.get("v.timing"),
             "poten" : component.get("v.potential"),
            "rid" : component.get("v.recordId"),
            "cc" : component.get("v.ccadd"),
            "to" : component.get("v.toadd"),
            "opp" : component.get("v.opp"),
            "comp" : component.get("v.comp")
        });
        action.setCallback(this,function(res){
            var status = res.getState();
            if(status === "SUCCESS")
            {
                console.log("finally success");
                component.set("v.mailStatus", true);
            }
            else
            {
                 console.log("finally Error");
            }
        });
        $A.enqueueAction(action);
    },
    
    closeMessage: function(component, event, helper) {
         component.set("v.mailStatus", false);
        component.set("v.toadd", null);
    	 component.set("v.ccadd", null);
  
        var orderId = component.get("v.recordId"); 
        //console.log("redirecting 1");
          var urlEvent = $A.get("e.force:navigateToURL");
         //console.log("redirecting 2");
         urlEvent.setParams({
           "url": "/"+orderId
           });
         //console.log("redirecting 3");
           urlEvent.fire();
         //console.log("redirecting 4");
       
    },
    
})