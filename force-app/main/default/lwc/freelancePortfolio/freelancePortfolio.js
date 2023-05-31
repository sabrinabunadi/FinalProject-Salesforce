import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import REVIEW_OBJECT from '@salesforce/schema/Review__c';
import PROJECT_FIELD from '@salesforce/schema/Review__c.Project__c';
import PROJECT_NAME_FIELD from '@salesforce/schema/Review__c.Project__r.Name';
import PROJECT_START_DATE_FIELD from '@salesforce/schema/Review__c.Project__r.Start_Date__c';
import PROJECT_LOCATION_FIELD from '@salesforce/schema/Review__c.Project__r.Location__c';
import TEAMWORK_RATE_FIELD from '@salesforce/schema/Review__c.Teamwork_Rate__c';
import PROFESSIONALISM_RATE_FIELD from '@salesforce/schema/Review__c.Professionalism_Rate__c';
import RELIABILITY_RATE_FIELD from '@salesforce/schema/Review__c.Reliability_Rate__c';

const FIELDS = [
    PROJECT_FIELD,
    PROJECT_NAME_FIELD,
    PROJECT_START_DATE_FIELD,
    PROJECT_LOCATION_FIELD,
    TEAMWORK_RATE_FIELD,
    PROFESSIONALISM_RATE_FIELD,
    RELIABILITY_RATE_FIELD
];

export default class FreelancePortfolio extends LightningElement {
    @api recordId;
    reviews = [];

    @wire(getObjectInfo, { objectApiName: REVIEW_OBJECT })
    reviewObjectInfo;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredFreelance({ error, data }) {
        if (data) {
            const projectField = this.reviewObjectInfo.data.fields[PROJECT_FIELD.fieldApiName];
            const reviews = projectField.relationshipName ? data.fields[projectField.relationshipName] : [];
            this.reviews = reviews.slice(0, 3);
        } else if (error) {
            console.error(error);
        }
    }
}
