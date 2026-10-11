({
	doInit : function(component, event, helper) {
		var action=component.get('c.fetchlineitem');
        action.setParams({
            "rid":component.get('v.recordId')
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            console.log('state'+state);
            console.log('response:'+response.getReturnValue());
            if(state==='SUCCESS')
            {
                component.set('v.oppList',JSON.parse(response.getReturnValue()));
            }
        });
        $A.enqueueAction(action);
	},
    
    removeDeletedRow:function(component,event,helper)
    {
        var ctarget=event.currentTarget;
        var index=ctarget.dataset.value;
        console.log('index'+index);
        console.log('ctarget:'+ctarget);
        var AllRowsList=component.get("v.oppList");
        console.log('AllRowsList:'+AllRowsList);
        var idss=AllRowsList[index].Id;
        console.log('idss:'+idss);
        AllRowsList.splice(index, 1);
        
        var action=component.get("c.lineItemDel");
        action.setParams({
            "recId":idss
        });
        
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS')
            {
                component.set("v.oppList", AllRowsList);
            }
            
        });
        $A.enqueueAction(action);
        
    },
    onSave: function(component,event,helper)
    {
        var action=component.get('c.onsave');
        var objWrap=component.get('v.oppList');
        action.setParams({
            "listItem":JSON.stringify(objWrap)
        });
        action.setCallback(this,function(res){
            var state=res.getState();
            var type;
            var msg;
            var title;
            console.log("state save:"+state);
            var ttu=component.get('v.recordId');
            var urlEvent= $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url":'/'+ttu
            });
            urlEvent.fire();
            
            
            if(state==='SUCCESS')
            {
                component.set('v.successMsg',res.getReturnValue());
                type="Success";
                msg="Records Updated Successfully!";
                title="Records Update";
                
            }
            if(state==='ERROR')
            {
                var error=res.getError();
                title="Error";
                type="Error";
                msg=error[0].message;
                alert(msg);
            }
            var toastEvent= $A.get('e.force:showToast');
            toastEvent.setParams({
                "title":title,
                "type":type,
                "message":msg
            });
            toastEvent.fire();
        })
        $A.enqueueAction(action);
    },
     validateqty : function(component,event,helper)
    {
        
		var llp = component.get("v.oppList");
        for(var item of llp)
        {
			var unit = parseInt(item.opli.Unit_Price__c);
             var qty = parseInt(item.opli.Quantity_Unit__c);
             item.opli.Base_Total__c = unit * qty;
            if(item.opli.Adjustment_Type__c === "%")
            {
                var discountval = parseInt(item.opli.Adjustment_Value__c);
                var base = parseInt(item.opli.Base_Total__c);
                item.opli.Gross_Total__c = (base*(100-discountval))/100;
                item.opli.Discount_Amount__c = (base * discountval)/100;
            }
            if(item.opli.Adjustment_Type__c === "Amount")
            {
                 var base = item.opli.Base_Total__c;
                var dis = item.opli.Adjustment_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (qty * dis);
                item.opli.Discount_Amount__c = qty * dis;
            }
            if(item.opli.Adjustment_Type__c === "Base Price Override")
            {
                var base = item.opli.Base_Total__c;
                 var dis = item.opli.Adjustment_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = qty * dis;
                 item.opli.Discount_Amount__c  = base - (qty * dis);
            }
            if(item.opli.Adjustment_Type__c === "Price Override")
             {
                 var base = item.opli.Base_Total__c;
                  var dis = item.opli.Adjustment_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                 item.opli.Gross_Total__c = dis;
                 item.opli.Discount_Amount__c  = base - dis;
             }
         if(item.opli.Quantity_Unit__c>item.invcount)
         {
           alert("Inventory Count Cannot be Greater.....");
        item.opli.Quantity_Unit__c=item.invcount;

             
         }
        }
       
        component.set("v.oppList",llp);
    },
    
    checkdiscount : function(component,event,helper)
    {
        console.log("Inside checkdiscount");
        var llp = component.get("v.oppList");
        for(var item of llp)
        {
            if(item.opli.Adjustment_Type__c === "%")
            {
                var discountval = item.opli.Adjustment_Value__c;
                var base = item.opli.Base_Total__c;
                item.opli.Gross_Total__c = (base*(100-discountval))/100;
                item.opli.Discount_Amount__c = (base * discountval)/100;
            }
			if(item.opli.Adjustment_Type__c === "Amount")
            {
                 var base = item.opli.Base_Total__c;
                var dis = item.opli.Adjustment_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (qty * dis);
                item.opli.Discount_Amount__c = qty * dis;
            }
            if(item.opli.Adjustment_Type__c === "Base Price Override")
            {
                var base = item.opli.Base_Total__c;
                 var dis = item.opli.Adjustment_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = qty * dis;
                 item.opli.Discount_Amount__c  = base - (qty * dis);
            }
             if(item.opli.Adjustment_Type__c === "Price Override")
             {
                 var base = item.opli.Base_Total__c;
                  var dis = item.opli.Adjustment_Value__c;
                 var qty = item.opli.Quantity_Unit__c;
                 item.opli.Gross_Total__c = dis;
                 item.opli.Discount_Amount__c  = base - dis;
             }
        }
        component.set("v.oppList",llp);

    }
    
 
    

})