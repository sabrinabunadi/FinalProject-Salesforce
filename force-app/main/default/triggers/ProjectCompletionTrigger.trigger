trigger ProjectCompletionTrigger on Project__c (after update) {
    List<Review__c> reviewsToInsert = new List<Review__c>();
    
    for (Project__c project : Trigger.new) {
        Project__c oldProject = Trigger.oldMap.get(project.Id);
        
        // Check if the project status has changed to "Completed"
        if (project.Status__c != oldProject.Status__c && project.Status__c == 'Completed') {
            // Query for the related Freelance_in_Project__c records
            List<Freelance_in_Project__c> freelances = [SELECT Id, Freelance__c FROM Freelance_in_Project__c WHERE Project__c = :project.Id];
            
            // Create review records for each freelance
            for (Freelance_in_Project__c freelance : freelances) {
                Review__c review = new Review__c();
                review.Project__c = project.Id;
                review.Freelance__c = freelance.Freelance__c;
                review.Complete_Date__c = project.End_Date__c.addDays(30);
                // Set any other relevant fields
                
                reviewsToInsert.add(review);
            }
        }
    }
    
    // Perform the insert operation
    if (!reviewsToInsert.isEmpty()) {
        insert reviewsToInsert;
    }
}
