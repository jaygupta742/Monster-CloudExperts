import { LightningElement, api, track, wire } from 'lwc';

import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import LightningAlert from "lightning/alert";

import { loadStyle } from 'lightning/platformResourceLoader';
import QuickAction from '@salesforce/resourceUrl/LWC_QuickAction';

import GetAllProducts from '@salesforce/apex/EditAllSeekerLineItem.getAllLineItem';
import UpdateOrderItems from "@salesforce/apex/EditAllSeekerLineItem.UpdateOrderItems";

export default class EditAllSeekerLineItem extends NavigationMixin(LightningElement) {

    @api recordId;
    @track OrderItems = [];
    @track spinnerStatus = true;

    @wire(GetAllProducts, { recordId: '$recordId' })
    async onCallback_GetProduct(response) {
        refreshApex(response);
        let data = response.data;
        let error = response.error;

        if (data) {
            let rval = JSON.parse(data);
            if(rval) {
                let Index = 0;
                this.OrderItems = rval.map(item => {
                    Index += 1;
                    return {
                        ...item,
                        SlNo: Index,
                        RecordURL: '/' + item.Id,
                        ProductURL: '/' + item.Product_No__c,
                    };
                });
            }
        }
        if (error) {
            let errorMsg = error.body.message;
            this.HandleAlertClick('Error! Something Went Wrong!!!', errorMsg, 'error', () => {
                return;
            });
        }
        this.spinnerStatus = false;
    }

    renderedCallback() {
        Promise.all([
            loadStyle(this, QuickAction)
        ]);
    }

    HandleChangeInput(event) {
        let index = parseInt(event.target.dataset.index);
        let fieldName = event.target.fieldName;
        let value = event.target.value;

        this.OrderItems[index][fieldName] = value;
        if(fieldName === 'Start_Date__c') this.OrderItems[index].End_Date__c = this.UpdateEndDate(value, this.OrderItems[index].Product_Tenure__c);
        if(fieldName === 'Discount__c' || fieldName === 'Subvention_Cost__c' || fieldName === 'Commission__c') {
            this.OrderItems[index].Selling_Fee__c = this.OrderItems[index].Unit_Price__c - (this.OrderItems[index].Discount__c ? this.OrderItems[index].Discount__c : 0) - (this.OrderItems[index].Subvention_Cost__c ? this.OrderItems[index].Subvention_Cost__c : 0);
            this.OrderItems[index].Gross_Total__c = this.OrderItems[index].Selling_Fee__c + (this.OrderItems[index].Selling_Fee__c * (this.OrderItems[index].Commission__c ? this.OrderItems[index].Commission__c / 100 : 0));
        }
    }

    UpdateEndDate(StartDate, Tenure) {
        let EndDate = new Date(StartDate);
        switch (Tenure) {
            case '13 Months':
                EndDate.setMonth(EndDate.getMonth() + 13);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '12 Months':
                EndDate.setMonth(EndDate.getMonth() + 12);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '9 Months':                
                EndDate.setMonth(EndDate.getMonth() + 9);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '6 Months':                
                EndDate.setMonth(EndDate.getMonth() + 6);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '3 Months':
                EndDate.setMonth(EndDate.getMonth() + 3);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '4 Months':
                EndDate.setMonth(EndDate.getMonth() + 4);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '2 Months':
                EndDate.setMonth(EndDate.getMonth() + 2);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '1 Months':
                EndDate.setMonth(EndDate.getMonth() + 1);
                EndDate.setDate(EndDate.getDate() - 1);
                break;
            case '1 Week':
                EndDate.setMonth(EndDate.getDate() + 7);
                break;
            case 'Tenure':
                break;
            case 'Per Month':
                break;
            case 'As per Balance Original Contract':
                break;
            case '0.1 Months':
                break;
            case '14 Days':
                EndDate.setMonth(EndDate.getDate() + 14);
                break;
            case '60 Days':
                EndDate.setMonth(EndDate.getDate() + 60);
                break;
            case '1 Day':
                EndDate.setMonth(EndDate.getDate() + 1);
                break;
            case '2 Days':
                EndDate.setMonth(EndDate.getDate() + 2);
                break;
            case '4 Days':
                EndDate.setMonth(EndDate.getDate() + 4);
                break;
            case '5 Days':
                EndDate.setMonth(EndDate.getDate() + 5);
                break;
            case '6 Days':
                EndDate.setMonth(EndDate.getDate() + 6);
                break;
            case '7 Days':
                EndDate.setMonth(EndDate.getDate() + 7);
                break;
            case 'To be derived':
                break;
            case '3 Days':
                EndDate.setMonth(EndDate.getDate() + 3);
                break;
            case '30 days':
                EndDate.setMonth(EndDate.getDate() + 30);
                break;
            case '15 days':
                EndDate.setMonth(EndDate.getDate() + 15);
                break;
            default:
                break;
        }
        console.log(EndDate);
        return EndDate.toISOString().slice(0, 10)
    }

    async HandleSavePage() {
        let Index = 0;
        for (let item of this.OrderItems) {
            Index += 1;
            if(!item.Start_Date__c) {
                this.HandleAlertClick('Error! Required Field Missing!!!', `Required field missing! Start Date is missing at index-${Index}`, 'error', () => {
                    return;
                });
                return;
            }
        }

        this.spinnerStatus = true;
        this.save_btn_status = true;

        await UpdateOrderItems({
            recordId: this.recordId,
            OrderItems: JSON.stringify(this.OrderItems),
        }) .then((response) => {
            console.log(response);
            this.HandleShowToast('Success!!!', 'Seeker Order Line Items updated successfully.', 'success');
            this.navigateToRecordPage(this.recordId);
        }) .catch((error) => {
            let error_message = error.body.message;
            this.HandleAlertClick('Error! Something Went Wrong!', error_message, 'error', () => {
                return;
            });
        });
        this.spinnerStatus = false;
        this.save_btn_status = false;
    }

    HandleDeleteItems(event) {
        let index = parseInt(event.target.dataset.index);

        this.OrderItems.splice(index, 1);
        if(this.OrderItems) {
            let Index = 0;
            this.OrderItems = this.OrderItems.map(item => {
                Index += 1;
                return {
                    ...item,
                    SlNo: Index,
                    RecordURL: '/' + item.Id,
                    ProductURL: '/' + item.Product_No__c,
                };
            });
        }
    }

    HandleCancelPage() {
        this.navigateToRecordPage(this.recordId);
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

    async HandleAlertClick(label, message, theme, onCallback) {
        await LightningAlert.open({
            label: label,
            message: message,
            theme: theme,
        });
        onCallback();
    }
}