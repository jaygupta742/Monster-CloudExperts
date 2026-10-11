import { LightningElement, api, track, wire } from 'lwc';
import Id from "@salesforce/user/Id";
import FORM_FACTOR from "@salesforce/client/formFactor";
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
import saveMethod from '@salesforce/apex/createOpportunity.saveMethod';

import { getRecord } from 'lightning/uiRecordApi';
import { createRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';

const AccountFields = [
    'Account.Id',
    'Account.Name',
    'Account.AccountStatus__c',
];

const UserFields = [
    'User.Id',
    'User.Name',
    'User.ProfileId',
    'User.Profile.Name',
    'User.Channel__c',
];

export default class CreateOpportunity_LWC extends NavigationMixin(LightningElement) {
    @api recordId;
    userId = Id;
    @track Account;
    @track Contacts;
    @track User;
    @track Account;
    @track Opportunity;
    @track btndisabled = false;

    @wire(getRecord, { recordId: "$recordId", fields: AccountFields })
    async onCallback_GetAccount(response) {
        const { data, error } = response;
        if (data) {
            this.Account = {};
            for (let field in data.fields) {
                this.Account[field] = data.fields[field].value;
            }
            this.Opportunity.Account__c = this.Account.Id;
        }
        if (error) {
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
                message = error.body.map((e) => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
                message = error.body.message;
            } else {
                message += JSON.stringify(error);
            }
            await this.HandleAlertClick('Something went wrong!', message, 'error');
        }
    }

    @wire(getRecord, { recordId: "$userId", fields: UserFields })
    async onCallback_GetCurrentUser(response) {
        const { data, error } = response;
        if (data) {
            this.User = {};
            for (let field in data.fields) {
                this.User[field] = data.fields[field].value;
            }

            let profile = {};
            for (let field in this.User.Profile.fields) {
                profile[field] = this.User.Profile.fields[field].value;
            }
            this.User.Profile = profile;
            this.Opportunity.OwnerId = this.User.Id;
            this.Opportunity.Owner_Channel__c = this.User.Channel__c;
        }
        if (error) {
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
                message = error.body.map((e) => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
                message = error.body.message;
            } else {
                message += JSON.stringify(error);
            }
            await this.HandleAlertClick('Something went wrong!', message, 'error');
        }
    }

    connectedCallback() {
        this.Account = {};
        this.Contacts = [];
        this.Opportunity = {
            Account__c: null,
            OwnerId: null,
            Contact__c: null,
            Price_Master__c: null,
            Closure_probablity__c: null,
            Opportunity_Type__c: null,
            Remarks__c: null,
            Stage__c: null,
            Reason_Won_Lost__c: null,
            Close_Date__c: null,
            Expected_Revenue__c: null,
            Stage__c: null,
            Base_Order_ID__c: null,
            CurrencyIsoCode: null,
            Owner_Channel__c: null
        }
    }

    HandleChangeInput(event) {
        const { fieldName, name, value } = event.target;
        if (fieldName) this.Opportunity[fieldName] = value;
        if (name) this.Opportunity[name] = value;
        if (name === 'Contact__c') this.Opportunity[name] = event.detail.recordId;
    }

    async HandleSaveChanges() {
        this.btndisabled = true;
        if (!this.Opportunity.Contact__c) {
            this.HandleShowToast(`Required field missing: Contact`, 'Contact can not be empty! Please complete this field', 'error');
            return;
        }
        if (!this.Opportunity.Price_Master__c) {
            this.HandleShowToast(`Required field missing: Price Master`, 'Price Master can not be empty! Please complete this field', 'error');
            return;
        }
        if (!this.Opportunity.Opportunity_Type__c) {
            this.HandleShowToast(`Required field missing: Opportunity Type`, 'Opportunity Type can not be empty! Please complete this field', 'error');
            return;
        }
        if (!this.Opportunity.Close_Date__c) {
            this.HandleShowToast(`Required field missing: Close Date`, 'Close Date can not be empty! Please complete this field', 'error');
            return;
        }
        if (!this.Opportunity.Expected_Revenue__c) {
            this.HandleShowToast(`Required field missing: Expected Revenue`, 'Expected Revenue can not be empty! Please complete this field', 'error');
            return;
        }

        console.log('Working 3');

        saveMethod({
            oppRecords: JSON.stringify(this.Opportunity)
        }).then(response => {
            this.HandleShowToast('Success!', 'Opportunity created successfully!', 'success');
            this.navigateToOppPage(response);
            this.HandleCancel();
        }).catch(error => {
            console.log('Working in error');
            console.log(JSON.stringify(error));
            const errorBody = error.body;
            const firstErrorMessage = errorBody.pageErrors && errorBody.pageErrors.length > 0 ? errorBody.pageErrors[0].message : 'An error occurred';
            this.HandleShowToast('Error!!', firstErrorMessage, 'error');
        })
            .finally(() => {
                this.btndisabled = false;
                this.HandleCancel();
            });
    }

    HandleSave() {
        this.btndisabled = true;
        if (!this.Opportunity.Contact__c) {
            this.HandleShowToast(`Required field missing: Contact`, 'Contact can not be empty! Please complete this field', 'error');
            this.btndisabled = false;
            return;
        }
        if (!this.Opportunity.Price_Master__c) {
            this.HandleShowToast(`Required field missing: Price Master`, 'Price Master can not be empty! Please complete this field', 'error');
            this.btndisabled = false;
            return;
        }
        if (!this.Opportunity.Opportunity_Type__c) {
            this.HandleShowToast(`Required field missing: Opportunity Type`, 'Opportunity Type can not be empty! Please complete this field', 'error');
            this.btndisabled = false;
            return;
        }
        if (!this.Opportunity.Close_Date__c) {
            this.HandleShowToast(`Required field missing: Close Date`, 'Close Date can not be empty! Please complete this field', 'error');
            this.btndisabled = false;
            return;
        }
        if (!this.Opportunity.Expected_Revenue__c) {
            this.HandleShowToast(`Required field missing: Expected Revenue`, 'Expected Revenue can not be empty! Please complete this field', 'error');
            this.btndisabled = false;
            return;
        }

        saveMethod({
            oppRecords: JSON.stringify(this.Opportunity)
        }).then(response => {
            this.HandleShowToast('Success!', 'Opportunity created successfully!', 'success');
            if (response == null) {
                this.HandleShowToast(`Account Not In Lead Or Unpromoted Stage`, 'Account Not Is In Lead Or Unpromoted Stage', 'error');
            } else {

            }
            console.log(response);
            this.navigateToOppPage(response);

            this.HandleCancel();
        }).catch(error => {
            console.log('Working in error');
            console.log(JSON.stringify(error));
            const errorBody = error.body;
            const firstErrorMessage = errorBody.pageErrors && errorBody.pageErrors.length > 0 ? errorBody.pageErrors[0].message : 'An error occurred';
            this.HandleShowToast('Error!!', firstErrorMessage, 'error');
        })
            .finally(() => {
                this.btndisabled = false;
                this.HandleCancel();
            });
    }

    navigateToOppPage(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'OpportunityN__c',
                recordId: recordId,
                actionName: 'view'
            },
        });
    }

    async HandleCreateRecord(ObjectApiName, data) {
        try {
            const fields = { ...data };
            return await createRecord({ apiName: ObjectApiName, fields })
        } catch (error) {
            console.error('Output error: ', error);
            throw error;
        }
    }

    HandleCancel() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    async HanldeUpdateRecord(RecordData) {
        try {
            const recordInput = {
                fields: RecordData
            };
            return updateRecord(recordInput);
        } catch (error) {
            throw error;
        }
    }

    get OpportunityTypeOptions() {
        let options = [];
        switch (this.Account.AccountStatus__c) {
            case 'Candidate':
                options = [
                    { label: 'New Customer', value: 'New Customer' },
                    { label: 'Free Trial', value: 'Free Trial' },
                ];
                break;
            case 'Customer':
                options = [
                    { label: 'Upsell', value: 'Upsell' },
                    { label: 'Renewal', value: 'Renewal' },
                    { label: 'Recontract', value: 'Recontract' },
                    { label: 'Free Trial', value: 'Free Trial' },
                ];
                break;
            case 'Slippage':
                options = [
                    { label: 'Slippage', value: 'Slippage' },
                    { label: 'Free Trial', value: 'Free Trial' },
                ];
                break;
            case 'Lapsed Customer':
                options = [
                    { label: 'Lapsed', value: 'Lapsed' },
                    { label: 'Free Trial', value: 'Free Trial' },
                ];
                break;
            default:
                options = [
                    { label: 'New Customer', value: 'New Customer' },
                    { label: 'Renewal', value: 'Renewal' },
                    { label: 'Upsell', value: 'Upsell' },
                    { label: 'Lapsed', value: 'Lapsed' },
                    { label: 'Recontract', value: 'Recontract' },
                    { label: 'Free Trial', value: 'Free Trial' },
                ];
                break;
        }
        return options;
    }

    get RelatedContactFilter() {
        return {
            criteria: [
                {
                    fieldPath: 'AccountId',
                    operator: 'eq',
                    value: this.recordId,
                },
            ],
        };
    }


    async HandleAlertClick(label, message, theme) {
        await LightningAlert.open({
            message: message,
            theme: theme,
            label: label,
        });
    }

    HandleShowToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    HandleNavigateToURL(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }


}