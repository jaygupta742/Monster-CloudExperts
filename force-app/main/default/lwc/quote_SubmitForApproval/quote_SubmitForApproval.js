import { LightningElement, api, track, wire } from 'lwc';
import LightningPrompt from 'lightning/prompt';
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import { getRecord } from 'lightning/uiRecordApi';
import SubmitForApproval from '@salesforce/apex/Quote_ApprovalSettingsController.SubmitForApproval';

const FIELDS = [
    'QuotesN__c.Id',
    'QuotesN__c.Name',
    'QuotesN__c.Level_of_Approval_Required__c',
]
export default class Quote_SubmitForApproval extends LightningElement {
    @api recordId;

    @track Quote;

    @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
    async onCallback_GetQuote(response) {
        const {data, error} = response;
        if (data) {
            this.Quote = {};
            for(let field in data.fields) {
                this.Quote[field] = data.fields[field].value;
            }
        }
        if (error) {
            let message = "Unknown error";
            if (Array.isArray(error.body)) {
                message = error.body.map((e) => e.message).join(", ");
            } else if (typeof error.body.message === "string") {
                message = error.body.message;
            } else message = JSON.stringify(error);
            
            await this.HandleAlertClick('Apex Error!', message, 'error');
        } 
    }


    HandleCancel() {
        const customEvent = new CustomEvent('cancel');
        this.dispatchEvent(customEvent);
    }

    async HandleSubmit() {
        let comments = await this.HandlePromptClick('Comments', 'Submit for Approval', null, "inverse");
        if (comments != null) {
            const buttons = await this.template.querySelectorAll('button');
            if (buttons) {
                buttons.forEach(button => {
                    button.disabled = true;
                    if (button.innerText === 'Submit For Approval') button.innerText = 'Submitting...';
                });
            }
            try {
                let response = await this.HanldeSubmitForApproval(comments);
                this.HandleShowToast('Success!', 'Submitted for Approval', 'success');
            } catch (error) {
                let message = "Unknown error";
                if (Array.isArray(error.body)) {
                    message = error.body.map((e) => e.message).join(", ");
                } else if (typeof error.body.message === "string") {
                    message = error.body.message;
                } else {
                    message += JSON.stringify(error);
                }
                await this.HandleAlertClick('Apex Error!', message, 'error');
            }
            if (buttons) {
                buttons.forEach(button => {
                    button.disabled = false;
                    if (button.innerText === 'Submitting...') button.innerText = 'Submit For Approval';
                });
            }
            this.HandleCancel();
        }
    }

    async HanldeSubmitForApproval(comments) {
        try {
            let processName = null;
            switch (this.Quote.Level_of_Approval_Required__c) {
                case 1:
                    processName = 'X1_LVL_Approval';
                    break;
                case 2:
                    processName = 'X2_LVL_Approval';
                    break;
                case 3:
                    processName = 'X3_LVL_Approval';
                    break;
                case 4:
                    processName = 'X4_LVL_Approval';
                    break;
                case 5:
                    processName = 'X5_LVL_Approval';
                    break;
                case 6:
                    processName = 'X6_LVL_Approval';
                    break;
                case 7:
                    processName = 'X7_LVL_Approval';
                    break;
                case 8:
                    processName = 'X8_LVL_Approval';
                    break;
                case 9:
                    processName = 'X9_LVL_Approval';
                    break;
                case 10:
                    processName = 'X10_LVL_Approval';
                    break;
                default:
                    break;
            }
            return await SubmitForApproval({
                recordId: this.recordId,
                comment: comments,
                processName: processName
            });
        } catch (error) {
            throw error;
        }
    }

    async HandlePromptClick(message, label, defaultValue, theme) {
        return await LightningPrompt.open({
            message: message,
            label: label,
            defaultValue: defaultValue,
            theme: theme
        });
    }

    async HandleAlertClick(label, message, theme) {
        await LightningAlert.open({
            label: label,
            message: message,
            theme: theme,
        });
    }

    HandleShowToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }
}