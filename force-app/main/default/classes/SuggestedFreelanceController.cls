public with sharing class SuggestedFreelanceController {
    @AuraEnabled(cacheable=true)
    public static List<Freelance__c> getSuggestedFreelance() {
        // Perform SOQL query to fetch records from Freelance__c sObject and return as a list
        return [SELECT Name, Hourly_Rate__c, Location__c FROM Freelance__c];
    }
}
