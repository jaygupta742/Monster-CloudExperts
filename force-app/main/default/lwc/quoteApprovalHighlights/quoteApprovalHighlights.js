import { LightningElement, api, wire, track } from "lwc";
import { getRecord } from 'lightning/uiRecordApi';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

import GetProcessDetails from "@salesforce/apex/approvalHighlightsController.GetProcessDetails";
import getConditions from '@salesforce/apex/approvalHighlightsController.getConditions';

const QuoteFields = [
	'QuotesN__c.Id',
	'QuotesN__c.Name',
	'QuotesN__c.Account__c',
	'QuotesN__c.Contact__c',
	'QuotesN__c.Opportunities__c',
	'QuotesN__c.Quote_Type__c',
	'QuotesN__c.Agency_ID__c',
	'QuotesN__c.Owner_Channel__c',
	'QuotesN__c.Start_Date__c',
	'QuotesN__c.End_Date__c',
	'QuotesN__c.CurrencyIsoCode',
	'QuotesN__c.OwnerId',
	'QuotesN__c.Price_Master__c',
	'QuotesN__c.Selling_Country__c',
	'QuotesN__c.Deal__c',
	'QuotesN__c.Days_Between__c',
	'QuotesN__c.Total_Discount__c',
	'QuotesN__c.Payment_count__c',
	'QuotesN__c.Net_Total__c',
	'QuotesN__c.Gross_Total1__c',
	'QuotesN__c.Opportunities__r.Name',
];

const APACPaymentFields = [
	'APAC_Payments__c.Id',
	'APAC_Payments__c.Name',
	'APAC_Payments__c.APAC_Payment_Name__c',
	'APAC_Payments__c.Due_Date__c',
	'APAC_Payments__c.Payment_Amount__c',
];

const QuoteItemsFields = [
	'Quote_Line_Items__c.Id',
	'Quote_Line_Items__c.Name',
	'Quote_Line_Items__c.Product_Name__c',
	'Quote_Line_Items__c.Start_Date__c',
];

const BaseOrderFields = [
	'Order__c.Id',
	'Order__c.Name',
	'Order__c.Gross_Total1__c',
	'Order__c.Deal__c',
	'Order__c.Order_Service_End_Date__c',
];

export default class QuoteApprovalHighlights extends LightningElement {
	@api recordId;
	@api objectApiName;
	@track TargetRecordId;
	@track TargetApiName;
	@track BaseOrderId;

	@track QuoteDetails;
	@track QuoteItems;
	@track APACPayments;
	@track Opportunity;
	@track BaseOrderDetails;
	@track BaseOrderAPACPayments;
	@track Conditions;

	@wire(getConditions)
	getWiredConditions(response) {
		const { data, error } = response;
		if (data) {
			console.log(data);
			this.Conditions = data;
		} if (error) {
			let error_message = 'Unknown Error';
			if (Array.isArray(error.body)) {
				error_message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				error_message = error.body.message;
			} else {
				error_message = 'Apex Error ' + JSON.stringify(error);
			}
			const element = this.template.querySelector('[data-id="error-text"]');
			if (element) {
				element.hidden = false;
				element.innerText = error_message;
			}
		}
	}

	@wire(GetProcessDetails, { recordId: '$recordId' })
	onCallback_ProcessDetails(response) {
		const { data, error } = response;
		if (data) {
			let rval = JSON.parse(data);
			if(rval.objectApiName === 'QuotesN__c') {
				this.TargetRecordId = rval.recordId;
				this.TargetApiName = rval.objectApiName;
			}
		}
		if (error) {
			let error_message = 'Unknown Error';
			if (Array.isArray(error.body)) {
				error_message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				error_message = error.body.message;
			} else {
				error_message = 'Apex Error ' + JSON.stringify(error);
			}

			const element = this.template.querySelector('[data-id="error-text"]');
			if (element) {
				element.hidden = false;
				element.innerText = error_message;
			}
		}
	}

	@wire(getRecord, {recordId: '$TargetRecordId', fields: QuoteFields})
	onCallback_GetQuoteDetails(response) {
		const {data, error} = response;
		if(data) {
			for(let field in data.fields) {
				this.QuoteDetails[field] = data.fields[field].value;
			}

			let opp = this.QuoteDetails.Opportunities__r;
			for(let field in opp.fields) {
				this.Opportunity[field] = opp.fields[field].value;
			}
			this.BaseOrderId = this.Opportunity.Order_For_Revamp__c;
		}
		if(error) {
			console.log(error);
		}
	}

	@wire(getRelatedListRecords, {
		parentRecordId: '$TargetRecordId',
		relatedListId: 'APAC_Payments__r',
		fields: APACPaymentFields,
		sortBy: ['APAC_Payments__c.Name']
	}) onCallback_GetAPACPayments(response) {
		const {data, error} = response;
		if(data) {
			for(let item of data.records) {
				let APACPayment = {};
				for(let field in item.fields) {
					APACPayment[field] = item.fields[field].value;
				}
				this.APACPayments.push(APACPayment);
			}
		}
		if(error) {
			console.log(error);
		}
	}

	@wire(getRelatedListRecords, { 
		parentRecordId: '$TargetRecordId',
		relatedListId: 'Quote_Line_Items__r',
		fields: QuoteItemsFields
	}) async onCallbakc_GetQuoteItems(response) {
		const {data, error} = response;
		if (data) {
			for(let item of data.records) {
				let QuoteItem = {};
				for(let field in item.fields) {
					QuoteItem[field] = item.fields[field].value;
				}
				this.QuoteItems.push(QuoteItem);
			}
		}
		if (error) {
			let error_message = 'Unknown Error';
			if (Array.isArray(error.body)) {
				error_message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				error_message = error.body.message;
			} else {
				error_message = 'Apex Error, ' + JSON.stringify(error);
			}

			const element = this.template.querySelector('[data-id="error-text"]');
			if (element) {
				element.hidden = false;
				element.innerText = error_message;
			}
		}
	}

	@wire(getRecord, {recordId: '$BaseOrderId', fields: BaseOrderFields})
	onCallback_GetBaseOrderDetails(response) {
		const {data, error} = response;
		if(data) {
			for(let field in data.fields) {
				this.BaseOrderDetails[field] = data.fields[field].value;
			}
		}
		if(error) {
			let error_message = 'Unknown Error';
			if (Array.isArray(error.body)) {
				error_message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				error_message = error.body.message;
			} else {
				error_message = 'Apex Error, ' + JSON.stringify(error);
			}

			const element = this.template.querySelector('[data-id="error-text"]');
			if (element) {
				element.hidden = false;
				element.innerText = error_message;
			}
		}
	}

	@wire(getRelatedListRecords, {
		parentRecordId: '$BaseOrderId',
		relatedListId: 'APAC_Payments__r',
		fields: APACPaymentFields,
		sortBy: ['APAC_Payments__c.Name']
	}) onCallback_GetBaseOrderAPACPayments(response) {
		const {data, error} = response;
		if(data) {
			for(let item of data.records) {
				let APACPayment = {};
				for(let field in item.fields) {
					APACPayment[field] = item.fields[field].value;
				}
				this.BaseOrderAPACPayments.push(APACPayment);
			}
		}
		if(error) {
			let error_message = 'Unknown Error';
			if (Array.isArray(error.body)) {
				error_message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				error_message = error.body.message;
			} else {
				error_message = 'Apex Error, ' + JSON.stringify(error);
			}

			const element = this.template.querySelector('[data-id="error-text"]');
			if (element) {
				element.hidden = false;
				element.innerText = error_message;
			}
		}
	}

	connectedCallback() {
		this.QuoteDetails = {};
		this.Opportunity = {};
		this.BaseOrderDetails = {};
		this.APACPayments = [];
		this.QuoteItems = [];
		this.BaseOrderAPACPayments = [];
		this.Conditions = [];
	}

	get ApprovalHighLights() {
		let Highlights = [];
		if(this.QuoteDetails) {
			let QuoteChannel = this.QuoteDetails.Owner_Channel__c;
			let DiscountCondition = null, PaymentCountCondition = null, UpfrontPaymentCondition = null, DealTypeCondition = null;
			for(let item of this.Conditions) {
				if(item.Channel__c === QuoteChannel) {
					if(item.HighLight_Type__c === 'Discount %') DiscountCondition = item.Value__c;
					if(item.HighLight_Type__c === '# Instalment') PaymentCountCondition = item.Value__c;
					if(item.HighLight_Type__c === 'Upfront Payment') UpfrontPaymentCondition = item.Value__c;
					if(item.HighLight_Type__c === 'Deal Type') DealTypeCondition = item.Value__c;
				}
			}
			if(this.QuoteDetails.Total_Discount__c) {
				if(DiscountCondition) {
					if(this.QuoteDetails.Total_Discount__c > DiscountCondition) Highlights.push({key: 'Discount', value: `${this.QuoteDetails.Total_Discount__c}%`, label: 'Discount', boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				} else {
					Highlights.push({key: 'Discount', value: `${this.QuoteDetails.Total_Discount__c}%`, label: 'Discount', boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				}
			}

			if(this.QuoteDetails.Payment_count__c) {
				if(PaymentCountCondition) {
					if(this.QuoteDetails.Payment_count__c > PaymentCountCondition) Highlights.push({ key: '# Instalment', value: this.QuoteDetails.Payment_count__c, label: '# Instalment', boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				} else {
					Highlights.push({ key: '# Instalment', value: this.QuoteDetails.Payment_count__c, label: '# Instalment', boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				}
			}

			if(this.APACPayments.length > 0) {
				let APACPayment = this.APACPayments[0];
				let UpfrontPayment = parseInt((APACPayment.Payment_Amount__c / this.QuoteDetails.Net_Total__c) * 100);

				if(UpfrontPaymentCondition) {
					if(UpfrontPayment < UpfrontPaymentCondition) Highlights.push({ key: 'Upfront Payment', value: `${UpfrontPayment}%`, label: 'Upfront Payment', boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				} else {
					Highlights.push({ key: 'Upfront Payment', value: `${UpfrontPayment}%`, label: 'Upfront Payment', boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				}
			}

			if(this.QuoteDetails.Deal__c) {
				if(this.BaseOrderId) {
					let DealType = `${this.BaseOrderDetails.Deal__c} to ${this.QuoteDetails.Deal__c}`;
					Highlights.push({ key: 'Deal Type', value: DealType, label: 'Deal Type', boxClass: DealType === 'SY to SY' ? 'slds-box slds-box_xx-small slds-text-color_success' : 'slds-box slds-box_xx-small slds-text-color_destructive'});
				} else {
					if(DealTypeCondition) {
						if(this.QuoteDetails.Days_Between__c > DealTypeCondition) Highlights.push({ key: 'Deal Type', value: this.QuoteDetails.Deal__c, label: 'Deal Type', boxClass: this.QuoteDetails.Deal__c === 'SY' ? 'slds-box slds-box_xx-small slds-text-color_success' : 'slds-box slds-box_xx-small slds-text-color_destructive'});
					} else {
						Highlights.push({ key: 'Deal Type', value: this.QuoteDetails.Deal__c, label: 'Deal Type', boxClass: this.QuoteDetails.Deal__c === 'SY' ? 'slds-box slds-box_xx-small slds-text-color_success' : 'slds-box slds-box_xx-small slds-text-color_destructive'});
					}
				}
			}

			if(this.QuoteItems.length > 0) {
				for(let item of this.QuoteItems) {
					if(item.Product_Name__c && item.Product_Name__c.includes('Custom Product')) {
						Highlights.push({ key: 'Custom Product', value: '✅', label: 'Custom Product',  boxClass: 'slds-box slds-box_xx-small' });
						break;
					}
				}

				let startDate = null;
				for(let item of this.QuoteItems) {
					if(!startDate || startDate > item.Start_Date__c) {
						startDate = item.Start_Date__c;
					}
				}
				if (startDate) {
					startDate = new Date(startDate);
					if (startDate > new Date()) {
						Highlights.push({ key: 'Activation Delay', value: '✅', label: 'Activation Delay', boxClass: 'slds-box slds-box_xx-small' },);
					}
				}
			}
			if(this.QuoteDetails.Gross_Total1__c !== null) {
				if(this.BaseOrderId && this.BaseOrderDetails && this.BaseOrderDetails.Gross_Total1__c !== null) {
					let Upliftment = parseInt((this.QuoteDetails.Gross_Total1__c / this.BaseOrderDetails.Gross_Total1__c - 1) * 100);
					Highlights.push({ key: 'Upliftment', value: `${Upliftment}%`, label: 'Upliftment', boxClass: Upliftment < 0 ? 'slds-box slds-box_xx-small slds-text-color_error' : 'slds-box slds-box_xx-small slds-text-color_success'});
				}
			}

			if(this.BaseOrderId) {
				let difference = this.APACPayments.length - this.BaseOrderAPACPayments.length;
				Highlights.push({ key: 'Payment Line Difference', value: difference, label: 'Payment Line Difference', boxClass: difference > 0 ? 'slds-box slds-box_xx-small slds-text-color_error' : 'slds-box slds-box_xx-small slds-text-color_success'});
			}
			if(this.BaseOrderId && this.BaseOrderDetails) {
				if(this.BaseOrderDetails.Order_Service_End_Date__c > this.QuoteDetails.Start_Date__c) {
					Highlights.push({ key: 'Pre-Renewal', value: '✅', label: 'Pre-Renewal', boxClass: 'slds-box slds-box_xx-small' },);
				}
			}

			if(this.QuoteDetails.Quote_Type__c === 'Lapsed') {
				if(this.BaseOrderId && this.BaseOrderDetails) {
					let startDate = new Date(this.BaseOrderDetails.Order_Service_End_Date__c);
					let endDate = new Date(this.QuoteDetails.Start_Date__c);
					
					// Calculate the difference in milliseconds
					let differenceInMilliseconds = startDate - endDate;
					
					// Convert milliseconds to days
					let lapsedDays = Math.floor(differenceInMilliseconds / (1000 * 60 * 60 * 24));
					
					Highlights.push({ key: 'Lapsed Days', value: lapsedDays, label: `Lapsed Since ${lapsedDays} Days`, boxClass: 'slds-box slds-box_xx-small slds-text-color_destructive'});
				}
			}
		}

		return Highlights;
	}

	get isQuoteObject() {
		return this.TargetApiName === 'QuotesN__c';
	}
}