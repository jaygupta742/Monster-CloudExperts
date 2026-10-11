({
	doInit : function(component, event, helper) {
        component.set('v.showFirstpage',true);
        console.log('v.showFirstpage:'+component.get('v.showFirstpage'));
        helper.fetchProducts(component, event, helper);
        
	},
    searchTable: function (cmp, event, helper) {
        var allRecords = cmp.get("v.allData");
        var searchFilter = event.getSource().get("v.value").toUpperCase();
        console.log('searchFilter : '+searchFilter);
        var tempArray =[];
        var i;
        for(i=0; i<allRecords.length; i++){
            if((allRecords[i].accName && allRecords[i].accName.toUpperCase().indexOf(searchFilter) != -1) || 
               (allRecords[i].topuptype && allRecords[i].topuptype.toUpperCase().indexOf(searchFilter) != -1) ||
               (allRecords[i].prodName && allRecords[i].prodName.toUpperCase().indexOf(searchFilter) != -1)||
               (allRecords[i].invtenure && allRecords[i].invtenure.toUpperCase().indexOf(searchFilter) != -1)||
               (allRecords[i].uom && allRecords[i].uom.toUpperCase().indexOf(searchFilter) != -1)){
                tempArray.push(allRecords[i]);
            }
        }
        cmp.set("v.oppliWrapList",tempArray);
    },
    selectAllCheckbox: function(component, event, helper) {
    var lltp=component.get("v.oppliWrapList");
     var testervalue=component.get("v.sel");
    var filt=[]; 
        for (var item of lltp){
            item.ckb=testervalue;
           filt.push(item);
            
        }
        component.set('v.oppliWrapList',filt);
        $A.get('e.force:refreshView').fire();
    },
    showNext : function(component, event, helper){
        component.set('v.showFirstpage',false);
        var allItems=component.get("v.oppliWrapList");
        console.log('allItems: '+allItems);
        var selectedItems=[];
         for (var item of allItems){
            if(item.ckb==true) {   
             selectedItems.push(item);
            }
        }
        console.log('selectedItems: '+selectedItems);
        component.set('v.proceedItem',selectedItems);   
    },
    saveOn : function(component,event,helper){
        var action = component.get('c.saveOpli');
        action.setParams({
            "strWrap" : JSON.stringify(component.get('v.proceedItem')),
            "RecordId": component.get('v.recordId')
        });
        var ttu=component.get('v.recordId');
        var urlEvent = $A.get("e.force:navigateToURL");
       urlEvent.setParams({
      "url": '/'+ttu
    });
    urlEvent.fire();
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('state save:'+state);
            var type;
            var msg;
            var title;
            var ttu=response.getReturnValue();
            console.log('response value save:'+ttu);
            var urlEvent = $A.get("e.force:navigateToURL");
             urlEvent.setParams({
        "url": "/"+component.get('v.recordId')
    });
       urlEvent.fire();
            var status = response.getState();
             console.log('status:'+status);
            if(status==="SUCCESS"){
                type="success";
                msg = 'Accessories Added';
                title="Accessories Line Items Added Successfully!!!!";  
            }
            if(state==="ERROR"){
                let err = res.getError();
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
    },
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
   },
     
    hideSpinner : function(component,event,helper){    
       component.set("v.Spinner", false);
    },
    
      validateqty : function(component,event,helper)
    {
	var llp = component.get("v.proceedItem");
        
        for(var item of llp)
        {
             var qty = item.opli.Quantity_Unit__c;
         if(item.opli.Quantity_Unit__c>item.invcount)
         {
           alert("Inventory Count Cannot be Greater.....");
        item.opli.Quantity_Unit__c=item.invcount;

             
         }
        }
        
        component.set("v.proceedItem",llp);
    }
})