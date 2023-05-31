trigger BadReviewTrigger on Review__c (after insert, after update) {
    Set<Id> freelanceIdsToUpdate = new Set<Id>();
    
    for (Review__c review : Trigger.new) {
        // Check the calculated rank field for each review record
        if (review.Calculated_Rank__c < 5) {
            freelanceIdsToUpdate.add(review.Freelance__c);
        }
    }
    
    if (!freelanceIdsToUpdate.isEmpty()) {
        List<Freelance__c> freelancesToUpdate = [SELECT Id, Call_to_Discuss__c, OwnerId FROM Freelance__c WHERE Id IN :freelanceIdsToUpdate];
        
        for (Freelance__c freelance : freelancesToUpdate) {
            freelance.Call_to_Discuss__c = true;
        }
        
        update freelancesToUpdate;
        
        // Send email alerts to freelance owners
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for (Freelance__c freelance : freelancesToUpdate) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTemplateId('<<Email_Template_Id>>');
            email.setTargetObjectId(freelance.OwnerId);
            email.setSaveAsActivity(false);
            
            emails.add(email);
        }
        
        Messaging.sendEmail(emails);
    }
}
