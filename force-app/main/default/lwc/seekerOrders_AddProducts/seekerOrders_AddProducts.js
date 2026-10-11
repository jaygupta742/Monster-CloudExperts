import { LightningElement, api, track, wire } from 'lwc';

import { loadStyle } from 'lightning/platformResourceLoader';
import QuickAction from '@salesforce/resourceUrl/LWC_QuickAction';
import Page1 from './seekerOrders_Page1.html';
import Page2 from './seekerOrders_Page2.html';
import LoadingPage from './seekerOrders_SpinnerPage.html';

import { refreshApex } from "@salesforce/apex";
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import GetAllProducts from '@salesforce/apex/SeekerOrders_AddProducts_cls.GetAllProducts';
import SaveProducts from '@salesforce/apex/SeekerOrders_AddProducts_cls.SaveProducts';

export default class SeekerOrders_AddProducts extends NavigationMixin(LightningElement) {
    @api recordId;
    @track ProductTableColumns = [];
    @track ProductTableData = [];
    @track SelectedProducts = [];
    @track ProductFilters = {};
    @track AllProducts = [];
    @track PageName;
    @track PageProperties;
    _WireResponse;

    @wire(GetAllProducts)
    onCallback_GetProduct(response) {
        refreshApex(response);
        this._WireResponse = response;
        let data = response.data;
        let error = response.error;

        if (data) {
            this.AllProducts = data;
            if(data) this.PageName = 'Page 1';
        }
        if (error) {
            let errorMsg = error.body.message;
            this.HandleAlertClick('Error! Something Went Wrong!', errorMsg, 'error', () => {
                return;
            });
        }
    }

    connectedCallback() {
        console.log('Add product seeker orders');

        this.ProductTableColumns = [
            { label: 'Product No', fieldName: 'Name' },
            { label: 'University Name', fieldName: 'Product_Name__c', type: 'text' },
            { label: 'Course Name', fieldName: 'SKU_Type__c', type: 'text' },
            { label: 'Description', fieldName: 'Product_Description__c', type: 'text', initialWidth: 300, wrapText: true},
            { label: 'Tenure', fieldName: 'Tenure_Months__c', type: 'text' },
            { label: 'Commision %', fieldName: 'Credit__c', type: 'text' },
            { label: 'Price', fieldName: 'Unit_List_Price_Value__c', type: 'currency' },
        ];

        this.ProductFilters = {
            Name: null,
            SKUType: null,
        };
        this.PageName = 'Page 1'; 
        this.PageProperties = {
            Flag_SavePage: false,
            Flag_NextPage: false
        };
    }

    renderedCallback() {
        Promise.all([
            loadStyle(this, QuickAction)
        ]);
    }

    render() {
        switch (this.PageName) {
            case 'Page 1':
                return Page1;
            case 'Page 2':
                return Page2;
            case 'Loading Page':
                return LoadingPage;
            default:
                break;
        }
    }

    HandleChangeFilters(event) {
        const { name, value } = event.target;
        this.ProductFilters[name] = value;
        if(this.ProductFilters.Name && this.ProductFilters.SKUType) this.UpdateProductList();
    }

    HandleGetSelectedProduct(event) {
        this.SelectedProducts =  event.detail.selectedRows;
    }

    HandleNextClick() {
        if(this.SelectedProducts.length === 0) {
            alert('Please selecte atleast one product.');
            return;
        }

        this.PageName = 'Loading Page';
        let index = 0;
        let StartDate = new Date();
        this.SelectedProducts = this.SelectedProducts.map(item => {
            index += 1;

            return {
                ...item,
                SlNo: index,
                Quantity__c: null,
                Selling_Fee__c: item.Unit_List_Price_Value__c,
                Commission__c: item.Credit__c / 100,
                Start_Date__c: StartDate.toISOString().slice(0, 10),
                End_Date__c: this.UpdateEndDate(StartDate, item.Tenure_Months__c),
                Gross_Total__c: item.Credit__c ? item.Unit_List_Price_Value__c * (item.Credit__c / 100) : item.Unit_List_Price_Value__c,
                Discount__c: null,
                Subvention_Cost__c: null
            };
        });

        this.PageName = 'Page 2';
    }

    HandleInputsChange(event) {
        let {name, value} = event.target;
        let index = parseInt(event.target.dataset.index);

        this.SelectedProducts[index][name] = value;

        if(name === 'Start_Date__c') this.SelectedProducts[index].End_Date__c = this.UpdateEndDate(value, this.SelectedProducts[index].Tenure_Months__c);
        if(name === 'Discount__c' || name === 'Subvention_Cost__c') {
            this.SelectedProducts[index].Selling_Fee__c = this.SelectedProducts[index].Unit_List_Price_Value__c - (this.SelectedProducts[index].Discount__c ? this.SelectedProducts[index].Discount__c : 0) - (this.SelectedProducts[index].Subvention_Cost__c ? this.SelectedProducts[index].Subvention_Cost__c : 0);
            this.SelectedProducts[index].Gross_Total__c = this.SelectedProducts[index].Commission__c ? this.SelectedProducts[index].Selling_Fee__c * this.SelectedProducts[index].Commission__c : this.SelectedProducts[index].Selling_Fee__c;
        }
    }

    async HandleSaveClick() {
        for(let i=0; i < this.SelectedProducts.length; i++) {
            if(!this.SelectedProducts[i].Start_Date__c) {
                this.HandleAlertClick('Error! Required Field Missing', `Start Date is missing at row-${i + 1}`, 'error', () => {
                    return;
                });
            }
        }
        this.PageName = 'Loading Page';

        await SaveProducts({
            recordId: this.recordId,
            ProductDetails: JSON.stringify(this.SelectedProducts)
        }) .then(response => {
            console.log(response);
            this.HandleShowToast('Success!', 'Product added successfully!!!', 'success');
            this.navigateToRecordPage(this.recordId);
        }) .catch(error => {
            let errorMSG = error.body.message;
            this.HandleAlertClick('Error! Something Went Wrong!!', errorMSG, 'error', () => {
                return;
            });
            this.PageName = 'Page 2';
        });
    }

    HandleCancel() {
        this.navigateToRecordPage(this.recordId);
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

    UpdateProductList() {
        let {Name, SKUType } = this.ProductFilters;

        Name = Name ? Name : '';
        SKUType = SKUType ? SKUType : '';

        this.ProductTableData = this.AllProducts.filter(item => {
            let ProductName = item.Product_Name__c ? item.Product_Name__c : '';
            let ProductSKUType = item.SKU_Type__c ? item.SKU_Type__c : '';

            return ProductName.includes(Name) && ProductSKUType.includes(SKUType);
        });
    }

    get FetchProductName() {
        // Create a Set to store unique Product_Name__c values
        let uniqueSet = new Set();

        // Iterate through All Products and add unique Product_Name__c values to the Set
        if(this.AllProducts) {
            this.AllProducts.forEach(item => {
                if(item.Product_Name__c) uniqueSet.add(item.Product_Name__c);
            });
        }

        // Convert the Set back to an array
        let Options = [];
        uniqueSet.forEach(item => {
            Options.push({label: item, value: item});
        });

        // Now Options contains all unique Product_Name__c values
        return Options;
    }

    get FetchProductSkuType() {
        // Create a Set to store unique SKU Type values
        let uniqueSet = new Set();

        // Iterate through All Products and add unique SKU Type values to the Set
        if(this.AllProducts) {
            this.AllProducts.forEach(item => {
                if(item.SKU_Type__c && item.Product_Name__c) {
                    if(this.ProductFilters.Name == null || (item.Product_Name__c === this.ProductFilters.Name)) uniqueSet.add(item.SKU_Type__c);
                }
            });
        }

        // Convert the Set back to an array
        let Options = [];
        uniqueSet.forEach(item => {
            Options.push({label: item, value: item});
        });

        // Now Options contains all unique SKU Type values
        return Options;
    }

    get FetchProductCountry() {
        // Create a Set to store unique SKU Type values
        let uniqueSet = new Set();

        // Iterate through All Products and add unique SKU Type values to the Set
        if(this.AllProducts) {
            this.AllProducts.forEach(item => {
                if(item.Product_Name__c && item.SKU_Type__c && item.Product_Country__c ) {
                    if(this.ProductFilters.Name === null || item.Product_Name__c === this.ProductFilters.Name) uniqueSet.add(item.Product_Country__c);
                }
            });
        }

        // Convert the Set back to an array
        let Options = [];
        uniqueSet.forEach(item => {
            Options.push({label: item, value: item});
        });

        // Now Options contains all unique SKU Type values
        return Options;
    }

    get FetchProductTenure() {
        // Create a Set to store unique SKU Type values
        let uniqueSet = new Set();

        // Iterate through All Products and add unique SKU Type values to the Set
        if(this.AllProducts) {
            this.AllProducts.forEach(item => {
                if(item.Tenure_Months__c) uniqueSet.add(item.Tenure_Months__c);
            });
        }

        // Convert the Set back to an array
        let Options = [];
        uniqueSet.forEach(item => {
            Options.push({label: item, value: item});
        });

        // Now Options contains all unique SKU Type values
        return Options;
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