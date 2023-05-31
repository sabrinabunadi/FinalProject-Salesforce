import { LightningElement, wire } from 'lwc';
import getSuggestedFreelance from '@salesforce/apex/SuggestedFreelanceController.getSuggestedFreelance';

const COLUMNS = [
    { label: 'Full Name', fieldName: 'Name', type: 'text' },
    { label: 'Hourly Rate', fieldName: 'Hourly_Rate__c', type: 'currency' },
    { label: 'Location', fieldName: 'Location__c', type: 'text' },
    { label: 'Overall Rate', fieldName: 'Overall_Rate__c', type: 'number', step: '0.01' },
    {
        label: 'Action',
        type: 'button',
        initialWidth: 100,
        typeAttributes: {
            label: 'Create',
            variant: 'brand',
            name: 'create',
            title: 'Create Freelance in Project',
            disabled: false
        }
    }
];

export default class SuggestedFreelanceTable extends LightningElement {
    freelanceData;
    columns = COLUMNS;

    @wire(getSuggestedFreelance)
    wiredFreelanceData({ error, data }) {
        if (data) {
            this.freelanceData = data;
        } else if (error) {
            // Handle error
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'create') {
            // Implement create freelance in project logic
        }
    }
}
