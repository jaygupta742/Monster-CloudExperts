({
    fetchData : function(component) {
        // Call an Apex controller method to retrieve data
        var action = component.get("c.getQuoteDetails");
         action.setParams({
            'recordId': component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Set the wrapperList attribute with the returned data
               // component.set("v.wrapperList", response.getReturnValue());
                 component.set("v.wrapperList",JSON.parse(response.getReturnValue()));
            } else {
                // Handle error state if needed
                console.error('Error fetching data: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    getApprovalDetailsHelper : function(component) {
        // Call an Apex controller method to retrieve data
        var action = component.get("c.getApprovalDetails");
         action.setParams({
            'recordId': component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Set the wrapperList attribute with the returned data
               // component.set("v.wrapperList", response.getReturnValue());
                 component.set("v.wrapperApprovalHistory",JSON.parse(response.getReturnValue()));
            } else {
                // Handle error state if needed
                console.error('Error fetching data: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
     getQuoteItemHelper : function(component) {
        // Call an Apex controller method to retrieve data
        var action = component.get("c.getQuoteItem");
         action.setParams({
            'recordId': component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Set the wrapperList attribute with the returned data
               // component.set("v.wrapperList", response.getReturnValue());
                 component.set("v.wrapperListQItem",JSON.parse(response.getReturnValue()));
            } else {
                // Handle error state if needed
                console.error('Error fetching data: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    showToast: function (component, event, helper, title, type, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            'title': title,
            'type': type,
            'message': message
        });
        toastEvent.fire();
    },
    label: function (component, event, helper, fieldSetName, fieldAPIName) {
        // alert('on label fieldSetName ' +fieldSetName +' fieldAPIName ' +fieldAPIName)
        return new Promise((resolve, reject) => {
            //  alert('on label inside')
            var action = component.get("c.getFieldLabelFromFieldSet");
            action.setParams({
            fieldAPINames: fieldSetName,
            objectname: fieldAPIName
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnValue = response.getReturnValue();
                //   console.log('Returned value:', returnValue);
                resolve(returnValue);
                console.log('Returned value:', resolve);
            } else {
                reject("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    });
}
 
 /*  label: function(component, event, helper, fieldAPINames, objectname) {
    var action = component.get("c.getFieldLabels");
    // Add your field API names here
    action.setParams({
        "fieldAPINames": fieldAPINames,
        "objectname": objectname
    });
    action.setCallback(this, function(response) {
        var state = response.getState();
        console.log('state ' + state);
        if (state === "SUCCESS") {
            var fieldLabelMap = response.getReturnValue();
          //  console.log('fieldLabelMap ' + JSON.stringify(fieldLabelMap));

            // Extracting only the values (labels)
            var labels = Object.values(fieldLabelMap);
             
            console.log('labels ' + JSON.stringify(labels));

            // Do something with the labels, such as populating your data table
            // Example:
           // component.set("v.labels", labels);
        } else {
            console.log("Failed with state: " + state);
        }
    });
    $A.enqueueAction(action);
}
    
  setLineItemsColumns : function(component, event, helper){
        console.log('---------- setLineItemsColumns ------------');
        let columns = [];
        var relatedObjApiName = component.get('v.relatedObjectApiName');
        
        if(relatedObjApiName === 'QuotesN__c') {
            columns = [
                { label: 'QULI Id', fieldName: 'itemName', initialWidth: 100 },
                { label: 'Account', fieldName: 'accoutName', initialWidth: 150 },
                { label: 'Product Name', fieldName: 'productName', initialWidth: 150 },
                { label: 'Product Country', fieldName: 'productCountry'},
                { label: 'Tenure (Months)', fieldName: 'tenure'},
                { label: 'Quantity (Unit)', fieldName: 'quantity'},
                { label: 'Unit Price', fieldName: 'unitPrice', type: 'currency', typeAttributes : {currencyCode : 'INR'}},
                { label: 'Gross Total', fieldName: 'grossTotal', type: 'currency', typeAttributes : {currencyCode : 'INR'}},
                { label: 'Start Date', fieldName: 'startDate'},
                { label: 'End Date', fieldName: 'startDate'}
            ];
        }
        component.set('v.datatableColums', columns);
        
    },
                
    setLineItemsTable : function(component, event, helper, data) {
        let table_data = [];
        var relatedObjApiName = component.get('v.relatedObjectApiName');
      
        if(relatedObjApiName === 'QuotesN__c') {
            for(let item of data) {
                let obj = {
                    itemName : item.Name,
                    itemId : item.Id,
                    itemUrl : '/' + item.Id,
                    accoutId : item.Account__c,
                    accoutName : item.Account__r.Name,
                    accoutUrl : '/' + item.Account__c,
                    productName : item.Product_Name__c,
                    productCountry : item.Product_Country__c,
                    tenure : item.Tenure_Months__c,
                    quantity : item.Quantity_Unit__c,
                    unitPrice : item.Unit_Price__c,
                    grossTotal : item.Gross_Total1__c,
                    startDate : item.Start_Date__c,
                    endDate : item.End_Date__c
                };

                table_data.push(obj);
            }
            component.set('v.datatableData', table_data);
        }
    }, */
 
 })