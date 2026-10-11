({
	doInit : function(component, event, helper) {
        var opportunityRecordVal;
        var action = component.get("c.getRecord");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response1) {
        	var state = response1.getState();
            if (state === "SUCCESS"){
                opportunityRecordVal =JSON.parse(response1.getReturnValue());
                console.log('opp:'+opportunityRecordVal);
                var action1 = component.get("c.createnewkyc");
                action1.setParams({ accId : opportunityRecordVal.li.Account__c });
                action1.setCallback(this, function(response) {
                    var state1 = response.getState();
                    if (state1 === "SUCCESS"){
                        if(response.getReturnValue() === 'Success KYC'){
                                  //  if(response.getReturnValue() === 'Success Quote'){

                            var dismissActionPanel = $A.get("e.force:closeQuickAction");
                            dismissActionPanel.fire();
                            var createRecordCVR = $A.get("e.force:createRecord");
                            createRecordCVR.setParams({
                                "entityApiName": "Client_Validation_Request__c" ,
                                "defaultFieldValues":{
                                "Contact__c" : opportunityRecordVal.li.Contact__c,
                                "Account__c" : opportunityRecordVal.li.Account__c,
                                //"Contact_Email_Address__c" : opportunityRecordVal.Contact__r.Email,
                                "Contact_Email_Address__c" : opportunityRecordVal.email,
                                "Tel_Number__c" : opportunityRecordVal.phone,    
                                "GST_ID__c" : opportunityRecordVal.li.Account__r.GST_ID__c,
                                "PAN_Number__c" : opportunityRecordVal.li.Account__r.PAN__c,
                                "Account_Registration_Number__c" : opportunityRecordVal.li.Account__r.RegistrationNumber__c
                                //"RecordTypeId" : Schema.SObjectType.Client_Validation_Request__c.getRecordTypeInfosByName().get('Default').getRecordTypeId()
                                }
                            }); 
                            
                            createRecordCVR.fire();
                        }
                        else if(response.getReturnValue() === 'Success Quote'){
                           
                            component.set("v.message","KYC is required only for INDIAN account/KYC already validated please proceed with quote");
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