public class CustomObjectCreator {
    public static void createCustomObjects() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();

        List<MetadataService.CustomObject> customObjects = new List<MetadataService.CustomObject>();

        // Create Project object
        customObjects.add(createCustomObject('Project__c', 'Project', 'Projects'));

        // Create Freelancer object
        customObjects.add(createCustomObject('Freelancer__c', 'Freelancer', 'Freelancers'));

        // Create Billable Hours object
        customObjects.add(createCustomObject('Billable_Hours__c', 'Billable Hour', 'Billable Hours'));

        // Create Invoice object
        customObjects.add(createCustomObject('Invoice__c', 'Invoice', 'Invoices'));

        // Create Review object
        customObjects.add(createCustomObject('Review__c', 'Review', 'Reviews'));

        // Create Project object
        customObjects.add(createCustomObject('FreeLancerProject__c', 'FreeLancerProject', 'FreeLancerProjects'));

        List<MetadataService.SaveResult> results = service.createMetadata(customObjects);

        for (MetadataService.SaveResult result : results) {
            if (result.success) {
                System.debug('Created custom object: ' + result.fullName);
            } else {
                System.debug('Failed to create custom object: ' + result.errors[0].message);
            }
        }
    }

    private static MetadataService.CustomObject createCustomObject(String fullName, String label, String pluralLabel) {
        MetadataService.CustomObject customObject = new MetadataService.CustomObject();
        customObject.fullName = fullName;
        customObject.label = label;
        customObject.pluralLabel = pluralLabel;
        customObject.nameField = new MetadataService.CustomField();
        customObject.nameField.type_x = 'Text';
        customObject.nameField.label = label + ' Name';
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';
        return customObject;
    }

}
