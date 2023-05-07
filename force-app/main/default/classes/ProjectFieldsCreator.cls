MetadataService.MetadataPort service = new MetadataService.MetadataPort();
service.SessionHeader = new MetadataService.SessionHeader_element();
service.SessionHeader.sessionId = UserInfo.getSessionId();

// Create custom fields
List<MetadataService.Metadata> fields = new List<MetadataService.Metadata>();

MetadataService.CustomField nameField = new MetadataService.CustomField();
nameField.fullName = 'Project__c.Name__c';
nameField.label = 'Project Name';
nameField.type_x = 'Text';
fields.add(nameField);

MetadataService.CustomField startDateField = new MetadataService.CustomField();
startDateField.fullName = 'Project__c.Start_Date__c';
startDateField.label = 'Start Date';
startDateField.type_x = 'Date';
fields.add(startDateField);

MetadataService.CustomField endDateField = new MetadataService.CustomField();
endDateField.fullName = 'Project__c.End_Date__c';
endDateField.label = 'End Date';
endDateField.type_x = 'Date';
fields.add(endDateField);

MetadataService.SaveResult[] results = service.createMetadata(fields);

for (MetadataService.SaveResult result : results) {
    if (result.success) {
        System.debug('Created custom field: ' + result.fullName);
    } else {
        System.debug('Failed to create custom field: ' + result.errors[0].message);
    }
}