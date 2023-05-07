public class BillingBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Freelance_In_Project__c, SUM(Hours__c) hours
            FROM Billable_Hours__c
            WHERE Status__c = 'Approved'
            GROUP BY Freelance_In_Project__c
        ]);
    }
    
    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Invoice__c> invoices = new List<Invoice__c>();
        for (AggregateResult ar : scope) {
            Id freelanceId = (Id) ar.get('Freelance_In_Project__c');
            Decimal totalHours = (Decimal) ar.get('hours');
            Decimal hourlyRate = [SELECT Max_Hourly_Rate__c FROM Freelance_In_Project__c WHERE Id = :freelanceId].Max_Hourly_Rate__c;
            Decimal totalAmount = totalHours * hourlyRate;
            Invoice__c invoice = new Invoice__c(
                Freelance__c = freelanceId,
                Billing_Date__c = Date.today(),
                Amount__c = totalAmount,
                Status__c = 'Draft'
            );
            invoices.add(invoice);
        }
        insert invoices;
    }
    
    public void finish(Database.BatchableContext bc) {
        List<Billable_Hours__c> billableHours = [SELECT Id, Status__c FROM Billable_Hours__c WHERE Status__c = 'Approved'];
        for (Billable_Hours__c bh : billableHours) {
            bh.Status__c = 'Pending Payment';
        }
        update billableHours;
    }
}
