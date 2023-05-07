public class ReviewTriggerHandler {
    public static void handleBadReview(List<Review__c> newReviews) {
        List<Id> freelanceIds = new List<Id>();
        for (Review__c r : newReviews) {
            if (r.Total_Rank__c < 5) {
                freelanceIds.add(r.Freelance__c);
            }
        }
        if (!freelanceIds.isEmpty()) {
            List<Freelancer__c> freelancersToUpdate = [SELECT Id, Call_to_Discuss__c, Owner.Email FROM Freelancer__c WHERE Id IN :freelanceIds];
            for (Freelancer__c f : freelancersToUpdate) {
                f.Call_to_Discuss__c = true;
                update f;
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{f.Owner.Email});
                mail.setSubject('New Bad Review');
                mail.setPlainTextBody('A new review has been posted for one of your freelancers and it has a total rank below 5. Please review the review and contact the freelancer to discuss any issues.');
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
            }
        }
    }
}
