import { LightningElement, api } from 'lwc';

export default class RecordPicker extends LightningElement {
    @api label;
    @api placeholder;
    @api objectApiName;
    @api filter;
    @api value;
    @api required;
    @api name;
    connectedCallback() {}

    HandleChanges(event) {
        event.preventDefault();
        console.log(this.name);
        this.dispatchEvent(new CustomEvent("change", {
            detail: {
                recordId: event.detail.recordId,
                fieldName: this.name
            }
        }));
    }
}