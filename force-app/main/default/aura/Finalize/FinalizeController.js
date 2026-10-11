({
	doInit : function(component, event, helper) {
		var action = component.get("c.getRecord");
		action.setParams({
			'quoteId': ''+component.get('v.recordId')+''
		});
		action.setCallback(this, function(response) {
			var quote = response.getReturnValue();
			if(quote.Net_Total__c !== quote.Payment_Net_Total__c){
				component.set("v.message","Net Total of Quote/Proposal and APAC Payment are not Equal");
			}
			else if(quote.Approval_Status__c === 'Finalized'){
				component.set("v.message","Finalized");
				location.reload();
			}
			else{
				component.set("v.message","Please submit for approval to finalize");
			}
		});
		$A.enqueueAction(action);
	},
	accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})