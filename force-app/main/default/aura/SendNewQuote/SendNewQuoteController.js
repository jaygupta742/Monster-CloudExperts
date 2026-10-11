({
	doInit : function(component, event, helper){
    helper.getQuote1(component, event, helper);
        helper.getTemplateheper(component, event, helper);
                helper.getAttachment(component, event, helper);

 },
    sendMail: function(component, event, helper) {
        
        //console.log('contact mail : '+component.get("v.email"))	;
        var getEmail = component.get("v.to");
        var getCCEmail = component.get("v.cc");
        var getSubject = component.get("v.subject");
        var getbody = component.get("v.body");
      //  console.log('get cc mail '+getCCEmail);
        if ($A.util.isEmpty(getEmail) || !getEmail.includes("@")) {
            alert('Please Enter valid Email Address');
        } else {
            helper.sendHelper(component, getEmail, getSubject, getbody);

            
        }
    },
 
    // when user click on the close buttton on message popup ,
    // hide the Message box by set the mailStatus attribute to false
    // and clear all values of input fields.   
    closeMessage: function(component, event, helper) {
        component.set("v.mailStatus", false);
        component.set("v.email", null);
        component.set("v.subject", null);
        component.set("v.body", null);
    },
     doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files").length > 0) {
            helper.uploadHelper(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
    doSave1: function(component, event, helper) {
        if (component.find("fileId1").get("v.files").length > 0) {
            helper.uploadHelper1(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
    doSave2: function(component, event, helper) {
        if (component.find("fileId2").get("v.files").length > 0) {
            helper.uploadHelper2(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
 
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },
     handleFilesChange1: function(component, event, helper) {
        var fileName1 = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName1 = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName1", fileName1);
    },
     handleFilesChange2: function(component, event, helper) {
        var fileName2 = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName2 = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName2", fileName2);
    },
    cancelit : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/"+ component.get("v.recordId")
        });
        urlEvent.fire();                
    },
})