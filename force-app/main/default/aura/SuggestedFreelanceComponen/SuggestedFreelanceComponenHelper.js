({
    getSuggestedFreelancers : function(component) {
        var action = component.get("c.getSuggestedFreelancers");
        action.setParams({
            projectId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.freelances", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    createFreelancerInProject : function(component, freelancerId) {
        var action = component.get("c.createFreelancerInProject");
        action.setParams({
            projectId: component.get("v.recordId"),
            freelancerId: freelancerId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Success!",
                    message: "Freelancer added to project.",
                    type: "success"
                });
                toastEvent.fire();
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
