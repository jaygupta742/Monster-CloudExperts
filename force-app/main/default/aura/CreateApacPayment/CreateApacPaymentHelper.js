({
    tasktamplate : function(component, event, helper) {
        
        
        
        var allpaymentitem = component.get("v.task");
        var obj = {};
       
        
     /*   var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();
        
        today = mm + '/' + dd + '/' + yyyy;
        
        var today1 = new Date();
        var dd = String(today1.getDate()).padStart(2, '0');
        var mm = String(today1.getMonth() + 2).padStart(2, '0'); //January is 0!
        var yyyy = today1.getFullYear();
        
        today1= mm + '/' + dd + '/' + yyyy;*/
      
        obj.Name = '';
        obj.Quotes__c =component.get("v.recordId");
        obj.APAC_Payment_Name__c = 'Single Shot';
        obj.TDS_Amount__c=0;
        obj.GST__c=18;
        
        
        
        allpaymentitem.push(obj);
        
        component.set("v.task", allpaymentitem);
        
    },
    getstatusquote : function(component, event, helper) {
        var action = component.get("c.getstatus");
        
        action.setParams({
            'rid':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.status", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
    getgrossamount : function(component, event, helper) {
        var action = component.get("c.getgross");
        
        action.setParams({
            'rid':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.gross", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
     getPOrderLineItem : function(component, event, helper) {
        console.log('------------ getpo() --------------');
        
		var action = component.get("c.getsoline");
        
        action.setParams({
            "rid" : component.get("v.recordId") 
        });
        
        action.setCallback(this, function(res){
            var state = res.getState();
          //  console.log("State : " + state);
            

            var result = res.getReturnValue();
          //  console.log("Return Value : " + result);
            
            if(state === "SUCCESS"){
                component.set("v.task", result);
            }
        });
        
        $A.enqueueAction(action);
	},
     getValidatedapprovalstatus : function(component, event, helper) {
        var action = component.get('c.getValidatedstatus');
        action.setParams({
            "rid":component.get('v.recordId')   
        });
        action.setCallback(this, function(res){
            console.log('state stat:'+res.getState());
            if(res.getState() === "SUCCESS"){
                component.set("v.Validationstatus",res.getReturnValue());
                console.log('stat'+component.get('v.status')) ;    
            }
        });
        $A.enqueueAction(action);
    }
})