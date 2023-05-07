
({
    doInit : function(component, event, helper) {
        helper.getSuggestedFreelancers(component);
    },
    createFreelanceInProject : function(component, event, helper) {
        var selectedFreelance = event.target.closest("tr").getAttribute("data-recid");
        helper.createFreelanceInProject(component, selectedFreelance);
    }
})

