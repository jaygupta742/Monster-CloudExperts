import { LightningElement, api, track, wire } from 'lwc';

import { loadStyle } from 'lightning/platformResourceLoader';
import QuickAction from '@salesforce/resourceUrl/LWC_QuickAction';

import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import GetOrderDetails from '@salesforce/apex/seekerOrder_AddApacPayments_cls.GetOrderDetails';
import SaveAPACPayments from '@salesforce/apex/seekerOrder_AddApacPayments_cls.SaveAPACPayments';

export default class SeekerOrder_AddApacPayments extends NavigationMixin(LightningElement) {
    @api recordId;
    @track OrderDetails;
    @track PaymentItems = [];
    @track PageProperty; 
    _Wire_OrderDetails;

    @wire(GetOrderDetails, {recordId: '$recordId'})
    onCallback_GetOrderDetails(response) {
        this._Wire_OrderDetails = response;
        let data = response.data;
        let error = response.error;

        if(data) {
            this.OrderDetails = {...data};
            this.CreateNewPaymentSchedule();
        }
        if(error) {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error!, Something went wrong!', errorMSG, 'error', () => {
                return;
            });
        }
    }

    connectedCallback() {
        console.log('Add APAC Payments');
        this.PageProperty = {
            RowCount : 1,
            Flag_RowCountInput: false,
            Flag_AddRow : false,
            Flag_SavePage: false
        };
    }

    renderedCallback() {
        Promise.all([
            loadStyle(this, QuickAction)
        ]);
    }

    HandleChangeRowCount(event) {
        this.PageProperty.RowCount = parseInt(event.target.value, 10);

        if (this.PageProperty.RowCount < 1) {
            this.HandleAlertClick('Error! Minimum: 1', 'Row count cannot be less than one. Minimum: 1', 'error', () => {
                this.PageProperty.RowCount = 1;
            });
        }
    }

    HandleChangePaymentItems(event) {
        let value = event.target.value;
        let name = event.target.fieldName;
        let index = Number(event.target.dataset.index);

        this.PaymentItems[index][name] = value;
    }

    HandleAddNewRow() {
        for (let index = 0; index < this.PageProperty.RowCount; index++) {
            this.CreateNewPaymentSchedule();
        }
        this.PageProperty.RowCount = 1;
    }

    HandleDeleteItem(event) {
        let index = Number(event.target.dataset.index);
        this.PaymentItems.splice(index, 1);

        let NetTotal = 0, InstallmentAmount = 0;

        if(this.OrderDetails && this.OrderDetails.Net_Total__c) {
            NetTotal = this.OrderDetails.Net_Total__c;
            InstallmentAmount = NetTotal / this.PaymentItems.length;
        }
        let i = 1;
        this.PaymentItems.forEach(item => {
            item.SLNo = i;
            i += 1;
            item.Payment_Amount__c = InstallmentAmount.toFixed(2);
        });
    }

    async HandleSavePaymentItems() {
        if(this.PaymentItems.length < 1) {
            await this.HandleAlertClick('Error! Empty APAC Payments', 'There is no APAC Payments to add. Add atleast one APAC Payment.', 'error', () => {
                return;
            });
            return;
        }

        let TotalInstallmentAmount = 0;
        for(const item of this.PaymentItems) {
            if(!item.Payment_Type__c) {
                await this.HandleAlertClick('Payment Type! Required Field Missing', `Required field missing, Payment Type is missing at index-${item.SLNo}`, 'error', () => {
                    return;
                });
                return;
            }
            if(!item.Due_Date__c) {
                await this.HandleAlertClick('Due Date! Required Field Missing', `Required field missing, Due Date is missing at index-${item.SLNo}`, 'error', () => {
                    return;
                });
                return;
            }
            if(!item.Payment_Amount__c) {
                await this.HandleAlertClick('Payment Amount! Required Field Missing', `Required field missing, Payment Amount is missing at index-${item.SLNo}`, 'error', () => {
                    return;
                });
                return;
            }

            TotalInstallmentAmount += Number(item.Payment_Amount__c);
            console.log(TotalInstallmentAmount);
        }

        console.log(this.OrderDetails.Net_Total__c != TotalInstallmentAmount);
        console.log('this.OrderDetails.Net_Total__c' + this.OrderDetails.Net_Total__c);
        console.log('TotalInstallmentAmount' + TotalInstallmentAmount);
        
        if(this.OrderDetails.Net_Total__c != TotalInstallmentAmount) {
            await this.HandleAlertClick('Net Total is not matched', `Net total is not matched, Net Total(${this.OrderDetails.Net_Total__c}) ≠ Total Installment Amount(${TotalInstallmentAmount})`, 'error', () => {
                return;
            });
            return;
        }

        this.PageProperty.Flag_SavePage = true;

        await SaveAPACPayments({
            recordId: this.recordId,
            PaymentItems: JSON.stringify(this.PaymentItems)
        }) .then(response => {
            console.log(response);
            this.HandleShowToast('Success!', 'APAC Payments addedd successfully!', 'success');
            this.navigateToRecordPage(this.recordId);
        }) .catch(error => {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error!, Something went wrong!', errorMSG, 'error', () => {
                return;
            });
        });
        this.PageProperty.Flag_SavePage = false;
    }

    HandleClosePage() {
        this.navigateToRecordPage(this.recordId);
    }

    async CreateNewPaymentSchedule() {
        let Item = {
            SLNo: null,
            Payment_Type__c: null,
            Payment_Amount__c: null,
            Due_Date__c: null,
            Seeker_Order__c: this.recordId
        };
        this.PaymentItems.push(Item);
        let NetTotal = 0, InstallmentAmount = 0;

        if(this.OrderDetails && this.OrderDetails.Net_Total__c) {
            NetTotal = this.OrderDetails.Net_Total__c;
            InstallmentAmount = NetTotal / this.PaymentItems.length;
        }
        let index = 1;
        this.PaymentItems.forEach(item => {
            item.SLNo = index;
            index += 1;
            item.Payment_Amount__c = InstallmentAmount.toFixed(2);
        });
    }

    async HandleAlertClick(label, message, theme, onCallback) {
        await LightningAlert.open({
            label: label,
            message: message,
            theme: theme,
        });
        onCallback();
    }

    HandleShowToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }

    navigateToRecordPage(recordId) {
        // Navigate to a record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view' // or 'edit' for editing the record
            }
        });
    }
}