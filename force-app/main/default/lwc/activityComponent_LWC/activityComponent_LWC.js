import { LightningElement, track, api, wire } from 'lwc';
import saveActvitiy from '@salesforce/apex/ActivityCreateFromAccount.createActivity';
import getUserData from '@salesforce/apex/ActivityCreateFromAccount.getUserData';
import getUpdateAccount from '@salesforce/apex/ActivityCreateFromAccount.updateAccountStat';
import getAccount from '@salesforce/apex/ActivityCreateFromAccount.getAccountSuspect';
import getLatestOpportunityRecord from '@salesforce/apex/ActivityCreateFromAccount.getLatestOpportunityRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import TASK_OBJECT from '@salesforce/schema/Task';
import REGION_FIELD from '@salesforce/schema/Task.Region__c';
import PRODUCT_NEW_FIELD from '@salesforce/schema/Task.Product_New__c';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

export default class ActivityComponent_LWC extends NavigationMixin(LightningElement) {
    @track selectedCategory;
    @track selectedSubcategory;
    @track filteredSubcategoryOptions = [];
    @track isSubcategoryDisabled = true;
    @track isReminderSet = false;
    @track priority;
    @track status;
    @track feedback;
    @api recordId;
    @track ownerProfile;
    @track userProfile = '';
    @track userId = '';
    _Wire_OrderDetails;
    wireServiceResponse;
    @track assigned;
    @track accompany;
    @track related;
    @track name;
    @track btnShow = false;
    @track subtype = '';
    @track suspectfalse;
    @track monsterSales = true;
    @track opportunityId = '';
    @track opportunityDisabled = false;
    @track productInterested = '';
    @track regionOptions = [];
    @track productNewOptions = [];

    isSeekerChannel = false;

    @track inputValues = {
        Subject: '',
        Priority: '',
        Task_Type__c: '',
        Task_Sub_Type1__c: '',
        Description__c: '',
        Status: '',
        ActivityDate: null,
        IsReminderSet: false,
        Disposition_Type__c: '',
        Sub_Disposition_Type__c: '',
        Remarks__c: '',
        recording_url__c: '',
        Feedback_By_Sales__c: '',
        Follow_Up_Date__c : '',
        Region__c : '',
        Product__c : '',
        Product_Value__c : '',
        Currency__c : ''
    };

    products = [
         { label: 'Featured Profile', value: 'FeaturedProfile' },
         { label: 'Profile Highlighter', value: 'ProfileHighlighter' },
         { label: 'Career Booster', value: 'CareerBooster' },
         { label: 'Resume Writing', value: 'ResumeWriting' },
         { label: 'Resume Builder', value: 'ResumeBuilder' },
         { label: 'Linkedin Makeover', value: 'LinkedinMakeover' },
         { label: 'Cover Letter', value: 'CoverLetter' }
    ]

    currency = [
        { label: 'INR', value: 'INR' },
        { label: 'USD', value: 'USD' },
        { label: 'SGD', value: 'SGD' },
        { label: 'MYR', value: 'MYR' },
        { label: 'PHP', value: 'PHP' },
        { label: 'HKD', value: 'HKD' },
    ]

    priorityOptions = [
        { label: 'None', value: '' },
        { label: 'High', value: 'High' },
        { label: 'Normal', value: 'Normal' },
        { label: 'Low', value: 'Low' },
    ];

    productInterestedOptions = [
        { label: 'RDA	', value: 'RDA' },
        { label: 'JP', value: 'JP' },
        { label: 'Skillyst', value: 'Skillyst' },
        { label: 'Sprynt', value: 'Sprynt' },
        { label: 'FBS', value: 'FBS' },
    ];

    categoryOptions = [
        { label: 'None', value: '' },
        { label: 'VOC', value: 'VOC' },
        { label: 'Meeting', value: 'Meeting' },
        { label: 'Demo', value: 'Demo' },
        { label: 'Free Trial', value: 'FreeTrial' },
        { label: 'Email', value: 'Email' },
        { label: 'Telecall', value: 'Telecall' },
        { label: 'Training CS', value: 'TrainingCS' },
        { label: 'Welcome Call CS', value: 'WelcomeCallCS' },
        // { label: 'Demo 2.0', value: 'Demo2_0' },
        { label: 'Leadership Meeting', value: 'LeadershipMeeting' },
        { label: 'Renewal Status', value: 'RenewalStatus' },
        { label: 'Compliance', value: 'Compliance' },
        { label: 'Connected', value: 'Connected' },
        { label: 'Not Connected', value: 'NotConnected' },
    ];



    subcategoryOptions = {
        VOC: [
            { label: 'None', value: '' },
            { label: 'Product Issue - DB Inventory / Applications', value: 'Product Issue – DB Inventory / Applications' },
            { label: 'Technical Issue/Bug', value: 'Technical Issue/Bug' },
            { label: 'ATS Related Issue', value: 'ATS Related Issue' },
            { label: 'Branding Related Issue', value: 'Branding Related Issue' },
            { label: 'Other', value: 'Other' },
        ],
        Meeting: [
            { label: 'None', value: '' },
            { label: 'Online', value: 'Online' },
            { label: 'Onsite', value: 'Onsite' },
        ],
        Demo: [
            { label: 'None', value: '' },
            { label: 'Online', value: 'Online' },
            { label: 'Onsite', value: 'Onsite' },

        ],
        FreeTrial: [
            { label: 'None', value: '' },
            { label: 'Free Trial', value: 'Free Trial' },
        ],
        Email: [
            { label: 'None', value: '' },
            { label: 'Email', value: 'Email' },
        ],
        Telecall: [
            //{ label: 'None', value: '' },
            //{ label: 'Telecall', value: 'Telecall' },
            { label: 'Connected', value: 'Connected' },
            { label: 'Not Connected', value: 'Not Connected' },
        ],
        TrainingCS: [
            { label: 'None', value: '' },
            { label: 'Profile walkthrough', value: 'Profile walkthrough' },
        ],
        WelcomeCallCS: [
            { label: 'None', value: '' },
            { label: 'Telecall', value: 'Telecall' },
        ],
        Demo2_0: [
            { label: 'None', value: '' },
            { label: 'Online', value: 'Online' },
            { label: 'Onsite', value: 'Onsite' },
        ],
        LeadershipMeeting: [
            { label: 'None', value: '' },
            { label: 'Senior Leadership', value: 'Senior Leadership' },
            { label: 'Channel Head', value: 'Channel Head' },
        ],
        RenewalStatus: [
            { label: 'None', value: '' },
            { label: 'Not Renewed', value: 'Not Renewed' },
            { label: 'Renewed', value: 'Renewed' }
        ],
        Compliance: [
            { label: 'None', value: '' },
            { label: 'A/C Disabled', value: 'A/C Disabled' },
            { label: 'A/C Warning', value: 'A/C Warning' },
            { label: 'A/C Audit	', value: 'A/C Audit' }
        ],
        Connected: [
            { label: 'Interested', value: 'Interested' },
            { label: 'Not Interested', value: 'NotInterested' },
        ],
        NotConnected: [
            { label: 'Switch off', value: 'Switchoff' },
            { label: 'Number does not Exist', value: 'NumberdoesnotExist' },
            { label: 'No Response', value: 'NoResponse' }
        ]
    };

    optionstatus = [
        { label: 'None', value: '' },
        { label: 'Completed', value: 'Completed' },
        { label: 'Open', value: 'Open' },
        { label: 'Lost', value: 'Lost' },
    ];

    @track optionfeedback = [
        { label: 'Budget Constraint', value: 'Budget Constraint' },
        { label: 'Clicked by mistake', value: 'Clicked by mistake' },
        { label: 'Client Not Enquired', value: 'Client Not Enquired' },
        { label: 'Closed', value: 'Closed' },
        { label: 'Customer Not Hiring', value: 'Customer Not Hiring' },
        { label: 'Customer Out Of Business/Business Closed', value: 'Customer Out Of Business/Business Closed' },
        { label: 'Duplicate Opportunity', value: 'Duplicate Opportunity' },
        { label: 'Fulfilled Through Ecomm/Online Purchase', value: 'Fulfilled Through Ecomm/Online Purchase' },
        { label: 'In discussion with the client', value: 'In discussion with the client' },
        { label: 'International Teaming', value: 'International Teaming' },
        { label: 'Invalid Contact Information', value: 'Invalid Contact Information' },
        { label: 'Just Enquired For Pricing', value: 'Just Enquired For Pricing' },
        { label: 'Looking For Free Trial Services', value: 'Looking For Free Trial Services' },
        { label: 'Need Time To Decide', value: 'Need Time To Decide' },
        { label: 'No Longer Hiring', value: 'No Longer Hiring' },
        { label: 'No Response From Customer', value: 'No Response From Customer' },
        { label: 'Not Happy With The Services/Product', value: 'Not Happy With The Services/Product' },
        { label: 'Not Interest/No Need', value: 'Not Interest/No Need' },
        { label: 'Not Interested In Paid Services', value: 'Not Interested In Paid Services' },
        { label: 'Not Looking For Services', value: 'Not Looking For Services' },
        { label: 'Others', value: 'Others' },
        { label: 'Pending for documents/proofs', value: 'Pending for documents/proofs' },
        { label: 'Potential lead to work', value: 'Potential lead to work' },
        { label: 'Pricing Issues', value: 'Pricing Issues' },
        { label: 'Proposal shared', value: 'Proposal shared' },
        { label: 'Purchased From Competition', value: 'Purchased From Competition' },
        { label: 'Sale Closed On Other City/Account Name', value: 'Sale Closed On Other City/Account Name' },
        { label: 'Sent Promotion Request', value: 'Sent Promotion Request' },
        { label: 'Single Posting Requirement', value: 'Single Posting Requirement' },
        { label: 'Start Up And Less Requirement', value: 'Start Up And Less Requirement' },
        { label: 'Suspended Account', value: 'Suspended Account' },
        { label: 'Taken Proposal Not Looking For Services', value: 'Taken Proposal Not Looking For Services' },
    ];

    handleCategoryChange(event) {
        console.log("Category change event:", JSON.stringify(event.detail));
        console.log("Event target:", JSON.stringify(event.target));



        this.selectedCategory = event.detail.value;
        console.log("Selected Category:", this.selectedCategory);

        const { name, value } = event.target;
        console.log("Target Name:", name, "Target Value:", value);

        this.inputValues = { ...this.inputValues, [name]: value };
        console.log("Updated inputValues:", JSON.stringify(this.inputValues));

        this.filteredSubcategoryOptions = this.subcategoryOptions[this.selectedCategory] || [];
        console.log("Filtered Subcategory Options:", JSON.stringify(this.filteredSubcategoryOptions));

        this.isSubcategoryDisabled = this.filteredSubcategoryOptions.length === 0;
        console.log("Is Subcategory Disabled:", this.isSubcategoryDisabled);

        // Set selectedSubcategory to the first option if available
        if (this.filteredSubcategoryOptions.length > 0) {
            this.selectedSubcategory = this.filteredSubcategoryOptions[1].value;
            this.subtype = this.filteredSubcategoryOptions[1].value;
            this.inputValues.Task_Sub_Type1__c = this.filteredSubcategoryOptions[1].value;

            console.log("Selected Subcategory:", this.selectedSubcategory);
            console.log("Subtype:", this.subtype);
            console.log("Task_Sub_Type1__c:", this.inputValues.Task_Sub_Type1__c);
        } else {
            this.selectedSubcategory = ''; // Reset if no options are available
            console.log("No subcategory options available. Resetting selectedSubcategory.");
        }
    }

    showIfConnected = false;

    handleSubcategoryChange(event) {
        this.selectedSubcategory = event.target.value;
        const { name, value } = event.target;
        this.showIfConnected = value == 'Interested' ? true : false
        this.inputValues = { ...this.inputValues, [name]: value };
        this.subtype = value;
    }


    handleCheckboxChange(event) {
        this.isReminderSet = event.target.checked; // Update the boolean property
        const { name, value } = event.target;
        this.inputValues = { ...this.inputValues, [name]: this.isReminderSet };
    }

    handleInputChange(event) {
        const { name, value } = event.target;
        this.inputValues = { ...this.inputValues, [name]: value };
    }

    @wire(getLatestOpportunityRecord, { recordId: "$recordId" })
    getWiredLatestOpportunityRecord(response) {
        let data = response.data;
        let error = response.error;

        if (data) {
            console.log(data);

            console.log(this.monsterSales);
            if (this.monsterSales == true) {
                this.opportunityDisabled = true;
            } else {
                this.opportunityId = data;
            }
        }
        if (error) {

        }
    }

    @wire(getUserData)
    wiredUser(response) {
        let data = response.data;
        let error = response.error;

        if (data) {
            this.ownerProfile = data.Profile.Name;
            console.log(this.ownerProfile);
            this.userId = data.Id;
            this.related = this.recordId;
            if (this.ownerProfile == 'Monster - Sales') {
                this.monsterSales = false;
            } else {
                this.opportunityDisabled = true;
            }

            this.isSeekerChannel = this.ownerProfile == 'Monster - B2C' ? true : false

            if (this.isSeekerChannel) {
                this.inputValues.Subject = 'Seeker Activity';
                this.inputValues.Priority = 'High';
                this.inputValues.Status = 'Completed';

                this.status = 'Completed';
                this.categoryOptions = [
                    { label: 'Connected', value: 'Connected' },
                    { label: 'Not Connected', value: 'NotConnected' }
                ];
            }
        }
        if (error) {

        }
    }

    @wire(getAccount, { accountId: '$recordId' })
    wiredAccount(response) {
        refreshApex(response)
        this.wireServiceResponse = response;
        let data = response.data;
        let error = response.error;

        if (data) {
            refreshApex(data)
            this.suspectfalse = data;
        }
        if (error) {

        }
    }



    saveIt_Helper() {
        console.log(this.inputValues);

        if (this.isSeekerChannel == false) {
            if (this.inputValues.Subject == '') {
                this.showErrorToast('Please mention the Subject!!!.');
                return false;
            }
            if (this.inputValues.Task_Type__c == '') {
                this.showErrorToast('Please mention the Activity Task Type!!!.');
                return false;
            }
            if (this.inputValues.Task_Sub_Type1__c == '' || this.inputValues.Task_Sub_Type1__c == 'None') {
                this.showErrorToast('Please mention the Activity Sub Task Type!!!.');
                return false;
            }
            if (this.inputValues.Priority == '') {
                this.showErrorToast('Please mention the Priority!!!.');
                return false;
            }
            if (this.inputValues.ActivityDate == null) {
                this.showErrorToast('Please mention the Due Date!!!.');
                return false;
            }
            if (this.inputValues.Status == '') {
                this.showErrorToast('Please mention the Status!!!.');
                return false;
            }
        } else {
            if (this.inputValues.Subject == '') {
                this.showErrorToast('Please mention the Subject!!!.');
                return false;
            }
            if (this.inputValues.Task_Type__c == '') {
                this.showErrorToast('Please mention the Activity Task Type!!!.');
                return false;
            }
            if (this.inputValues.Task_Sub_Type1__c == '' || this.inputValues.Task_Sub_Type1__c == 'None') {
                this.showErrorToast('Please mention the Activity Sub Task Type!!!.');
                return false;
            }

            if (this.showIfConnected) {
                if (this.inputValues.Region__c == '') {
                    this.showErrorToast('Please mention the Region!!!.');
                    return false;
                }
                if (this.inputValues.Product_New__c  == '') {
                    this.showErrorToast('Please mention the Product!!!.');
                    return false;
                }
                if (this.inputValues.Follow_Up_Date__c == '') {
                    this.showErrorToast('Please mention the Follow Up Date!!!.');
                    return false;
                }
            }
        }

        // this.ownerProfile = 'Monster - Sales';
        const taskType = this.inputValues.Task_Type__c;
        const recordingUrl = this.inputValues.recording_url__c;
        const taskSubType = this.inputValues.Task_Sub_Type1__c;

        console.log(JSON.stringify(this.inputValues));

        console.log(taskSubType);

        const validateRecordingUrl = (taskType) => {
            switch (taskType) {
                case 'Demo':
                    if (!recordingUrl && taskSubType == 'Online') {
                        this.showErrorToast('Please mention the Recording URL for Task Type Demo.');
                        return false;
                    }
                    break;
                case 'Demo2_0':
                    if (!recordingUrl && taskSubType == 'Online') {
                        this.showErrorToast('Please mention the Recording URL for Task Type Demo 2.0.');
                        return false;
                    }
                    break;

            }
            return true;
        };

        if (this.ownerProfile === 'Monster - Sales') {
            if (!validateRecordingUrl(taskType)) {
                return;
            }
        }
        if (this.inputValues.Task_Type__c == 'LeadershipMeeting') {
            this.inputValues.Task_Type__c = 'Leadership Meeting';
        }
        if (this.inputValues.Task_Type__c == 'FreeTrial') {
            this.inputValues.Task_Type__c = 'Free Trial';
        }
        if (this.inputValues.Task_Type__c == 'Demo2_0') {
            this.inputValues.Task_Type__c = 'Demo 2.0';
        }
        this.inputValues.Task_Sub_Type1__c = this.selectedSubcategory;
        saveActvitiy({
            activityRec: this.inputValues,
            recordId: this.recordId,
            assigned: this.accompany,
            name: this.name,
            related: this.related,
            accompany: this.accompany,
            recordUrl: this.recording_url__c,
            subtype: this.subtype,
            opportunityId: this.opportunityDisabled != true ? this.opportunityId : ''
        }).then(response => {
            this.showSuccessToast('Task created successfully!');
            this.navigateToViewAccountPage();
        })
    }

    showSuccessToast(message) {
        const event = new ShowToastEvent({
            title: 'Success',
            message: message,
            variant: 'success',
        });
        this.dispatchEvent(event);
    }

    showErrorToast(message) {
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: message,
            variant: 'error'
        });
        this.dispatchEvent(toastEvent);
    }

    handlePriorityChange(event) {
        this.priority = event.detail.value;
        const { name, value } = event.target;
        this.inputValues = { ...this.inputValues, [name]: value };
    }

    handleStatusChange(event) {
        this.status = event.detail.value;
        const { name, value } = event.target;
        this.inputValues = { ...this.inputValues, [name]: value };
    }

    handleOptionFeedbackChange(event) {
        this.feedback = event.detail.value;
        const { name, value } = event.target;
        this.inputValues = { ...this.inputValues, [name]: value };

    }

    handleOptionProductInterestedChange(event) {
        this.feedback = event.detail.value;
        const { name, value } = event.target;
        this.inputValues = { ...this.inputValues, [name]: value };

    }

    navigateToViewAccountPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
    }

    Handlecancel() {
        this.navigateToViewAccountPage();
    }

    handleAssigned(event) {
        this.assigned = event.target.value;
    }

    handleRelated(event) {
        this.related = event.target.value;
        console.log(event.target.value)
    }

    handleAccompany(event) {
        this.accompany = event.target.value;
    }

    handleOpportunity(event) {
        this.opportunityId = event.target.value;
    }

    async handleNotRelatedToCheckBoxChange(event) {
        let value = event.detail.checked;
        this.opportunityDisabled = value;
        if (value) {
            this.opportunityId = ''
        } else {
            this.opportunityId = await getLatestOpportunityRecord({ recordId: this.recordId });
        }
    }

    handleName(event) {
        this.name = event.target.value;
    }

    @track accountStat = '';
    handlesuspect(event) {
        this.accountStat = event.detail.value;
        console.log(event.detail.value)
    }

    recordUrl(event) {
        console.log(event.target.value);
        this.inputValues.recording_url__c = event.target.value;
    }

    handleUpdate(event) {
        this.btnShow = false;
        getUpdateAccount({
            accountId: this.recordId,
            accountStat: this.accountStat
        }).then(response => {
            if (response == false) {
                this.suspectfalse = false;
                refreshApex(this.wireServiceResponse);
            }
        })
            .catch(error => {
                console.error('Error:', error);

            })
            .finally(() => {
                this.btnShow = true;
            });
    }



    // Add these wire adapters
@wire(getObjectInfo, { objectApiName: TASK_OBJECT })
taskObjectInfo;

@wire(getPicklistValues, { 
    recordTypeId: '$taskObjectInfo.data.defaultRecordTypeId', 
    fieldApiName: REGION_FIELD 
})
wiredRegionValues({ data, error }) {
    if (data) {
        this.regionOptions = [
            { label: 'None', value: '' },
            ...data.values.map(item => ({
                label: item.label,
                value: item.value
            }))
        ];
    }
    if (error) {
        console.error('Error fetching Region picklist values:', error);
    }
}

@wire(getPicklistValues, { 
    recordTypeId: '$taskObjectInfo.data.defaultRecordTypeId', 
    fieldApiName: PRODUCT_NEW_FIELD 
})
wiredProductNewValues({ data, error }) {
    if (data) {
        this.productNewOptions = data.values.map(item => ({
            label: item.label,
            value: item.value
        }));
    }
    if (error) {
        console.error('Error fetching Product_New picklist values:', error);
    }
}


handleProductNewChange(event) {
    this.inputValues.Product_New__c = event.detail.value; // returns array of selected values
}


}