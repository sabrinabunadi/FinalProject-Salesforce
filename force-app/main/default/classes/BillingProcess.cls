global class BillingProcess implements Schedulable {
    global void execute(SchedulableContext ctx) {
        // Get the current date and month
        Date currentDate = Date.today();
        Integer currentMonth = currentDate.month();
        Integer currentYear = currentDate.year();
        
        // Query for billable hours records in the current month with status 'Approved'
        List<Billable_Hours__c> billableHoursList = [SELECT Id, Freelance_In_Project__c, Hours__c FROM Billable_Hours__c WHERE CALENDAR_MONTH(Month_Date__c) = :currentMonth AND CALENDAR_YEAR(Month_Date__c) = :currentYear AND Status__c = 'Approved'];
        
        // Create a map to store the total hours per freelance
        Map<Id, Decimal> freelanceHoursMap = new Map<Id, Decimal>();
        
        // Calculate the total hours per freelance
        for (Billable_Hours__c billableHours : billableHoursList) {
            if (freelanceHoursMap.containsKey(billableHours.Freelance_In_Project__c)) {
                freelanceHoursMap.put(billableHours.Freelance_In_Project__c, freelanceHoursMap.get(billableHours.Freelance_In_Project__c) + billableHours.Hours__c);
            } else {
                freelanceHoursMap.put(billableHours.Freelance_In_Project__c, billableHours.Hours__c);
            }
            
            // Update the status of billable hours records to 'Pending Payment'
            billableHours.Status__c = 'Pending Payment';
        }
        
        // Update the billable hours records
        update billableHoursList;
        
        // Create invoice records for each freelance
        List<Invoice__c> invoicesToCreate = new List<Invoice__c>();
        
        for (Billable_Hours__c billableHours : billableHoursList) {
            Decimal totalHours = freelanceHoursMap.get(billableHours.Freelance_In_Project__c);
            
            Invoice__c invoice = new Invoice__c();
            //invoice.Freelance_In_Project__c = billableHours.Freelance_In_Project__c;
            invoice.Amount__c = totalHours;  // Replace with the actual calculation based on billing rates, etc.
            invoice.Status__c = 'Draft';
            
            invoicesToCreate.add(invoice);
        }
        
        // Create the invoice records
        insert invoicesToCreate;
    }
}
