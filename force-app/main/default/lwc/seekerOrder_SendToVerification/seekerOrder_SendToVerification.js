import { LightningElement, api, wire } from 'lwc';

import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';

import FetchOrderDetails from '@salesforce/apex/SeekerOrder_SendToVerification_cls.FetchOrderDetails';
import SendForVerification from '@salesforce/apex/SeekerOrder_SendToVerification_cls.SendForVerification';

export default class SeekerOrder_SendToVerification extends NavigationMixin(LightningElement) {
    @api recordId;
    _Wire_FetchOrderDetails;

    @wire(FetchOrderDetails, { recordId: '$recordId' })
    onCallback(response) {
        this._Wire_FetchOrderDetails = response;
        let data = response.data;
        let error = response.error;

        if (data) {
            let message = 'Once you send this quote for verification, you will no longer be able to edit this quote and it\'s related details. Press "Ok" to proceed From jay';
            // this.HandleAlertClick('Warning! Send For Verification!!!', message, 'warning', () => {
            //     this.HandleSendForVerification();
            // });

            this.handleConfirmClick(message);
        }
        if (error) {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error!, Something went wrong!', errorMSG, 'error', () => {
                this.navigateToRecordPage(this.recordId);
            });
        }
    }

    connectedCallback() {
        console.log('Send to Verification');
    }

    HandleSendForVerification() {
        SendForVerification({
            recordId: this.recordId
        }).then(response => {
            console.log(response);
            this.HandleShowToast('Success!', 'Send to order successfully!', 'success');
            this.navigateToRecordPage(this.recordId);
        }).catch(error => {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error!, Something went wrong!', errorMSG, 'error', () => {
                this.navigateToRecordPage(this.recordId);
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
        // Navigate to a record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view' // or 'edit' for editing the record
            }
        });
    }

    async handleConfirmClick(message) {
        const result = await LightningConfirm.open({
            message: message,
            label: 'Warning! Send For Verification!!!',
            theme: 'warning'
        });
        if (result) {
            this.HandleSendForVerification();
        } else {
            this.navigateToRecordPage(this.recordId);
        }

    }
}