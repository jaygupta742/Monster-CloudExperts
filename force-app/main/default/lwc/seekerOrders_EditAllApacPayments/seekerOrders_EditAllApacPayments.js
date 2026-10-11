import { LightningElement, api, track, wire } from 'lwc';

import { loadStyle } from 'lightning/platformResourceLoader';
import QuickAction from '@salesforce/resourceUrl/LWC_QuickAction';

import { refreshApex } from '@salesforce/apex';
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import GetOrderDetails from '@salesforce/apex/SeekerOrders_EditAllApacPayments.GetOrderDetails';
import UpdatePaymentItems from '@salesforce/apex/SeekerOrders_EditAllApacPayments.UpdatePaymentItems';

export default class SeekerOrders_EditAllApacPayments extends  NavigationMixin(LightningElement) {
    @api recordId;
    @track OrderDetails;
    @track PaymentItems = [];
    @track PageProperty; 
    _Wire_OrderDetails;
   

    @wire(GetOrderDetails, {recordId: '$recordId'})
    onCallback_GetOrderDetails(response) {
        refreshApex(response);
        this._Wire_OrderDetails = response;
        let data = response.data;
        let error = response.error;

        if(data) {
            let rval = JSON.parse(data);
            this.OrderDetails = rval.Order;
            let index = 0;
            this.PaymentItems = rval.APACPayment.map(item => {
                index += 1;
                return {
                    ... item,
                    SLNo: index,
                    DetailsLink: '/' + item.Id,
                };
            });


        }
        if(error) {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error!, Something went wrong!', errorMSG, 'error', () => {
                return;
            });
        }
    }

    connectedCallback() {
        console.log('Edit All APAC Payments');
        this.PageProperty = {
            Flag_SavePage: false,
        };
    }

    renderedCallback() {
        Promise.all([
            loadStyle(this, QuickAction)
        ]);
    }

    HandleChangePaymentItems(event) {
        let value = event.target.value;
        let name = event.target.fieldName;
        let index = Number(event.target.dataset.index);

        this.PaymentItems[index][name] = value;
    }

    HandleDeleteItem(event) {
        let index = Number(event.target.dataset.index);
        this.PaymentItems.splice(index, 1);

        let i = 1;
        this.PaymentItems.forEach(item => {
            item.SLNo = i;
            i += 1;
        });
    }

    HandleClosePage() {
        this.navigateToRecordPage(this.recordId);
    }

    async HandleSavePaymentItems() {
        if(this.PaymentItems.length < 1) {
            await this.HandleAlertClick('Error! Empty APAC Payments', 'There is no APAC Payments to update. Add atleast one APAC Payment.', 'error', () => {
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
        }

        if(this.OrderDetails.Net_Total__c != TotalInstallmentAmount.toFixed(2)) {
            await this.HandleAlertClick('Net Total is not matched', `Net total is not matched, Net Total(${this.OrderDetails.Net_Total__c}) ≠ Total Installment Amount(${TotalInstallmentAmount.toFixed(2)})`, 'error', () => {
                return;
            });
            return;
        }

        this.PageProperty.Flag_SavePage = true;

        await UpdatePaymentItems({
            recordId: this.recordId,
            PaymentItems: JSON.stringify(this.PaymentItems)
        }) .then(response => {
            console.log(response);
            this.HandleShowToast('Success!', 'APAC Payments updated successfully!', 'success');
            this.navigateToRecordPage(this.recordId);
        }) .catch(error => {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error!, Something went wrong!', errorMSG, 'error', () => {
                return;
            });
        });

        this.PageProperty.Flag_SavePage = false;
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
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }
}