import { LightningElement, api, track, wire } from 'lwc';
import LightningAlert from 'lightning/alert';

import GetApprovalSettings from '@salesforce/apex/Quote_ApprovalSettingsController.GetApprovalSettings';
import ApprovalPaymentVariables from '@salesforce/apex/Quote_ApprovalSettingsController.ApprovalPaymentVariables';
export default class QuoteApprovalSettings extends LightningElement {
    @api recordId;

threshHold = {
    'INR': 2500000,
    'USD': 30000,
    'SGD': 45000,
    'MYR': 150000,
    'PHP': 1700000,
    'HKD': 240000,
    'AED': 110000
};



    @track Quote;
    @track Payments;
    @track ApprovalSettings;

    @track ApprovalRequired;
    @track LvlApprovalRequired;
    @track Approvers;

    @wire(GetApprovalSettings, { recordId: "$recordId" })
    async onCallback_GetApprovalSetting(response) {
        const { data, error } = response;
        if (data) {
            let rval = JSON.parse(data);
            this.Quote = rval.Quote;
            this.Payments = rval.Payments;
            this.ApprovalSettings = rval.ApprovalSettings;

            this.ApprovalRequired = [];

            console.log(data);

            if (rval.GrossTotalApproval === 1) {
                this.ApprovalRequired.push({
                    id: 'Gross Total',
                    label: `Deal Value > ${this.Quote.CurrencyIsoCode} ${this.threshHold[this.Quote.CurrencyIsoCode]}`,
                    description: `CEO approval required`
                });
            }

            if (rval.DiscountApprovalLvl > 0) {

                this.ApprovalRequired.push({
                    id: 'Discount',
                    label: 'Discount',
                    description: `${this.Quote.Total_Discount__c}% (${rval.DiscountApprovalPosition} approval required)`
                });
            }
            if (rval.PaymentApprovalLvl === 1) {
                try {
                    let response = await this.GetApprovalPaymentVariables(this.recordId);
                    let paymentApproval = JSON.parse(response);
                    console.log('Payment Approval required ' + paymentApproval.length);
                    this.ApprovalRequired = this.ApprovalRequired.concat(paymentApproval);
                } catch (error) {
                    console.log('Error on Payment Approval LVL');
                    console.error(error);
                }
            }
                        if (this.Quote.Payment_count__c > 1) {
                this.ApprovalRequired.push({
                    id: 'Payment Approval',
                    label: 'APAC Payment Approval',
                    description: 'Payment Count Is Greater Than One.'
                });
            }
            if (rval.IndiaRegionLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'India Region Product',
                    label: 'India Product',
                    description: `Vimal Nair approval required`
                });
            }
            if (rval.SEARegionLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'SEA Region Product',
                    label: 'SEA Product',
                    description: `Sujo John approval required`
                });
            }
            if (rval.MERegionLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'ME Region Product',
                    label: 'ME Product',
                    description: `Sujo John approval required`
                });
            }
            if (rval.SkillystLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'Skillyst Product',
                    label: 'Skillyst',
                    description: `Ekta Poddar approval required`
                });
            }
            if (rval.TPSLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'TPS Product',
                    label: 'TPS',
                    description: `Dastur Rustom approval required.`
                });
            }
            if (rval.fBSLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'fBS Product',
                    label: 'fBS',
                    description: `Saurabh Srivastava approval required.`
                });
            }
            if (rval.customeLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'Custom Product',
                    label: 'Custom',
                    description: `Deal Desk approval required.`
                });
            }
            if (rval.PreRenewalLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'Pre-renewal',
                    label: 'Pre-renewal',
                    description: `Finance Head approval required`
                });
            }
            if (rval.DealTypeLvl === 1) {
                this.ApprovalRequired.push({
                    id: 'Deal Type',
                    label: 'Multi-Year',
                    description: 'Finance Head approval required'
                });
            }
            this.LvlApprovalRequired = rval.approvers.length;
            this.Approvers = rval.approvers;
        }
        if (error) {
            console.log('error in quote approval settings');
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
    }

    async GetApprovalPaymentVariables(recordId) {
        try {
            return await ApprovalPaymentVariables({ recordId: recordId });
        } catch (error) {
            throw error;
        }
    }

    renderedCallback() {
        const ApproverHeader = this.template.querySelector('tr[data-id="approvers-header"]');
        if (ApproverHeader) {
            const thElements = ApproverHeader.querySelectorAll('th');
            console.log(thElements);
            thElements.forEach((th, index) => {
                th.innerText = `Approver ${index + 1}`;
            });
        } else {
            console.error('ApproverHeader element not found');
        }
    }

    async HandleAlertClick(label, message, theme) {
        await LightningAlert.open({
            label: label,
            message: message,
            theme: theme,
        });
    }
}