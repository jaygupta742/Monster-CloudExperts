({
	doinit : function(component, event, helper) {
		helper.getQuote(component, event, helper);
        helper.getTemplateheper(component, event, helper);
	},
    
    sendit : function(component, event, helper) {
        var subject = component.get("v.subject");
        var to = component.get("v.to");
        var cc = component.get("v.cc");
        var body = component.get("v.body");
         var pdf = component.get("v.ctemp");

        if($A.util.isEmpty(to) ||!to.includes("@")) {
            alert('TO: Invalid sender mail!!!');
            return;
        }
        
        var action = component.get("c.onSend");
        action.setParams({
            'recordId':component.get("v.recordId"),
            'subject':subject,
            'reciever':to,
            'cc':cc,
            'body':body,
            'pdff':pdf
        });
        
        action.setCallback(this, function(response) {
           	var state = response.getState();
            var title, type, message;
            if(state === 'SUCCESS') {
                title = 'SUCCESS';
                type = 'success';
                message = 'Mail has been sent...';
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+component.get("v.recordId")
                });
                urlEvent.fire();
            }
            if(state === 'ERROR') {
                title = 'ERROR';
                type = 'error';
                let err = response.getError();
                message = err[0].message;
            }
            
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                'title':title,
                'type':type,
                'message':message
            });
            toastEvent.fire();
        });
        
        $A.enqueueAction(action);
    },
       gonext: function(component, event, helper) {
           
            var allproduct= component.get("v.temp");
           var cproduct=component.get("v.ctemp");
           
            var id=[];
           
       
   var id=[];
        for(let item of cproduct) {	
            
            if(item.isChecked==true){
                for(let po of allproduct){
                    
                    if(po.Id==item.Id){
                        id.push(item.Id);
                        po.isChecked=true
                        break;
                    }
                }
            }
          
        }
           
           
        var cp=[];
        for(let product of allproduct){
            if(product.isChecked == true){
                //product.quantity=1;
                cp.push(product);
                console.log('cp======='+ cp);
            }
        } 
        component.set("v.ctemp",cp);
            component.set("v.quotepdf",cp.id);
            console.log('Quote pdf selected name ===' +id);

        component.set("v.next",true);
      
    },
   selectAllCheckbox : function(component, event, helper) {
		 //var ctarget = event.currentTarget;
        //var index = ctarget.dataset.value;
        //console.log('ctarget.dataset: '+ctarget.dataset.index);
       var index = event.getSource().get("v.name");
        console.log('amitsingh'+index);
        var cproduct=component.get("v.temp");
        var ttu=[];
         for(let item of cproduct){
               item.isChecked=false; 
                ttu.push(item);
          
        }
     ttu[index].isChecked=true;
      component.set("v.temp",ttu);   
	}
})