import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import { NavigationMixin } from "lightning/navigation";
import FORM_FACTOR from "@salesforce/client/formFactor";

import GetProcessDetails from "@salesforce/apex/approvalHighlightsController.GetProcessDetails";
import FetchApprovalHistory from '@salesforce/apex/approvalHighlightsController.FetchApprovalHistory';
import FetchAttachmentsFromQuote from '@salesforce/apex/approvalHighlightsController.FetchAttachmentsFromQuote';

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
	'QuotesN__c.Base_Total1__c',
	'QuotesN__c.Base_Order_ID__c',
	'QuotesN__c.Level_of_Approval_Required__c',
	'QuotesN__c.Opportunities__r.Name',
];

const APACPaymentFields = [
	'APAC_Payments__c.Id',
	'APAC_Payments__c.Name',
	'APAC_Payments__c.APAC_Payment_Name__c',
	'APAC_Payments__c.Due_Date__c',
	'APAC_Payments__c.Payment_Amount__c',
	'APAC_Payments__c.Net_Total__c',
	'APAC_Payments__c.CurrencyIsoCode',
];

const QuoteItemsFields = [
	'Quote_Line_Items__c.Id',
	'Quote_Line_Items__c.Name',
	'Quote_Line_Items__c.Product_Name__c',
	'Quote_Line_Items__c.Start_Date__c',
	'Quote_Line_Items__c.Product__c',
	'Quote_Line_Items__c.Product_Classification__c',
	'Quote_Line_Items__c.Product_Country__c',
	'Quote_Line_Items__c.Product_Industry__c',
	'Quote_Line_Items__c.Product_Geo_Scope__c',
	'Quote_Line_Items__c.Product_Tenure_Months__c',
	'Quote_Line_Items__c.Product_Text__c',
	'Quote_Line_Items__c.Product_No__c',
	'Quote_Line_Items__c.Comment__c',
	'Quote_Line_Items__c.Quantity_Unit__c',
	'Quote_Line_Items__c.CurrencyIsoCode',
	'Quote_Line_Items__c.Gross_Total1__c',
	'Quote_Line_Items__c.Base_Total1__c',
	'Quote_Line_Items__c.Unit_Price__c',
	'Quote_Line_Items__c.Discount_Amount_Unit__c'
];

const BaseOrderFields = [
	'Order__c.Id',
	'Order__c.Name',
	'Order__c.Gross_Total1__c',
	'Order__c.Base_Total1__c',
	'Order__c.Deal__c',
	'Order__c.Order_Service_End_Date__c',
	'Order__c.Revised_Service_End_Date__c',
	'Order__c.CurrencyIsoCode',
];

export default class QuoteApprovalDetails extends NavigationMixin(LightningElement) {
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
	@track ApprovalHistory;
	@track quoteFiles;

	@wire(GetProcessDetails, { recordId: '$recordId' })
	async onCallback_ProcessDetails(response) {
		const { data, error } = response;
		if (data) {
			let rval = JSON.parse(data);
			if (rval.objectApiName === 'QuotesN__c') {
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

	@wire(FetchApprovalHistory, { QuoteId: '$TargetRecordId' })
	async onCallback_ApprovalHistory(response) {
		const { data, error } = response;
		if (data) {
			this.ApprovalHistory = [];
			for (let item of data) {
				this.ApprovalHistory.push({
					...item,
					Label: item.StepStatus === 'Started' ? 'Submitted' : null,
				});
				if (item.StepStatus === 'Started') break;
			}

			this.ApprovalHistory.forEach((item, index) => {
				item.Label = item.StepStatus === 'Started' ? 'Submitted' : `Approver ${(this.ApprovalHistory.length - index) - 1}`;
			});
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

	@wire(getRecord, { recordId: '$TargetRecordId', fields: QuoteFields })
	onCallback_GetQuoteDetails(response) {
		const { data, error } = response;
		if (data) {
			for (let field in data.fields) {
				this.QuoteDetails[field] = data.fields[field].value;
			}

			this.QuoteDetails = {
				...this.QuoteDetails,
				RecordURL: '/' + this.QuoteDetails.Id,
				isSingleYear: this.QuoteDetails.Deal__c === 'SY',
				UpfrontPayment: null,
				DiscountPercentage: this.QuoteDetails.Total_Discount__c / 100,
			};

			let opp = this.QuoteDetails.Opportunities__r;
			for (let field in opp.fields) {
				this.Opportunity[field] = opp.fields[field].value;
			}
			this.BaseOrderId = this.QuoteDetails.Base_Order_ID__c;
		}
		if (error) {
			console.log(error);
		}
	}

	@wire(FetchAttachmentsFromQuote, { recordId: '$TargetRecordId' })
	onCallback_FetchAttachmentsFromQuote(response) {
		let { data, error } = response;
		if (data) {
			data = JSON.parse(JSON.stringify(data))
			this.quoteFiles = data.map(item => {
				item.fileTypeLogo = this.createFileType(item.ContentDocument.FileExtension);
				return item;
			});
			console.table(data);
		} else if (error) {
			console.log(error);
		}
	}


	@wire(getRelatedListRecords, {
		parentRecordId: '$TargetRecordId',
		relatedListId: 'APAC_Payments__r',
		fields: APACPaymentFields,
		sortBy: ['APAC_Payments__c.Name']
	}) onCallback_GetAPACPayments(response) {
		const { data, error } = response;
		if (data) {
			this.APACPayments = [];
			for (let item of data.records) {
				let APACPayment = {};
				for (let field in item.fields) {
					APACPayment[field] = item.fields[field].value;
				}
				this.APACPayments.push(APACPayment);
			}
			this.QuoteDetails.UpfrontPayment = (this.APACPayments[0]?.Net_Total__c / this.QuoteDetails?.Net_Total__c);
		}
		if (error) {
			console.log(error);
		}
	}

	@wire(getRelatedListRecords, {
		parentRecordId: '$TargetRecordId',
		relatedListId: 'Quote_Line_Items__r',
		fields: QuoteItemsFields
	}) async onCallbakc_GetQuoteItems(response) {
		const { data, error } = response;
		if (data) {
			this.QuoteItems = [];
			for (let item of data.records) {
				let QuoteItem = {};
				for (let field in item.fields) {
					QuoteItem[field] = item.fields[field].value;
				}

				QuoteItem = {
					...QuoteItem,
					Classification1: QuoteItem.Product_Classification__c === '1' ? true : false,
					Classification2: QuoteItem.Product_Classification__c === '2' ? true : false,
					Classification3: QuoteItem.Product_Classification__c === '3' ? true : false,
					Classification4: QuoteItem.Product_Classification__c === '4' ? true : false,
					Classification5: QuoteItem.Product_Classification__c === '5' ? true : false,
					Classification6: QuoteItem.Product_Classification__c === '6' ? true : false,
					Classification7: QuoteItem.Product_Classification__c === '7' ? true : false,
					Classification8: QuoteItem.Product_Classification__c === '8' ? true : false,
					ScopeS1NS2: QuoteItem.Product_Geo_Scope__c === 'S1' || QuoteItem.Product_Geo_Scope__c === 'S1' ? true : false,
					SrNo: this.QuoteItems.length + 1,
					Discount: this.getDiscountPercentage(QuoteItem.Base_Total1__c, QuoteItem.Gross_Total1__c),
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

	getDiscountPercentage(baseTotal, grossTotal) {
		if (baseTotal === 0) return 0;
		let discountPercentage = ((baseTotal - grossTotal) / baseTotal);
		return discountPercentage.toFixed(2);
	}


	@wire(getRecord, { recordId: '$BaseOrderId', fields: BaseOrderFields })
	onCallback_GetBaseOrderDetails(response) {
		const { data, error } = response;
		if (data) {
			for (let field in data.fields) {
				this.BaseOrderDetails[field] = data.fields[field].value;
			}
			this.BaseOrderDetails = {
				...this.BaseOrderDetails,
				RecordURL: '/' + this.BaseOrderDetails.Id,
				Upliftment: ((this.QuoteDetails.Gross_Total1__c / this.BaseOrderDetails.Gross_Total1__c) - 1)
			};
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

	@wire(getRelatedListRecords, {
		parentRecordId: '$BaseOrderId',
		relatedListId: 'APAC_Payments__r',
		fields: APACPaymentFields,
		sortBy: ['APAC_Payments__c.Name']
	}) onCallback_GetBaseOrderAPACPayments(response) {
		const { data, error } = response;
		if (data) {
			for (let item of data.records) {
				let APACPayment = {};
				for (let field in item.fields) {
					APACPayment[field] = item.fields[field].value;
				}
				this.BaseOrderAPACPayments.push(APACPayment);
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

	connectedCallback() {
		this.QuoteDetails = {};
		this.Opportunity = {};
		this.BaseOrderDetails = {};
		this.APACPayments = [];
		this.QuoteItems = [];
		this.BaseOrderAPACPayments = [];
		this.ApprovalHistory = [];
	}

	previewDocument(event) {
		let contentDocumentId = event.target.dataset.id;
		console.log(contentDocumentId);
		this.navigateToFiles(contentDocumentId);
	}

	previewAndDownloadDocument(event) {
		let contentDocumentId = event.target.dataset.id;
		console.log(contentDocumentId);
		let url = `/sfc/servlet.shepherd/document/download/${contentDocumentId}`;
		let link = document.createElement('a');
		link.href = url;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
		this.navigateToFiles(contentDocumentId);
	}

	createFileType(filetype) {
		const iconMapping = {
			'png': 'doctype:image',
			'jpg': 'doctype:image',
			'xlsx': 'doctype:excel',
			'excel_x': 'doctype:excel',
			'csv': 'doctype:csv',
			'mp3': 'doctype:audio',
			'exe': 'doctype:exe',
			'pdf': 'doctype:pdf',
			'ppt': 'doctype:ppt',
			'power_point_x': 'doctype:ppt',
			'pptx': 'doctype:ppt',
			'psd': 'doctype:psd',
			'mp4': 'doctype:video',
			'mkv': 'doctype:video',
			'word_x': 'doctype:word'
		};

		if (filetype === '') {
			return 'doctype:unknown';
		} else if (filetype && iconMapping[filetype.toLowerCase()]) {
			return iconMapping[filetype.toLowerCase()];
		} else {
			return 'doctype:attachment';
		}
	}


	navigateToFiles(recordId) {
		this[NavigationMixin.Navigate]({
			type: "standard__namedPage",
			attributes: {
				pageName: "filePreview",
			},
			state: {
				recordIds: recordId
			},
		});
	}

	get isQuoteObject() {
		return this.TargetApiName === 'QuotesN__c';
	}

	get APACPaymentsCount() {
		return this.APACPayments.length;
	}

	get BaseOrderAPACPaymentsCount() {
		return this.BaseOrderAPACPayments.length;
	}

	get DefaultLayoutColumns() {
		return FORM_FACTOR === 'Small' ? '1' : '2';
	}
}