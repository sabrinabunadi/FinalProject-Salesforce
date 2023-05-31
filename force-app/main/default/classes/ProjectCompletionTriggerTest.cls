@IsTest
public class ProjectCompletionTriggerTest {
    @IsTest
    static void testProjectCompletionTrigger() {
        // Create test data
        Project__c project = new Project__c();
        // Set necessary fields for the project
        // ...

        // Insert the project record
        insert project;

        // Update the project status to 'Completed'
        project.Status__c = 'Completed';
        update project;

        // Retrieve the inserted review records
        List<Review__c> reviews = [
            SELECT Id, Project__c, Freelance__c, Complete_Date__c
            FROM Review__c
            WHERE Project__c = :project.Id
        ];

        // Perform assertions to verify the auto-created review records
        System.assertEquals(1, reviews.size(), 'Expected one review record to be created');
        System.assertEquals(project.Id, reviews[0].Project__c, 'Review record should be associated with the project');
        System.assertEquals(freelanceId, reviews[0].Freelance__c, 'Review record should be associated with the freelance');
        System.assertEquals(expectedCompleteDate, reviews[0].Complete_Date__c, 'Complete date should be 30 days from project end date');
        // Perform additional assertions for other relevant fields
    }
}
