import { LightningElement, api, wire, track } from "lwc";
import { CloseActionScreenEvent } from 'lightning/actions';
import { CurrentPageReference } from 'lightning/navigation';
import LightningAlert from 'lightning/alert';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import GetApprovalSettings from '@salesforce/apex/Quote_ApprovalSettingsController.GetApprovalSettings';
import proceedToNextStep from '@salesforce/apex/escalateApprovalProcessController.proceedToNextStep';
import getCurrentApprover from '@salesforce/apex/escalateApprovalProcessController.getCurrentApprover';
import getManagerName from '@salesforce/apex/escalateApprovalProcessController.getManagerName';

export default class EscalateApprovalProcess extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track Approvers = [];
    comment;
    currentApprover;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
        }
    }

    @wire(GetApprovalSettings, { recordId: "$recordId" })
    async onCallback_GetApprovalSetting(response) {
        const { data, error } = response;
        if (data) {

            let currentApprover = await getCurrentApprover({ recordId: this.recordId });
            let getManager = await getManagerName();
            this.currentApprover = await currentApprover[0].Actor.Name;
            let rval = JSON.parse(data);
            let currentApproverFound = false;

            for (let i = 0; i < rval.approvers.length; i++) {
                let approverName = rval.approvers[i];

                if (approverName == 'Manager') {
                    approverName = getManager.Manager;
                } else if (approverName == 'Managers Manager') {
                    approverName = getManager.ManagersManager;
                }

                let approverObject = {
                    approverName: approverName,
                    currentApproval: approverName === this.currentApprover,
                    approved: false
                };

                if (approverObject.currentApproval) {
                    currentApproverFound = true;
                } else if (!currentApproverFound) {
                    approverObject.approved = true;
                }

                this.Approvers.push(approverObject);
            }

            console.log(JSON.stringify(this.Approvers));
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

    escalateApprover(event) {
        const button = event.target;
        button.setAttribute('disabled', 'true');

        if (!this.comment) {
            this.HandleAlertClick('Error!!', 'Please enter a comment for escalation', 'error');
            button.removeAttribute('disabled');
            return;
        }

        if (this.currentApprover == 'Pranay Kale' || this.currentApprover == 'Akash Jain' || this.currentApprover == 'Nagaraju Pogula') {
            this.HandleAlertClick('Error!!', `Approval cant be escalated for ${this.currentApprover}`, 'error');
            button.removeAttribute('disabled');
            return;
        }

        proceedToNextStep({ recordId: this.recordId, comment: this.comment })
            .then(result => {
                this.HandleShowToast('Success!', 'Approver has been escalated', 'success');
                this.closeModal();
            })
            .catch(error => {
                button.removeAttribute('disabled');
                console.error('Error proceeding to the next step:', error);
            });
    }

    handleComment(event) {
        this.comment = event.target.value;
    }

    closeModal() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    async HandleAlertClick(label, message, theme) {
        await LightningAlert.open({
            label: label,
            message: message,
            theme: theme,
        });
    }

    async HandleShowToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }
}