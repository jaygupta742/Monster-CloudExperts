import { LightningElement, api, track, wire } from "lwc";
import getComments from '@salesforce/apex/OpportunityCommentController.getComments';
import getTotalCommentsDigit from '@salesforce/apex/OpportunityCommentController.getTotalCommentsDigit';
import getUserName from '@salesforce/apex/OpportunityCommentController.getUserName';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';
import COMMENT_OBJECT from '@salesforce/schema/Opportunity_Comment__c';
import { CurrentPageReference } from 'lightning/navigation';
import { createRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OpportunityComments extends NavigationMixin(LightningElement) {
    @api recordId;
    @track comments = [];
    showNoComment = false;
    isLoading = false;
    isShowModal = false;
    @api objectApiName;
    userId = Id;
    @track totalComments = 0;
    @track comment = {
        Comment__c: '',
        Created_By__c: ''
    };
    UserName = '';
    limitSize = 10;
    offsetSize = 0;

    @wire(CurrentPageReference)
    async getPageReferenceParameters(currentPageReference) {
        if (currentPageReference) {
            console.log(currentPageReference);
            this.recordId = currentPageReference.attributes.recordId;

            let data = await getTotalCommentsDigit({ 'recordId': this.recordId });
            this.totalComments = data.length
            console.log(data);
        }
    }

    async connectedCallback() {
        this.UserName = await getUserName({ 'userId': Id });
        this.comment.Created_By__c = this.UserName;
        console.log(this.UserName);
        this.refreshComments();
    }

    get title() {
        return `Comments (${this.totalComments > 5 ? "5+" : this.totalComments})`;
    }

    refreshComments() {
        this.isLoading = true;
        getComments({ recordId: this.recordId, limitSize: this.limitSize, offsetSize: this.offsetSize })
            .then(result => {
                this.comments = [...this.comments, ...result].sort((a, b) => {
                    return new Date(b.CreatedDate) - new Date(a.CreatedDate);
                });
                console.log(result);
                this.showNoComment = this.comments.length === 0;
                this.totalComments = this.comments.length;
            })
            .catch(error => {
                console.error('Error fetching comments: ', error);
                this.dispatchEvent(new ShowToastEvent({
                    title: "Error",
                    message: "There was an error fetching comments.",
                    variant: "error"
                }));
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    handleViewMore() {
        this.offsetSize += this.limitSize;
        this.refreshComments();
    }

    formatDate(dateStr) {
        const dateObj = new Date(dateStr);

        const datePart = dateObj.toLocaleDateString('en-GB'); // DD/MM/YYYY
        const timePart = dateObj.toLocaleTimeString('en-GB', { hour: 'numeric', minute: 'numeric', hour12: false });

        return `${datePart} | ${timePart}`;
    }

    openModalForNewComment() {
        this.isShowModal = true;
    }

    closeModalForNewComment() {
        this.isShowModal = false;
    }

    get getDate() {
        const today = new Date();
        const formattedDate = today.toISOString().split('T')[0];
        return formattedDate;
    }

    handleChange(event) {
        console.log(event.target.value);
        this.comment.Comment__c = event.target.value;
    }

    createComment(event) {

        if (this.comment.Comment__c == '' || this.comment.Comment__c == undefined || this.comment.Comment__c == null) {
            this.dispatchEvent(new ShowToastEvent({
                title: "Error!!",
                message: "Comment Cant Be Empty",
                variant: "error"
            }));
            return;
        }

        const button = event.target;
        button.setAttribute('disabled', 'true');

        this.comment.Opportunities_Revamp__c = this.recordId;
        const recordInput = {
            apiName: COMMENT_OBJECT.objectApiName,
            fields: this.comment
        };

        console.log(recordInput);

        createRecord(recordInput)
            .then((record) => {
                console.log(record);
                this.dispatchEvent(new ShowToastEvent({
                    title: "Success",
                    message: "Comment Added Successfully",
                    variant: "success"
                }));
                this.navigateToRecordPage(this.recordId);
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    title: "Error",
                    message: "There was some error please try again later",
                    variant: "error"
                }));
                console.log(error);
            })
            .finally(() => {
                this.refreshComments();
                button.removeAttribute('disabled');
            });
    }

    closeModal() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    navigateToRecordPage(recordId) {
        // Use the NavigationMixin to navigate to the record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'OpportunityN__c',
                actionName: 'view'
            }
        });
    }
}