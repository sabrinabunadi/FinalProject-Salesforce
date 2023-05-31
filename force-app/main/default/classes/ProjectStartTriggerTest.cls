@isTest
private class ProjectStartTriggerTest {
    @isTest
    static void testProjectStartTrigger() {
        // Create test data
        List<Project__c> projects = new List<Project__c>();
        for (Integer i = 0; i < 5; i++) {
            Project__c project = new Project__c(
                Name = 'Test Project ' + i,
                Status__c = 'Not Started'
            );
            projects.add(project);
        }
        insert projects;

        // Set the status of some projects to "In Progress"
        List<Project__c> projectsToUpdate = new List<Project__c>();
        for (Integer i = 0; i < 2; i++) {
            projectsToUpdate.add(new Project__c(
                Id = projects[i].Id,
                Status__c = 'In Progress'
            ));
        }
        update projectsToUpdate;

        // Retrieve the updated projects
        List<Project__c> updatedProjects = [SELECT Id, Start_Date__c FROM Project__c WHERE Id IN :projectsToUpdate];

        // Verify that the start date of the updated projects is set to today
        for (Project__c project : updatedProjects) {
            System.assertEquals(Date.today(), project.Start_Date__c);
        }
    }
}
