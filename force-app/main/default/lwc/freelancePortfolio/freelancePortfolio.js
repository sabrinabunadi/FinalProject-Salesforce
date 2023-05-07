import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getLatestReviews from '@salesforce/apex/FreelanceController.getLatestReviews';

const fields = [
    'Freelancer__c.Name',
    'Freelancer__c.Location__c',
    'Freelancer__c.Hourly_Rate__c'
];

export default class FreelancePortfolio extends LightningElement {
    @api recordId;
    freelancerFields = fields;
    reviews;

    @wire(getRecord, { recordId: '$recordId', fields })
    freelance;

    @wire(getLatestReviews, { freelancerId: '$recordId' })
    wiredReviews({ error, data }) {
        if (data) {
            this.reviews = data;
        } else if (error) {
            console.error(error);
        }
    }

    get freelancerName() {
        return getFieldValue(this.freelance.data, 'Freelancer__c.Name');
    }

    get freelancerLocation() {
        return getFieldValue(this.freelance.data, 'Freelancer__c.Location__c');
    }

    get freelancerHourlyRate() {
        return getFieldValue(this.freelance.data, 'Freelancer__c.Hourly_Rate__c');
    }
}
