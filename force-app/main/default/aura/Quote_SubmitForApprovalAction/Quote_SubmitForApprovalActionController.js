({
    HandleCancel : function(component, event, helper) {
        console.log('Handle Cancel parent');
        // Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }
})