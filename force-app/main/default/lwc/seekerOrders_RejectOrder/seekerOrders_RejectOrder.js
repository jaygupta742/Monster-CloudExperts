import { LightningElement, api, wire } from 'lwc';

import { refreshApex } from "@salesforce/apex";
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import FetchOrderDetail_ApprovedRejected from '@salesforce/apex/SeekerOrder_SendToVerification_cls.FetchOrderDetail_ApprovedRejected';
import Reject_SeekerOrder from '@salesforce/apex/SeekerOrder_SendToVerification_cls.Reject_SeekerOrder';

export default class SeekerOrders_RejectOrder extends NavigationMixin(LightningElement) {
    @api recordId;

    @wire(FetchOrderDetail_ApprovedRejected, {recordId: '$recordId'})
    async onCallback_OrderDetails(response) {
        let {data, error} = response;
        refreshApex(response);
        if(data) {
            let message = 'Reject Seeker Orders. Press "Ok" to Reject the Seeker Orders.';
            this.HandleAlertClick('Warning! Reject Seeker Orders', message, 'warning', async () => {
                await this.RejectOrder(this.recordId);
            });
        }
        if(error) {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Warning! Reject Seeker Orders', errorMSG, 'error', async () => {
                this.navigateToRecordPage(this.recordId);
            });
        }
    }

    async RejectOrder() {
        Reject_SeekerOrder({
            recordId: this.recordId
        }) .then(response => {
            console.log(response);
            let message = 'Order Rejected successfully!';
            this.HandleShowToast('Success!', message, 'success');
            this.navigateToRecordPage(this.recordId);
        }) .catch(error => {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Warning! Rejected Seeker Orders', errorMSG, 'error', async () => {
                return;
            });
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
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }    
}