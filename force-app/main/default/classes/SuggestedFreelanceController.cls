public with sharing class SuggestedFreelanceController {
    @AuraEnabled
    public static List<Freelancer__c> getSuggestedFreelancers(Id projectId) {
        List<Freelancer__c> freelancers = new List<Freelancer__c>();
        Project__c project = [SELECT Electricity__c, Mechanical__c, Driving_License__c, Cargo_Shipment__c FROM Project__c WHERE Id = :projectId];
        
        if (project != null) {
            String query = 'SELECT Id, Name, Hourly_Rate__c, Location__c, Overall_Rate__c FROM Freelancer__c WHERE Available__c = true ';
            
            if (project.Electricity__c) {
                query += 'AND Electricity__c = true ';
            }
            if (project.Mechanical__c) {
                query += 'AND Mechanical__c = true ';
            }
            if (project.Driving_License__c) {
                query += 'AND Driving_License__c = true ';
            }
            if (project.Cargo_Shipment__c) {
                query += 'AND Cargo_Shipment__c = true ';
            }
            
            freelancers = Database.query(query);
        }
        
        return freelancers;
    }
}
