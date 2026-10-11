({
	doInit : function(component, event, helper) {
		var action=component.get("c.sendforactivation");
        action.setParams({
            "rid" : component.get("v.recordId"),
           
        });
        //let button=component.find('disablebuttonid1');
       // button.set("v.disabled",true);
        
        action.setCallback(this,function(res){
            var state=res.getState();
            console.log('state save:'+state);
            var type;
            var msg;
            var title;
            var ttu=res.getReturnValue();
            console.log('ttu save:'+ttu);
             var urlEvent = $A.get("e.force:navigateToURL");
              urlEvent.setParams({
                "url": "/"+ttu
               });
            urlEvent.fire();
            if(state==="SUCCESS")
            {
                //component.set("v.successMsg",res.getReturnValue());
                type="success";
                msg = 'Sent For Activation: '+' Successfully ';
                title="Sent For Activation Successfully!!!!";  
                //component.set("v.recordIdt",res.getReturnValue());   
                        $A.get('e.force:refreshView').fire();

            }
            if(state==="ERROR")
            {
                let err=res.getError();
                title='Error';
                type='Error';
                msg=err[0].message();
                alert(msg);
            }
            var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": title,
        "type":type,
        "message":msg
    });
    toastEvent.fire();
        });
        $A.enqueueAction(action);
    },
})