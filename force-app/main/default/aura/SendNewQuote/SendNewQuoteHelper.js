({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
  CHUNK_SIZE: 750000,      //Chunk Max size 750Kb
  sendHelper: function(component, getEmail, getSubject, getbody) {
      console.log ('call send email method')
      // call the server side controller method 	
      var action = component.get("c.onSend");
      // set the 3 params to sendMailMethod method   
      console.log ('call send email action')
      action.setParams({
         'recordId' : component.get('v.recordId'),
          'subject': getSubject,
          'reciever': getEmail,
          'cc': component.get("v.cc"),
          'body': getbody,
          
          'uploadedAttId':component.get("v.attachedId"),
          'uploadedAttId1':component.get("v.attachedId1"),
          'uploadedAttId2':component.get("v.attachedId2"),
          
      });
      action.setCallback(this, function(response) {
           console.log ('call send email response');
          var state = response.getState();
           console.log ('call send email state '+ state);
          var type;
          var msg;
          var title;
          var ttu=component.get('v.recordId');
          var urlEvent = $A.get("e.force:navigateToURL");
          urlEvent.setParams({
              "url": "/"+ttu
          });
          urlEvent.fire();
          if (state === "SUCCESS") {
              var storeResponse = response.getReturnValue();
              type="success";
              msg = 'Mail Sent Successfully';
              title="Mail Sent to "+component.get('v.to')+" Successfully!!!!";  
              // if state of server response is comes "SUCCESS",
              // display the success message box by set mailStatus attribute to true
              //component.set("v.mailStatus", true);
              
              
          }
          if(state==="ERROR"){
              let err = res.getError();
              title = 'Error';
              type = 'error';
              msg = err[0].message;
          }
          var toastEvent = $A.get("e.force:showToast");
          toastEvent.setParams({
              "title": title,
              "type": type,
              "message": msg
          });  
          
          toastEvent.fire();
          
      });
      $A.enqueueAction(action);
  },
	getQuote1 : function(component, event, helper) {
        var action = component.get("c.get_Quote");
        
        action.setParams({
            'recordId' : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                var rval = JSON.parse(response.getReturnValue());
                if(rval.qt.Contact__c!=null){
                var subject = "Quote from Monster for "+rval.qt.Contact__r.Name+" | "+rval.qt.Name;
                var body = '<div style="white-space: nowrap;">Dear '+ rval.qt.Contact__r.Name +',<br/><br/>'
              					+'Greetings from <b>Monster</b> !!!<br/>'
              					+'In Continuation to your requirement, we are forwarding you the Quotation with this mail.<br/>'
                				+'We attached our best Quotation as pdf bellow, please check it.'
              					+'Kindly reach us back for any required clarification/change.<br/>' 
              					+'Thanking you and looking forward for your order.<br/><br/></div>' 
					            +'Because we care.®,<br/>';
                
                component.set("v.quote", rval.qt);
                component.set("v.to", rval.to);
                component.set("v.cc", rval.cc);
                component.set("v.subject", subject);
                component.set("v.body", body);
                }
                
                if(rval.qt.Contact__c==null){
                     var subject = "Quote from Monster for "
                var body = '<div style="white-space: nowrap;">Dear '
              					+'Greetings from <b>Monster</b> !!!<br/>'
              					+'In Continuation to your requirement, we are forwarding you the Quotation with this mail.<br/>'
                				+'We attached our best Quotation as pdf bellow, please check it.'
              					+'Kindly reach us back for any required clarification/change.<br/>' 
              					+'Thanking you and looking forward for your order.<br/><br/></div>' 
					            +'Because we care.®,<br/>';
                
                component.set("v.quote", rval.qt);
                component.set("v.to", rval.to);
                component.set("v.cc", rval.cc);
                component.set("v.subject", subject);
                component.set("v.body", body);
                }
                
            }
            else {
                console.log("error in getQuote");
            }
        });
        
        $A.enqueueAction(action);
	},
    getTemplateheper : function(component, event , helper) { 
        var action = component.get("c.sendAttachedPdf");
        //console.log('All product' + action);
       
         action.setParams({
            'rid' : component.get("v.recordId")
        });
      
        action.setCallback(this,function(response){
            var state= response.getState();
            console.log('All template state'+ state);
            if(state==='SUCCESS'){
                var res=(response.getReturnValue());
                //console.log('All template result pdf name++++++' + res.PDF__c);
                
                component.set("v.temp" ,res);
                                console.log('res tempname:'+component.get("v.temp"));

                 // component.set("v.pdfname" , res.PDF__c);
            }
            
        });
        $A.enqueueAction(action); 
    },
    getAttachment : function(component, event , helper) { 
        var action = component.get("c.checkForAttachment");
        //console.log('All product' + action);
       
         action.setParams({
            'rid' : component.get("v.recordId")
        });
      
        action.setCallback(this,function(response){
            var state= response.getState();
            //console.log('All template state'+ state);
            if(state==='SUCCESS'){
                var res=(response.getReturnValue());
                //console.log('All template result pdf name++++++' + res.PDF__c);
                
                component.set("v.status" ,res);
                                //console.log('res tempname:'+component.get("v.temp"));

                 // component.set("v.pdfname" , res.PDF__c);
            }
            
        });
        $A.enqueueAction(action); 
    },
    uploadHelper: function(component, event) {
      // start/show the loading spinner   
      component.set("v.showLoadingSpinner", true);
      // get the selected files using aura:id [return array of files]
      var fileInput = component.find("fileId").get("v.files");
      // get the first file using array index[0]  
      var file = fileInput[0];
      var self = this;
      // check the selected file size, if select file size greter then MAX_FILE_SIZE,
      // then show a alert msg to user,hide the loading spinner and return from function  
      if (file.size > self.MAX_FILE_SIZE) {
          component.set("v.showLoadingSpinner", false);
          component.set("v.fileName", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
          return;
      }
      
      // create a FileReader object 
      var objFileReader = new FileReader();
      // set onload function of FileReader object   
      objFileReader.onload = $A.getCallback(function() {
          var fileContents = objFileReader.result;
          var base64 = 'base64,';
          var dataStart = fileContents.indexOf(base64) + base64.length;
          
          fileContents = fileContents.substring(dataStart);
          // call the uploadProcess method 
          self.uploadProcess(component, file, fileContents);
      });
      
      objFileReader.readAsDataURL(file);
  },
  uploadHelper1: function(component, event) {
      
      component.set("v.showLoadingSpinner1", true);
      
      var fileInput = component.find("fileId1").get("v.files");
      
      var file = fileInput[0];
      var self = this;
      
      
      if (file.size > self.MAX_FILE_SIZE) {
          component.set("v.showLoadingSpinner1", false);
          component.set("v.fileName1", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
          return;
      }
      
      
      var objFileReader = new FileReader();
      
      objFileReader.onload = $A.getCallback(function() {
          var fileContents = objFileReader.result;
          var base64 = 'base64,';
          var dataStart = fileContents.indexOf(base64) + base64.length;
          
          fileContents = fileContents.substring(dataStart);
          
          self.uploadProcess1(component, file, fileContents);
      });
      
      objFileReader.readAsDataURL(file);
  },
  uploadHelper2: function(component, event) {
      
      component.set("v.showLoadingSpinner2", true);
      
      var fileInput = component.find("fileId2").get("v.files");
      
      var file = fileInput[0];
      var self = this;
      
      
      if (file.size > self.MAX_FILE_SIZE) {
          component.set("v.showLoadingSpinner2", false);
          component.set("v.fileName2", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
          return;
      }
      
      
      var objFileReader = new FileReader();
      
      objFileReader.onload = $A.getCallback(function() {
          var fileContents = objFileReader.result;
          var base64 = 'base64,';
          var dataStart = fileContents.indexOf(base64) + base64.length;
          
          fileContents = fileContents.substring(dataStart);
          
          self.uploadProcess2(component, file, fileContents);
      });
      
      objFileReader.readAsDataURL(file);
  },
  
  uploadProcess: function(component, file, fileContents) {
      // set a default size or startpostiton as 0 
      var startPosition = 0;
      // calculate the end size or endPostion using Math.min() function which is return the min. value   
      var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
      
      // start with the initial chunk, and set the attachId(last parameter)is null in begin
      this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '');
  },
  
  
  uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId) {
      // call the apex method 'saveChunk'
      var getchunk = fileContents.substring(startPosition, endPosition);
      var action = component.get("c.saveChunk");
      action.setParams({
          parentId: component.get("v.recordId"),
          fileName: file.name,
          base64Data: encodeURIComponent(getchunk),
          contentType: file.type,
          fileId: attachId
      });
      
      // set call back 
      action.setCallback(this, function(response) {
          // store the response / Attachment Id   
          attachId = response.getReturnValue();
          var state = response.getState();
          if (state === "SUCCESS") {
              // update the start position with end postion
              startPosition = endPosition;
              endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
              // check if the start postion is still less then end postion 
              // then call again 'uploadInChunk' method , 
              // else, diaply alert msg and hide the loading spinner
              if (startPosition < endPosition) {
                  this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
              } else {
                  alert('your File is uploaded successfully');
                  component.set("v.showLoadingSpinner", false);
                  component.set("v.attachedId", response.getReturnValue());
              }
              // handel the response errors        
          } else if (state === "INCOMPLETE") {
              alert("From server: " + response.getReturnValue());
          } else if (state === "ERROR") {
              var errors = response.getError();
              if (errors) {
                  if (errors[0] && errors[0].message) {
                      console.log("Error message: " + errors[0].message);
                  }
              } else {
                  console.log("Unknown error");
              }
          }
      });
      // enqueue the action
      $A.enqueueAction(action);
  },
  uploadProcess1: function(component, file, fileContents) {
      
      var startPosition = 0;
      
      var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
      
      
      this.uploadInChunk1(component, file, fileContents, startPosition, endPosition, '');
  },
  
  
  uploadInChunk1: function(component, file, fileContents, startPosition, endPosition, attachId) {
      // call the apex method 'saveChunk'
      var getchunk = fileContents.substring(startPosition, endPosition);
      var action = component.get("c.saveChunk1");
      action.setParams({
          parentId1: component.get("v.recordId"),
          fileName1: file.name,
          base64Data: encodeURIComponent(getchunk),
          contentType: file.type,
          fileId1: attachId
      });
      
      // set call back 
      action.setCallback(this, function(response) {
          // store the response / Attachment Id   
          attachId = response.getReturnValue();
          var state = response.getState();
          if (state === "SUCCESS") {
              // update the start position with end postion
              startPosition = endPosition;
              endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
              // check if the start postion is still less then end postion 
              // then call again 'uploadInChunk' method , 
              // else, diaply alert msg and hide the loading spinner
              if (startPosition < endPosition) {
                  this.uploadInChunk1(component, file, fileContents, startPosition, endPosition, attachId);
              } else {
                  alert('your File is uploaded successfully');
                  component.set("v.showLoadingSpinner1", false);
                  component.set("v.attachedId1", response.getReturnValue());
              }
              // handel the response errors        
          } else if (state === "INCOMPLETE") {
              alert("From server: " + response.getReturnValue());
          } else if (state === "ERROR") {
              var errors = response.getError();
              if (errors) {
                  if (errors[0] && errors[0].message) {
                      console.log("Error message: " + errors[0].message);
                  }
              } else {
                  console.log("Unknown error");
              }
          }
      });
      // enqueue the action
      $A.enqueueAction(action);
  },
  uploadProcess2: function(component, file, fileContents) {
      // set a default size or startpostiton as 0 
      var startPosition = 0;
      // calculate the end size or endPostion using Math.min() function which is return the min. value   
      var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
      
      // start with the initial chunk, and set the attachId(last parameter)is null in begin
      this.uploadInChunk2(component, file, fileContents, startPosition, endPosition, '');
  },
  
  
  uploadInChunk2: function(component, file, fileContents, startPosition, endPosition, attachId) {
      // call the apex method 'saveChunk'
      var getchunk = fileContents.substring(startPosition, endPosition);
      var action = component.get("c.saveChunk2");
      action.setParams({
          parentId2: component.get("v.recordId"),
          fileName2: file.name,
          base64Data: encodeURIComponent(getchunk),
          contentType: file.type,
          fileId2: attachId
      });
      
      // set call back 
      action.setCallback(this, function(response) {
          // store the response / Attachment Id   
          attachId = response.getReturnValue();
          var state = response.getState();
          if (state === "SUCCESS") {
              // update the start position with end postion
              startPosition = endPosition;
              endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
              // check if the start postion is still less then end postion 
              // then call again 'uploadInChunk' method , 
              // else, diaply alert msg and hide the loading spinner
              if (startPosition < endPosition) {
                  this.uploadInChunk2(component, file, fileContents, startPosition, endPosition, attachId);
              } else {
                  alert('your File is uploaded successfully');
                  component.set("v.showLoadingSpinner2", false);
                  component.set("v.attachedId2", response.getReturnValue());
              }
              // handel the response errors        
          } else if (state === "INCOMPLETE") {
              alert("From server: " + response.getReturnValue());
          } else if (state === "ERROR") {
              var errors = response.getError();
              if (errors) {
                  if (errors[0] && errors[0].message) {
                      console.log("Error message: " + errors[0].message);
                  }
              } else {
                  
                  console.log("Unknown error");
              }
          }
      });
      // enqueue the action
      $A.enqueueAction(action);
  }
})