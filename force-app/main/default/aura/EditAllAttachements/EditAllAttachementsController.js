({
    doinit : function(component, event, helper) {
        helper.getstatusquote(component, event, helper);
                helper.fetchatt(component, event, helper);

        var action = component.get("c.get_Attachements");
        
        action.setParams({
            'recordId':component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if(state === 'SUCCESS') {
                component.set("v.att", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
    
    cancelit : function(component, event, helper) {
        var urlEvent=$A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url":"/"+ component.get("v.recordId")
        });
        urlEvent.fire();
    },
    
    deleteit : function(component, event, helper) {
        
        var index = event.getSource().get("v.value");
        console.log('index:'+index);
        var att = component.get("v.attach");
                        var idss = att[index].Id;
        console.log('idss:'+idss);

        
        att.splice(index, 1);
        
                var action = component.get('c.lineItemDel');
        action.setParams({
            "rid":component.get("v.recordId"),
            "oid":idss
        });
        
        action.setCallback(this, function(res){
            console.log('res.getState():'+res.getState());
            
             var type;
            var message;
            var title;
            //console.log('res.getReturnValue():'+JSON.parse(res.getReturnValue()));
            if(res.getState() === "SUCCESS"){
               
                title = 'SUCCESS';
                type = "success";
                message = "Attachement Deleted successfully!!!";
                
                /*var urlEvent=$A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url":"/"+ component.get("v.recordId")
                });
                urlEvent.fire();*/
                                component.set("v.attach", res.getReturnValue());

       // component.set("v.opliList",JSON.parse(res.getReturnValue()));
                //console.log('opliList value'+component.get('v.opliList'));
               
            }
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type":type,
                "message": message
            });
            toastEvent.fire();
        });
        
        
        $A.enqueueAction(action);
        
        $A.get('e.force:refreshView').fire();
   
    },
    
    /*saveit : function(component, event, helper) {
        let doc_list = component.get("v.att");
        let li = [];
        for(let item of doc_list) {
            li.push(item.Id);
        }
        
        var action = component.get("c.onsave");
        
        action.setParams({
            "recordId" : component.get("v.recordId"),
            "docIds" : li
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var title, type, message;
            
            if(state === 'SUCCESS') {
                title = 'SUCCESS';
                type = "success";
                message = "Attachement Save successfully!!!";
                
                var urlEvent=$A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url":"/"+ component.get("v.recordId")
                });
                urlEvent.fire();
            }
            
            if(state === 'ERROR') {
                title = "ERROR";
                type="error";
                let err = response.getError();
                message = err[0].message;
            }
            
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type":type,
                "message": message
            });
            toastEvent.fire();
            
        });
        
        $A.enqueueAction(action);
    },*/
    saveit : function(component, event, helper) {
        let doc_list = component.get("v.attach");
       
        console.log('attch list:'+doc_list);
        let li = [];
        for(let item of doc_list) {
            li.push(item.Id);
        }
        
        var action = component.get("c.onsave1");
        
        action.setParams({
            "recordId" : component.get("v.recordId"),
            "attch" : doc_list,
            "ids" :li
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var title, type, message;
            
            if(state === 'SUCCESS') {
                title = 'SUCCESS';
                type = "success";
                message = "Attachement Save successfully!!!";
                
                var urlEvent=$A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url":"/"+ component.get("v.recordId")
                });
                urlEvent.fire();
            }
            
            if(state === 'ERROR') {
                title = "ERROR";
                type="error";
                let err = response.getError();
                message = err[0].message;
            }
            
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type":type,
                "message": message
            });
            toastEvent.fire();
            
        });
        
        $A.enqueueAction(action);
    }
})