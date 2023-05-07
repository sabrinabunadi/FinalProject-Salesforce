public class FreelancerFieldCreator {
    public static void createCustomFields() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();

        List<MetadataService.Metadata> metadataList = new List<MetadataService.Metadata>();
        
        // Full Name (Text)
        MetadataService.CustomField fullNameField = createTextField('Full_Name__c', 'Full Name', 255);
        metadataList.add(fullNameField);

        // Phone (Phone)
        MetadataService.CustomField phoneField = createPhoneField('Phone__c', 'Phone');
        metadataList.add(phoneField);

        // Email (Email)
        MetadataService.CustomField emailField = createEmailField('Email__c', 'Email');
        metadataList.add(emailField);

        // Electricity (Checkbox)
        MetadataService.CustomField electricityField = createCheckboxField('Electricity__c', 'Electricity');
        metadataList.add(electricityField);

        // Mechanical (Checkbox)
        MetadataService.CustomField mechanicalField = createCheckboxField('Mechanical__c', 'Mechanical');
        metadataList.add(mechanicalField);

        // Driving License (Checkbox)
        MetadataService.CustomField drivingLicenseField = createCheckboxField('Driving_License__c', 'Driving License');
        metadataList.add(drivingLicenseField);

        // Cargo Shipment (Checkbox)
        MetadataService.CustomField cargoShipmentField = createCheckboxField('Cargo_Shipment__c', 'Cargo Shipment');
        metadataList.add(cargoShipmentField);

        // Available (Checkbox)
        MetadataService.CustomField availableField = createCheckboxField('Available__c', 'Available');
        metadataList.add(availableField);

        // Hourly Rate (Currency)
        MetadataService.CustomField hourlyRateField = createCurrencyField('Hourly_Rate__c', 'Hourly Rate', 2);
        metadataList.add(hourlyRateField);

        // Location (Picklist)
        List<String> locationValues = new List<String>{'Location1', 'Location2', 'Location3'};
        MetadataService.CustomField locationField = createPicklistField('Location__c', 'Location', locationValues);
        metadataList.add(locationField);

        // Call to Discuss (Checkbox)
        MetadataService.CustomField callToDiscussField = createCheckboxField('Call_to_Discuss__c', 'Call to Discuss');
        metadataList.add(callToDiscussField);

        // Deploy fields
        MetadataService.SaveResult[] results = service.createMetadata(metadataList);

        // Check if the field creation was successful
        for (MetadataService.SaveResult result : results) {
            if (result.success) {
                System.debug('The field was created successfully.');
            } else {
                System.debug('Failed to create the field: ' + result.errors[0].message);
            }
        }
    }

    private static MetadataService.CustomField createTextField(String fieldName, String fieldLabel, Integer fieldLength) {
        MetadataService.CustomField field = new MetadataService.CustomField();
        field.fullName = 'Freelancer__c.' + fieldName;
        field.label = fieldLabel;
        field.type_x = 'Text';
        field.length = fieldLength;
        return field;
    }

    private static MetadataService.CustomField createPhoneField(String fieldName, String fieldLabel) {
        MetadataService.CustomField field = new MetadataService.CustomField();
        field.fullName = 'Freelancer__c.' + fieldName;
        field.label = fieldLabel;
        field.type_x = 'Phone';
        return field;
    }
    private static MetadataService.CustomField createEmailField(String fieldName, String fieldLabel) {
        MetadataService.CustomField field = new MetadataService.CustomField();
        field.fullName = 'Freelancer__c.' + fieldName;
        field.label = fieldLabel;
        field.type_x = 'Email';
        return field;
    }
    
    private static MetadataService.CustomField createCheckboxField(String fieldName, String fieldLabel) {
        MetadataService.CustomField field = new MetadataService.CustomField();
        field.fullName = 'Freelancer__c.' + fieldName;
        field.label = fieldLabel;
        field.type_x = 'Checkbox';
        field.defaultValue = 'false';
        return field;
    }
    
    private static MetadataService.CustomField createCurrencyField(String fieldName, String fieldLabel, Integer decimalPlaces) {
        MetadataService.CustomField field = new MetadataService.CustomField();
        field.fullName = 'Freelancer__c.' + fieldName;
        field.label = fieldLabel;
        field.type_x = 'Currency';
        field.precision = 18;
        field.scale = decimalPlaces;
        return field;
    }
    
    private static MetadataService.CustomField createPicklistField(String fieldName, String fieldLabel, List<String> values) {
        MetadataService.CustomField field = new MetadataService.CustomField();
        field.fullName = 'Freelancer__c.' + fieldName;
        field.label = fieldLabel;
        field.type_x = 'Picklist';
        field.picklist = new MetadataService.Picklist();
        field.picklist.sorted = false;
    
        List<MetadataService.PicklistValue> picklistValues = new List<MetadataService.PicklistValue>();
        for (String value : values) {
            MetadataService.PicklistValue picklistValue = new MetadataService.PicklistValue();
            picklistValue.fullName = value;
            picklistValue.default_x = false;
            picklistValues.add(picklistValue);
        }
        field.picklist.picklistValues = picklistValues;
        return field;
    }
    

