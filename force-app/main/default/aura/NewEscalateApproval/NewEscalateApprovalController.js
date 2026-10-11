({
    doInit : function(component, event, helper) {
		helper.sendemail(component,event, helper);
        //helper.getquoteinformation(component, event, helper);
        var action = component.get("c.escateapproval");
        
        action.setParams({
            "rid" : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response){
            var type;
            var msg;
            var title;
            var ttu;
            var status = response.getState();
            
            //let qq=response.getReturnValue();
            /*let qq=component.get("v.qq1");
            console.log('lltp res:'+qq);
            if(qq==true){
                alert('You cant Escate further to the Higher Management');
            }
            
            else{*/
            
            if(status==="SUCCESS"){
                ttu = response.getReturnValue();
                type="success";
                msg = 'Approval Escalated Successfully!!!';
                title="Approval Created!!!";
            }
            var urlEvent = $A.get("e.force:navigateToURL");
            var rr=component.get("v.recordId");
            urlEvent.setParams({
                "url": "/"+rr
            });
            urlEvent.fire();
            
            if(status==="ERROR"){
                let err = response.getError();
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
            
            //  }
        });
        $A.enqueueAction(action);
        
        
        
    },
})