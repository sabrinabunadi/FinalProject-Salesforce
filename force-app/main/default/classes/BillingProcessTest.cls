@isTest
public class BillingProcessTest {
    @isTest
    static void testBillingProcess() {
        // Create test data for billable hours records
        List<Billable_Hours__c> billableHoursList = new List<Billable_Hours__c>();
        // Populate the billableHoursList with test data
        
        // Insert the test data
        insert billableHoursList;
        
        // Create an instance of the BillingProcess class
        BillingProcess billingProcess = new BillingProcess();
        
        // Call the execute method of the BillingProcess class
        Test.startTest();
        // Optionally, you can use System.schedule to schedule the job at a specific time
        // System.schedule('Billing Process Job', '0 0 1 * * ?', new BillingProcess());
        billingProcess.execute(null);
        Test.stopTest();
        
        // Assert the results and verify the expected behavior
        // Retrieve the updated billable hours records and assert their status
        List<Billable_Hours__c> updatedBillableHoursList = [SELECT Id, Status__c FROM Billable_Hours__c WHERE Id IN :billableHoursList];
        for (Billable_Hours__c bh : updatedBillableHoursList) {
            System.assertEquals('Pending Payment', bh.Status__c);
        }
        
        // Retrieve the created invoice records and assert their values
        List<Invoice__c> createdInvoices = [SELECT Id, Amount__c, Status__c FROM Invoice__c];
        System.assertEquals(billableHoursList.size(), createdInvoices.size());
        for (Invoice__c invoice : createdInvoices) {
            System.assertEquals('Draft', invoice.Status__c);
            // Perform additional assertions on the invoice record as needed
        }
        
        // Add more assertions as needed
    }
}
