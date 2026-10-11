({
    getQuoteObject : function(component, event, helper) {
        var action = component.get("c.getQuoteObj");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                var x = [];
                x=JSON.stringify(response.getReturnValue());
                console.log('x'+x);
                component.set("v.quoteObj",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    
    getAccountStatusApexHelper : function(component) {
        var action = component.get("c.getAccountStatusApex");
        action.setParams({
          "recId" : component.get("v.recordId")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.accountStatus", response.getReturnValue());
            } else {
                console.error("Failed with state: " + state);
            }
        });

        $A.enqueueAction(action);
    },
    
    getRecontractQuotes : function(component, event, helper) {
        var action = component.get("c.GetQuotesForRecontract");
        action.setParams({
            recordId : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var status = response.getState();
            if(status === "SUCCESS"){
                component.set("v.RecontractQuotes",response.getReturnValue()); 
            } 
        });
        $A.enqueueAction(action);
    },
    
    getOppObject : function(component, event, helper) {
        var action = component.get("c.getoppinfo");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS"){
                let rval = JSON.parse(response.getReturnValue());
                let products = rval.Products;
                let services = rval.Services;
                for(let item of products) {
                    item['ItemURL'] = '/' + item.Id;
                    item['ProductURL'] = '/' + item.Product__c;
                }
                for(let item of services) {
                    item['ItemURL'] = '/' + item.Id;
                    item['ProductURL'] = '/' + item.Product__c;
                    item['ServiceURL'] = '/' + item.Top_Ups__c;
                    item['ServiceName'] = item.Top_Ups__r.Name;
                }
                component.set("v.oppObj", rval.Opportunity); 
                component.set("v.OpportunityItems", products);
                component.set("v.OpportunityServices", services);
                helper.GetRelatedContactFilter(component, rval.Opportunity.Account__c);
                helper.GetBaseOrderFilter(component, rval.Opportunity.Account__c);
                helper.GetBaseQuoteFilter(component, rval.Opportunity.Account__c);
            }
        });
        $A.enqueueAction(action);
    },

    getQULI : function(component, event, helper) {
        var action = component.get("c.getQuoteLine");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            
            if(status==="SUCCESS"){
                // console.log('response.getReturnValue(): '+response.getReturnValue());
                component.set("v.quoteLineItems",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },

    getQULIAcc : function(component, event, helper) {
        var action = component.get("c.getQuoteLineAccessories");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                //console.log('response.getReturnValue(): '+response.getReturnValue());
                component.set("v.quliAccessories",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    
    getcontact : function(component, event, helper) {
        var action = component.get('c.getcon');
        action.setParams({
            "recId" : component.get("v.recordId") 
        });
        
        action.setCallback(this, function(response){
            var status = response.getState();
            if(status ==='SUCCESS'){
                //console.log('Get option of contact: '+response.getReturnValue());
                component.set("v.coption",JSON.parse(response.getReturnValue()));  
            }
            
            if(status ==='ERROR'){
                console.log('get in errror for fetch contact')
                
            }
        });
        $A.enqueueAction(action);
        // $A.get('e.force:refreshView').fire();
    },

    GetRelatedContactFilter: function(component, AccountId) {
        const filter = {
            criteria: [
                {
                    fieldPath: 'AccountId',
                    operator: 'eq',
                    value: AccountId,
                }
            ]
        };
        component.set('v.RelatedContactFilter', filter);
    },

    GetBaseOrderFilter: function(component, AccountId) {
        const filter = {
            criteria: [
                {
                    fieldPath: 'Account__c',
                    operator: 'eq',
                    value: AccountId,
                }
            ]
        };
        component.set('v.RelatedBaseOrderFilter', filter);
    },

    GetBaseQuoteFilter: function(component, AccountId) {
        const filter = {
            criteria: [
                {
                    fieldPath: 'Account__c',
                    operator: 'eq',
                    value: AccountId,
                }
            ]
        };
        component.set('v.RelatedBaseQuoteFilter', filter);
    },

    HandleOpenAlert: function(label, message, theme, onCallback) {
        this.LightningAlert.open({
            message: message,
            theme: theme,
            label: label,
        }).then(function() {
            console.log('alert is closed');
            onCallback();
        });
    },
    HanldeShowToast : function(title, message, variant) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: title,
            message: message,
            type: variant
        });
        toastEvent.fire();
    }
})