({
    diallit : function(component, event, helper) {
        var action = component.get('c.fetchOpportunity');
        action.setParams({
            "rId" : component.get('v.Diallerdate')         
        });
        action.setCallback(this, function(response){
            
            var status = response.getState();
            
            if(status==="SUCCESS"){
                var type="success";
                var msg = 'Auto-Dialler Started';
                var title="Auto-Dialler Started Successfully!!!!";
            }
            if(status==="ERROR"){
                let err = response.getError();
                var title = 'Error';
                var type = 'error';
                var msg = err[0].message;
            }
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type": type,
                "message": msg
            });  
            
            toastEvent.fire();
            //$A.get('e.force:refreshView').fire();
            setTimeout(function(){
                window.location.reload();  
            }, 500);
            
        });
        $A.enqueueAction(action);
    },
    doInit : function(component, event, helper) {
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set('v.Diallerdate', today);      
        
    }
})