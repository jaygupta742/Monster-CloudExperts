({
    x: [],
    Y: [],
    // Unberry: Base Total = Unit Price * Qty + Annual Platform Fee (fee % of Unit Price * Qty)
    UNBERRY_PRODUCT_NAME: 'Unberry',
    UNBERRY_PLATFORM_FEE_PCT: 35,

    isUnberry : function(item) {
        return item.prodName === this.UNBERRY_PRODUCT_NAME;
    },

    getBaseTotal : function(item) {
        var base = item.opli.Unit_Price__c * item.opli.Quantity_Unit__c;
        if (this.isUnberry(item)) {
            base += (base * this.UNBERRY_PLATFORM_FEE_PCT) / 100;
        }
        return base;
    },
    fetchOpportunity : function(component, event, helper) {
        var action = component.get('c.fetchOpportunity');
        var recId = component.get("v.recordId");
        //console.log('v.recordId:'+component.get("v.recordId"));
        action.setParams({
            "rId" : recId           
        });
        
        action.setCallback(this, function(response){
            //console.log('I am in callback: '+action);
            var status = response.getState();
            //console.log('status:'+status);
            if(status==="SUCCESS"){
                
                component.set('v.oppInstance',response.getReturnValue());
                //console.log('Arun'+component.get('v.oppInstance'));
            }
        });
        $A.enqueueAction(action);
    },
    
    getAccountStatusApexHelper : function(component) {
        console.log('Get Account Status');
        var action = component.get("c.getAccountStatusApex");
        action.setParams({
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('Get Account Status : ' + response.getState());
            if (state === "SUCCESS") {
                console.log('Get Account Response : ' + response.getReturnValue());
                component.set("v.accountStatus", response.getReturnValue());
            } else {
                console.error("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    fetchtodaysdate : function(component,event,helper){
        var action = component.get('c.todaysdate');
        
        //console.log('getting picklist values');
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                //console.log('status:'+status);
                
                component.set('v.todays',response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    fetchtpreviousdate : function(component,event,helper){
        var action = component.get('c.todaysdate');
        
        //console.log('getting picklist values');
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                //console.log('status:'+status);
                
                component.set('v.previous',response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    fetchProducts : function(component, event, helper) {
        
        var action = component.get('c.fetchProducts');
        var recId = component.get('v.recordId');
        action.setParams({
            "rId" : recId           
        });
        action.setCallback(this,function(response){
            //console.log(JSON.parse(response.getReturnValue()));
            var status = response.getState();
            if(status==="SUCCESS"){
                let rval = JSON.parse(response.getReturnValue());
                console.log(rval);
                console.log("all product size : " + rval);
                component.set('v.allData', rval);
            }
        });
        $A.enqueueAction(action);
        
    },
    fetchacc : function(component, event, helper) {
        
        var action = component.get('c.fetchAccessories');
        var recId = component.get('v.recordId');
        action.setParams({
            "rId" : recId           
        });
        action.setCallback(this,function(response){
            //console.log(JSON.parse(response.getReturnValue()));
            var status = response.getState();
            if(status==="SUCCESS"){
                
                
                //component.set('v.allData',JSON.parse(response.getReturnValue()));
                component.set('v.allDatas',JSON.parse(response.getReturnValue()));
                //console.log(component.get('v.allDatas'));
                component.set('v.allDatas',JSON.parse(response.getReturnValue()));
                /*var lltp=component.get('v.allData');
                for(var item of lltp){
                    console.log('enddate:'+item.opli.End_Date__c);
                }*/
            }
        });
        $A.enqueueAction(action);
        
    },
    fetchpronames : function(component,event,helper){
        var action = component.get('c.getproductnames');
        
        //console.log('getting picklist values');
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                //console.log('status:'+status);
                
                component.set('v.objCategory',response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    fetchprochannels : function(component,event,helper){
        var action = component.get('c.getchannels');
        
        //console.log('getting picklist values');
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status==="SUCCESS"){
                //console.log('status:'+status);
                
                component.set('v.objchannel',response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
    },
    fetchtenure : function(component,event,helper){
        var action = component.get('c.gettenure');
        
        action.setParams({
            'recId' : component.get('v.recordId')
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            //console.log('status:'+status);
            if(status==="SUCCESS"){
                component.set("v.objPrincipal",response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    fetchskutype : function(component,event,helper){
        var action = component.get('c.getskutype');
        
        action.setParams({
            'recId' : component.get('v.recordId')
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            //console.log('status:'+status);
            if(status==="SUCCESS"){
                component.set("v.objskutype",response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    fetchcountry : function(component,event,helper){
        var action = component.get('c.getCountry');
        
        action.setParams({
            'recId' : component.get('v.recordId')
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            //console.log('status:'+status);
            if(status==="SUCCESS"){
                console.log('fetch country /////'+ response.getReturnValue());
                component.set("v.objType",response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    fetchptypes : function(component,event,helper){
        var action = component.get('c.getptype');
        
        action.setParams({
            'recId' : component.get('v.recordId')
        });
        
        action.setCallback(this,function(response){
            var status = response.getState();
            //console.log('status:'+status);
            if(status==="SUCCESS"){
                component.set("v.objptype",response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    
    pageLoadClassMethod1 : function(component, event, helper) {
        var action = component.get('c.usrdetails');
        action.setParams({
            "recId":component.get("v.recordId")   
        });
        
        action.setCallback(this, function(res){
            console.log(res.getReturnValue());
            if(res.getReturnValue()!=null){
            }
            if(res.getState() === "SUCCESS"){
                
                component.set('v.usrObj', res.getReturnValue());
                
            }
            else if(res.getState() === "ERROR") {
                var errors = res.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.ErrorMessage",errors[0].message);
                    }
                } else {
                    component.set("v.ErrorMessage","Unknown error");
                }
            }else if (!JSON.parse(res.getReturnValue()).success) {
                component.set("v.ErrorMessage",JSON.parse(res.getReturnValue()).errorMessage);
            }
        });
        $A.enqueueAction(action);
    },
    fetchopli : function(component, event, helper,skucode,proName) {
        var recId = component.get('v.recordId');
        
        var action = component.get('c.fetchOppli');
        
        action.setParams({
            "rId" : recId,
            "skutyeInput" : skucode,
            "proNameInput" : proName
        });
        action.setCallback(this,function(response){
            //console.log('anup quli fetched'+JSON.parse(response.getReturnValue()));
            var status = response.getState();
            if(status==="SUCCESS"){
                
                
                //component.set('v.allData',JSON.parse(response.getReturnValue()));
                component.set('v.oppliWrapper',JSON.parse(response.getReturnValue()));
                //console.log(component.get('v.allDatas'));
            }
        });
        $A.enqueueAction(action);
        
    },
    fetchopli1 : function(component, event, helper,skucode,proName) {
        // alert('inside heleper skucode is '+skucode);
        var action = component.get('c.fetchOpplii');
        var recId = component.get('v.recordId');
        action.setParams({
            "rId" : recId,
            "skutyeInput" : skucode,
            "proNameInput" : proName
        });
        action.setCallback(this,function(response){
            console.log('anup opli fetched'+JSON.parse(response.getReturnValue()));
            var status = response.getState();
            if(status==="SUCCESS"){
                
                
                //component.set('v.allData',JSON.parse(response.getReturnValue()));
                component.set('v.oppliWrapper1',JSON.parse(response.getReturnValue()));
                //console.log(component.get('v.allDatas'));
            }
        });
        $A.enqueueAction(action);
        
    },
    
    
})