trigger ReviewTrigger on Review__c (after insert) {
    ReviewTriggerHandler.handleBadReview(Trigger.new);
}
