({
    getProjects : function(component, event, helper) {
        var location = component.get("v.location");
        helper.getProjectsByLocation(component, location);
    },
    getFreelancers : function(component, event, helper) {
        var location = component.get("v.location");
        helper.getFreelancersByLocation(component, location);
    }
})
