({
    doinit : function(component, event, helper) {
        helper.getValidatedapprovalstatus(component, event, helper);
        helper.tasktamplate(component, event, helper);
        helper.getstatusquote(component, event, helper);
        helper.getgrossamount(component, event, helper);
        
    },
    
    addrows : function(component, event, helper) {
        helper.tasktamplate(component, event, helper);
    },
    
    addfiverows : function(component, event, helper) {
        var i=0;
        while(i < 5) {
            helper.tasktamplate(component, event, helper);
            i += 1;
        }
    },
    
    deleteit : function(component, event, helper) {
        var index = event.getSource().get("v.value");
        
        var task = component.get("v.task");
        
        task.splice(index, 1);
        component.set("v.task", task);
    },	
    
    cancelit : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/"+component.get("v.recordId")
        });
        urlEvent.fire();      
        $A.get('e.force:refreshView').fire();
    },
    
    saveit : function(component, event, helper) {
        var gg=component.get("v.gross");
        var tsk=component.get("v.task");
        // let itemsize=tsk.length;
        var ttlamt=0;
        
        var tot=0;
        let x = false;
        
        
        for(let item of tsk) {
            if(item.Payment_Amount__c >0 || item.TDS_Payment_Amount__c){
                tot+=item.TDS_Payment_Amount__c;
                tot+=item.Payment_Amount__c;
            }
            /*console.log('tot:'+tot);
            console.log('gg:'+gg);
            if(tot!=gg){
                alert('Sum of Payment Amt and Tds Amt is equal to net total');
                return null;
            }*/
            if(item.Due_Date__c==null || item.Payment_Amount__c==null || item.TDS_Payment_Amount__c==null || item.GST__c==null) {
                x=true;
            }
            if(item.Payment_Amount__c!=null || item.Payment_Amount__c!=undefined ) {
                
                ttlamt+=parseFloat(item.Payment_Amount__c);
                //  ttlamt+=parseFloat(item.TDS_Payment_Amount__c);
                //  console.log('ttoal amount is===='+ttlamt);
            }
            if(item.TDS_Payment_Amount__c!=null || item.TDS_Payment_Amount__c!=undefined ) {
                
                //  ttlamt+=parseFloat(item.Payment_Amount__c);
                ttlamt+=parseFloat(item.TDS_Payment_Amount__c);
                //  console.log('ttoal amount is===='+ttlamt);
            }
            
        }
        console.log('grand total is=='+ttlamt);
        console.log('x is'+x);
        
        
        
        for(var item of tsk) {
            
            if(x) {
                alert('Please fill mandatory fields');
                //break;
                return null;
            }
            console.log('gg:'+gg);
            if(ttlamt.toFixed(2)!=gg){
                console.log('net total:'+gg);
                console.log("total amount : " + ttlamt.toFixed(2));
                alert('Sum Of Amount & TDS Amount  Must Be Equal To Net Total !!!!');     
                // break;
                return null;
            }
        }
        //   else {
        var action = component.get("c.onsave");
        
        action.setParams({
            'recordId' : component.get("v.recordId"),
            'task' : component.get("v.task")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var title, type, message;
            if(state === 'SUCCESS') {
                title = 'SUCCESS';
                type = "success";
                message = 'APAC Payments added successfully';
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+component.get("v.recordId")
                });
                urlEvent.fire();                
                $A.get('e.force:refreshView').fire();
            }
            
            if(state === 'ERROR') {
                title = 'ERROR';
                type = "error";
                let err = response.getError();
                
                message = err[0].message;
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
    }
    //     }
    
    
    
    //  }
})