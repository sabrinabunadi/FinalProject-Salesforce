trigger ProjectStartTrigger on Project__c (before update) {
    List<Project__c> projectsToUpdate = new List<Project__c>();

    for (Project__c project : Trigger.new) {
        Project__c oldProject = Trigger.oldMap.get(project.Id);

        // Check if the project status has changed to "In Progress"
        if (project.Status__c != oldProject.Status__c && project.Status__c == 'In Progress') {
            projectsToUpdate.add(new Project__c(
                Id = project.Id,
                Start_Date__c = Date.today()
            ));
        }
    }

    // Update the start date of the projects to today
    if (!projectsToUpdate.isEmpty()) {
        update projectsToUpdate;
    }
}
