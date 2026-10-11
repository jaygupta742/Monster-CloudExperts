({
    doInit : function(component, event, helper) {
        component.set('v.SpinnerStatus', true);
        helper.getAccountStatusApexHelper(component, event, helper);
        helper.getOppObject(component, event, helper);
        helper.getQuoteObject(component, event, helper);
        helper.getQULI(component, event, helper);
        helper.getQULIAcc(component, event, helper);
        helper.getcontact(component, event, helper);
        helper.getRecontractQuotes(component, event, helper);

        component.set('v.ProductColumns', [
            {label: 'Opportunity Items', fieldName: 'ItemURL', type: 'url', typeAttributes: { tooltip: { fieldName: 'Click to visit Opportunity Items' }, label: {fieldName: 'Name'}, target: '_blank'} },
            {label: 'Product Name', fieldName: 'ProductURL', type: 'url', typeAttributes: { tooltip: { fieldName: 'Click to visit Product Details' }, label: {fieldName: 'Product_Name__c'}, target: '_blank'} },
            {label: 'Start Date', fieldName: 'Start_Date__c', type: 'date'},
            {label: 'End Date', fieldName: 'End_Date__c', type: 'date'},
            {label: 'Comment', fieldName: 'Comment__c', type: 'text'},
            {label: 'Quantity', fieldName: 'Quantity_Unit__c', type: 'number'},
            {label: 'Unit Rate', fieldName: 'Unit_Price__c', type: 'currency'},
            {label: 'Adjustment Type', fieldName: 'Discount_Type__c', type: 'text'},
            {label: 'Adjusted Value', fieldName: 'Discount_Value__c', type: 'currency'},
        ]);

        component.set('v.AccessoriesColumns', [
            {label: 'Opportunity Services', fieldName: 'ItemURL', type: 'url', typeAttributes: { tooltip: { fieldName: 'Click to visit Opportunity Services' }, label: {fieldName: 'Name'}, target: '_blank'} },
            {label: 'Product Name', fieldName: 'ProductURL', type: 'url', typeAttributes: { tooltip: { fieldName: 'Click to visit Product Details' }, label: {fieldName: 'Product_Name__c'}, target: '_blank'} },
            {label: 'Services Name', fieldName: 'ServiceURL', type: 'url', typeAttributes: { tooltip: { fieldName: 'Click to visit Service Details' }, label: {fieldName: 'ServiceName'}, target: '_blank'} },
            {label: 'Quantity', fieldName: 'Quantity__c', type: 'number'},
            {label: 'Unit Rate', fieldName: 'Unit_Price1__c', type: 'currency'},
            {label: 'Inventory Quota Tenure', fieldName: 'Inventory_Quota_Tenure1__c', type: 'text'},
        ]);
        component.set('v.SpinnerStatus', false);
    },
    HandleChangeValue : function(component, event, helper) {
        console.log(JSON.stringify(event));
        let recordId = event.getParam('recordId');
        let fieldName = event.getParam('fieldName');
        console.log(recordId, fieldName);
        let Quotation = component.get("v.quoteObj");
        Quotation[fieldName] = recordId;
        component.set("v.quoteObj", Quotation);
    },
    showNext : function(component, event, helper) {
        
        var qu =  component.get('v.quoteObj');
        console.log('order type'+qu.Quote_Type__c);
        if(qu.Quote_Type__c == null || qu.Quote_Type__c == 'undefined' || qu.Quote_Type__c ==''){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title":'',
                "type": 'error',
                "message":'Quote Type Is Mandatory..!!'
            });  
            toastEvent.fire();
            return ;
        }
        component.set('v.showFirstpage',false);
        var quli = component.get('v.quoteLineItems');
        var quliacc = component.get('v.quliAccessories');
        
        for(let qu of quli){
            for(let qa of quliacc){
                if(qu.Opportunity_Line_Item__c===qa.Opportunity_Line_Item__c){
                    qa.Unloading_Charges__c=qu.Unloading_Charges__c;
                } 
            }
        }
        component.set('v.quliAccessories',quliacc);
        
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
        var AllRowsList = component.get("v.quoteLineItems");
        console.log('AllRowsList:'+AllRowsList[index].Id);
        var idss = AllRowsList[index].Id;
        AllRowsList.splice(index, 1);
        component.set("v.quoteLineItems", AllRowsList);
    },
    removeDeletedRow1 : function(component, event, helper){
        var ctarget = event.currentTarget;
        var index = ctarget.dataset.value;
        console.log('ctarget.dataset: '+ctarget.dataset.index);
        // get the all List (listPay attribute) and remove the Object Element Using splice method    
        var AllRowsList = component.get("v.quliAccessories");
        console.log('AllRowsList:'+AllRowsList[index].Id);
        var idss = AllRowsList[index].Id;
        AllRowsList.splice(index, 1);
        component.set("v.quliAccessories", AllRowsList);
    },
    HandleSaveQuote : function(component, event, helper){
        var Quotation = component.get("v.quoteObj");

        if(Quotation.Contact__c === null || Quotation.Contact__c === undefined || Quotation.Contact__c === '') {
            helper.HanldeShowToast('Contact!', 'Required Field Missing, Please update Contact.', 'error');
            return ;
        }
        if(Quotation.Quote_Type__c === null || Quotation.Quote_Type__c === undefined || Quotation.Quote_Type__c === ''){
            helper.HanldeShowToast('Quote Type!', 'Required Field Missing, Please update Quote Type.', 'error');
            return ;
        }
        if(Quotation.Quote_Type__c === 'lapsed' || Quotation.Quote_Type__c === 'Renewal' || Quotation.Quote_Type__c === 'Slippage') {
            if(Quotation.Base_Order_ID__c === null || Quotation.Base_Order_ID__c === undefined || Quotation.Base_Order_ID__c === '') {
                helper.HanldeShowToast('Base Order Id!', 'Required Field Missing, Please update Base Order Id.', 'error');
                return ;
            }
        }
       if(Quotation.Quote_Type__c === 'Recontract') {
            if(Quotation.Base_Quote_Id__c === null || Quotation.Base_Quote_Id__c === undefined || Quotation.Base_Quote_Id__c === '') {
                helper.HanldeShowToast('Base Quote Id!', 'Required Field Missing, Please update Base Quote Id', 'error');
                return;
            }
            if(Quotation.Payment_Type__c === null || Quotation.Payment_Type__c === undefined || Quotation.Payment_Type__c === '') {
                helper.HanldeShowToast('Payment Type!', 'Required Field Missing, Please update Payment Type', 'error');
                return;
            }
            if(Quotation.Amount__c === null || Quotation.Amount__c === undefined || Quotation.Amount__c === '') {
                helper.HanldeShowToast('Amount!', 'Required Field Missing, Please update Amount', 'error');
                return;
            }
        }
        if(Quotation.Billing_Address__c === null || Quotation.Billing_Address__c === undefined || Quotation.Billing_Address__c === '') {
            helper.HanldeShowToast('Billing Address!', 'Required Field Missing, Please update Billing Address.', 'error');
            return ;
        }
        if(Quotation.Posting_Address__c === null || Quotation.Posting_Address__c === undefined || Quotation.Posting_Address__c === '') {
            helper.HanldeShowToast('Posting Address!', 'Required Field Missing, Please update Posting Address.', 'error');
            return ;
        }
        if(Quotation.Selling_Country__c === null || Quotation.Selling_Country__c === undefined || Quotation.Selling_Country__c === '') {
            helper.HanldeShowToast('Selling Country!', 'Required Field Missing, Please update Selling Country.', 'error');
            return ;
        }
        
        if(Quotation.Billing_Address__c != null && Quotation.Posting_Address__c != null && Quotation.Selling_Country__c != null) {
            component.set('v.SpinnerStatus', true);

            var action = component.get("c.saveQuote");
            
            action.setParams({
                "recId" : component.get("v.recordId"),
                "quo" : component.get("v.quoteObj"),
                "quli" : component.get("v.quoteLineItems"),
                "quacli" : component.get("v.quliAccessories")
            });
            
            let SaveButton = component.find('SaveButton');
            let CancelButton = component.find('CancelButton');

            if(SaveButton) SaveButton.set('v.disabled', true);
            if(CancelButton) CancelButton.set('v.disabled', true);

            action.setCallback(this, function(response){
                let status = response.getState();
                if(status === "SUCCESS"){
                    let rval = response.getReturnValue();
                    helper.HanldeShowToast('Quote Created!!!', 'Quote Created Successfully!!!', 'success');
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/" + rval
                    });
                    urlEvent.fire();
                }
                
                if(status==="ERROR"){
                    let err = response.getError();
                    let msg = err[0].message;
                    helper.HanldeShowToast('Something went wrong', msg, 'error');
                }
                component.set('v.SpinnerStatus', false);
                if(SaveButton) SaveButton.set('v.disabled', false);
                if(CancelButton) CancelButton.set('v.disabled', false);
            });
            $A.enqueueAction(action);
            $A.get('e.force:refreshView').fire();
        }
        else {
            helper.HanldeShowToast('Error!', 'Please fill Billing address and Posting address', 'error');
        }
    },
    HandleCancelPage: function(component) {
        var action = $A.get("e.force:closeQuickAction");
        action.fire();
    }
})