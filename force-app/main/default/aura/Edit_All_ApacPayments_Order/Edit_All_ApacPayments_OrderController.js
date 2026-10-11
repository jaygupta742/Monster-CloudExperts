({
    doinit : function(component, event, helper) {
                helper.getstatusorder(component, event, helper);
		var action = component.get("c.getAPACPayments");
        
        action.setParams({
            'recordId' : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.apac", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
	},
    
    deleteit : function(component, event, helper) {
      	var index = event.getSource().get("v.value");
        var li = component.get("v.apac");
        
        li.splice(index, 1);
        
        component.set("v.apac", li);
    },
    
    saveit : function(component, event, helper) {
        
       /* var app =  component.get('v.apac');
        for(var ap of app){
            console.log('order type'+ap.Order_Type__c);
            if(ap.Payment_Amount__c != ap.Net_Total__c){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title":'',
                    "type": 'error',
                    "message":'Amount should be equl to the Net Total Amount..!!'
                });  
                toastEvent.fire();
                return ;
            }
        }*/
        var action = component.get("c.onsave");
        
        action.setParams({
            'recordId' : component.get("v.recordId"),
            'apac' : component.get("v.apac")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var title, type, message;
            
            if(state === 'SUCCESS') {
            	type="success";
                title="SUCCESS!!!";
                message="APAC Payments Updated Successfully!!!";
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+component.get("v.recordId")
                });
                urlEvent.fire();                
                $A.get('e.force:refreshView').fire();
            }
            
            if(state === "ERROR") {
                type="error";
                title=response.getError();
                message=title[0].message;
            }
            
            var toastevent = $A.get("e.force:showToast");
            toastevent.setParams({
                'title':title,
                'type':type,
                'message':message
            });
            
            toastevent.fire();
        });
        
        $A.enqueueAction(action);
    },
    
    cancelit : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/"+component.get("v.recordId")
        });
        urlEvent.fire();                
        $A.get('e.force:refreshView').fire();
    },
})