({
	doInit : function(component, event, helper) {
        component.set('v.showFirstpage',true);
        
        helper.getOrderObject(component, event, helper);
        
    },
    goBack : function(component, event, helper) {
      var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+component.get("v.recordId")
                });
                urlEvent.fire();
    },
    saveOn : function(component, event, helper){
        
         var ppt=component.get("v.orderObj");
        if(ppt.Reversal_Amount__c>ppt.Order_Value__c) {
            alert('Reversal amount can not be greater than order value');
        }
        else {
        var action = component.get("c.saveQuote");
        
        action.setParams({
            "recId" : component.get("v.recordId"),
            "quo" : component.get("v.orderObj"),
            "quli" : component.get("v.orderLineItems"),
            "quacli" : JSON.stringify(component.get("v.OAccessories"))
        });
        
        action.setCallback(this, function(response){
            var type;
            var msg;
            var title;
            var ttu;
            var status = response.getState();
            
            console.log('onsave status : '+status);
            if(status==="SUCCESS"){
                ttu = response.getReturnValue();
                type="success";
                 msg = 'Reversal/Bad Debt Created Successfully!!!';
                title="Reversal/Bad Debt Created!!!";
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+ttu
                });
                urlEvent.fire();
            }
            
            if(status==="ERROR"){
                let err = response.getError();
                title = 'Error';
                type = 'error';
                msg = "Something Went Wrong...";
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
        }
    }
})