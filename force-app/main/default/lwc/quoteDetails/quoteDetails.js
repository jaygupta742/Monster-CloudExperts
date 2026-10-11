import { LightningElement, api, track, wire } from "lwc";

import GetProcessDetails from "@salesforce/apex/approvalHighlightsController.GetProcessDetails";
import { getRecord } from "lightning/uiRecordApi";

const QUOTE_FIELDS = [
    "QuotesN__c.Id",
    "QuotesN__c.Name", 
    "QuotesN__c.Quote_Type__c",
    "QuotesN__c.Account__c",
    "QuotesN__c.Account__r.Name",
    "QuotesN__c.Owner_Channel__c",
];

export default class QuoteDetails extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track TargetId;
    @track TargetApiName;
    @track Quote;
    @track Account;
    
    @wire(GetProcessDetails, { recordId: '$recordId' })
    async onCallback_getApprovalDetails(response) {
        console.log('on callback get approval details')
        const {data, error} = response;
        if (data) {
            console.log(data);
            let rval = JSON.parse(data);
            if(rval.objectApiName === "QuotesN__c") {
                this.TargetId = rval.recordId;
                this.TargetApiName = rval.objectApiName;
            }
        } 
        if(error) {
            let error_message = 'Unknown Error';
            if (Array.isArray(error.body)) {
                error_message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                error_message = error.body.message;
            } else {
                error_message = JSON.stringify(error);
            }

            const element = this.template.querySelector('[data-id="error-text"]');
            if(element) {
                element.hidden = false;
                element.innerText = error_message;
            }
        }
    }

    @wire(getRecord, { recordId: "$TargetId", fields: QUOTE_FIELDS })
    async onCallback_GetQuoteDetails(response) {
        const {data, error} = response;
        if(data) {
            for(let field in data.fields) {
                this.Quote[field] = data.fields[field].value;
            }

            let AccountDetails = this.Quote.Account__r;
            for(let field in AccountDetails.fields) {
                this.Account[field] = AccountDetails.fields[field].value;
            }
        }
        if(error) {
            let error_message = 'Unknown Error';
            if (Array.isArray(error.body)) {
                error_message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                error_message = error.body.message;
            } else {
                error_message = JSON.stringify(error);
            }

            const element = this.template.querySelector('[data-id="error-text"]');
            if(element) {
                element.hidden = false;
                element.innerText = error_message;
            }
        }
    }

    connectedCallback() {
        this.TargetId = null;
        this.Quote = {};
        this.Account = {};
    }

    get AccountURL() {
        return '/' + this.Quote.Account__c;
    }

    get isQuoteObject() {
        return this.TargetApiName === 'QuotesN__c';
    }
}