({
	doInit : function(component, event, helper) {
        var opportunityRecordVal;
        var action = component.get("c.getRecord");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response1) {
        	var state = response1.getState();
            if (state === "SUCCESS"){
                opportunityRecordVal = response1.getReturnValue();
                var action1 = component.get("c.createnewcvr");
                action1.setParams({ accId : opportunityRecordVal.Account__c });
                action1.setCallback(this, function(response) {
                    var state1 = response.getState();
                    if (state1 === "SUCCESS"){
                        if(response.getReturnValue() === 'Success KYC'){
                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();
                            var createRecordCVR = $A.get("e.force:createRecord");
                            createRecordCVR.setParams({
                                "entityApiName": "Client_Validation_Request__c" ,
                                "defaultFieldValues":{
                                "Contact__c" : opportunityRecordVal.Contact__c,
                                "Account__c" : opportunityRecordVal.Account__c,
                                "Contact_Email_Address__c" : opportunityRecordVal.Contact__r.Email,
                                "Tel_Number__c" : opportunityRecordVal.Contact__r.Phone,    
                                "GST_ID__c" : opportunityRecordVal.Account__r.GST_ID__c,
                                "PAN_Number__c" : opportunityRecordVal.Account__r.PAN__c,
                                "Account_Registration_Number__c" : opportunityRecordVal.Account__r.RegistrationNumber__c
                                //"RecordTypeId" : Schema.SObjectType.Client_Validation_Request__c.getRecordTypeInfosByName().get('Default').getRecordTypeId()
                                }
                            }); 
                            createRecordCVR.fire();
                        }
                        else if(response.getReturnValue() === 'Success Quote'){
                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();
                            var createRecordQuote = $A.get("e.force:createRecord");
                            createRecordQuote.setParams({
                                "entityApiName": "apttus_proposal_proposal__c" ,
                                "defaultFieldValues":{
                                "Opportunity__c" : component.get("v.recordId"),
                                "Account__c" : opportunityRecordVal.Account__c,
                                "APTS_Quote_Type__c" : opportunityRecordVal.OpportunityType__c,
                                "Order_Type__c" : opportunityRecordVal.OpportunityType__c
                                //"RecordTypeId" : Schema.SObjectType.apttus_proposal_proposal__c.getRecordTypeInfosByName().get('before_finalize').getRecordTypeId()
                                }
                            }); 
                            createRecordQuote.fire();
                        }
                        else{
                            component.set("v.message","Error: "+response.getReturnValue());
                        }
                    }              
                });
                $A.enqueueAction(action1);
            }
        });
        $A.enqueueAction(action);
	},
    // accept button function to close quick action and reload the page
    accept : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        location.reload();
    }
})