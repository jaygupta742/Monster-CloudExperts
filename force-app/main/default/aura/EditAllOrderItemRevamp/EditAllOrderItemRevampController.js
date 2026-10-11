({
    
    doInit : function(component, event, helper) {
        //helper.chkv(component, event, helper);
        helper.getapprovalstatus(component, event, helper);
        var action = component.get('c.getAllLineItem');
        action.setParams({
            "rId":component.get('v.recordId')   
        });
        action.setCallback(this, function(res){
            console.log('res.getState():'+res.getState());
            
            
            console.log('res.getReturnValue():'+JSON.parse(res.getReturnValue()));
            if(res.getState() === "SUCCESS"){
                component.set("v.opliList",JSON.parse(res.getReturnValue()));
                //console.log('opliList value'+component.get('v.opliList'));
                
            }
            
        });
        $A.enqueueAction(action);
    },
    stdate : function(component,event,helper){
        var ind= event.getSource().get("v.label");
        //console.log('index:'+ind);
        var ss=component.get('v.opliList');
        var sd=ss[ind].opli.Start_Date__c;
        console.log('start date:'+sd);
        // var prev=component.get("v.previous");
        
        //var ttdays=component.get("v.todays");
        
        var items1=component.get("v.opliList");
        //var ten1=ss[ind].prodtenure;
        var ten1=ss[ind].opli.Tenure_Months__c;
        
        console.log('tenure months:'+ten1);
        // var pp=component.get("v.ptype");
        if(ten1!=undefined ){
        var action = component.get('c.getenddate');
        
        action.setParams({
            'wroppp' : JSON.stringify(component.get('v.opliList')),
            'stdate' :sd.toString(),
            'ten' : ten1.toString()
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            //console.log('status:'+status);
            if(status==="SUCCESS"){
                
                //if(pp!='Upsell'){
                console.log('enddate:'+response.getReturnValue());
                ss[ind].opli.End_Date__c=response.getReturnValue();
                // }
                
                
                component.set("v.opliList",ss); 
                
            }
            
        });
        $A.enqueueAction(action); 
        }
    },
    removeDeletedRow : function(component,event,helper){
        var indexvar = event.getSource().get("v.label");
        console.log('gghh '+indexvar);
        
        var AllRowsList = component.get("v.opliList");
        console.log(AllRowsList[indexvar].opli.Id);
        
        var idss = AllRowsList[indexvar].opli.Id;
        var lorry=AllRowsList[indexvar].delAcc;
        AllRowsList.splice(indexvar, 1);
        var action = component.get('c.lineItemDel');
        action.setParams({
            "recId":idss,
            "chklist":lorry
        });
        
        action.setCallback(this, function(res){
            console.log('res.getState():'+res.getState());
            
            
            console.log('res.getReturnValue():'+JSON.parse(res.getReturnValue()));
            if(res.getState() === "SUCCESS"){
                component.set("v.opliList",JSON.parse(res.getReturnValue()));
                //console.log('opliList value'+component.get('v.opliList'));
                
            }
        });
        
        $A.enqueueAction(action);
        
        $A.get('e.force:refreshView').fire();
    },
    onSave : function(component,event,helper){
      //  alert('111');
        var objWrap = component.get("v.opliList");
        console.log('oplilist:'+JSON.stringify(objWrap));
        var action = component.get("c.onsave");
      //   alert('222');
        action.setParams({
            "listItem" :JSON.stringify(objWrap),
            
        });
        
        action.setCallback(this, function(res){
            //console.log(res.getReturnValue());
            var state = res.getState();
            var type;
            var msg;
            var title;
            console.log('state save:'+state);
            console.log('response return value save:'+res.getReturnValue());
            
            var ttu=component.get("v.recordId");
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/"+ttu
            });
            urlEvent.fire();
            if(state === "SUCCESS"){
                component.set("v.successMsg",res.getReturnValue());
                type="success";
                msg = 'Records Updated Successfully!!!';
                title="Record Update";  
                console.log('Success message:'+component.get('v.successMsg'));
                
            }
            if(state==="ERROR"){
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
    }
    
})