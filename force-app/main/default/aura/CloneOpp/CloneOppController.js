({
	doinit : function(component, event, helper) {
          //console.log("Inside doinit");
		helper.getopp(component, event, helper);
        helper.getopli(component,event,helper);
        helper.getoplia(component,event,helper);
        
	},
    saveOn : function(component, event, helper)
    {
        //console.log("Inside Save on In JS");
        var action = component.get("c.saveopp");
        
        action.setParams({
            "rid" : component.get("v.recordId"),
            "op" : component.get("v.oppobj"),
            "opli" : component.get("v.oppli"),
            "oplia" : component.get("v.opplia")
        });
        //console.log("Params assigne done in save on in js");
        
        action.setCallback(this,function(response){
            var status = response.getState();
            var type;
            var msg;
            var title;
            var ttu = response.getReturnValue();
             var urlEvent = $A.get("e.force:navigateToURL");
           urlEvent.setParams({
           "url": "/"+ttu
           });
           urlEvent.fire();
            if(status === "SUCCESS")
            {
                //console.log("Inside Success in save on");
                type="success";
                msg = 'Opportunity Created Successfully!!!';
                title="Opportunity Created!!!";
            }
            if(status === "ERROR")
            {
                //console.log("Inside ERROR in save on");
                 let err = res.getError();
                title = 'Error';
                type = 'error';
                msg = err[0].message;
                alert(msg);
                
            }
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
            "title": title,
            "type": type,
            "message": msg
        });  
     toastEvent.fire();
        });
        $A.enqueueAction(action);
    },
    
    removeDeletedRow : function(component, event, helper)
    {
        var ctarget=event.currentTarget;
        var index=ctarget.dataset.value;
        //console.log('index:'+index);
        
        var lltp=component.get("v.oppli");
        var idss=lltp[index].Id;
        //console.log('idss:'+idss);
        lltp.splice(index,1);
        
        component.set("v.oppli",lltp);
    }
})