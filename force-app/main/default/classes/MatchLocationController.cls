public with sharing class MatchLocationController {
    @AuraEnabled
    public static List<Project__c> getProjectsByLocation(String location) {
        return [SELECT Id, Name, Status__c, Owner.Full_Name__c, Max_Hourly_Rate__c, CreatedDate FROM Project__c WHERE Location__c = :location];
    }
    
    @AuraEnabled
    public static List<Freelancer__c> getFreelancersByLocation(String location) {
        return [SELECT Id, Name, Available__c, Owner.Full_Name__c, Hourly_Rate__c, CreatedDate FROM Freelancer__c WHERE Location__c = :location];
    }
}
