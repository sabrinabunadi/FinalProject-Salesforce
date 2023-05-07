({
    getProjectsByLocation : function(component, location) {
        var action = component.get("c.getProjectsByLocation");
        action.setParams({
            location: location
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.projects", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    getFreelancersByLocation : function(component, location) {
        var action = component.get("c.getFreelancersByLocation");
        action.setParams({
            location: location
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.freelancers", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
