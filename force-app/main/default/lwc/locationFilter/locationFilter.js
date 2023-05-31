import { LightningElement, track } from 'lwc';

export default class LocationFilter extends LightningElement {
    @track locationOptions = [
        { label: 'United States', value: 'United States' },
        { label: 'Canada', value: 'Canada' },
        { label: 'Spain', value: 'Spain' },
        { label: 'England', value: 'England' },
        { label: 'Germany', value: 'Germany' }
    ];
    @track selectedLocation = '';
    @track showProjectsTable = false;
    @track showFreelancesTable = false;
    @track projectData = []; // Project data to be fetched based on location
    @track freelanceData = []; // Freelance data to be fetched based on location

    handleLocationChange(event) {
        this.selectedLocation = event.target.value;
        this.showProjectsTable = false;
        this.showFreelancesTable = false;

        // Fetch and assign project data based on location
        // Replace 'fetchProjectsByLocation' with your actual Apex method to fetch projects
        this.fetchProjectsByLocation(this.selectedLocation)
            .then((result) => {
                this.projectData = result;
                this.showProjectsTable = true;
            })
            .catch((error) => {
                console.error(error);
            });

        // Fetch and assign freelance data based on location
        // Replace 'fetchFreelancesByLocation' with your actual Apex method to fetch freelances
        this.fetchFreelancesByLocation(this.selectedLocation)
            .then((result) => {
                this.freelanceData = result;
                this.showFreelancesTable = true;
            })
            .catch((error) => {
                console.error(error);
            });
    }

    // Replace with your actual Apex methods to fetch projects and freelances
    fetchProjectsByLocation(location) {
        return new Promise((resolve, reject) => {
            // Perform the server-side callout to fetch projects
            // Resolve with the result data when successful, reject with error when an error occurs
            // Example:
            // YourApexClass.fetchProjectsByLocation({ location: location })
            //     .then((result) => {
            //         resolve(result);
            //     })
            //     .catch((error) => {
            //         reject(error);
            //     });

            // Placeholder code
            setTimeout(() => {
                resolve([
                    {
                        Id: '001',
                        Name: 'Project 1',
                        Status: 'In Progress',
                        OwnerFullName: 'John Doe',
                        MaxHourlyRate: 50,
                        CreatedDate: '2023-05-30'
                    },
                    {
                        Id: '002',
                        Name: 'Project 2',
                        Status: 'Completed',
                        OwnerFullName: 'Jane Smith',
                        MaxHourlyRate: 75,
                        CreatedDate: '2023-05-28'
                    }
                ]);
            }, 1000);
        });
    }

    fetchFreelancesByLocation(location) {
        return new Promise((resolve, reject) => {
            // Perform the server-side callout to fetch freelances
            // Resolve with the result data when successful, reject with error when an error occurs
            // Example:
            // YourApexClass.fetchFreelancesByLocation({ location: location })
            //     .then((result) => {
            //         resolve(result);
            //     })
            //     .catch((error) => {
            //         reject(error);
            //     });

            // Placeholder code
            setTimeout(() => {
                resolve([
                    {
                        Id: '001',
                        Name: 'Freelance 1',
                        Available: true,
                        OwnerFullName: 'John Doe',
                        HourlyRate: 50,
                        CreatedDate: '2023-05-30'
                    },
                    {
                        Id: '002',
                        Name: 'Freelance 2',
                        Available: false,
                        OwnerFullName: 'Jane Smith',
                        HourlyRate: 75,
                        CreatedDate: '2023-05-28'
                    }
                ]);
            }, 1000);
        });
    }

    get projectColumns() {
        return [
            { label: 'Name', fieldName: 'Name', type: 'text' },
            { label: 'Status', fieldName: 'Status', type: 'text' },
            { label: 'Owner Full Name', fieldName: 'OwnerFullName', type: 'text' },
            { label: 'Max Hourly Rate', fieldName: 'MaxHourlyRate', type: 'currency' },
            { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' }
        ];
    }

    get freelanceColumns() {
        return [
            { label: 'Name', fieldName: 'Name', type: 'text' },
            { label: 'Available', fieldName: 'Available', type: 'boolean' },
            { label: 'Owner Full Name', fieldName: 'OwnerFullName', type: 'text' },
            { label: 'Hourly Rate', fieldName: 'HourlyRate', type: 'currency' },
            { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' }
        ];
    }
}
