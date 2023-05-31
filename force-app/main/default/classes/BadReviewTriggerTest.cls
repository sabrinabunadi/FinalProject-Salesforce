@isTest
public class BadReviewTriggerTest {
    @isTest
    static void testBadReviewTrigger() {
        // Create test data
        Freelance__c testFreelance = new Freelance__c(Name = 'Test Freelance');
        insert testFreelance;
        
        Review__c testReview1 = new Review__c(Freelance__c = testFreelance.Id, Calculated_Rank__c = 3);
        Review__c testReview2 = new Review__c(Freelance__c = testFreelance.Id, Calculated_Rank__c = 7);
        
        // Insert the reviews
        Test.startTest();
        insert new List<Review__c>{ testReview1, testReview2 };
        Test.stopTest();
        
        // Retrieve the updated Freelance record
        Freelance__c updatedFreelance = [SELECT Call_to_Discuss__c FROM Freelance__c WHERE Id = :testFreelance.Id];
        
        // Verify the expected changes
        System.assertEquals(true, updatedFreelance.Call_to_Discuss__c);
        
        // Verify the sent emails
        List<Messaging.SingleEmailMessage> sentEmails = [SELECT Id, TargetObjectId FROM EmailMessage];
        System.assertEquals(1, sentEmails.size());
        System.assertEquals(testFreelance.OwnerId, sentEmails[0].TargetObjectId);
    }
}
