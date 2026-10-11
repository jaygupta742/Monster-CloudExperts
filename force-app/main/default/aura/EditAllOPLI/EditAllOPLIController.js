({
	doInit : function(component, event, helper) {
        //helper.chkv(component, event, helper);
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
                
                var lltp=component.get("v.opliList");
                
                for(var item of lltp){
                    if(item.opli.Discount_Type__c=='%'){
                      item.damt=((item.opli.Discount_Value__c*item.opli.Unit_Price__c)/100)*item.opli.Quantity_Unit__c;
                      //item.grosstotal=((item.opli.Unit_Price__c*item.opli.Quantity_Unit__c)-(item.opli.Discount_Value__c*item.opli.Unit_Price__c)/100)*item.opli.Quantity_Unit__c;
                                            item.grosstotal=(item.opli.Unit_Price__c*item.opli.Quantity_Unit__c)-item.damt;

                    }
                    if(item.opli.Discount_Type__c=='Base Price Override'){
                item.grosstotal=item.opli.Discount_Value__c;
                item.damt=item.opli.Unit_Price__c* item.opli.Quantity_Unit__c -item.opli.Discount_Value__c;
            }
            if(item.opli.Discount_Type__c=='Price Override'){
                item.grosstotal=item.opli.Discount_Value__c*item.opli.Quantity_Unit__c;
                item.damt=item.opli.Unit_Price__c* item.opli.Quantity_Unit__c - item.opli.Discount_Value__c*item.opli.Quantity_Unit__c;
            }
            if(item.opli.Discount_Type__c=='Amount'){
                item.damt=item.opli.Discount_Value__c;
                item.grosstotal=item.opli.Unit_Price__c*item.opli.Quantity_Unit__c-item.opli.Discount_Value__c;
            }
                }
               
            }
            
        });
        $A.enqueueAction(action);
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
    },
    onSave : function(component,event,helper){
        var objWrap = component.get("v.opliList");
        console.log(objWrap);
        var action = component.get("c.onsave");
        action.setParams({
            "listItem" :JSON.stringify(objWrap),
            
        });
     let button = component.find('disablebuttonid');
    button.set('v.disabled',true);
        
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
    },
    validateqty : function(component,event,helper)
    {
        
		var llp = component.get("v.opliList");
        for(var item of llp)
        {
			var unit = item.opli.Unit_Price__c;
             var qty = item.opli.Quantity_Unit__c;
             item.opli.Base_Total__c = unit * qty;
            if(item.opli.Discount_Type__c === "%")
            {
                var discountval = item.opli.Discount_Value__c;
                var base = item.opli.Base_Total__c;
                item.opli.Gross_Total__c = (base*(100-discountval))/100;
                item.opli.Discount_Amount_1__c = (base * discountval)/100;
            }
            if(item.opli.Discount_Type__c === "Amount")
            {
                 var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (qty * dis);
                item.opli.Discount_Amount_1__c = qty * dis;
            }
            if(item.opli.Discount_Type__c === "Base Price Override")
            {
                var base = item.opli.Base_Total__c;
                 var dis = item.opli.Discount_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = qty * dis;
                 item.opli.Discount_Amount_1__c  = base - (qty * dis);
            }
            if(item.opli.Discount_Type__c === "Price Override")
             {
                 var base = item.opli.Base_Total__c;
                  var dis = item.opli.Discount_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                 item.opli.Gross_Total__c = dis;
                 item.opli.Discount_Amount_1__c  = base - dis;
             }
              if(item.opli.Quantity_Unit__c>item.to)
            {
                alert('Quantity Should be in the Range of BIN');
              item.opli.Quantity_Unit__c=item.fromqty;

            }
        }
       
        component.set("v.opliList",llp);
    },
    
    checkdiscount : function(component,event,helper)
    {
        console.log("Inside checkdiscount");
        var llp = component.get("v.opliList");
        for(var item of llp)
        {
            if(item.opli.Discount_Type__c === "%")
            {
                var discountval = item.opli.Discount_Value__c;
                var base = item.opli.Base_Total__c;
                item.opli.Gross_Total__c = (base*(100-discountval))/100;
                item.opli.Discount_Amount_1__c = (base * discountval)/100;
            }
			if(item.opli.Discount_Type__c === "Amount")
            {
                 var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (qty * dis);
                item.opli.Discount_Amount_1__c = qty * dis;
            }
            if(item.opli.Discount_Type__c === "Base Price Override")
            {
                var base = item.opli.Base_Total__c;
                 var dis = item.opli.Discount_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = qty * dis;
                 item.opli.Discount_Amount_1__c  = base - (qty * dis);
            }
             if(item.opli.Discount_Type__c === "Price Override")
             {
                 var base = item.opli.Base_Total__c;
                  var dis = item.opli.Discount_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                 item.opli.Gross_Total__c = dis;
                 item.opli.Discount_Amount_1__c  = base - dis;
             }
             /////////////////////////////////////////////////////////////////////////////////////
                    if(item.opli.Discount_Type__c=='%'){
                      item.damt=((item.opli.Discount_Value__c*item.opli.Unit_Price__c)/100)*item.opli.Quantity_Unit__c;
                      item.grosstotal=(item.opli.Unit_Price__c*item.opli.Quantity_Unit__c)-item.damt;
                    }
                    if(item.opli.Discount_Type__c=='Base Price Override'){
                item.grosstotal=item.opli.Discount_Value__c;
                item.damt=item.opli.Unit_Price__c* item.opli.Quantity_Unit__c -item.opli.Discount_Value__c;

            }
            if(item.opli.Discount_Type__c=='Price Override'){
                item.grosstotal=item.opli.Discount_Value__c*item.opli.Quantity_Unit__c;
                item.damt=item.opli.Unit_Price__c* item.opli.Quantity_Unit__c - item.opli.Discount_Value__c*item.opli.Quantity_Unit__c;
            }
            if(item.opli.Discount_Type__c=='Amount'){
                item.damt=item.opli.Discount_Value__c;
                item.grosstotal=item.opli.Unit_Price__c*item.opli.Quantity_Unit__c-item.opli.Discount_Value__c;

            }
            
            if(item.opli.Quantity_Unit__c>item.to)
            {
                alert('Quantity Should be in the Range of BIN'); 
              item.opli.Quantity_Unit__c=item.fromqty;

            }
            ///////////////////////////////////////////////////////////////////////////////////
        }
        component.set("v.opliList",llp);

    }

    
    
    
})