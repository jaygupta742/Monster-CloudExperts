import { LightningElement, track } from 'lwc';

export default class AccountContactOpportunity extends LightningElement {
    @track account;
    @track contacts = [];

    connectedCallback() {
        this.contacts.push({
            SerialNumber: this.contacts.length + 1,
            Email: null,
            LastName: null
        });
    }

    HandleAddContact() {
        this.contacts.push({
            SerialNumber: this.contacts.length + 1,
            Email: null,
            LastName: null
        });
    }

    HandleChangeContacts(event) {
        const {value, name, dataset} = event.target;
        const index = Number(dataset.index);
        this.contacts[index][name] = value;
    }

    HandleSave() {
        for(let item of this.contacts) {
            if(!item.LastName) {
                alert('Name can not be null');
                return;
            }
            if(!item.Email) {
                alert('Email can not be null');
                return;
            }
        }    
        this.HandleSaveController();    
    }
    
    HandleSaveController() {
        // SaveAccount({
        //     Account: this.account,
        //     Contacts: this.contacts
        // });
    }
}