({
    doInit : function(component, event, helper) {
        component.set('v.showFirstpage',true);
        helper.getQuoteObject(component, event, helper);
        helper.getProfileObject(component, event, helper);
        
        helper.getOrderObject(component, event, helper);
        helper.getOLI(component, event, helper);
        helper.getOLIAcc(component, event, helper);
    },
    showNext : function(component, event, helper) {
        var ord =  component.get('v.orderObj');
        console.log('order type'+ord.Order_Type__c);
        if(ord.Order_Type__c == null || ord.Order_Type__c == 'undefined' || ord.Order_Type__c ==''){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title":'',
                "type": 'error',
                "message":'Order Type Is Mandatory..!!'
            });  
            toastEvent.fire();
            return ;
        }
        component.set('v.showFirstpage',false);
        var quli = component.get('v.orderLineItems');
        var quliacc = component.get('v.OAccessories');
        
        for(let qu of quli){
            for(let qa of quliacc){
                if(qu.Opportunity_Line_Item__c===qa.Opportunity_Line_Item__c){
                    qa.Unloading_Charges__c=qu.Unloading_Charges__c;
                } 
            }
        }
        component.set('v.OAccessories',quliacc);
        
    },
    goBack : function(component, event, helper) {
        component.set('v.showFirstpage',true);
    },
    chngValue : function(component, event, helper) {
        if(component.get('v.quoteObj').Mode_Terms_Of_Payment__c=='Others'){
            component.set('v.ren',true);
        }
        
        console.log('true:'+component.get('v.ren'));
    },
    removeDeletedRow : function(component, event, helper){
        var ctarget = event.currentTarget;
        var index = ctarget.dataset.value;
        console.log('ctarget.dataset: '+ctarget.dataset.index);
        // get the all List (listPay attribute) and remove the Object Element Using splice method    
        var AllRowsList = component.get("v.orderLineItems");
        console.log('AllRowsList:'+AllRowsList[index].Id);
        var idss = AllRowsList[index].Id;
        AllRowsList.splice(index, 1);
        component.set("v.orderLineItems", AllRowsList);
    },
    removeDeletedRow1 : function(component, event, helper){
        var ctarget = event.currentTarget;
        var index = ctarget.dataset.value;
        console.log('ctarget.dataset: '+ctarget.dataset.index);
        // get the all List (listPay attribute) and remove the Object Element Using splice method    
        var AllRowsList = component.get("v.OAccessories");
        console.log('AllRowsList:'+AllRowsList[index].Id);
        var idss = AllRowsList[index].Id;
        AllRowsList.splice(index, 1);
        component.set("v.OAccessories", AllRowsList);
    },
    saveOn : function(component, event, helper){
        let button = component.find('disablebuttonid');
        button.set('v.disabled',true);
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
                msg = 'Order Created Successfully!!!';
                title="Order Created!!!";
                
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+ttu
                });
                urlEvent.fire();
            }
            
            if(status==="ERROR"){
                button.set('v.disabled', false);
                let err = response.getError();
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
    }
})