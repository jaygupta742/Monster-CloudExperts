({
    
    
    doInit : function(component, event, helper) {
        
          component.set("v.showFirstpage",true);
        
        var action = component.get("c.getorder");
        
        action.setParams({
            'rid':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                component.set("v.getmrnfrpo",response.getReturnValue())
                
               /* if(response.getReturnValue().length > 0) {
                    component.set("v.f1", true);
                    component.set("v.f2", false);
                }
                else {
                    component.set("v.f1", false);
                    component.set("v.f2", true);                    
                }  */
                
            }
        });
        
        $A.enqueueAction(action);

        
    },
    
   
		
      
    
    saveOn : function(component, event, helper) {
        var action = component.get("c.onsave");
        action.setParams({ 
          // "recid" : component.get ("v.recordId"), 
            "mn": component.get ("v.getmrnfrpo")
        });
        action.setCallback(this,function(response){
            var status = response.getState();
            var type;
            var msg;
            var title;
            
            if(status==="SUCCESS"){
                type="success";
                msg = 'Order Rejected Successfully!!!';
                title="Order Rejected!!!";
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url":"/"+response.getReturnValue()
                });
                urlEvent.fire();
                 $A.get('e.force:refreshView').fire();
                
            }
            if(status==="ERROR"){
                let err = res.getError();
                title = 'Error';
                type = 'error';
                msg = err[0].message;
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
    
    
})