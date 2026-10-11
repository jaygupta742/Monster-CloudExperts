import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import EmailValidation from '@salesforce/apex/ValidContactEmail.validemail';

export default class ValidContactEmail extends NavigationMixin(LightningElement) {

    @api recordId;
    @track showSpinner = true;


    connectedCallback() {
        setTimeout(() => {
            this.HandleEmailValidation(this.recordId);
        }, 5);
    }

    HandleEmailValidation(recordId) {
        EmailValidation({ 
            recordId: recordId
        }) .then(result => {
            let message = `ZeroBounce Email Status "${result}".`;
            this.HandleShowToast('Success!', message, 'success');
            this.showSpinner = false;
            this.cancelit();
        }) .catch(error => {
            let errorMessage = error.body.message;
            this.showAlert(errorMessage, 'error', 'Error!', () => {
                this.cancelit();
            });
            this.showSpinner = false;
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

    async showAlert(message, theme, label, ff) {
        await LightningAlert.open({
            message: message,
            theme: theme,
            label: label,
        });
        ff();
    }

    cancelit() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }

}