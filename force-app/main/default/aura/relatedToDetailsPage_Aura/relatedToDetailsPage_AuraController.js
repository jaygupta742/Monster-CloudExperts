({
    onInit: function (component, event, helper) {
        helper.fetchData(component);
        helper.getApprovalDetailsHelper(component);
        helper.getQuoteItemHelper(component);
        
        var action = component.get('c.getRelatedTo');
        console.log(component.get('v.recordId'));
        
        action.setParams({
            'recordId': component.get('v.recordId')
        });
        
        action.setCallback(this, function (res) {
            var state = res.getState();
            console.log('State : ' + state);
            if (state === 'SUCCESS') {
                
                var title, type, message;
                var rval = JSON.parse(res.getReturnValue());
                console.log('Result : ' + rval);
                // alert(' objectApiName  '+rval.objectAPIName)
                /*  let quoteFields = rval.relatedObjectFields.split(', ');
                if(quoteFields.includes('Id')) {
                    let index = quoteFields.indexOf('Id');
                    quoteFields.splice(index, 1);
                } */
                component.set('v.relatedTo', rval.recordId);
                component.set('v.relatedObjectApiName', rval.objectAPIName);
                component.set("v.isQuotesObject", component.get("v.relatedObjectApiName") === "QuotesN__c");
                //  component.set('v.fields', quoteFields);
                component.set('v.relatedToLabel', rval.relatedToLabel);
                component.set('v.relatedListLabel', rval.relatedListLabel);
                if (rval.relatedListFieldset && rval.relatedListFieldset.length > 0) {
                    var columnsToExclude = ['attributes', 'Id'];
                    let filteredColumns = Object.keys(rval.relatedListFieldset[0]).filter(key => !columnsToExclude.includes(key));
                    // alert(filteredColumns)
                    let TableColumns = filteredColumns.map(key => ({
                        label: key.replace('_', ' ').replace('__c', '').replace('1', ''),
                        fieldName: key,
                        type: 'text',
                    }));
                    let filteredData = rval.relatedListFieldset.map(record => {
                        let filteredRecord = {};
                                                                    filteredColumns.forEach(column => {
                                                                    filteredRecord[column] = record[column];
                                                                    });
                    return filteredRecord;
                });
                component.set('v.datatableColumset', TableColumns);
                component.set('v.datatableDataset', filteredData);
            }
            //  alert(' relatedListFieldsetforservice '+rval.relatedListFieldsetforservice)
            if (rval.relatedListFieldsetforservice && rval.relatedListFieldsetforservice.length > 0) {
                var columnsToExcludes = ['attributes', 'Id'];
                // alert(JSON.stringify(rval.relatedListFieldsetforservice))
                let filteredColumnser = Object.keys(rval.relatedListFieldsetforservice[0]).filter(key => !columnsToExcludes.includes(key));
                let TableColumnser = filteredColumnser.map(key => ({
                    label: key.replace('_', ' ').replace('__c', '').replace('_FS', ''),
                    // label :'',
                    fieldName: key,
                    type: 'text',
                }));
                
                /*   let promises = filteredColumnser.map(key => {
                           return new Promise((resolve, reject) => {
                           helper.label(component, event, helper, 'Quli_Accessories_Feildset', key, function(result) {
                          
                           resolve(result);
                           
                       });
                         
                   });
               });
          
               Promise.all(promises).then(function (results) {
                   results.forEach((value, index) => {
                       TableColumnser[index].label = value;
                   });
                       // Continue with the rest of your logic here, for example, setting the TableColumnser and filteredDataser
                   }); */
                
                
                let filteredDataser = rval.relatedListFieldsetforservice.map(record => {
                    let filteredRecordser = {};
                                                                             filteredColumnser.forEach(column => {
                                                                             filteredRecordser[column] = record[column];
                                                                             });
                return filteredRecordser;
            });
            component.set('v.datatableColumsetforservice', TableColumnser);
            component.set('v.datatableDatasetforservice', rval.relatedListFieldsetforservice);
        }
                           
                           
                           }
                           
                           
                           
                           
                           });
        
        $A.enqueueAction(action);
    },
    
    
})