public class CustomObjectCreator {
    public static void createCustomObjects() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();

        // Create Project object
        createCustomObject(service, 'Project__c', 'Project', 'Projects');

        // Create Freelancer object
        createCustomObject(service, 'Freelancer__c', 'Freelancer', 'Freelancers');

        // Create Billable Hours object
        createCustomObject(service, 'Billable_Hours__c', 'Billable Hour', 'Billable Hours');

        // Create Invoice object
        createCustomObject(service, 'Invoice__c', 'Invoice', 'Invoices');

        // Create Review object
        createCustomObject(service, 'Review__c', 'Review', 'Reviews');
    }

    private static void createCustomObject(MetadataService.MetadataPort service, String fullName, String label, String pluralLabel) {
        MetadataService.CustomObject customObject = new MetadataService.CustomObject();
        customObject.fullName = fullName;
        customObject.label = label;
        customObject.pluralLabel = pluralLabel;
        customObject.nameField = new MetadataService.CustomField();
        customObject.nameField.type_x = 'Text';
        customObject.nameField.label = label + ' Name';
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';

        MetadataService.SaveResult[] results = service.createMetadata(new MetadataService.Metadata[] { customObject });

        for (MetadataService.SaveResult result : results) {
            if (result.success) {
                System.debug('Created custom object: ' + result.fullName);
            } else {
                System.debug('Failed to create custom object: ' + result.errors[0].message);
            }
        }
    }
}
