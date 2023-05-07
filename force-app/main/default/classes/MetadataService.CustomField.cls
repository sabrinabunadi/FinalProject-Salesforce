MetadataService.CustomField nameField = createTextField('Project_Name__c', 'Project Name');
MetadataService.CustomField statusField = createPicklistField('Status__c', 'Status', new List<String>{'Planned', 'In Progress', 'Completed', 'Cancelled'});
MetadataService.CustomField descriptionField = createTextAreaField('Description__c', 'Description', 255);
MetadataService.CustomField electricityField = createCheckboxField('Electricity__c', 'Electricity');
MetadataService.CustomField mechanicalField = createCheckboxField('Mechanical__c', 'Mechanical');
MetadataService.CustomField drivingLicenseField = createCheckboxField('Driving_License__c', 'Driving License');
MetadataService.CustomField cargoShipmentField = createCheckboxField('Cargo_Shipment__c', 'Cargo Shipment');
MetadataService.CustomField estimatedDaysField = createNumberField('Estimated_Time_in_Days__c', 'Estimated time in days', 0, 365);
MetadataService.CustomField maxHourlyRateField = createCurrencyField('Max_Hourly_Rate__c', 'Max Hourly Rate', 0, 99999);
MetadataService.CustomField locationField = createPicklistField('Location__c', 'Location', new List<String>{'New York', 'Los Angeles', 'Chicago', 'Houston'});
MetadataService.CustomField startDateField = createDateField('Start_Date__c', 'Start date');
MetadataService.CustomField endDateField = createDateField('End_Date__c', 'End date');

MetadataService.MetadataPort service = createService();
List<MetadataService.SaveResult> results = service.createMetadata(new List<MetadataService.Metadata>{nameField, statusField, descriptionField, electricityField, mechanicalField, drivingLicenseField, cargoShipmentField, estimatedDaysField, maxHourlyRateField, locationField, startDateField, endDateField});

// Handle the results
for (MetadataService.SaveResult result : results) {
    if (result.success) {
        System.debug('Created field ' + result.fullName + ' successfully');
    } else {
        System.debug('Error creating field ' + result.fullName + ': ' + result.errors[0].message);
    }
}
